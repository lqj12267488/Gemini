package com.goisan.evaluation.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.goisan.evaluation.bean.*;
import com.goisan.evaluation.service.EvaluationService;
import com.goisan.evaluation.bean.Group;
import com.goisan.system.bean.Index;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.*;
import java.util.regex.Pattern;

/**
 * Created by admin on 2017/7/28.
 */
@Controller
public class StudentEvaluationController {
    @Resource
    public EvaluationService evaluationService;

    @Resource
    public CommonService commonService;

    @Resource
    public EmpService empService;

    @RequestMapping("/xgEvaluation/group")
    public String group() {
        return "/business/evaluation/student/group/group";
    }

    @RequestMapping("/xgEvaluation/addGroup")
    public String toAddGroup() {
        return "/business/evaluation/student/group/addGroup";
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/saveGroup")
    public Message saveGroup(Group group) {
        group.setGroupId(CommonUtil.getUUID());
        group.setCreateDept(CommonUtil.getDefaultDept());
        group.setCreator(CommonUtil.getPersonId());
        group.setCreateTime(CommonUtil.getDate());
        evaluationService.saveGroup(group);
        return new Message(1, "添加成功！", null);
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/deleteGroup")
    public Message deleteGroup(String id) {
        Message message = new Message(1, "删除成功！", "success");
        List<EvaluationTask> evaluationTasks = evaluationService.getTasksByGroupId(id);
        if (evaluationTasks.size() == 0) {
            evaluationService.deleteGroup(id);
            evaluationService.deleteMemberByGroupId(id, null);
        } else {
            message.setMsg("该评委组已经被使用，不能删除！");
            message.setResult("error");
        }
        return message;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/getGroupList")
    public Map getGroupList(String groupName, String evaluationType) {
        String deptId = CommonUtil.getDefaultDept();
        Group group = new Group();
        group.setGroupName(groupName);
        group.setCreateDept(deptId);
        group.setEvaluationType(evaluationType);
        group.setChangeDept(CommonUtil.getDefaultDept());
        group.setLevel(CommonUtil.getLoginUser().getLevel());
        return CommonUtil.tableMap(evaluationService.getGroupList(group));
    }

    @RequestMapping("/xgEvaluation/toSelectMember")
    public ModelAndView getEmpTree(String id, String memberType) {
        ModelAndView mv = new ModelAndView("/business/evaluation/student/group/selectMember");
        mv.addObject("id", id);
        mv.addObject("memberType", memberType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/getEmpsByGroup")
    public Map<String, List> getEmpsByGroup(String id, String memberType) {
        List<Tree> trees = null;
        if ("0".equals(memberType)) {
            trees = commonService.getEmpTree();
        }
        if ("1".equals(memberType)) {
            trees = commonService.getStuTree();
        }
        List<EvaluationMembers> evaluationMembers = evaluationService.getMembersByGroupId(id, memberType);
        Map<String, List> map = new HashMap<String, List>();
        map.put("tree", trees);
        map.put("selected", evaluationMembers);
        return map;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/saveMember")
    public Message deleteGroup(String ids, String groupId, String memberType) {
        String[] tmp = ids.split(";");
        evaluationService.deleteMemberByGroupId(groupId, memberType);
        boolean b, c;
        EvaluationMembers evaluationMembers = new EvaluationMembers();
        evaluationMembers.setGroupId(groupId);
        evaluationMembers.setMemberType(memberType);
        evaluationMembers.setCreator(CommonUtil.getPersonId());
        evaluationMembers.setCreateDept(CommonUtil.getDefaultDept());
        evaluationMembers.setCreateTime(CommonUtil.getDate());
        if (!"".equals(ids)) {
            for (String memberIdAndDeptId : tmp) {
                if(memberIdAndDeptId.split(",").length <=2)
                    continue;
                b = Pattern.matches("^\\d{15}|^\\d{17}([0-9]|X|x)$", memberIdAndDeptId.split(",")[0]);
                c = memberIdAndDeptId.split(",")[0].length() == 36;
                evaluationMembers.setMemberId(CommonUtil.getUUID());
                evaluationMembers.setDeptId(memberIdAndDeptId.split(",")[1]);
                evaluationMembers.setName(memberIdAndDeptId.split(",")[2]);
                if ("0".equals(memberType)) {
                    if (c) {
                        evaluationMembers.setPersonId(memberIdAndDeptId.split(",")[0]);
                        evaluationService.saveMember(evaluationMembers);
                    }
                }
                if ("1".equals(memberType)) {
                    if (b) {
                        evaluationMembers.setPersonId(memberIdAndDeptId.split(",")[0]);
                        evaluationService.saveMember(evaluationMembers);
                    }
                }
            }

        }
        evaluationService.updateGroupMembersNum(groupId);
        return new Message(1, "保存成功！", null);
    }

    @RequestMapping("/xgEvaluation/toEditGroup")
    public String toEditGroup(String id, Model model) {

        model.addAttribute("group", evaluationService.getGroup(id));
        return "/business/evaluation/student/group/editGroup";
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/updateGroup")
    public Message upadteGroup(Group group) {
        CommonUtil.update(group);
        evaluationService.upadteGroup(group);
        return new Message(1, "修改成功！", null);
    }

    @RequestMapping("/xgEvaluation/plan")
    public String plan() {
        return "/business/evaluation/student/plan/plan";
    }

    @RequestMapping("/xgEvaluation/addPlan")
    public String toAddPlan() {
        return "/business/evaluation/student/plan/addPlan";
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/savePlan")
    public Message savePlan(EvaluationPlan evaluationPlan) {
        evaluationPlan.setPlanId(CommonUtil.getUUID());
        evaluationPlan.setCreator(CommonUtil.getPersonId());
        evaluationPlan.setCreateDept(CommonUtil.getDefaultDept());
        evaluationPlan.setCreateTime(CommonUtil.getDate());
        evaluationService.savePlan(evaluationPlan);
        return new Message(1, "添加成功！", null);
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/getPlanList")
    public Map getPlanList(String name, String evaluationType) {
        if (name != null && name != "") {
            name = "%" + name + "%";
        }
        EvaluationPlan plan = new EvaluationPlan();
        plan.setPlanName(name);
        plan.setEvaluationType(evaluationType);
        plan.setCreateDept(CommonUtil.getDefaultDept());
        plan.setLevel(CommonUtil.getLoginUser().getLevel());
        return CommonUtil.tableMap(evaluationService.getPlanList(plan));
    }

    @RequestMapping("/xgEvaluation/toEditPlan")
    public String toEditPlan(Model model, String id) {
        model.addAttribute("plan", evaluationService.getPlan(id));
        return "/business/evaluation/student/plan/editPlan";
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/updatePlan")
    public Message updatePlan(EvaluationPlan evaluationPlan) {
        evaluationPlan.setChanger(CommonUtil.getPersonId());
        evaluationPlan.setChangeDept(CommonUtil.getDefaultDept());
        evaluationPlan.setChangeTime(CommonUtil.getDate());
        evaluationService.upadtePlan(evaluationPlan);
        return new Message(1, "修改成功！", null);
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/deletePlan")
    public Message deletePlan(String id) {
        List<EvaluationTask> tasks = evaluationService.getTasksByPlanId(id);
        if (tasks.size() > 0) {
            return new Message(0, "该评教方案已经应用，不能删除！", "error");
        } else {
            evaluationService.deletePlan(id);
            evaluationService.deleteTaskByPlanId(id);
            evaluationService.deleteIndexByPlanid(id);
            return new Message(1, "删除成功！", "success");
        }
    }


    @RequestMapping("/xgEvaluation/toIndex")
    public String toIndex(String id, Model model, String planName) {
        ObjectMapper mapper = new ObjectMapper();
        String json = null;
        try {
            json = mapper.writeValueAsString(evaluationService.getIndexByPlanId(id));
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        model.addAttribute("id", id);
        model.addAttribute("data", json);
        model.addAttribute("planName", planName);
        return "/business/evaluation/student/plan/index/index";
    }

    @RequestMapping("/xgEvaluation/toAddIndex")
    public String toAddIndex(String planId, String pId, Model model) {
        model.addAttribute("planId", planId);
        model.addAttribute("pId", pId);
        return "/business/evaluation/student/plan/index/addIndex";
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/saveIndex")
    public Message saveIndex(Index index) {
        Integer scoreSum;
        Integer weightsSum;
        boolean b = true;
        Message msg = new Message(0, "保存成功！", null);
        if (index.getPlanId().equals(index.getParentIndexId())) {
            scoreSum = evaluationService.getPlanScoreByPlanId(index.getPlanId());
            weightsSum = 100;
        } else {
            scoreSum = evaluationService.getIndexScoreByIndexId(index.getParentIndexId());
            weightsSum = evaluationService.getIndexWeightsByIndexId(index.getParentIndexId());
        }
        Integer score = evaluationService.getIndexScoreTotalByParentIndexId(index
                .getParentIndexId(), null);
        Integer weights = evaluationService.getIndexWeightsTotalByParentIndexId(index
                .getParentIndexId(), null);
        if (score == null) {
            score = 0;
        }
        if (weights == null) {
            weights = 0;
        }
/*
        if (score + index.getScore() > scoreSum) {
            b = false;
            msg.setMsg("子级指标分数总和不能大于父级！");
        }
*/
        if (weights + index.getWeights() > weightsSum) {
            b = false;
            msg.setMsg("子级权重总和不能大于父级！");
        }
        if (weightsSum == 100 && weights + index.getWeights() > weightsSum) {
            b = false;
            msg.setMsg("权重总和不能大于100！");
        }
        if (b) {
            index.setIndexId(CommonUtil.getUUID());
            index.setCreator(CommonUtil.getPersonId());
            index.setCreateDept(CommonUtil.getDefaultDept());
            index.setCreateTime(CommonUtil.getDate());
            index.setColspan(1);
            evaluationService.saveIndex(index);
            Integer col = evaluationService.getLeafTotal(index.getParentIndexId());
            evaluationService.updateIndexLeafFlag(index.getParentIndexId(), 0, col);
            if ("3".equals(index.getIndexLevel())) {
                index = evaluationService.getIndexById(evaluationService.getIndexById(index
                        .getParentIndexId()).getParentIndexId());
                List<Index> indices = evaluationService.getIndexsByParentIndexId(index.getIndexId());
                int colspan = 0;
                for (Index i : indices) {
                    Integer sum = evaluationService.getLeafTotal(i.getIndexId());
                    if (sum == null || sum == 0) {
                        sum = 1;
                    }
                    colspan += sum;
                }
                evaluationService.updateIndexLeafFlag(index.getIndexId(), 0, colspan);
                evaluationService.updatePlanTestFlag(index.getPlanId(), 0);
            }
            msg.setStatus(1);
        }
        return msg;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/deleteIndex")
    public Message deleteIndex(String id) {
        Index index = evaluationService.getIndexById(id);
        evaluationService.deleteIndex(id);
        Integer total = evaluationService.getLeafTotal(index.getParentIndexId());
        if (total == 0) {
            evaluationService.updateIndexLeafFlag(index.getParentIndexId(), 1, 2);
        } else {
            evaluationService.updateIndexLeafFlag(index.getParentIndexId(), 0, total);
        }
        return new Message(1, "删除成功！", null);
    }

    @RequestMapping("/xgEvaluation/toEditIndex")
    public String toEditIndex(String id, Model model) {
        model.addAttribute("index", evaluationService.getIndexById(id));
        return "/business/evaluation/student/plan/index/editIndex";
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/updateIndex")
    public Message updateIndex(Index index) {
        Integer scoreSum;
        Integer weightsSum;
        boolean b = true;
        Message msg = new Message(0, "修改成功！", null);
        if (index.getPlanId().equals(index.getParentIndexId())) {
            scoreSum = evaluationService.getPlanScoreByPlanId(index.getPlanId());
            weightsSum = 100;
        } else {
            scoreSum = evaluationService.getIndexScoreByIndexId(index.getParentIndexId());
            weightsSum = evaluationService.getIndexWeightsByIndexId(index.getParentIndexId());
        }
        Integer score = evaluationService.getIndexScoreTotalByParentIndexId(index
                .getParentIndexId(), index.getIndexId());
        Integer weights = evaluationService.getIndexWeightsTotalByParentIndexId(index
                .getParentIndexId(), index.getIndexId());
        if (score == null) {
            score = 0;
        }
        if (weights == null) {
            weights = 0;
        }
/*
        if (score + index.getScore() > scoreSum) {
            b = false;
            msg.setMsg("子级指标分数总和不能大于父级！");
        }
*/
        if (weights + index.getWeights() > weightsSum) {
            b = false;
            msg.setMsg("子级权重总和不能大于父级！");
        }
        if (weightsSum == 100 && weights + index.getWeights() > weightsSum) {
            b = false;
            msg.setMsg("权重总和不能大于100！");
        }
/*        if (score + index.getScore() > seoreSum && weights + index.getWeights() >
                weightsSum) {
            msg.setMsg("子级指标分数总和和权重总和不能大于父级！");
        }*/
        if (b) {
            index.setChanger(CommonUtil.getPersonId());
            index.setCreateTime(CommonUtil.getDate());
            index.setCreateDept(CommonUtil.getDefaultDept());
            evaluationService.updateIndex(index);
            evaluationService.updatePlanTestFlag(index.getPlanId(), 0);
            msg.setStatus(1);
        }
        return msg;
    }

    @RequestMapping("/xgEvaluation/task")
    public String task() {
        return "/business/evaluation/student/task/task";
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/getTasks")
    public Map<String, List> getTasks(String name, String evaluationType) {
        if (name != null && name != "") {
            name = "%" + name + "%";
        }
        EvaluationTask task = new EvaluationTask();
        task.setTaskName(name);
        task.setEvaluationType(evaluationType);
        task.setCreateDept(CommonUtil.getDefaultDept());
        task.setLevel(CommonUtil.getLoginUser().getLevel());
        return CommonUtil.tableMap(evaluationService.getTasks(task));
    }

    @RequestMapping("/xgEvaluation/toAddTask")
    public String toAddTask(String evaluationType, Model model) {
        EvaluationPlan plan = new EvaluationPlan();
        String deptId = CommonUtil.getDefaultDept();
        plan.setCreateDept(deptId);
        plan.setEvaluationType(evaluationType);
        plan.setCreateDept(CommonUtil.getDefaultDept());
        plan.setLevel(CommonUtil.getLoginUser().getLevel());
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("plan", evaluationService.getSelectPlan(plan));
        map.put("group", evaluationService.getSelectGroup(plan));
        map.put("type", commonService.getSysDict("JSPJRWLX", ""));
        map.put("xq", commonService.getSysDict("XQ", ""));
        ObjectMapper mapper = new ObjectMapper();
        String json = null;
        try {
            json = mapper.writeValueAsString(map);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        model.addAttribute("data", json);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/student/task/addTask";
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/saveTask")
    public Message saveTask(EvaluationTask task) {
        task.setTaskId(CommonUtil.getUUID());
        CommonUtil.save(task);
        evaluationService.saveTask(task);
        return new Message(0, "添加成功！", "success");
    }

    @RequestMapping("/xgEvaluation/toEditTask")
    public String toEditTask(String id,String evaluationType, Model model) {
        EvaluationPlan plan = new EvaluationPlan();
        plan.setCreateDept(CommonUtil.getDefaultDept());
        plan.setLevel(CommonUtil.getLoginUser().getLevel());
        plan.setEvaluationType(evaluationType);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("plan", evaluationService.getSelectPlan(plan));
        map.put("group", evaluationService.getSelectGroup(plan));
        map.put("type", commonService.getSysDict("JSPJRWLX", ""));
        map.put("xq", commonService.getSysDict("XQ", ""));
        ObjectMapper mapper = new ObjectMapper();
        String json = null;
        try {
            json = mapper.writeValueAsString(map);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        model.addAttribute("task", evaluationService.getTask(id));
        model.addAttribute("taskId", id);
        model.addAttribute("data", json);
        return "/business/evaluation/student/task/editTask";
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/updateTask")
    public Message updateTask(EvaluationTask task) {
        CommonUtil.update(task);
        evaluationService.updateTask(task);
        return new Message(0, "修改成功！", null);
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/delTask")
    public Message delTask(String id) {
        evaluationService.delTask(id);
        return new Message(0, "删除成功！", "success");
    }

    @RequestMapping("/xgEvaluation/toTaskSelectEmps")
    public ModelAndView toSelectEmps(String id, String startFlag, String evaluationType) {
        ModelAndView mv = new ModelAndView("/business/evaluation/student/task/taskEmps");
        mv.addObject("id", id);
        mv.addObject("evaluationType", evaluationType);
        if (startFlag.equals("未启动"))
            mv.addObject("startFlag", 0);
        else
            mv.addObject("startFlag", 1);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/getEmpsByTask")
    public Map<String, List> getEmpsByTask(String id) {
        List<Tree> trees = commonService.getStuTree();
        List<EvaluationEmp> evaluationEmps = evaluationService.getEmpsByTaskId(id);
        Map<String, List> map = new HashMap<String, List>();
        map.put("tree", trees);
        map.put("selected", evaluationEmps);
        return map;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/getEmpsCheckByTask")
    public Map<String, List> getEmpsCheckByTask(String id, String evaluationType) {
        Map<String, List> map = new HashMap<String, List>();
        if (evaluationType.equals("0"))
            map.put("tree", evaluationService.getEmpsCheckByTask(id));
        else if (evaluationType.equals("1"))
            map.put("tree", evaluationService.getClassStudentCheckByTask(id));
        return map;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/saveEmps")
    public Message saveEmps(String ids, String taskId) {
        String[] tmp = ids.split(";");
        evaluationService.deleteEmpsByTaskId(taskId);
        evaluationService.deleteEmpsMenmbersByTaskId(taskId);
        List<EvaluationMembers> evaluationMembers = evaluationService.getMembersByTaskId(taskId);
        String rgx = "^\\d{15}|^\\d{17}([0-9]|X|x)$";
        Pattern p = Pattern.compile(rgx);

        for (String empsIdAndDeptId : tmp) {
            if (p.matcher(empsIdAndDeptId.split(",")[0]).matches()) {
                EvaluationEmp evaluationEmp = new EvaluationEmp();
                evaluationEmp.setEmpsId(CommonUtil.getUUID());
                evaluationEmp.setTaskId(taskId);
                evaluationEmp.setPersonId(empsIdAndDeptId.split(",")[0]);
                evaluationEmp.setDeptId(empsIdAndDeptId.split(",")[1]);
                evaluationEmp.setName(empsIdAndDeptId.split(",")[2]);
                evaluationEmp.setCreator(CommonUtil.getPersonId());
                evaluationEmp.setCreateDept(CommonUtil.getDefaultDept());
                evaluationEmp.setCreateTime(CommonUtil.getDate());
                evaluationService.saveEmps(evaluationEmp);
//                for (EvaluationMembers members : evaluationMembers) {
//                    EvaluationEmpsMenmbers evaluationEmpsMenmbers = new EvaluationEmpsMenmbers();
//                    evaluationEmpsMenmbers.setId(CommonUtil.getUUID());
//                    evaluationEmpsMenmbers.setEmpPersonId(evaluationEmp.getPersonId());
//                    evaluationEmpsMenmbers.setEmpDeptId(evaluationEmp.getDeptId());
//                    evaluationEmpsMenmbers.setEmpName(evaluationEmp.getName());
//                    evaluationEmpsMenmbers.setTaskId(taskId);
//                    evaluationEmpsMenmbers.setEmpsId(evaluationEmp.getEmpsId());
//                    evaluationEmpsMenmbers.setMemberId(members.getMemberId());
//                    evaluationEmpsMenmbers.setMemberPersonId(members.getPersonId());
//                    evaluationEmpsMenmbers.setMemberName(members.getName());
//                    evaluationEmpsMenmbers.setMemberDeptId(members.getDeptId());
//                    CommonUtil.save(evaluationEmpsMenmbers);
//                    evaluationService.savaEmpsMembers(evaluationEmpsMenmbers);
//                }
            }
        }
        evaluationService.updateGroupMembersNum(taskId);
        return new Message(1, "保存成功！", null);
    }

    @RequestMapping("/xgEvaluation/monitor")
    public String monitor() {
        return "/business/evaluation/student/monitor/monitor";
    }

    @RequestMapping("/xgEvaluation/toEmps")
    public String toEmps(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/student/monitor/monitorEmps";
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/getMonitoerEmpsByTaskId")
    public Map getMonitoerEmpsByTaskId(String id, String evaluationType) {
        EvaluationTask etask = new EvaluationTask();
        etask.setTaskId(id);
        etask.setEvaluationType(evaluationType);
        return CommonUtil.tableMap(evaluationService.getMonitoerEmpsByTaskId(etask));
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/getMonitoerTask")
    public Map getMonitoerTask(String taskname, String evaluationType, String planName) {
        EvaluationTask task = new EvaluationTask();
        task.setCreateDept(CommonUtil.getDefaultDept());
        task.setLevel(CommonUtil.getLoginUser().getLevel());
        if (null != taskname && !taskname.equals(""))
            task.setTaskName("%" + taskname + "%");
        if (null != planName && !planName.equals(""))
            task.setPlanName("%" + planName + "%");
        if (null != evaluationType && !evaluationType.equals(""))
            task.setEvaluationType(evaluationType);
        List list = evaluationService.getMonitoerTask(task);
        return CommonUtil.tableMap(list);
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/getMonitoerTaskBySelf")
    public Map getMonitoerTaskBySelf(String taskname, String evaluationType , String planName ) {
        String personId = CommonUtil.getPersonId();
        EvaluationTask task = new EvaluationTask();
        task.setCreator(personId);
        task.setCreateDept(CommonUtil.getDefaultDept());
        task.setLevel(CommonUtil.getLoginUser().getLevel());
        if (null != taskname && !taskname.equals(""))
            task.setTaskName("%" + taskname + "%");
        if (null != planName && !planName.equals(""))
            task.setPlanName("%" + planName + "%");
        task.setEvaluationType(evaluationType);
        List list = evaluationService.getMonitoerTaskBySelf(task);
        return CommonUtil.tableMap(list);
    }

    @RequestMapping("/xgEvaluation/toEmpDetails")
    public String toEmpDetails(String id, String taskId, String name, String taskName, Model model) {
        List<Index> indices = evaluationService.getIndexByTaskId(taskId);
        Integer maxLevel = evaluationService.getMaxLevel(taskId);
        model.addAttribute("id", id);
        model.addAttribute("taskId", taskId);
        model.addAttribute("indices", indices);
        model.addAttribute("maxLevel", maxLevel);
        model.addAttribute("name", name);
        model.addAttribute("taskName", taskName);
        return "/business/evaluation/student/monitor/empDetails";
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/getDetails")
    public Map getDetails(String id, String taskId) {
        List<EvaluationEmpsMenmbers> evaluationMembers = evaluationService.getMembersByTaskIdAndEmpId
                (id, taskId);
        List<Map> data = new ArrayList<Map>();
        List<Index> indices = evaluationService.getIndexByTaskId(taskId);
        for (EvaluationEmpsMenmbers members : evaluationMembers) {
            Map<String, String> tmp = new HashMap<String, String>();
            tmp.put("id", members.getId());
            tmp.put("membersName", members.getMemberName());
            tmp.put("invalidFlag", members.getInvalidFlag());
            tmp.put("evaluationFlag", members.getEvaluationFlag());
            String ScoreVal =members.getScore();
            if(ScoreVal!=null && ScoreVal.subSequence(0, 1).equals(".")){
                ScoreVal ="0"+ScoreVal;
            }
            tmp.put("score", ScoreVal);
            List<EvaluationResult> results = evaluationService.getMonitorResults(id, taskId,
                    members.getMemberPersonId());
            if (results.size() == 0) {
                for (Index index : indices) {
                    if ("1".equals(index.getLeafFlag())) {
                        tmp.put(index.getIndexId() + "-score", "");
                        tmp.put(index.getIndexId() + "-remark", "");
                    }
                }
            } else {
                for (EvaluationResult result : results) {
                    tmp.put(result.getIndexId() + "-score", result.getScore() + "");
                    tmp.put(result.getIndexId() + "-remark", result.getRemark());
                }
            }
            data.add(tmp);
        }
        return CommonUtil.tableMap(data);
    }

    @RequestMapping("/xgEvaluation/result/listEmpsMenmbers")
    public ModelAndView listMenmbers() {
        ModelAndView mv = new ModelAndView("/business/evaluation/student/result/listEmps");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/result/getlisteEmpsMenmbers")
    public Map<String, List<EvaluationEmpsMenmbers>> getlisteEmpsMenmbers(EvaluationEmpsMenmbers eEmps) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        EvaluationEmpsMenmbers eEmpsMenmbers = new EvaluationEmpsMenmbers();
        if (!loginUser.getPersonId().equals("sa")) {
            eEmpsMenmbers.setMemberPersonId(loginUser.getPersonId());
            eEmpsMenmbers.setMemberDeptId(loginUser.getDefaultDeptId());
        }
        if (null != eEmps) {
            if (null != eEmps.getTaskName() && !eEmps.getTaskName().equals("")) {
                eEmpsMenmbers.setTaskName("%" + eEmps.getTaskName() + "%");
            }
            if (null != eEmps.getEmpPersonId() && !eEmps.getEmpPersonId().equals("") && !eEmps.getEmpPersonId()
                    .equals("undefined")) {
                String[] str = eEmps.getEmpPersonId().split(",");
                eEmpsMenmbers.setEmpDeptId(str[0]);
                eEmpsMenmbers.setEmpPersonId(str[1]);
            }
        }
        eEmpsMenmbers.setEvaluationFlag(eEmps.getEvaluationFlag());
        eEmpsMenmbers.setEvaluationType(eEmps.getEvaluationType());

        List<EvaluationEmpsMenmbers> eEMenmbersList = evaluationService.getlistTask(eEmpsMenmbers);
        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();
        for(EvaluationEmpsMenmbers EvalEmpMen: eEMenmbersList){
            if(( date.getTime() -EvalEmpMen.getEndTime().getTime())>1000*60*60*24){
                EvalEmpMen.setValidFlag("0");
            } else {
                EvalEmpMen.setValidFlag("1");
            }
        }
        Map<String, List<EvaluationEmpsMenmbers>> studentList = new HashMap<String, List<EvaluationEmpsMenmbers>>();
        studentList.put("data", eEMenmbersList);
        return studentList;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/result/updateEmpsMenmbers")
    public Message updateEmpsMenmbers(EvaluationEmpsMenmbers eEMenmbers) {
        CommonUtil.update(eEMenmbers);
        evaluationService.updateEmpsMenmbers(eEMenmbers);
        return new Message(0, "删除成功！", null);
    }

    @RequestMapping("/xgEvaluation/result/listResult")
    public ModelAndView gerlistResult(EvaluationEmpsMenmbers evaluationEmpsMenmbers) {
        ModelAndView mv = new ModelAndView("/business/evaluation/student/result/listEditResult");
        LoginUser loginUser = CommonUtil.getLoginUser();
        evaluationEmpsMenmbers.setMemberPersonId(loginUser.getPersonId());
        evaluationEmpsMenmbers.setMemberDeptId(loginUser.getDefaultDeptId());

        List<Index> iList = evaluationService.getlistIndex(evaluationEmpsMenmbers.getPlanId());
        List<Index> iListReturn = new ArrayList<Index>();
        for (Iterator iListItemFir = iList.iterator(); iListItemFir.hasNext(); ) {
            //第一层
            Index indexFir = (Index) iListItemFir.next();
            if (indexFir.getParentIndexId().equals(evaluationEmpsMenmbers.getPlanId()) && indexFir.getLeafFlag()
                    .equals("1")) {
                //第一层 叶子
                iListReturn.add(indexFir);
            } else if (indexFir.getParentIndexId().equals(evaluationEmpsMenmbers.getPlanId()) && indexFir.getLeafFlag
                    ().equals("0")) {
                //第二层
                List<Index> iListSe = new ArrayList<Index>();
                for (Iterator iListItemSe = iList.iterator(); iListItemSe.hasNext(); ) {
                    Index indexSe = (Index) iListItemSe.next();
                    if (indexSe.getParentIndexId().equals(indexFir.getIndexId()) && indexSe.getLeafFlag().equals("1")) {
                        //第二层叶子
                        iListSe.add(indexSe);
                    } else if (indexSe.getParentIndexId().equals(indexFir.getIndexId()) && indexSe.getLeafFlag()
                            .equals("0")) {
                        //第三层
                        List<Index> iListThr = new ArrayList<Index>();
                        for (Iterator iListItemThr = iList.iterator(); iListItemThr.hasNext(); ) {
                            Index indexThr = (Index) iListItemThr.next();
                            if (indexThr.getParentIndexId().equals(indexSe.getIndexId())) {
                                //第三层叶子
                                iListThr.add(indexThr);
                            }
                        }
                        indexSe.setIndexList(iListThr);
                        iListSe.add(indexSe);
                    }
                }
                indexFir.setIndexList(iListSe);
                iListReturn.add(indexFir);
            }
        }
        mv.addObject("iList", iListReturn);
        mv.addObject("taskId", evaluationEmpsMenmbers.getTaskId());
        mv.addObject("empPersonId", evaluationEmpsMenmbers.getEmpPersonId());
        mv.addObject("empDeptId", evaluationEmpsMenmbers.getEmpDeptId());
        mv.addObject("empName", evaluationEmpsMenmbers.getEmpName());
        mv.addObject("taskName", evaluationEmpsMenmbers.getTaskName());
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/result/insertResult")
    public Message updateResult(String taskId, String empPersonId, String empDeptId, String returnValue, String
            empName) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        String memberPersonId = loginUser.getPersonId(); //memberPersonId = "a88c0353-bc45-4c27-85a1-96aa86ba1d72";
        String memberDeptId = loginUser.getDefaultDeptId();// memberDeptId = "001001";
        String memberName = loginUser.getName();

        evaluationService.insertResult(taskId, empPersonId, empDeptId, returnValue, empName ,
                memberPersonId ,memberDeptId  , memberName);

/*
        EvaluationResult eResult = new EvaluationResult();
        eResult.setCreateDept(memberDeptId);
        eResult.setCreator(memberPersonId);
        eResult.setMemberDeptId(memberDeptId);
        eResult.setMemberPersonId(memberPersonId);
        eResult.setMemberName(memberName);

        eResult.setTaskId(taskId);

        eResult.setEmpPersonId(empPersonId);
        eResult.setEmpDeptId(empDeptId);
        eResult.setEmpName(empName);
        evaluationService.delectResult(eResult);
        String[] result = returnValue.split("@@@@");
        for (int i = 0; i < result.length; i++) {
            String resultStr = result[i];
            String[] r = resultStr.split("##");
            String indexId = r[0];
            String score = r[1];
            if (r.length > 2) {
                String remark = r[2];
                eResult.setRemark(remark);
            }
            eResult.setIndexId(indexId);
            eResult.setScore(Double.parseDouble(score));
            eResult.setResultId(CommonUtil.getUUID());
            evaluationService.insertResult(eResult);
        }
        EvaluationEmpsMenmbers eEMenmbers = new EvaluationEmpsMenmbers();
        eEMenmbers.setTaskId(taskId);
        eEMenmbers.setMemberPersonId(memberPersonId);
        eEMenmbers.setMemberDeptId(memberDeptId);
        eEMenmbers.setEmpDeptId(empDeptId);
        eEMenmbers.setEmpPersonId(empPersonId);
        evaluationService.updateEvaluationEmpMenmber(eEMenmbers);
*/
//        evaluationService.updateEmpsMenmbers(taskId);
        return new Message(0, "保存成功！", null);
    }

    @RequestMapping("/xgEvaluation/toInvalid")
    public String toInvalid(String id, Model model) {
        model.addAttribute("id", id);
        return "/business/evaluation/student/monitor/invalid";
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/invalid")
    public Message invalid(EvaluationEmpsMenmbers menmber) {
        menmber.setInvalidFlag("1");
        menmber.setInvalidOperator(CommonUtil.getPersonId());
        menmber.setInvalidOperatorDept(CommonUtil.getDefaultDept());
        evaluationService.invalid(menmber);
        return new Message(0, "操作成功！", null);
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/checkInvalid")
    public Message checkInvalid(String id) {
        EvaluationEmpsMenmbers menmber = evaluationService.getEmpsMenmbersById(id);
        Message msg;
        if ("1".equals(menmber.getInvalidFlag())) {
            msg = new Message(1, menmber.getMemberName() + "的评分已经是废票了！", null);
        } else {
            msg = new Message(0, "", null);
        }
        return msg;
    }

    //已经评分查询
    @RequestMapping("/xgEvaluation/result/searchEmpsMenmbers")
    public ModelAndView searchListMenmbers() {
        ModelAndView mv = new ModelAndView("/business/evaluation/student/result/searchListEmps");
        return mv;
    }

    @RequestMapping("/xgEvaluation/result/searchListResult")
    public ModelAndView searchListResult(EvaluationEmpsMenmbers evaluationEmpsMenmbers) {
        ModelAndView mv = new ModelAndView("/business/evaluation/student/result/viewListEditResult");
        LoginUser loginUser = CommonUtil.getLoginUser();
        evaluationEmpsMenmbers.setMemberPersonId(loginUser.getPersonId());
        evaluationEmpsMenmbers.setMemberDeptId(loginUser.getDefaultDeptId());

        List<EvaluationResult> eResultSearchList = evaluationService.searchlistIndex(evaluationEmpsMenmbers);
        List<EvaluationResult> eListReturn = new ArrayList<EvaluationResult>();
        for (Iterator eListItemFir = eResultSearchList.iterator(); eListItemFir.hasNext(); ) {
            //第一层
            EvaluationResult eListFir = (EvaluationResult) eListItemFir.next();
            if (eListFir.getParentIndexId().equals(evaluationEmpsMenmbers.getPlanId()) && eListFir.getLeafFlag()
                    .equals("1")) {
                //第一层 叶子
                eListReturn.add(eListFir);
            } else if (eListFir.getParentIndexId().equals(evaluationEmpsMenmbers.getPlanId()) && eListFir.getLeafFlag
                    ().equals("0")) {
                //第二层
                List<EvaluationResult> eListSe = new ArrayList<EvaluationResult>();
                for (Iterator eListItemSe = eResultSearchList.iterator(); eListItemSe.hasNext(); ) {
                    EvaluationResult eResultSe = (EvaluationResult) eListItemSe.next();
                    if (eResultSe.getParentIndexId().equals(eListFir.getIndexId()) && eResultSe.getLeafFlag().equals
                            ("1")) {
                        //第二层叶子
                        eListSe.add(eResultSe);
                    } else if (eResultSe.getParentIndexId().equals(eListFir.getIndexId()) && eResultSe.getLeafFlag()
                            .equals("0")) {
                        //第三层
                        List<EvaluationResult> eListThr = new ArrayList<EvaluationResult>();
                        for (Iterator eListItemThr = eResultSearchList.iterator(); eListItemThr.hasNext(); ) {
                            EvaluationResult eResultThr = (EvaluationResult) eListItemThr.next();
                            if (eResultThr.getParentIndexId().equals(eResultSe.getIndexId())) {
                                //第三层叶子
                                eListThr.add(eResultThr);
                            }
                        }
                        eResultSe.setEvalList(eListThr);
                        eListSe.add(eResultSe);
                    }
                }
                eListFir.setEvalList(eListSe);
                eListReturn.add(eListFir);
            }
        }
        mv.addObject("eList", eListReturn);
        mv.addObject("taskId", evaluationEmpsMenmbers.getTaskId());
        mv.addObject("empPersonId", evaluationEmpsMenmbers.getEmpPersonId());
        mv.addObject("empDeptId", evaluationEmpsMenmbers.getEmpDeptId());
        mv.addObject("empName", evaluationEmpsMenmbers.getEmpName());
        mv.addObject("taskName", evaluationEmpsMenmbers.getTaskName());
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/startTask")
    public Message startTask(String id) {
        //evaluationService.delectEmpsMembers(id);
        EvaluationTask task = evaluationService.getTask(id);
        Message message = new Message();
        List<EvaluationGroupEmps> evaluationGroupEmps = evaluationService.getEmpsTreeByTaskId(task.getTaskId());
        List<EvaluationMembers> evaluationMembers = evaluationService.getMembersByTaskId(task.getTaskId());
        if (evaluationGroupEmps ==null || evaluationGroupEmps.size() == 0) {
            message.setMsg("被评人组中无人员信息！");
            message.setResult("error");
            message.setStatus(0);
        } else if (evaluationMembers == null || evaluationMembers.size() == 0) {
            message.setMsg("评委组中无人员信息！");
            message.setResult("error");
            message.setStatus(0);
        } else if ("1".equals(task.getStartFlag())) {
            message.setMsg(task.getTaskName() + "已经启动！");
            message.setResult("success");
            message.setStatus(1);
        } else {
            task.setStartFlag("1");
            evaluationService.updateTask(task);
            task.setCreateDept(CommonUtil.getDefaultDept());
            task.setCreator(CommonUtil.getPersonId());
            evaluationService.insertEmpsMembers(task);
            message.setMsg(task.getTaskName() + "启动成功！");
            message.setResult("success");
            message.setStatus(1);
        }
        return message;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/checkPlan")
    public Message checkPlan(String id) {
        Message message = new Message();
        Integer score = evaluationService.calPlanScore(id);
        EvaluationPlan plan = evaluationService.getPlan(id);
        Integer weights = evaluationService.calPlanWights(id);
        String msg = "验证未通过！";
        if (score != null || weights != null) {
            if (weights != 100) {
                msg += "权重总和与总权重相差" + (100 - weights) + "，";

            }
/*            if (score != Integer.parseInt(plan.getScore())) {
                msg += "指标分数总和与总分相差" + (Integer.parseInt(plan.getScore()) - score) + "，";
            }*/
            msg += "请修改！";
            message.setResult("error");
            /*if (weights == 100 && score == Integer.parseInt(plan.getScore())) {*/
            if (weights == 100) {
                plan.setTestFlag("1");
                evaluationService.updatePlanTestFlag(id, 1);
                msg = "验证通过！";
                message.setResult("success");
            }
        } else {
            msg = "当前方案没有指标，请添加指标！";
            message.setResult("error");
        }

        message.setMsg(msg);
        return message;
    }

    //评教结果
    @RequestMapping("/xgEvaluation/statistics/queryResult")
    public String queryResult() {
        return "/business/evaluation/student/statistics/queryResult";
    }

    @RequestMapping("/xgEvaluation/statistics/resultEmps")
    public String resultEmps(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/student/statistics/resultEmps";
    }

    @RequestMapping("/xgEvaluation/statistics/order")
    public String statisticsOrder() {
        return "/business/evaluation/student/statistics/queryResultOrder";
    }

    @RequestMapping("/xgEvaluation/statistics/resultEmpsOrder")
    public String resultEmpsOrder(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/student/statistics/resultEmpsOeder";
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/statistics/getMonitoerEmpsOeder")
    public Map getMonitoerEmpsOeder(EvaluationTask etask) {
        return CommonUtil.tableMap(evaluationService.getMonitoerEmpsOrder(etask));
    }


    @RequestMapping("/xgEvaluation/statistics/monitorBySelf")
    public String monitorBySelf() {
        return "/business/evaluation/student/statistics/monitorBySelf";
    }

    @RequestMapping("/xgEvaluation/statistics/detailsBySelf")
    public String resultDetails(String id, String taskName, String evaluationType, Model model) {
        List<Index> indices = evaluationService.getIndexByTaskId(id);
        Integer maxLevel = evaluationService.getMaxLevel(id);
        LoginUser loginUser = CommonUtil.getLoginUser();
        model.addAttribute("id", loginUser.getPersonId());
        model.addAttribute("taskId", id);
        model.addAttribute("indices", indices);
        model.addAttribute("maxLevel", maxLevel);
        model.addAttribute("name", loginUser.getName());
        model.addAttribute("taskName", taskName);
        String person = loginUser.getPersonId();
        String deptId = loginUser.getDefaultDeptId();
        EvaluationTask etask = new EvaluationTask();
        etask.setTaskId(id);
        etask.setEvaluationType(evaluationType);
        List<EvaluationEmp> eEmp = evaluationService.getMonitoerEmpsOrder(etask);
        String headerView = "";
        for (int i = 0; i < eEmp.size(); i++) {
            EvaluationEmp e = eEmp.get(i);
            if (e.getPersonId().equals(person) && e.getDeptId().equals(deptId)) {
                headerView = "<div class=\"col-md-1 tar\">姓名:</div><div class=\"col-md-1\">" + loginUser.getName() +
                        "</div>" +
                        "<div class=\"col-md-1 tar\">排行:</div><div class=\"col-md-1\">" + e.getTotalOrder() + "</div>" +
                        "<div class=\"col-md-1 tar\">得分:</div><div class=\"col-md-1\">" + e.getTotal() + "</div>";
            }
        }
        model.addAttribute("headerView", headerView);
        return "/business/evaluation/student/statistics/resultDetails";
    }

    @RequestMapping("/xgEvaluation/exportEvaluationResult")
    public void exportEvaluationResult(String id, String name, String evaluationType, int flag, HttpServletResponse
            response) {
        EvaluationTask etask = new EvaluationTask();
        etask.setTaskId(id);
        etask.setEvaluationType(evaluationType);
        List<EvaluationEmp> evaluationEmps = evaluationService.getMonitoerEmpsOrder(etask);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet(name);
        //创建HSSFRow对象
        HSSFRow hssfRow = sheet.createRow(0);
        String[] strs1 = {"被评人", "被评人班级", "进度", "总分"};
        String[] strs2 = {"排名", "被评人", "被评人班级", "进度", "总分"};
        int tmp = 1;
        if (flag == 1) {
            for (int i = 0; i < strs1.length; i++) {
                hssfRow.createCell(i).setCellValue(strs1[i]);
            }
            for (EvaluationEmp evaluationEmp : evaluationEmps) {
                HSSFRow row = sheet.createRow(tmp);
                //创建HSSFCell对象
                row.createCell(0).setCellValue(evaluationEmp.getName());
                row.createCell(1).setCellValue(evaluationEmp.getDeptShow());
                row.createCell(2).setCellValue(evaluationEmp.getSchedule());
                row.createCell(3).setCellValue(evaluationEmp.getTotal());
                tmp++;
            }
        } else {
            for (int i = 0; i < strs2.length; i++) {
                hssfRow.createCell(i).setCellValue(strs2[i]);
            }
            for (EvaluationEmp evaluationEmp : evaluationEmps) {
                HSSFRow row = sheet.createRow(tmp);
                //创建HSSFCell对象
                row.createCell(0).setCellValue(evaluationEmp.getTotalOrder());
                row.createCell(1).setCellValue(evaluationEmp.getName());
                row.createCell(2).setCellValue(evaluationEmp.getDeptShow());
                row.createCell(3).setCellValue(evaluationEmp.getSchedule());
                row.createCell(4).setCellValue(evaluationEmp.getTotal());
                tmp++;
            }
        }

        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    (name + ".xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @RequestMapping("/xgEvaluation/complex/getTaskList")
    public ModelAndView complexTaskList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/student/complex/complexTaskList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/complex/getComplexTask")
    public Map getComplexTask(EvaluationComplexTask ecTask) {
        if (null != ecTask.getComplexTaskName() && !ecTask.getComplexTaskName().equals(""))
            ecTask.setComplexTaskName("%" + ecTask.getComplexTaskName() + "%");
        ecTask.setCreateDept(CommonUtil.getDefaultDept());
        ecTask.setLevel(CommonUtil.getLoginUser().getLevel());
        List<EvaluationComplexTask> list = evaluationService.getEvaluationComplexTask(ecTask);
        return CommonUtil.tableMap(list);
    }

    @RequestMapping("/xgEvaluation/complex/addComplexTask")
    public ModelAndView addComplexTask(String evaluationType) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("evaluationType", evaluationType);
        mv.setViewName("/business/evaluation/student/complex/addComplexTask");
        return mv;
    }

    @RequestMapping("/xgEvaluation/complex/editComplexTask")
    public ModelAndView editComplexTask(String complexTaskId, String testFlag) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/student/complex/editComplexTask");
        EvaluationComplexTask ecTask = evaluationService.getEvaluationComplexTaskByid(complexTaskId);
        mv.addObject("ecTask", ecTask);
        mv.addObject("testFlag", testFlag);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/complex/saveComplexTask")
    public Message saveComplexTask(EvaluationComplexTask ecTask) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (null == ecTask.getComplexTaskId() || ecTask.getComplexTaskId().equals("")) {
            String ComplexTaskId = CommonUtil.getUUID();
            ecTask.setCreateDept(loginUser.getDefaultDeptId());
            ecTask.setCreator(loginUser.getPersonId());
            ecTask.setComplexTaskId(ComplexTaskId);
            evaluationService.saveComplexTask(ecTask);
            return new Message(1, "添加成功！", null);
        } else {
            ecTask.setChangeDept(loginUser.getDefaultDeptId());
            ecTask.setChanger(loginUser.getPersonId());
            evaluationService.updateComplexTask(ecTask);
            return new Message(1, "修改成功！", null);
        }
    }

    @RequestMapping("/xgEvaluation/complex/editChildTask")
    public ModelAndView editChildTask(EvaluationComplexTask ecTask) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/student/complex/detail/complexDetailList");
        mv.addObject("complexTaskId", ecTask.getComplexTaskId());
        mv.addObject("term", ecTask.getTerm());
        mv.addObject("testFlag", ecTask.getTestFlag());
        mv.addObject("evaluationType", ecTask.getEvaluationType());
        mv.addObject("complexTaskName", ecTask.getComplexTaskName());
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/complex/getComplexDetail")
    public Map getComplexDetail(String complexTaskId) {
        List<EvaluationComplexDetail> list = evaluationService.getEvaluationComplexDetail(complexTaskId);
        return CommonUtil.tableMap(list);
    }

    @RequestMapping("/xgEvaluation/complex/addComplexDetail")
    public ModelAndView addComplexDetail(String complexTaskId, String term, String evaluationType) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/student/complex/detail/addComplexDetail");
        mv.addObject("complexTaskId", complexTaskId);
        mv.addObject("term", term);
        mv.addObject("evaluationType", evaluationType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/complex/saveDetail")
    public Message saveDetail(EvaluationComplexDetail ecDetail) {
        Integer weights = evaluationService.getDetailWeights(ecDetail.getComplexTaskId());
        if (null == weights) {
            weights = 0;
        }
        Integer weightsSum = weights + ecDetail.getWeights();
        if (weightsSum > 100) {
            return new Message(0, "总权重超过100，请重新编辑！", null);
        }
        String taksId = ecDetail.getTaskId();
        if (taksId.indexOf(",") == -1) {
            EvaluationTask eTask = evaluationService.getTask(taksId);
            EvaluationPlan plan = evaluationService.getPlan(eTask.getPlanId());
            ecDetail.setScore(plan.getScore());
        }
        LoginUser loginUser = CommonUtil.getLoginUser();
        ecDetail.setCreateDept(loginUser.getDefaultDeptId());
        ecDetail.setCreator(loginUser.getPersonId());
        evaluationService.seveComplexDetail(ecDetail);
        return new Message(1, "添加成功！", null);
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/complex/checkDetailWeights")
    public Message checkDetailWeights(String complexTaskId) {
        Integer weights = evaluationService.getDetailWeights(complexTaskId);
        if (null == weights) {
            return new Message(1, "", null);
        } else if (weights > 100) {
            return new Message(0, "总权重已超过100！", null);
        } else if (weights == 100) {
            return new Message(0, "总权重已满100！", null);
        } else {
            return new Message(1, "", null);
        }
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/complex/delChildTask")
    public Message delChildTask(String id) {
        evaluationService.delComplexDetail(id);
        return new Message(1, "删除成功！", null);
    }

    @RequestMapping("/xgEvaluation/complex/viewComplexDetail")
    public ModelAndView viewComplexDetail(String id) {
        EvaluationComplexDetail ecDetail = evaluationService.getEvaluationComplexDetailByid(id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/student/complex/detail/viewComplexDetail");
        mv.addObject("ecDetail", ecDetail);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/complex/checkChildTask")
    public Message checkChildTask(String complexTaskId) {
        Integer weights = evaluationService.getDetailWeights(complexTaskId);
        if (weights == 0) {
            return new Message(0, "当前评教未添加子评教！", null);
        } else if (weights == 100) {
            evaluationService.checkComplexTask(complexTaskId);
            evaluationService.delComplexResult(complexTaskId);
            List<EvaluationComplexDetail> list1 = evaluationService.getEvaluationComplexDetail(complexTaskId);
            for (int i = 0; i < list1.size(); i++) {
                EvaluationComplexDetail ecDetail = list1.get(i);
                if (ecDetail.getTaskId().indexOf(",") > 0) {// 包含多项子项
                    evaluationService.insertComplexResultByTaskList(ecDetail);
                } else {// 包含单项子项
                    evaluationService.insertComplexResultBySingleTask(ecDetail);
                }
            }
            return new Message(1, "校验成功,并生成评教结果！", null);
        } else {
            return new Message(0, "验证未通过！权重总和与总权重相差" + (100 - weights) + "，请修改！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/complex/delComplexTask")
    public Message delComplexTask(String id) {
        evaluationService.delComplexDetail(id);
        evaluationService.delComplexTask(id);
        evaluationService.delComplexResult(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/complex/insertResult")
    public Message insertResult(String complexTaskId) {
        evaluationService.delComplexResult(complexTaskId);
        List<EvaluationComplexDetail> list = evaluationService.getEvaluationComplexDetail(complexTaskId);
        for (int i = 0; i < list.size(); i++) {
            EvaluationComplexDetail ecDetail = list.get(i);
            if (ecDetail.getTaskId().indexOf(",") > 0) {// 包含多项子项
                evaluationService.insertComplexResultByTaskList(ecDetail);
            } else {// 包含单项子项
                evaluationService.insertComplexResultBySingleTask(ecDetail);
            }
        }
        return new Message(1, "生成成功！", null);
    }

    @RequestMapping("/xgEvaluation/complex/getComplexResult")
    public ModelAndView getComplexResult() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/student/complex/result/complexResultList");
        return mv;
    }

    @RequestMapping("/xgEvaluation/complex/getResult")
    public ModelAndView getResult(String complexTaskId, String complexTaskName, String evaluationType) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/student/complex/result/complexTaskResultList");
        List<EvaluationComplexDetail> details = evaluationService.getEvaluationComplexDetail(complexTaskId);
        mv.addObject("details", details);
        mv.addObject("complexTaskId", complexTaskId);
        mv.addObject("complexTaskName", complexTaskName);
        mv.addObject("evaluationType", evaluationType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/complex/getComplexResultList")
    public Map getComplexResultList(String complexTaskId, String evaluationType) {
        EvaluationComplexDetail str = new EvaluationComplexDetail();
        str.setComplexTaskId(complexTaskId);
        str.setEvaluationType(evaluationType);
        List<EvaluationComplexResult> list = evaluationService.getEvaluationComplexSumResult(str);
        List<Map> data = new ArrayList<Map>();
        List<Map> dataLast = new ArrayList<Map>();
        //评分项 Detail
        List<EvaluationComplexDetail> details = evaluationService.getEvaluationComplexDetail(complexTaskId);
        for (EvaluationComplexResult complexResult : list) {
            boolean b = false;
            Map<String, String> tmp = new HashMap<String, String>();
            tmp.put("empName", complexResult.getEmpName());
            tmp.put("deptShow", complexResult.getDeptShow());
            tmp.put("score", complexResult.getScore());
            // 每单项分数  Result
            complexResult.setEvaluationType(evaluationType);
            List<EvaluationComplexResult> results = evaluationService.getEvaluationComplexResult(complexResult);
            if (results.size() == 0) {
                for (EvaluationComplexDetail detail : details) {
                    tmp.put(detail.getId() + "-score", "");
                    tmp.put(detail.getId() + "-remark", "");
                    b = true;
                }
            } else {
                for (EvaluationComplexResult result : results) {
                    tmp.put(result.getComplexDetailId() + "-score", result.getScore() + "");
                    tmp.put(result.getComplexDetailId() + "-remark", result.getFullMarks());
                }
                if (details.size() != results.size()) {
                    for (EvaluationComplexDetail detail : details) {
                        int i = 0;
                        for (EvaluationComplexResult result : results) {
                            if (!detail.getId().equals(result.getComplexDetailId())) {
                                i++;
                            }
                        }
                        if (i == results.size()) {
                            tmp.put(detail.getId() + "-score", "");
                            tmp.put(detail.getId() + "-remark", "");
                            b = true;
                        }
                    }
                }
            }
            if(b){
                dataLast.add(tmp);
            }else{
                data.add(tmp);
            }
        }
        data.addAll(dataLast);
        return CommonUtil.tableMap(data);

    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/complex/exportComplexResult")
    public void getComplexResultLista(String complexTaskId, String complexTaskName, HttpServletResponse
            response) {
        EvaluationComplexDetail str = new EvaluationComplexDetail();
        str.setComplexTaskId(complexTaskId);
        str.setEvaluationType("");
        List<EvaluationComplexResult> list = evaluationService.getEvaluationComplexSumResult(str);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("综合评教结果");
        //创建HSSFRow对象
        HSSFRow hssfRow = sheet.createRow(0);
        int tmp = 0;
        HSSFRow rowhead = sheet.createRow(tmp);
        //创建HSSFCell对象
        rowhead.createCell(0).setCellValue("评教人");
        rowhead.createCell(1).setCellValue("评教人部门");
        rowhead.createCell(2).setCellValue("分数");
        tmp++;
        for (EvaluationComplexResult ecResult : list) {
            HSSFRow row = sheet.createRow(tmp);
            //创建HSSFCell对象
            row.createCell(0).setCellValue(ecResult.getEmpName());
            row.createCell(1).setCellValue(ecResult.getDeptShow());
            row.createCell(2).setCellValue(ecResult.getScore());
            tmp++;
        }

        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    (complexTaskName + "评教评分.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @RequestMapping("/xgEvaluation/exportEvaluationResultList")
    public void exportEvaluationResultList(String taskIds, String evaluationType, HttpServletResponse response) {
        Map<String, List<EvaluationEmp>> map = evaluationService.exportEvaluationResultList(taskIds, evaluationType);

        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        String[] strs1 = {"","任务名称", "评教方案", "班级",  "被评教学生", "参评人总数", "参评人数", "评价平均分"};

        Iterator iter = map.entrySet().iterator();
        while (iter.hasNext()) {
            Map.Entry entry = (Map.Entry) iter.next();
            String key = (String)entry.getKey();
            List<EvaluationEmp> evaluationEmpList = (List<EvaluationEmp>) entry.getValue();
            //创建HSSFSheet对象
            HSSFSheet sheet = wb.createSheet(key);
            CellRangeAddress cra=new CellRangeAddress(0, 0, 0, 7);
            //在sheet里增加合并单元格
            sheet.addMergedRegion(cra);
            // 评教方案结果查询
            HSSFRow hssfRow1 = sheet.createRow(0);
            hssfRow1.createCell(0).setCellValue("评教方案结果查询");

            //创建HSSFRow对象
            HSSFRow hssfRow = sheet.createRow(1);
            int tmp = 2;
            for (int i = 0; i < strs1.length; i++) {
                hssfRow.createCell(i).setCellValue(strs1[i]);
            }
            int i = 1 ;
            for (EvaluationEmp evaluationEmp : evaluationEmpList) {
                HSSFRow row = sheet.createRow(tmp);
                //创建HSSFCell对象
                row.createCell(0).setCellValue(i);
                row.createCell(1).setCellValue(evaluationEmp.getName());
                row.createCell(2).setCellValue(evaluationEmp.getPlanName());
                row.createCell(3).setCellValue(evaluationEmp.getDeptId());
                row.createCell(4).setCellValue(evaluationEmp.getPersonId());
                row.createCell(5).setCellValue(evaluationEmp.getTotalNumber());
                row.createCell(6).setCellValue(evaluationEmp.getNumber());
                if(null == evaluationEmp.getTotal()|| evaluationEmp.getTotal().equals(""))
                    row.createCell(7).setCellValue("0");
                else
                    row.createCell(7).setCellValue(evaluationEmp.getTotal());
                tmp++;
                i++;
            }
        }

        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("评教结果.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @RequestMapping("/xgEvaluation/tostudentGroupList")
    public ModelAndView getGroupList(String complexTaskId, String complexTaskName, String evaluationType) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/student/studentGroup/groupList");
        List<EvaluationComplexDetail> details = evaluationService.getEvaluationComplexDetail(complexTaskId);
        mv.addObject("details", details);
        mv.addObject("complexTaskId", complexTaskId);
        mv.addObject("complexTaskName", complexTaskName);
        mv.addObject("evaluationType", evaluationType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/getStudentGroupList")
    public Map getList(Group group) {
        group.setCreateDept(CommonUtil.getDefaultDept());
        group.setLevel(CommonUtil.getLoginUser().getLevel());
        return CommonUtil.tableMap(evaluationService.getEmpGroupList(group));
    }

    @RequestMapping("/xgEvaluation/toStudentGroupAdd")
    public ModelAndView toStudentGroupAdd() {
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "新增");
        mv.setViewName("/business/evaluation/student/studentGroup/editStudentGroup");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/saveStudentGroup")
    public Message save(Group group) {
        if (null == group.getGroupId() || "".equals(group.getGroupId())) {
            group.setGroupId(CommonUtil.getUUID());
            CommonUtil.save(group);
            evaluationService.saveEmpGroup(group);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(group);
            evaluationService.updateEmpGroup(group);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/xgEvaluation/toStudentGroupEdit")
    public ModelAndView toEdit(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/student/studentGroup/editStudentGroup");
        mv.addObject("group", evaluationService.getEmpGroup(id));
        mv.addObject("head", "修改");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/deleteStudentGroup")
    public Message del(String id) {
        Message message = new Message(1, "删除成功！", "success");
        List<EvaluationTask> evaluationTasks = evaluationService.getTasksByEmpGroupId(id);
        if (evaluationTasks.size() == 0) {
            evaluationService.deleteEmpGroup(id);
            evaluationService.deleteMemberByEmpGroupId(id);
        } else {
            message.setMsg("该被评人组已经被使用，不能删除！");
            message.setResult("error");
        }
        return message;
    }

    @RequestMapping("/xgEvaluation/toSelectEmp")
    public ModelAndView getSelectEmpTree(String id, String evaluationType) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/student/studentGroup/selectStudent");
        mv.addObject("id", id);
        mv.addObject("evaluationType", evaluationType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/getStudentTree")
    public Map<String, List> getEmpsTree(String groupId, String evaluationType) {
        List<Tree> trees = null;
        if ("0".equals(evaluationType)) {
            trees = commonService.getEmpTree();
        }else if ("1".equals(evaluationType)) {
            trees = commonService.getStuTree();
        }
        List<EvaluationGroupEmps> evaluationGroupEmps = evaluationService.getEmpsTree(groupId);
        Map<String, List> map = new HashMap<String, List>();
        map.put("tree", trees);
        map.put("selected", evaluationGroupEmps);
        return map;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/saveGroupEmps")
    public Message saveGroupEmps(String ids, String groupId, String evaluationType) {
        evaluationService.deleteGroupEmps(groupId);
        evaluationService.saveGroupEmps(ids, groupId,evaluationType);
        return new Message(1, "保存成功！", null);
    }

    /*  评教功能复制 */
    @ResponseBody
    @RequestMapping("/xgEvaluation/editCopyMemberGroup")
    public Message editCopyMemberGroup(String id) {
        evaluationService.editCopyMemberGroup(id);
        return new Message(1, "复制成功！", null);
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/editCopyPlan")
    public Message editCopyPlan(String id) {
        evaluationService.editCopyPlan(id);
        return new Message(1, "复制成功！", null);
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/editCopyEmpGroup")
    public Message editCopyEmpGroup(String id) {
        evaluationService.editCopyEmpGroup(id);
        return new Message(1, "复制成功！", null);
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/editCopyTask")
    public Message editCopyTask(String id) {
        evaluationService.editCopyTask(id);
        return new Message(1, "复制成功！", null);
    }

    @RequestMapping("/xgEvaluation/toTaskSelectMembers")
    public ModelAndView toTaskSelectMembers(String id, String startFlag, String evaluationType) {
        ModelAndView mv = new ModelAndView("/business/evaluation/student/task/taskMembers");
        mv.addObject("id", id);
        mv.addObject("evaluationType", evaluationType);
        if (startFlag.equals("未启动"))
            mv.addObject("startFlag", 0);
        else
            mv.addObject("startFlag", 1);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/getMembersByTask")
    public Map<String, List> getMembersByTask(String id, String evaluationType) {
        return evaluationService.getMembersByTaskIDType(id);
    }

    @RequestMapping("/xgEvaluation/setProportion")
    public ModelAndView setProportion(String id , String taskName) {
        ModelAndView mv = new ModelAndView("/business/evaluation/student/task/setProportion");
        mv.addObject("id", id);
        mv.addObject("task",evaluationService.getTask(id)) ;
        mv.addObject("taskName", taskName);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/saveProportion")
    public Message saveProportion(EvaluationTask task) {
        evaluationService.saveProportion(task);
        return new Message(1, "设置成功！", null);
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/setStartFlagByTaskId")
    public Message setStartFlagByTaskId(String taskId,String startFlag) {
        evaluationService.setStartFlagByTaskId(taskId,startFlag);
        return new Message(1, "修改成功！", null);
    }

    @RequestMapping("/xgEvaluation/complex/checkEmpsList")
    public ModelAndView checkEmpsList(String complexTaskId, String complexTaskName, String evaluationType) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/student/complex/result/complexCheckEmpsList");
        List<EvaluationComplexDetail> details = evaluationService.getEvaluationComplexDetail(complexTaskId);
        mv.addObject("details", details);
        mv.addObject("complexTaskId", complexTaskId);
        mv.addObject("complexTaskName", complexTaskName);
        mv.addObject("evaluationType", evaluationType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/xgEvaluation/complex/getcheckEmpsList")
    public Map getcheckEmpsList(String complexTaskId, String evaluationType) {
        EvaluationComplexDetail str = new EvaluationComplexDetail();
        str.setComplexTaskId(complexTaskId);
        str.setEvaluationType(evaluationType);
        // 所有被评分人
        List<EvaluationComplexResult> list = evaluationService.getEvaluationComplexSumResult(str);
        if( null ==list || list.size()==0 ){
            evaluationService.delComplexResult(complexTaskId);
            List<EvaluationComplexDetail> list1 = evaluationService.getEvaluationComplexDetail(complexTaskId);
            for (int i = 0; i < list1.size(); i++) {
                EvaluationComplexDetail ecDetail = list1.get(i);
                if (ecDetail.getTaskId().indexOf(",") > 0) {// 包含多项子项
                    evaluationService.insertComplexResultByTaskList(ecDetail);
                } else {// 包含单项子项
                    evaluationService.insertComplexResultBySingleTask(ecDetail);
                }
            }
        }
        return evaluationService.getcheckEmpsList(complexTaskId, evaluationType);
    }

}
