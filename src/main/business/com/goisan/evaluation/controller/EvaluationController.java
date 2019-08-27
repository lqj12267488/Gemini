package com.goisan.evaluation.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.goisan.evaluation.bean.EvaluationMembers;
import com.goisan.system.bean.*;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.EmpService;
import com.goisan.evaluation.service.EvaluationService;
import com.goisan.system.service.ParameterService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.system.tools.TimerTask;
import org.apache.ibatis.annotations.Param;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.goisan.evaluation.bean.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.NumberFormat;
import java.util.*;
import java.util.regex.Pattern;

/**
 * Created by Admin on 2017/5/23.
 */
@Controller
public class EvaluationController {
    @Resource
    public EvaluationService evaluationService;

    @Resource
    public CommonService commonService;

    @Resource
    public EmpService empService;

    @Resource
    public ParameterService parameterService;

    @RequestMapping("/evaluation/group")
    public String group() {
        return "/business/evaluation/employee/group/group";
    }

    @RequestMapping("/evaluation/addGroup")
    public String toAddGroup() {
        return "/business/evaluation/employee/group/addGroup";
    }

    @ResponseBody
    @RequestMapping("/evaluation/saveGroup")
    public Message saveGroup(Group group) {
        group.setGroupId(CommonUtil.getUUID());
        group.setCreateDept(CommonUtil.getDefaultDept());
        group.setCreator(CommonUtil.getPersonId());
        group.setCreateTime(CommonUtil.getDate());
        evaluationService.saveGroup(group);
        return new Message(1, "添加成功！", null);
    }

    @ResponseBody
    @RequestMapping("/evaluation/deleteGroup")
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
    @RequestMapping("/evaluation/getGroupList")
    public Map getGroupList(String groupName, String evaluationType) {
        Group group = new Group();
        group.setGroupName(groupName);
        group.setEvaluationType(evaluationType);
        group.setCreateDept(CommonUtil.getDefaultDept());
        group.setLevel(CommonUtil.getLoginUser().getLevel());
        return CommonUtil.tableMap(evaluationService.getGroupList(group));
    }

    @RequestMapping("/evaluation/toSelectMember")
    public ModelAndView getEmpTree(String id, String memberType) {
        ModelAndView mv = new ModelAndView();
        if (memberType.equals("2")) {
            mv.setViewName("/business/evaluation/employee/group/selectMemberParent");
        } else {
            mv.setViewName("/business/evaluation/employee/group/selectMember");
        }

        mv.addObject("id", id);
        mv.addObject("memberType", memberType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/getEmpsByGroup")
    public Map<String, List> getEmpsByGroup(String id, String memberType) {
        List<Tree> trees = null;
        if ("0".equals(memberType)) {
            trees = commonService.getEmpTree();
        }
        if ("1".equals(memberType)) {
            trees = commonService.getStuTree();
        }
        if ("2".equals(memberType)) {
            trees = commonService.getParentTree();
        }
        if ("3".equals(memberType)) {
            trees = commonService.getEmpTree();
        }
        if ("4".equals(memberType)) {
            trees = commonService.getEmpTree();
        }
        List<EvaluationMembers> evaluationMembers = evaluationService.getMembersByGroupId(id, memberType);
        Map<String, List> map = new HashMap<String, List>();
        map.put("tree", trees);
        map.put("selected", evaluationMembers);
        return map;
    }

    @ResponseBody
    @RequestMapping("/evaluation/saveMember")
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
                if (memberIdAndDeptId.split(",").length <= 2)
                    continue;
                b = Pattern.matches("^\\d{15}|^\\d{17}([0-9]|X|x)$", memberIdAndDeptId.split(",")[0]);
                c = memberIdAndDeptId.split(",")[0].length() == 36;
                evaluationMembers.setMemberId(CommonUtil.getUUID());
                evaluationMembers.setPersonId(memberIdAndDeptId.split(",")[0]);
                if ("0".equals(memberType) && c) {
                    evaluationMembers.setDeptId(memberIdAndDeptId.split(",")[1]);
                    evaluationMembers.setName(memberIdAndDeptId.split(",")[2]);
                    evaluationService.saveMember(evaluationMembers);
                } else if ("1".equals(memberType) && b) {
                    evaluationMembers.setDeptId(memberIdAndDeptId.split(",")[1]);
                    evaluationMembers.setName(memberIdAndDeptId.split(",")[2]);
                    evaluationService.saveMember(evaluationMembers);
                } else if ("2".equals(memberType) && b) {
                    evaluationMembers.setDeptId(memberIdAndDeptId.split(",")[1]);
                    evaluationMembers.setClassId(memberIdAndDeptId.split(",")[2]);
                    evaluationMembers.setName(memberIdAndDeptId.split(",")[3]);
                    evaluationService.saveMember(evaluationMembers);
                } else if ("3".equals(memberType) && c) {
                    evaluationMembers.setDeptId(memberIdAndDeptId.split(",")[1]);
                    evaluationMembers.setName(memberIdAndDeptId.split(",")[2]);
                    evaluationService.saveMember(evaluationMembers);
                } else if ("4".equals(memberType) && c) {
                    evaluationMembers.setDeptId(memberIdAndDeptId.split(",")[1]);
                    evaluationMembers.setName(memberIdAndDeptId.split(",")[2]);
                    evaluationService.saveMember(evaluationMembers);
                }
            }
        }
        evaluationService.updateGroupMembersNum(groupId);
        return new Message(1, "保存成功！", null);
    }

    @RequestMapping("/evaluation/toEditGroup")
    public String toEditGroup(String id, Model model) {

        model.addAttribute("group", evaluationService.getGroup(id));
        return "/business/evaluation/employee/group/editGroup";
    }

    @ResponseBody
    @RequestMapping("/evaluation/updateGroup")
    public Message upadteGroup(Group group) {
        CommonUtil.update(group);
        evaluationService.upadteGroup(group);
        return new Message(1, "修改成功！", null);
    }

    @RequestMapping("/evaluation/plan")
    public String plan() {
        return "/business/evaluation/employee/plan/plan";
    }

    @RequestMapping("/evaluation/addPlan")
    public String toAddPlan() {
        return "/business/evaluation/employee/plan/addPlan";
    }

    @ResponseBody
    @RequestMapping("/evaluation/savePlan")
    public Message savePlan(EvaluationPlan evaluationPlan) {
        evaluationPlan.setPlanId(CommonUtil.getUUID());
        evaluationPlan.setCreator(CommonUtil.getPersonId());
        evaluationPlan.setCreateDept(CommonUtil.getDefaultDept());
        evaluationPlan.setCreateTime(CommonUtil.getDate());
        evaluationService.savePlan(evaluationPlan);
        return new Message(1, "添加成功！", null);
    }

    @ResponseBody
    @RequestMapping("/evaluation/getPlanList")
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

    @RequestMapping("/evaluation/toEditPlan")
    public String toEditPlan(Model model, String id) {
        model.addAttribute("plan", evaluationService.getPlan(id));
        return "/business/evaluation/employee/plan/editPlan";
    }

    @ResponseBody
    @RequestMapping("/evaluation/updatePlan")
    public Message updatePlan(EvaluationPlan evaluationPlan) {
        evaluationPlan.setChanger(CommonUtil.getPersonId());
        evaluationPlan.setChangeDept(CommonUtil.getDefaultDept());
        evaluationPlan.setChangeTime(CommonUtil.getDate());
        evaluationService.upadtePlan(evaluationPlan);
        return new Message(1, "修改成功！", null);
    }

    @ResponseBody
    @RequestMapping("/evaluation/deletePlan")
    public Message deletePlan(String id) {
        List<EvaluationTask> tasks = evaluationService.getTasksByPlanId(id);
        if (tasks.size() > 0) {
            return new Message(0, "该评教方案已经应用，不能删除！", "error");
        } else {
            evaluationService.deletePlan(id);
            evaluationService.deleteIndexByPlanid(id);
            return new Message(1, "删除成功！", "success");
        }
    }


    @RequestMapping("/evaluation/toIndex")
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
        return "/business/evaluation/employee/plan/index/index";
    }

    @RequestMapping("/evaluation/toAddIndex")
    public String toAddIndex(String planId, String pId, Model model) {
        model.addAttribute("planId", planId);
        model.addAttribute("pId", pId);
        return "/business/evaluation/employee/plan/index/addIndex";
    }

    @ResponseBody
    @RequestMapping("/evaluation/saveIndex")
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
        /*if (score + index.getScore() > scoreSum) {
            b = false;
            msg.setMsg("子级指标分数总和不能大于父级！");
        }*/
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
    @RequestMapping("/evaluation/deleteIndex")
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

    @RequestMapping("/evaluation/toEditIndex")
    public String toEditIndex(String id, Model model) {
        model.addAttribute("index", evaluationService.getIndexById(id));
        return "/business/evaluation/employee/plan/index/editIndex";
    }

    @ResponseBody
    @RequestMapping("/evaluation/updateIndex")
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
        /*if (score + index.getScore() > scoreSum) {
            b = false;
            msg.setMsg("子级指标分数总和不能大于父级！");
        }*/
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

    @RequestMapping("/evaluation/task")
    public String task() {
        return "/business/evaluation/employee/task/task";
    }

    @ResponseBody
    @RequestMapping("/evaluation/getTasks")
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

    @RequestMapping("/evaluation/toAddTask")
    public String toAddTask(String evaluationType, String taskType, Model model) {
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
        model.addAttribute("taskType", taskType);
        model.addAttribute("evaluationType", evaluationType);
        model.addAttribute("createDept",CommonUtil.getDefaultDept());
        return "/business/evaluation/employee/task/addTask";
    }

    @ResponseBody
    @RequestMapping("/evaluation/saveTask")
    public Message saveTask(EvaluationTask task) {
        task.setTaskId(CommonUtil.getUUID());
        CommonUtil.save(task);
        evaluationService.saveTask(task);
        return new Message(0, "添加成功！", "success");
    }

    @RequestMapping("/evaluation/toEditTask")
    public String toEditTask(String id, String evaluationType, Model model) {
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
        return "/business/evaluation/employee/task/editTask";
    }

    @ResponseBody
    @RequestMapping("/evaluation/updateTask")
    public Message updateTask(EvaluationTask task) {
        CommonUtil.update(task);
        evaluationService.updateTask(task);
        return new Message(0, "修改成功！", null);
    }

    @ResponseBody
    @RequestMapping("/evaluation/delTask")
    public Message delTask(String id) {
        evaluationService.delTask(id);
        return new Message(0, "删除成功！", "success");
    }

    @RequestMapping("/evaluation/toTaskSelectEmps")
    public ModelAndView toSelectEmps(String id, String startFlag, String evaluationType) {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/task/taskEmps");
        mv.addObject("id", id);
        mv.addObject("evaluationType", evaluationType);
        if (startFlag.equals("未启动"))
            mv.addObject("startFlag", 0);
        else
            mv.addObject("startFlag", 1);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/getEmpsByTask")
    public Map<String, List> getEmpsByTask(String id) {
        List<Tree> trees = commonService.getEmpTree();
        List<EvaluationEmp> evaluationEmps = evaluationService.getEmpsByTaskId(id);
        Map<String, List> map = new HashMap<String, List>();
        map.put("tree", trees);
        map.put("selected", evaluationEmps);
        return map;
    }

    @ResponseBody
    @RequestMapping("/evaluation/getEmpsCheckByTask")
    public Map<String, List> getEmpsCheckByTask(String id, String evaluationType) {
        Map<String, List> map = new HashMap<String, List>();
        if (evaluationType.equals("0"))
            map.put("tree", evaluationService.getEmpsCheckByTask(id));
        else if (evaluationType.equals("1"))
            map.put("tree", evaluationService.getClassStudentCheckByTask(id));
        return map;
    }

    @ResponseBody
    @RequestMapping("/evaluation/saveEmps")
    public Message saveEmps(String ids, String taskId) {
        String[] tmp = ids.split(";");
        evaluationService.deleteEmpsByTaskId(taskId);
        evaluationService.deleteEmpsMenmbersByTaskId(taskId);
        List<EvaluationMembers> evaluationMembers = evaluationService.getMembersByTaskId(taskId);
        for (String empsIdAndDeptId : tmp) {
            if (empsIdAndDeptId.split(",")[0].length() == 36) {
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

    @RequestMapping("/evaluation/monitor")
    public String monitor() {
        return "/business/evaluation/employee/monitor/monitor";
    }

    @RequestMapping("/evaluation/toEmps")
    public String toEmps(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/monitor/monitorEmps";
    }

    @ResponseBody
    @RequestMapping("/evaluation/getMonitoerEmpsByTaskId")
    public Map getMonitoerEmpsByTaskId(String id, String evaluationType) {
        EvaluationTask etask = new EvaluationTask();
        etask.setTaskId(id);
        etask.setEvaluationType(evaluationType);
        return CommonUtil.tableMap(evaluationService.getMonitoerEmpsByTaskId(etask));
    }

    @ResponseBody
    @RequestMapping("/evaluation/getMonitoerTask")
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
    @RequestMapping("/evaluation/getMonitoerTaskBySelf")
    public Map getMonitoerTaskBySelf(String taskname, String evaluationType, String planName) {
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

    @RequestMapping("/evaluation/toEmpDetails")
    public String toEmpDetails(String id, String taskId, String name, String taskName, Model model) {
        List<Index> indices = evaluationService.getIndexByTaskId(taskId);
        Integer maxLevel = evaluationService.getMaxLevel(taskId);
        model.addAttribute("id", id);
        model.addAttribute("taskId", taskId);
        model.addAttribute("indices", indices);
        model.addAttribute("maxLevel", maxLevel);
        model.addAttribute("name", name);
        model.addAttribute("taskName", taskName);
        return "/business/evaluation/employee/monitor/empDetails";
    }

    @ResponseBody
    @RequestMapping("/evaluation/getDetails")
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
            String ScoreVal = members.getScore();
            if (ScoreVal != null && ScoreVal.subSequence(0, 1).equals(".")) {
                ScoreVal = "0" + ScoreVal;
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

    @RequestMapping("/evaluation/result/listEmpsMenmbers")
    public ModelAndView listMenmbers() {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/result/listEmps");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/result/getlisteEmpsMenmbers")
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
        for (EvaluationEmpsMenmbers EvalEmpMen : eEMenmbersList) {
            if ((date.getTime() - EvalEmpMen.getEndTime().getTime()) > 1000 * 60 * 60 * 24) {
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
    @RequestMapping("/evaluation/result/updateEmpsMenmbers")
    public Message updateEmpsMenmbers(EvaluationEmpsMenmbers eEMenmbers) {
        CommonUtil.update(eEMenmbers);
        evaluationService.updateEmpsMenmbers(eEMenmbers);
        return new Message(0, "删除成功！", null);
    }

    @RequestMapping("/evaluation/result/listResult")
    public ModelAndView gerlistResult(EvaluationEmpsMenmbers evaluationEmpsMenmbers) {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/result/listEditResult");
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
    @RequestMapping("/evaluation/result/insertResult")
    public Message updateResult(String taskId, String empPersonId, String empDeptId, String returnValue, String
            empName) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        String memberPersonId = loginUser.getPersonId(); //memberPersonId = "a88c0353-bc45-4c27-85a1-96aa86ba1d72";
        String memberDeptId = loginUser.getDefaultDeptId();// memberDeptId = "001001";
        String memberName = loginUser.getName();
        evaluationService.insertResult(taskId, empPersonId, empDeptId, returnValue, empName,
                memberPersonId, memberDeptId, memberName);

//        evaluationService.updateEmpsMenmbers(taskId);
        return new Message(0, "保存成功！", null);
    }

    @RequestMapping("/evaluation/toInvalid")
    public String toInvalid(String id, Model model) {
        model.addAttribute("id", id);
        return "/business/evaluation/employee/monitor/invalid";
    }

    @ResponseBody
    @RequestMapping("/evaluation/invalid")
    public Message invalid(EvaluationEmpsMenmbers menmber) {
        menmber.setInvalidFlag("1");
        menmber.setInvalidOperator(CommonUtil.getPersonId());
        menmber.setInvalidOperatorDept(CommonUtil.getDefaultDept());
        evaluationService.invalid(menmber);
        return new Message(0, "操作成功！", null);
    }

    @ResponseBody
    @RequestMapping("/evaluation/checkInvalid")
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
    @RequestMapping("/evaluation/result/searchEmpsMenmbers")
    public ModelAndView searchListMenmbers() {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/result/searchListEmps");
        return mv;
    }

    @RequestMapping("/evaluation/result/searchListResult")
    public ModelAndView searchListResult(EvaluationEmpsMenmbers evaluationEmpsMenmbers) {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/result/viewListEditResult");
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
    @RequestMapping("/evaluation/startTask")
    public Message startTask(String id) {
        //evaluationService.delectEmpsMembers(id);
        EvaluationTask task = evaluationService.getTask(id);
        Message message = new Message();
        List<EvaluationGroupEmps> evaluationGroupEmps = evaluationService.getEmpsTreeByTaskId(task.getTaskId());
        List<EvaluationMembers> evaluationMembers = evaluationService.getMembersByTaskId(task.getTaskId());
        if (evaluationGroupEmps == null || evaluationGroupEmps.size() == 0) {
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
    @RequestMapping("/evaluation/checkPlan")
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
            message.setResult("error");
/*            if (score != Integer.parseInt(plan.getScore())) {
                msg += "指标分数总和与总分相差" + (Integer.parseInt(plan.getScore()) - score) + "，";
            }*/
            msg += "请修改！";
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
    @RequestMapping("/evaluation/statistics/queryResult")
    public String queryResult() {
        return "/business/evaluation/employee/statistics/queryResult";
    }

    @RequestMapping("/evaluation/statistics/resultEmps")
    public String resultEmps(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/statistics/resultEmps";
    }

    @RequestMapping("/evaluation/statistics/order")
    public String statisticsOrder() {
        return "/business/evaluation/employee/statistics/queryResultOrder";
    }

    @RequestMapping("/evaluation/statistics/resultEmpsOrder")
    public String resultEmpsOrder(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/statistics/resultEmpsOeder";
    }

    @ResponseBody
    @RequestMapping("/evaluation/statistics/getMonitoerEmpsOeder")
    public Map getMonitoerEmpsOeder(EvaluationTask etask) {
        return CommonUtil.tableMap(evaluationService.getMonitoerEmpsOrder(etask));
    }


    @RequestMapping("/evaluation/statistics/monitorBySelf")
    public String monitorBySelf() {
        return "/business/evaluation/employee/statistics/monitorBySelf";
    }

    @RequestMapping("/evaluation/loading")
    public String loading() {
        return "/business/evaluation/loading";
    }

    @RequestMapping("/evaluation/statistics/detailsBySelf")
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
        return "/business/evaluation/employee/statistics/resultDetails";
    }

    @RequestMapping("/evaluation/exportEvaluationResult")
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
        String[] strs1 = {"被评人", "被评人部门", "进度", "总分"};
        String[] strs2 = {"排名", "被评人", "被评人部门", "进度", "总分"};
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

    @RequestMapping("/evaluation/complex/getTaskList")
    public ModelAndView complexTaskList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/employee/complex/complexTaskList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/complex/getComplexTask")
    public Map getComplexTask(EvaluationComplexTask ecTask) {
        if (null != ecTask.getComplexTaskName() && !ecTask.getComplexTaskName().equals(""))
            ecTask.setComplexTaskName("%" + ecTask.getComplexTaskName() + "%");
        ecTask.setCreateDept(CommonUtil.getDefaultDept());
        ecTask.setLevel(CommonUtil.getLoginUser().getLevel());
        List<EvaluationComplexTask> list = evaluationService.getEvaluationComplexTask(ecTask);
        return CommonUtil.tableMap(list);
    }

    @RequestMapping("/evaluation/complex/addComplexTask")
    public ModelAndView addComplexTask(String evaluationType) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("evaluationType", evaluationType);
        mv.setViewName("/business/evaluation/employee/complex/addComplexTask");
        return mv;
    }

    @RequestMapping("/evaluation/complex/editComplexTask")
    public ModelAndView editComplexTask(String complexTaskId, String testFlag) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/employee/complex/editComplexTask");
        EvaluationComplexTask ecTask = evaluationService.getEvaluationComplexTaskByid(complexTaskId);
        mv.addObject("ecTask", ecTask);
        mv.addObject("testFlag", testFlag);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/complex/saveComplexTask")
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

    @RequestMapping("/evaluation/complex/editChildTask")
    public ModelAndView editChildTask(EvaluationComplexTask ecTask) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/employee/complex/detail/complexDetailList");
        mv.addObject("complexTaskId", ecTask.getComplexTaskId());
        mv.addObject("term", ecTask.getTerm());
        mv.addObject("testFlag", ecTask.getTestFlag());
        mv.addObject("evaluationType", ecTask.getEvaluationType());
        mv.addObject("complexTaskName", ecTask.getComplexTaskName());
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/complex/getComplexDetail")
    public Map getComplexDetail(String complexTaskId) {
        List<EvaluationComplexDetail> list = evaluationService.getEvaluationComplexDetail(complexTaskId);
        return CommonUtil.tableMap(list);
    }

    @RequestMapping("/evaluation/complex/addComplexDetail")
    public ModelAndView addComplexDetail(String complexTaskId, String term, String evaluationType) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/employee/complex/detail/addComplexDetail");
        mv.addObject("complexTaskId", complexTaskId);
        mv.addObject("term", term);
        mv.addObject("evaluationType", evaluationType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/complex/saveDetail")
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
    @RequestMapping("/evaluation/complex/checkDetailWeights")
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
    @RequestMapping("/evaluation/complex/delChildTask")
    public Message delChildTask(String id) {
        evaluationService.delComplexDetail(id);
        return new Message(1, "删除成功！", null);
    }

    @RequestMapping("/evaluation/complex/viewComplexDetail")
    public ModelAndView viewComplexDetail(String id) {
        EvaluationComplexDetail ecDetail = evaluationService.getEvaluationComplexDetailByid(id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/employee/complex/detail/viewComplexDetail");
        mv.addObject("ecDetail", ecDetail);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/complex/checkChildTask")
    public Message checkChildTask(String complexTaskId) {
        Integer weights = evaluationService.getDetailWeights(complexTaskId);
        if (weights == null) {
            return new Message(2, "请先设置子评教管理！", null);
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
    @RequestMapping("/evaluation/complex/delComplexTask")
    public Message delComplexTask(String complexTaskId) {
        evaluationService.delComplexDetail(complexTaskId);
        evaluationService.delComplexTask(complexTaskId);
        evaluationService.delComplexResult(complexTaskId);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/evaluation/complex/insertResult")
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

    @RequestMapping("/evaluation/complex/getComplexResult")
    public ModelAndView getComplexResult() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/employee/complex/result/complexResultList");
        return mv;
    }

    @RequestMapping("/evaluation/complex/getResult")
    public ModelAndView getResult(String complexTaskId, String complexTaskName, String evaluationType) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/employee/complex/result/complexTaskResultList");
        List<EvaluationComplexDetail> details = evaluationService.getEvaluationComplexDetail(complexTaskId);
        mv.addObject("details", details);
        mv.addObject("complexTaskId", complexTaskId);
        mv.addObject("complexTaskName", complexTaskName);
        mv.addObject("evaluationType", evaluationType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/complex/getComplexResultList")
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
            if (b) {
                dataLast.add(tmp);
            } else {
                data.add(tmp);
            }
        }
        data.addAll(dataLast);
        return CommonUtil.tableMap(data);

    }

    @ResponseBody
    @RequestMapping("/evaluation/complex/exportComplexResult")
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

    @RequestMapping("/evaluation/exportEvaluationResultList")
    public void exportEvaluationResultList(String taskIds, String evaluationType, HttpServletResponse response) {
        Map<String, List<EvaluationEmp>> map = evaluationService.exportEvaluationResultList(taskIds, evaluationType);

        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        String[] strs1 = {"排名", "任务名称", "评教方案", "部门", "教师编号","被评教教师", "应参评人数", "实际参评人数", "总评"};

        Iterator iter = map.entrySet().iterator();
        while (iter.hasNext()) {
            Map.Entry entry = (Map.Entry) iter.next();
            String key = (String) entry.getKey();
            List<EvaluationEmp> evaluationEmpList = (List<EvaluationEmp>) entry.getValue();
            //创建HSSFSheet对象
            HSSFSheet sheet = wb.createSheet(key);
            CellRangeAddress cra = new CellRangeAddress(0, 0, 0, 7);
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
            int i = 1;
            for (EvaluationEmp evaluationEmp : evaluationEmpList) {
                HSSFRow row = sheet.createRow(tmp);
                //创建HSSFCell对象
                row.createCell(0).setCellValue(i);
                row.createCell(1).setCellValue(evaluationEmp.getName());
                row.createCell(2).setCellValue(evaluationEmp.getPlanName());
                row.createCell(3).setCellValue(evaluationEmp.getDeptId());
                String staffId = empService.getStaffIdByPersonId(evaluationEmp.getPerson());
                row.createCell(4).setCellValue(staffId);
                row.createCell(5).setCellValue(evaluationEmp.getPersonId());
                row.createCell(6).setCellValue(evaluationEmp.getTotalNumber());
                row.createCell(7).setCellValue(evaluationEmp.getNumber());
                if (null == evaluationEmp.getTotal() || evaluationEmp.getTotal().equals(""))
                    row.createCell(8).setCellValue("0");
                else
                    row.createCell(8).setCellValue(evaluationEmp.getTotal());
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

    @RequestMapping("/evaluation/toEmpGroupList")
    public ModelAndView getGroupList(String complexTaskId, String complexTaskName, String evaluationType) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/employee/empGroup/groupList");
        List<EvaluationComplexDetail> details = evaluationService.getEvaluationComplexDetail(complexTaskId);
        mv.addObject("details", details);
        mv.addObject("complexTaskId", complexTaskId);
        mv.addObject("complexTaskName", complexTaskName);
        mv.addObject("evaluationType", evaluationType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/getEmpGroupList")
    public Map getList(Group group) {
        group.setCreateDept(CommonUtil.getDefaultDept());
        group.setLevel(CommonUtil.getLoginUser().getLevel());
        return CommonUtil.tableMap(evaluationService.getEmpGroupList(group));
    }

    @RequestMapping("/evaluation/toEmpGroupAdd")
    public ModelAndView toEmpGroupAdd() {
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "新增");
        mv.setViewName("/business/evaluation/employee/empGroup/editEmpGroup");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/saveEmpGroup")
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

    @RequestMapping("/evaluation/toEmpGroupEdit")
    public ModelAndView toEdit(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/employee/empGroup/editEmpGroup");
        mv.addObject("group", evaluationService.getEmpGroup(id));
        mv.addObject("head", "修改");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/deleteEmpGroup")
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

    @RequestMapping("/evaluation/toSelectEmp")
    public ModelAndView getSelectEmpTree(String id, String evaluationType) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/employee/empGroup/selectEmp");
        mv.addObject("id", id);
        mv.addObject("evaluationType", evaluationType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/getEmpsTree")
    public Map<String, List> getEmpsTree(String groupId, String evaluationType) {
        List<Tree> trees = null;
        if ("0".equals(evaluationType)) {
            trees = commonService.getEmpTree();
        } else if ("1".equals(evaluationType)) {
            trees = commonService.getStuTree();
        }
        List<EvaluationGroupEmps> evaluationGroupEmps = evaluationService.getEmpsTree(groupId);
        Map<String, List> map = new HashMap<String, List>();
        map.put("tree", trees);
        map.put("selected", evaluationGroupEmps);
        return map;
    }

    @ResponseBody
    @RequestMapping("/evaluation/saveGroupEmps")
    public Message saveGroupEmps(String ids, String groupId, String evaluationType) {
        evaluationService.deleteGroupEmps(groupId);
        evaluationService.saveGroupEmps(ids, groupId, evaluationType);
        return new Message(1, "保存成功！", null);
    }

    /*  评教功能复制 */
    @ResponseBody
    @RequestMapping("/evaluation/editCopyMemberGroup")
    public Message editCopyMemberGroup(String id) {
        evaluationService.editCopyMemberGroup(id);
        return new Message(1, "复制成功！", null);
    }

    @ResponseBody
    @RequestMapping("/evaluation/editCopyPlan")
    public Message editCopyPlan(String id) {
        evaluationService.editCopyPlan(id);
        return new Message(1, "复制成功！", null);
    }

    @ResponseBody
    @RequestMapping("/evaluation/editCopyEmpGroup")
    public Message editCopyEmpGroup(String id) {
        evaluationService.editCopyEmpGroup(id);
        return new Message(1, "复制成功！", null);
    }

    @ResponseBody
    @RequestMapping("/evaluation/editCopyTask")
    public Message editCopyTask(String id) {
        evaluationService.editCopyTask(id);
        return new Message(1, "复制成功！", null);
    }

    @RequestMapping("/evaluation/toTaskSelectMembers")
    public ModelAndView toTaskSelectMembers(String id, String startFlag, String evaluationType) {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/task/taskMembers");
        mv.addObject("id", id);
        mv.addObject("evaluationType", evaluationType);
        if (startFlag.equals("未启动"))
            mv.addObject("startFlag", 0);
        else
            mv.addObject("startFlag", 1);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/getMembersByTask")
    public Map<String, List> getMembersByTask(String id, String evaluationType) {
        return evaluationService.getMembersByTaskIDType(id);
    }

    @RequestMapping("/evaluation/setProportion")
    public ModelAndView setProportion(String id, String taskName) {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/task/setProportion");
        mv.addObject("id", id);
        mv.addObject("task", evaluationService.getTask(id));
        mv.addObject("taskName", taskName);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/saveProportion")
    public Message saveProportion(EvaluationTask task) {
        evaluationService.saveProportion(task);
        return new Message(1, "设置成功！", null);
    }

    @ResponseBody
    @RequestMapping("/evaluation/setStartFlagByTaskId")
    public Message setStartFlagByTaskId(String taskId, String startFlag) {
        evaluationService.setStartFlagByTaskId(taskId, startFlag);
        return new Message(1, "修改成功！", null);
    }

    @RequestMapping("/evaluation/complex/checkEmpsList")
    public ModelAndView checkEmpsList(String complexTaskId, String complexTaskName, String evaluationType) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/employee/complex/result/complexCheckEmpsList");
        List<EvaluationComplexDetail> details = evaluationService.getEvaluationComplexDetail(complexTaskId);
        mv.addObject("details", details);
        mv.addObject("complexTaskId", complexTaskId);
        mv.addObject("complexTaskName", complexTaskName);
        mv.addObject("evaluationType", evaluationType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/complex/getcheckEmpsList")
    public Map getcheckEmpsList(String complexTaskId, String evaluationType) {
        EvaluationComplexDetail str = new EvaluationComplexDetail();
        str.setComplexTaskId(complexTaskId);
        str.setEvaluationType(evaluationType);
        // 所有被评分人
        List<EvaluationComplexResult> list = evaluationService.getEvaluationComplexSumResult(str);
        if (null == list || list.size() == 0) {
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


    /**
     * 领导评教任务设置
     *
     * @return
     */
    @RequestMapping("/evaluation/taskLeader")
    public String taskLeader() {
        return "/business/evaluation/employee/task/taskLeader";
    }

    /**
     * 领导评教任务查询
     *
     * @param name
     * @param evaluationType
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/getLeaderTasks")
    public Map<String, List> getLeaderTasks(String name, String evaluationType) {
        if (name != null && name != "") {
            name = "%" + name + "%";
        }
        EvaluationTask task = new EvaluationTask();
        task.setTaskName(name);
        task.setEvaluationType(evaluationType);
        task.setCreateDept(CommonUtil.getDefaultDept());
        task.setLevel(CommonUtil.getLoginUser().getLevel());
        return CommonUtil.tableMap(evaluationService.getLeaderTasks(task));
    }

    /**
     * 领导评教  待评教评分页面
     *
     * @return
     */
    @RequestMapping("/evaluation/result/listLeaderMenmbers")
    public ModelAndView listLeaderMenmbers() {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/result/listLeaderEmps");
        return mv;
    }

    /**
     * 领导评教  待评教评分数据查看
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/result/getlisteLeaderMenmbers")
    public Map<String, List<EvaluationEmpsMenmbers>> getlisteLeaderMenmbers(EvaluationEmpsMenmbers eEmps) {
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

        List<EvaluationEmpsMenmbers> eEMenmbersList = evaluationService.getLeaderListTask(eEmpsMenmbers);
        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();
        for (EvaluationEmpsMenmbers EvalEmpMen : eEMenmbersList) {
            if ((date.getTime() - EvalEmpMen.getEndTime().getTime()) > 1000 * 60 * 60 * 24) {
                EvalEmpMen.setValidFlag("0");
            } else {
                EvalEmpMen.setValidFlag("1");
            }
        }
        Map<String, List<EvaluationEmpsMenmbers>> studentList = new HashMap<String, List<EvaluationEmpsMenmbers>>();
        studentList.put("data", eEMenmbersList);
        return studentList;
    }

    /**
     * 领导评教  已评教评分页面
     *
     * @return
     */
    @RequestMapping("/evaluation/result/searchLeaderMenmbers")
    public ModelAndView searchLeaderListMenmbers() {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/result/searchListLeader");
        return mv;
    }

    /**
     * 领导评教  评教进度监控页面
     *
     * @return
     */
    @RequestMapping("/evaluation/monitorLeader")
    public String monitorLeader() {
        return "/business/evaluation/employee/monitor/monitorLeader";
    }

    /**
     * 领导评教  评教进度监控详情页面
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/toLeaders")
    public String toLeaders(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "business/evaluation/employee/monitor/monitorToLeaders";
    }

    /**
     * 领导评教 评教进度详情 中的审核页面跳转
     *
     * @param id
     * @param taskId
     * @param name
     * @param taskName
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/toLeaderDetails")
    public String toLeaderDetails(String id, String taskId, String name, String taskName, Model model) {
        List<Index> indices = evaluationService.getIndexByTaskId(taskId);
        Integer maxLevel = evaluationService.getMaxLevel(taskId);
        model.addAttribute("id", id);
        model.addAttribute("taskId", taskId);
        model.addAttribute("indices", indices);
        model.addAttribute("maxLevel", maxLevel);
        model.addAttribute("name", name);
        model.addAttribute("taskName", taskName);
        return "/business/evaluation/employee/monitor/leaderDetails";
    }

    /**
     * 领导评教  评教进度监控数据查询
     *
     * @param taskname
     * @param evaluationType
     * @param planName
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/getMonitoerLeaderTask")
    public Map getMonitoerLeaderTask(String taskname, String evaluationType, String planName) {
        EvaluationTask task = new EvaluationTask();
        task.setCreateDept(CommonUtil.getDefaultDept());
        task.setLevel(CommonUtil.getLoginUser().getLevel());
        if (null != taskname && !taskname.equals(""))
            task.setTaskName("%" + taskname + "%");
        if (null != planName && !planName.equals(""))
            task.setPlanName("%" + planName + "%");
        if (null != evaluationType && !evaluationType.equals(""))
            task.setEvaluationType(evaluationType);
        List list = evaluationService.getMonitoerLeaderTask(task);
        return CommonUtil.tableMap(list);
    }

    /**
     * 领导评教  评教结果页面跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/statistics/queryLeaderResult")
    public String queryLeaderResult() {
        return "/business/evaluation/employee/statistics/queryLeaderResult";
    }

    /**
     * 领导评教  评教结果查看 页面跳转
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/statistics/resultLeader")
    public String resultLeader(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/statistics/resultLeader";
    }

    /**
     * 领导评教 评教结果排行  页面跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/statistics/orderLeader")
    public String statisticsOrderLeader() {
        return "/business/evaluation/employee/statistics/queryResultOrderLeader";
    }

    /**
     * 领导评教 个人评教结果查看 页面跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/statistics/monitorLeaderBySelf")
    public String monitorLeaderBySelf() {
        return "/business/evaluation/employee/statistics/monitorLeaderBySelf";
    }

    /**
     * 领导评教 个人评教结果查看
     *
     * @param taskname
     * @param evaluationType
     * @param planName
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/getMonitoerLeaderTaskBySelf")
    public Map getMonitoerLeaderTaskBySelf(String taskname, String evaluationType, String planName) {
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
        List list = evaluationService.getMonitoerLeaderTaskBySelf(task);
        return CommonUtil.tableMap(list);
    }

    /**
     * 领导评教 评教结果查询 查看图表
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/leaderEcharts")
    public String leaderEcharts(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/echarts/leaderEcharts";
    }

    /**
     * 领导评教 评教结果查询 图表数据查询
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/echartsMenu/getLeaderEcharts")
    public Map getLeaderEcharts(String id, String taskName, String evaluationType) {
        EchartsMenu echartsMenu = new EchartsMenu();
        echartsMenu.setId(id);
        echartsMenu.setTaskName(taskName);
        echartsMenu.setEvaluationType(evaluationType);
        Map map = evaluationService.getLeaderTeacherEcharts(echartsMenu);
        return map;
    }

    /**
     * 教师评教任务设置
     *
     * @return
     */
    @RequestMapping("/evaluation/taskTeacher")
    public String taskTeacher() {
        return "/business/evaluation/employee/task/taskTeacher";
    }

    /**
     * 教师评教任务查询
     *
     * @param name
     * @param evaluationType
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/getTeacherTasks")
    public Map<String, List> getTeacherTasks(String name, String evaluationType) {
        if (name != null && name != "") {
            name = "%" + name + "%";
        }
        EvaluationTask task = new EvaluationTask();
        task.setTaskName(name);
        task.setEvaluationType(evaluationType);
        task.setCreateDept(CommonUtil.getDefaultDept());
        task.setLevel(CommonUtil.getLoginUser().getLevel());
        return CommonUtil.tableMap(evaluationService.getTeacherTasks(task));
    }

    /**
     * 教师评教  待评教评分页面
     *
     * @return
     */
    @RequestMapping("/evaluation/result/listTeacherMenmbers")
    public ModelAndView listTeacherMenmbers() {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/result/listTeacherEmps");
        return mv;
    }

    /**
     * 教师评教  待评教评分数据查看
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/result/getlisteTeacherMenmbers")
    public Map<String, List<EvaluationEmpsMenmbers>> getlisteTeacherMenmbers(EvaluationEmpsMenmbers eEmps) {
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

        List<EvaluationEmpsMenmbers> eEMenmbersList = evaluationService.getTeacherListTask(eEmpsMenmbers);
        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();
        for (EvaluationEmpsMenmbers EvalEmpMen : eEMenmbersList) {
            if ((date.getTime() - EvalEmpMen.getEndTime().getTime()) > 1000 * 60 * 60 * 24) {
                EvalEmpMen.setValidFlag("0");
            } else {
                EvalEmpMen.setValidFlag("1");
            }
        }
        Map<String, List<EvaluationEmpsMenmbers>> studentList = new HashMap<String, List<EvaluationEmpsMenmbers>>();
        studentList.put("data", eEMenmbersList);
        return studentList;
    }

    /**
     * 教师评教  已评教评分页面
     *
     * @return
     */
    @RequestMapping("/evaluation/result/searchTeacherMenmbers")
    public ModelAndView searchTeacherListMenmbers() {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/result/searchListTeacher");
        return mv;
    }

    /**
     * 教师评教  评教进度监控页面
     *
     * @return
     */
    @RequestMapping("/evaluation/monitorTeacher")
    public String monitorTeacher() {
        return "/business/evaluation/employee/monitor/monitorTeacher";
    }

    /**
     * 教师评教  评教进度监控详情页面
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/toTeachers")
    public String toTeachers(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/monitor/monitorToTeachers";
    }

    /**
     * 教师评教 评教进度详情 中的审核页面跳转
     *
     * @param id
     * @param taskId
     * @param name
     * @param taskName
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/toTeacherDetails")
    public String toTeacherDetails(String id, String taskId, String name, String taskName, Model model) {
        List<Index> indices = evaluationService.getIndexByTaskId(taskId);
        Integer maxLevel = evaluationService.getMaxLevel(taskId);
        model.addAttribute("id", id);
        model.addAttribute("taskId", taskId);
        model.addAttribute("indices", indices);
        model.addAttribute("maxLevel", maxLevel);
        model.addAttribute("name", name);
        model.addAttribute("taskName", taskName);
        return "/business/evaluation/employee/monitor/teacherDetails";
    }

    /**
     * 教师评教  评教进度监控数据查询
     *
     * @param taskname
     * @param evaluationType
     * @param planName
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/getMonitoerTeacherTask")
    public Map getMonitoerTeacherTask(String taskname, String evaluationType, String planName) {
        EvaluationTask task = new EvaluationTask();
        task.setCreateDept(CommonUtil.getDefaultDept());
        task.setLevel(CommonUtil.getLoginUser().getLevel());
        if (null != taskname && !taskname.equals(""))
            task.setTaskName("%" + taskname + "%");
        if (null != planName && !planName.equals(""))
            task.setPlanName("%" + planName + "%");
        if (null != evaluationType && !evaluationType.equals(""))
            task.setEvaluationType(evaluationType);
        List list = evaluationService.getMonitoerTeacherTask(task);
        return CommonUtil.tableMap(list);
    }

    /**
     * 教师评教  评教结果页面跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/statistics/queryTeacherResult")
    public String queryTeacherResult() {
        return "/business/evaluation/employee/statistics/queryTeacherResult";
    }

    /**
     * 教师评教  评教结果查看 页面跳转
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/statistics/resultTeacher")
    public String resultTeacher(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/statistics/resultTeacher";
    }

    /**
     * 教师评教 评教结果排行  页面跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/statistics/orderTeacher")
    public String statisticsOrderTeacher() {
        return "/business/evaluation/employee/statistics/queryResultOrderTeacher";
    }

    /**
     * 教师评教 个人评教结果查看 页面跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/statistics/monitorTeacherBySelf")
    public String monitorTeacherBySelf() {
        return "/business/evaluation/employee/statistics/monitorTeacherBySelf";
    }

    /**
     * 教师评教 个人评教结果查看
     *
     * @param taskname
     * @param evaluationType
     * @param planName
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/getMonitoerTeacherTaskBySelf")
    public Map getMonitoerTeacherTaskBySelf(String taskname, String evaluationType, String planName) {
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
        List list = evaluationService.getMonitoerTeacherTaskBySelf(task);
        return CommonUtil.tableMap(list);
    }

    /**
     * 教师评教 评教结果查询 查看图表
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/teacherEcharts")
    public String teacherEcharts(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/echarts/teacherEcharts";
    }

    /**
     * 教师评教 评教结果查询 图表数据查询
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/echartsMenu/getTeacherEcharts")
    public Map getTeacherEcharts(String id, String taskName, String evaluationType) {
        EchartsMenu echartsMenu = new EchartsMenu();
        echartsMenu.setId(id);
        echartsMenu.setTaskName(taskName);
        echartsMenu.setEvaluationType(evaluationType);
        Map map = evaluationService.getTeacherTeacherEcharts(echartsMenu);
        return map;
    }

    /**
     * 学生评教任务设置
     *
     * @return
     */
    @RequestMapping("/evaluation/taskStudent")
    public String taskStudent() {
        return "/business/evaluation/employee/task/taskStudent";
    }

    /**
     * 学生评教任务查询
     *
     * @param name
     * @param evaluationType
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/getStudentTasks")
    public Map<String, List> getStudentTasks(String name, String evaluationType) {
        if (name != null && name != "") {
            name = "%" + name + "%";
        }
        EvaluationTask task = new EvaluationTask();
        task.setTaskName(name);
        task.setEvaluationType(evaluationType);
        task.setCreateDept(CommonUtil.getDefaultDept());
        task.setLevel(CommonUtil.getLoginUser().getLevel());
        return CommonUtil.tableMap(evaluationService.getStudentTasks(task));
    }

    /**
     * 学生评教  待评教评分页面
     *
     * @return
     */
    @RequestMapping("/evaluation/result/listStudentMenmbers")
    public ModelAndView listStudentMenmbers() {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/result/listStudentEmps");
        return mv;
    }

    /**
     * 学生评教  待评教评分数据查看
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/result/getlisteStudentMenmbers")
    public Map<String, List<EvaluationEmpsMenmbers>> getlisteStudentMenmbers(EvaluationEmpsMenmbers eEmps) {
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

        List<EvaluationEmpsMenmbers> eEMenmbersList = evaluationService.getStudentListTask(eEmpsMenmbers);
        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();
        for (EvaluationEmpsMenmbers EvalEmpMen : eEMenmbersList) {
            if ((date.getTime() - EvalEmpMen.getEndTime().getTime()) > 1000 * 60 * 60 * 24) {
                EvalEmpMen.setValidFlag("0");
            } else {
                EvalEmpMen.setValidFlag("1");
            }
        }
        Map<String, List<EvaluationEmpsMenmbers>> studentList = new HashMap<String, List<EvaluationEmpsMenmbers>>();
        studentList.put("data", eEMenmbersList);
        return studentList;
    }

    /**
     * 学生评教  已评教评分页面
     *
     * @return
     */
    @RequestMapping("/evaluation/result/searchStudentMenmbers")
    public ModelAndView searchStudentListMenmbers() {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/result/searchListStudent");
        return mv;
    }

    /**
     * 学生评教  评教进度监控页面
     *
     * @return
     */
    @RequestMapping("/evaluation/monitorStudent")
    public String monitorStudent() {
        return "/business/evaluation/employee/monitor/monitorStudent";
    }

    /**
     * 学生评教  评教进度监控详情页面
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/toStudents")
    public String toStudents(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/monitor/monitorToStudents";
    }

    /**
     * 学生评教 评教进度详情 中的审核页面跳转
     *
     * @param id
     * @param taskId
     * @param name
     * @param taskName
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/toStudentDetails")
    public String toStudentDetails(String id, String taskId, String name, String taskName, Model model) {
        List<Index> indices = evaluationService.getIndexByTaskId(taskId);
        Integer maxLevel = evaluationService.getMaxLevel(taskId);
        model.addAttribute("id", id);
        model.addAttribute("taskId", taskId);
        model.addAttribute("indices", indices);
        model.addAttribute("maxLevel", maxLevel);
        model.addAttribute("name", name);
        model.addAttribute("taskName", taskName);
        return "/business/evaluation/employee/monitor/studentDetails";
    }

    /**
     * 学生评教  评教进度监控数据查询
     *
     * @param taskname
     * @param evaluationType
     * @param planName
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/getMonitoerStudentTask")
    public Map getMonitoerStudentTask(String taskname, String evaluationType, String planName) {
        EvaluationTask task = new EvaluationTask();
        task.setCreateDept(CommonUtil.getDefaultDept());
        task.setLevel(CommonUtil.getLoginUser().getLevel());
        if (null != taskname && !taskname.equals(""))
            task.setTaskName("%" + taskname + "%");
        if (null != planName && !planName.equals(""))
            task.setPlanName("%" + planName + "%");
        if (null != evaluationType && !evaluationType.equals(""))
            task.setEvaluationType(evaluationType);
        List list = evaluationService.getMonitoerStudentTask(task);
        return CommonUtil.tableMap(list);
    }

    /**
     * 学生评教  评教结果页面跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/statistics/queryStudentResult")
    public String queryStudentResult() {
        return "/business/evaluation/employee/statistics/queryStudentResult";
    }

    /**
     * 学生评教  评教结果查看 页面跳转
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/statistics/resultStudent")
    public String resultStudent(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/statistics/resultStudent";
    }

    /**
     * 学生评教 评教结果查询 查看图表
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/studentEcharts")
    public String studentEcharts(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/echarts/studentEcharts";
    }

    /**
     * 学生评教 评教结果查询 图表数据查询
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/echartsMenu/getStudentEcharts")
    public Map getStudentEcharts(String id, String taskName, String evaluationType) {
        EchartsMenu echartsMenu = new EchartsMenu();
        echartsMenu.setId(id);
        echartsMenu.setTaskName(taskName);
        echartsMenu.setEvaluationType(evaluationType);
        Map map = evaluationService.getStudentTeacherEcharts(echartsMenu);
        return map;
    }

    /**
     * 学生评教 评教结果排行  页面跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/statistics/orderStudent")
    public String statisticsOrderStudent() {
        return "/business/evaluation/employee/statistics/queryResultOrderStudent";
    }

    /**
     * 学生评教 个人评教结果查看 页面跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/statistics/monitorStudentBySelf")
    public String monitorStudentBySelf() {
        return "/business/evaluation/employee/statistics/monitorStudentBySelf";
    }

    /**
     * 学生评教 个人评教结果查看
     *
     * @param taskname
     * @param evaluationType
     * @param planName
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/getMonitoerStudentTaskBySelf")
    public Map getMonitoerStudentTaskBySelf(String taskname, String evaluationType, String planName) {
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
        List list = evaluationService.getMonitoerStudentTaskBySelf(task);
        return CommonUtil.tableMap(list);
    }

    /**
     * 同行评教任务设置
     *
     * @return
     */
    @RequestMapping("/evaluation/taskPeer")
    public String taskPeer() {
        return "/business/evaluation/employee/task/taskPeer";
    }

    /**
     * 同行评教任务查询
     *
     * @param name
     * @param evaluationType
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/getPeerTasks")
    public Map<String, List> getPeerTasks(String name, String evaluationType) {
        if (name != null && name != "") {
            name = "%" + name + "%";
        }
        EvaluationTask task = new EvaluationTask();
        task.setTaskName(name);
        task.setEvaluationType(evaluationType);
        task.setCreateDept(CommonUtil.getDefaultDept());
        task.setLevel(CommonUtil.getLoginUser().getLevel());
        return CommonUtil.tableMap(evaluationService.getPeerTasks(task));
    }

    /**
     * 同行评教  待评教评分页面
     *
     * @return
     */
    @RequestMapping("/evaluation/result/listPeerMenmbers")
    public ModelAndView listPeerMenmbers() {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/result/listPeerEmps");
        return mv;
    }

    /**
     * 同行评教  待评教评分数据查看
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/result/getlistePeerMenmbers")
    public Map<String, List<EvaluationEmpsMenmbers>> getlistePeerMenmbers(EvaluationEmpsMenmbers eEmps) {
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

        List<EvaluationEmpsMenmbers> eEMenmbersList = evaluationService.getPeerListTask(eEmpsMenmbers);
        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();
        for (EvaluationEmpsMenmbers EvalEmpMen : eEMenmbersList) {
            if ((date.getTime() - EvalEmpMen.getEndTime().getTime()) > 1000 * 60 * 60 * 24) {
                EvalEmpMen.setValidFlag("0");
            } else {
                EvalEmpMen.setValidFlag("1");
            }
        }
        Map<String, List<EvaluationEmpsMenmbers>> studentList = new HashMap<String, List<EvaluationEmpsMenmbers>>();
        studentList.put("data", eEMenmbersList);
        return studentList;
    }

    /**
     * 同行评教  已评教评分页面
     *
     * @return
     */
    @RequestMapping("/evaluation/result/searchPeerMenmbers")
    public ModelAndView searchPeerListMenmbers() {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/result/searchListPeer");
        return mv;
    }

    /**
     * 同行评教  评教进度监控页面
     *
     * @return
     */
    @RequestMapping("/evaluation/monitorPeer")
    public String monitorPeer() {
        return "/business/evaluation/employee/monitor/monitorPeer";
    }

    /**
     * 同行评教  评教进度监控详情页面
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/toPeers")
    public String toPeers(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/monitor/monitorToPeers";
    }

    /**
     * 同行评教 评教进度详情 中的审核页面跳转
     *
     * @param id
     * @param taskId
     * @param name
     * @param taskName
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/toPeerDetails")
    public String toPeerDetails(String id, String taskId, String name, String taskName, Model model) {
        List<Index> indices = evaluationService.getIndexByTaskId(taskId);
        Integer maxLevel = evaluationService.getMaxLevel(taskId);
        model.addAttribute("id", id);
        model.addAttribute("taskId", taskId);
        model.addAttribute("indices", indices);
        model.addAttribute("maxLevel", maxLevel);
        model.addAttribute("name", name);
        model.addAttribute("taskName", taskName);
        return "/business/evaluation/employee/monitor/peerDetails";
    }

    /**
     * 同行评教  评教进度监控数据查询
     *
     * @param taskname
     * @param evaluationType
     * @param planName
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/getMonitoerPeerTask")
    public Map getMonitoerPeerTask(String taskname, String evaluationType, String planName) {
        EvaluationTask task = new EvaluationTask();
        task.setCreateDept(CommonUtil.getDefaultDept());
        task.setLevel(CommonUtil.getLoginUser().getLevel());
        if (null != taskname && !taskname.equals(""))
            task.setTaskName("%" + taskname + "%");
        if (null != planName && !planName.equals(""))
            task.setPlanName("%" + planName + "%");
        if (null != evaluationType && !evaluationType.equals(""))
            task.setEvaluationType(evaluationType);
        List list = evaluationService.getMonitoerPeerTask(task);
        return CommonUtil.tableMap(list);
    }

    /**
     * 同行评教  评教结果页面跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/statistics/queryPeerResult")
    public String queryPeerResult() {
        return "/business/evaluation/employee/statistics/queryPeerResult";
    }

    /**
     * 同行评教  评教结果查看 页面跳转
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/statistics/resultPeer")
    public String resultPeer(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/statistics/resultPeer";
    }

    /**
     * 同行评教 评教结果查询 查看图表
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/peerEcharts")
    public String peerEcharts(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/echarts/peerEcharts";
    }

    /**
     * 同行评教 评教结果查询 图表数据查询
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/echartsMenu/getPeerEcharts")
    public Map getPeerEcharts(String id, String taskName, String evaluationType) {
        EchartsMenu echartsMenu = new EchartsMenu();
        echartsMenu.setId(id);
        echartsMenu.setTaskName(taskName);
        echartsMenu.setEvaluationType(evaluationType);
        Map map = evaluationService.getPeerTeacherEcharts(echartsMenu);
        return map;
    }

    /**
     * 同行评教 评教结果排行  页面跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/statistics/orderPeer")
    public String statisticsOrderPeer() {
        return "/business/evaluation/employee/statistics/queryResultOrderPeer";
    }

    /**
     * 同行评教 个人评教结果查看 页面跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/statistics/monitorPeerBySelf")
    public String monitorPeerBySelf() {
        return "/business/evaluation/employee/statistics/monitorPeerBySelf";
    }

    /**
     * 同行评教 个人评教结果查看
     *
     * @param taskname
     * @param evaluationType
     * @param planName
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/getMonitoerPeerTaskBySelf")
    public Map getMonitoerPeerTaskBySelf(String taskname, String evaluationType, String planName) {
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
        List list = evaluationService.getMonitoerPeerTaskBySelf(task);
        return CommonUtil.tableMap(list);
    }

    /**
     * 社会评教任务设置
     *
     * @return
     */
    @RequestMapping("/evaluation/taskParent")
    public String taskParent() {
        return "/business/evaluation/employee/task/taskParent";
    }

    /**
     * 社会评教任务查询
     *
     * @param name
     * @param evaluationType
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/getParentTasks")
    public Map<String, List> getParentTasks(String name, String evaluationType) {
        if (name != null && name != "") {
            name = "%" + name + "%";
        }
        EvaluationTask task = new EvaluationTask();
        task.setTaskName(name);
        task.setEvaluationType(evaluationType);
        task.setCreateDept(CommonUtil.getDefaultDept());
        task.setLevel(CommonUtil.getLoginUser().getLevel());
        return CommonUtil.tableMap(evaluationService.getParentTasks(task));
    }

    /**
     * 社会评教  待评教评分页面
     *
     * @return
     */
    @RequestMapping("/evaluation/result/listParentMenmbers")
    public ModelAndView listParentMenmbers() {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/result/listParentEmps");
        return mv;
    }

    /**
     * 社会评教  待评教评分数据查看
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/result/getlisteParentMenmbers")
    public Map<String, List<EvaluationEmpsMenmbers>> getlisteParentMenmbers(EvaluationEmpsMenmbers eEmps) {
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

        List<EvaluationEmpsMenmbers> eEMenmbersList = evaluationService.getParentListTask(eEmpsMenmbers);
        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();
        for (EvaluationEmpsMenmbers EvalEmpMen : eEMenmbersList) {
            if ((date.getTime() - EvalEmpMen.getEndTime().getTime()) > 1000 * 60 * 60 * 24) {
                EvalEmpMen.setValidFlag("0");
            } else {
                EvalEmpMen.setValidFlag("1");
            }
        }
        Map<String, List<EvaluationEmpsMenmbers>> studentList = new HashMap<String, List<EvaluationEmpsMenmbers>>();
        studentList.put("data", eEMenmbersList);
        return studentList;
    }

    /**
     * 社会评教  已评教评分页面
     *
     * @return
     */
    @RequestMapping("/evaluation/result/searchParentMenmbers")
    public ModelAndView searchParentListMenmbers() {
        ModelAndView mv = new ModelAndView("/business/evaluation/employee/result/searchListParent");
        return mv;
    }

    /**
     * 社会评教  评教进度监控页面
     *
     * @return
     */
    @RequestMapping("/evaluation/monitorParent")
    public String monitorParent() {
        return "/business/evaluation/employee/monitor/monitorParent";
    }

    /**
     * 社会评教  评教进度监控详情页面
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/toParents")
    public String toParents(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/monitor/monitorToParents";
    }

    /**
     * 社会评教 评教进度详情 中的审核页面跳转
     *
     * @param id
     * @param taskId
     * @param name
     * @param taskName
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/toParentDetails")
    public String toParentDetails(String id, String taskId, String name, String taskName, Model model) {
        List<Index> indices = evaluationService.getIndexByTaskId(taskId);
        Integer maxLevel = evaluationService.getMaxLevel(taskId);
        model.addAttribute("id", id);
        model.addAttribute("taskId", taskId);
        model.addAttribute("indices", indices);
        model.addAttribute("maxLevel", maxLevel);
        model.addAttribute("name", name);
        model.addAttribute("taskName", taskName);
        return "/business/evaluation/employee/monitor/parentDetails";
    }

    /**
     * 社会评教  评教进度监控数据查询
     *
     * @param taskname
     * @param evaluationType
     * @param planName
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/getMonitoerParentTask")
    public Map getMonitoerParentTask(String taskname, String evaluationType, String planName) {
        EvaluationTask task = new EvaluationTask();
        task.setCreateDept(CommonUtil.getDefaultDept());
        task.setLevel(CommonUtil.getLoginUser().getLevel());
        if (null != taskname && !taskname.equals(""))
            task.setTaskName("%" + taskname + "%");
        if (null != planName && !planName.equals(""))
            task.setPlanName("%" + planName + "%");
        if (null != evaluationType && !evaluationType.equals(""))
            task.setEvaluationType(evaluationType);
        List list = evaluationService.getMonitoerParentTask(task);
        return CommonUtil.tableMap(list);
    }

    /**
     * 社会评教  评教结果页面跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/statistics/queryParentResult")
    public String queryParentResult() {
        return "/business/evaluation/employee/statistics/queryParentResult";
    }

    /**
     * 社会评教  评教结果查看 页面跳转
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/statistics/resultParent")
    public String resultParent(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/statistics/resultParent";
    }

    /**
     * 社会评教 评教结果查询 查看图表
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/parentEcharts")
    public String parentEcharts(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/echarts/parentEcharts";
    }

    /**
     * 社会评教 评教结果查询 图表数据查询
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/echartsMenu/getParentEcharts")
    public Map getParentEcharts(String id, String taskName, String evaluationType) {
        EchartsMenu echartsMenu = new EchartsMenu();
        echartsMenu.setId(id);
        echartsMenu.setTaskName(taskName);
        echartsMenu.setEvaluationType(evaluationType);
        Map map = evaluationService.getParentTeacherEcharts(echartsMenu);
        return map;
    }

    /**
     * 社会评教 评教结果排行  页面跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/statistics/orderParent")
    public String statisticsOrderParent() {
        return "/business/evaluation/employee/statistics/queryResultOrderParent";
    }

    /**
     * 社会评教 个人评教结果查看 页面跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/statistics/monitorParentBySelf")
    public String monitorParentBySelf() {
        return "/business/evaluation/employee/statistics/monitorParentBySelf";
    }

    /**
     * 社会评教 个人评教结果查看
     *
     * @param taskname
     * @param evaluationType
     * @param planName
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/getMonitoerParentTaskBySelf")
    public Map getMonitoerParentTaskBySelf(String taskname, String evaluationType, String planName) {
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
        List list = evaluationService.getMonitoerParentTaskBySelf(task);
        return CommonUtil.tableMap(list);
    }

    /**
     * 领导 教师 学生 同行 社会 评教排行查看
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/statistics/resultAllOrder")
    public String resultAllOrder(String id, String taskName, String evaluationType, String taskType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        model.addAttribute("taskType", taskType);
        return "/business/evaluation/employee/statistics/resultAllOrder";
    }

    /**
     * 领导 教师 学生 同行 社会 个人评教结果查看 中的详情页面跳转
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/statistics/detailsByAllSelf")
    public String resultAllDetails(String id, String taskName, String evaluationType, String taskType, Model model) {
        List<Index> indices = evaluationService.getIndexByTaskId(id);
        Integer maxLevel = evaluationService.getMaxLevel(id);
        LoginUser loginUser = CommonUtil.getLoginUser();
        model.addAttribute("id", loginUser.getPersonId());
        model.addAttribute("taskId", id);
        model.addAttribute("indices", indices);
        model.addAttribute("maxLevel", maxLevel);
        model.addAttribute("name", loginUser.getName());
        model.addAttribute("taskName", taskName);
        model.addAttribute("taskType", taskType);
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
        return "/business/evaluation/employee/statistics/resultAllDetails";
    }

    /**
     * 评教结果汇总页面 跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/result/summary")
    public String evaluationResultSummary() {
        return "/business/evaluation/employee/statistics/evaluationResultSummary";
    }

    /**
     * 评教结果汇总数据查询
     *
     * @param taskname
     * @param evaluationType
     * @param planName
     * @returngetMonitoerTask
     */
    @ResponseBody
    @RequestMapping("/evaluation/getEvaluationSummaryTask")
    public Map getEvaluationSummaryTask(String taskname, String evaluationType, String planName) {
        EvaluationTask task = new EvaluationTask();
        task.setCreateDept(CommonUtil.getDefaultDept());
        task.setLevel(CommonUtil.getLoginUser().getLevel());
        if (null != taskname && !taskname.equals(""))
            task.setTaskName("%" + taskname + "%");
        if (null != planName && !planName.equals(""))
            task.setPlanName("%" + planName + "%");
        if (null != evaluationType && !evaluationType.equals(""))
            task.setEvaluationType(evaluationType);
        List list = evaluationService.getEvaluationSummaryTask(task);
        return CommonUtil.tableMap(list);
    }

    /**
     * 评教汇总查询 页面跳转
     *
     * @param id
     * @param taskName
     * @param evaluationType
     * @param model
     * @return
     */
    @RequestMapping("/evaluation/statistics/resultEvaluationSummary")
    public String resultEvaluationSummary(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/statistics/resultEvaluationSummary";
    }

    /**
     * 评教汇总查询 数据查询
     *
     * @param id
     * @param evaluationType
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/getMonitoerSummaryByTaskId")
    public Map getMonitoerSummaryByTaskId(String id, String staffId, String name, String evaluationType) {
        EvaluationTask etask = new EvaluationTask();
        etask.setTaskId(id);
        etask.setEvaluationType(evaluationType);
        if (null != name && !name.equals(""))
            etask.setName("%" + name + "%");
        if (null != staffId && !staffId.equals(""))
            etask.setStaffId("%" + staffId + "%");
        return CommonUtil.tableMap(evaluationService.getMonitoerSummaryByTaskId(etask));
    }

    /**
     * 评教结果推送选择人员
     *
     * @param id
     * @return
     */
    @RequestMapping("/evaluation/toSelectPushMember")
    public ModelAndView getPushEmpTree(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/evaluation/employee/group/selectPushMember");
        mv.addObject("id", id);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluation/getPushEmpsByGroup")
    public Map<String, List> getPushEmpsByGroup(String id) {
        List<Tree> trees = null;
        trees = commonService.getEmpTree();
        List<EvaluationPush> evaluationMembers = evaluationService.getEvaluationPushMembersByGroupId(id);
        Map<String, List> map = new HashMap<String, List>();
        map.put("tree", trees);
        map.put("selected", evaluationMembers);
        return map;
    }

    /**
     * 评教结果推送 人员保存
     *
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping("/evaluation/saveEvaluationPushMember")
    public Message deleteEvaluationPushMember(String ids, String id, String groupId, String empGroupId) {
        String[] tmp = ids.split(";");
        evaluationService.deleteEvaluationPushMember(id);
        boolean b, c;
        EvaluationPush evaluationMembers = new EvaluationPush();
        evaluationMembers.setTaskId(id);
        evaluationMembers.setCreator(CommonUtil.getPersonId());
        evaluationMembers.setCreateDept(CommonUtil.getDefaultDept());
        evaluationMembers.setCreateTime(CommonUtil.getDate());
        if (!"".equals(ids)) {
            for (String memberIdAndDeptId : tmp) {
                if (memberIdAndDeptId.split(",").length <= 2)
                    continue;
                b = Pattern.matches("^\\d{15}|^\\d{17}([0-9]|X|x)$", memberIdAndDeptId.split(",")[0]);
                c = memberIdAndDeptId.split(",")[0].length() == 36;
                evaluationMembers.setGroupId(groupId);
                evaluationMembers.setEmpGroupId(empGroupId);
                evaluationMembers.setPersonId(memberIdAndDeptId.split(",")[0]);
                evaluationMembers.setDeptId(memberIdAndDeptId.split(",")[1]);
                evaluationMembers.setName(memberIdAndDeptId.split(",")[2]);
                evaluationService.saveEvaluationPushMember(evaluationMembers);
            }
        }
        evaluationService.updateEvaluationTaskPushFlag(id);
        return new Message(1, "推送成功！", null);
    }

    /**
     * 评教结果推送查看页面 跳转
     *
     * @return
     */
    @RequestMapping("/evaluation/result/summaryEvaluationPush")
    public String summaryEvaluationPush() {
        return "/business/evaluation/employee/statistics/summaryEvaluationPush";
    }

    /**
     * 评教结果推送查看数据查询
     *
     * @param taskname
     * @param evaluationType
     * @param planName
     * @returngetMonitoerTask
     */
    @ResponseBody
    @RequestMapping("/evaluation/getEvaluationSummaryPushTask")
    public Map getEvaluationSummaryPushTask(String taskname, String evaluationType, String planName) {
        EvaluationTask task = new EvaluationTask();
        task.setCreateDept(CommonUtil.getDefaultDept());
        task.setLevel(CommonUtil.getLoginUser().getLevel());
        if (null != taskname && !taskname.equals(""))
            task.setTaskName("%" + taskname + "%");
        if (null != planName && !planName.equals(""))
            task.setPlanName("%" + planName + "%");
        if (null != evaluationType && !evaluationType.equals(""))
            task.setEvaluationType(evaluationType);
        task.setPersonId(CommonUtil.getPersonId());
        List list = evaluationService.getEvaluationSummaryPushTask(task);
        return CommonUtil.tableMap(list);
    }


    @RequestMapping("/evaluation/statistics/resultEvaluationSummaryPush")
    public String resultEvaluationSummaryPush(String id, String taskName, String evaluationType, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("taskName", taskName);
        model.addAttribute("evaluationType", evaluationType);
        return "/business/evaluation/employee/statistics/resultEvaluationSummaryPush";
    }


    /**
     * 评教情况汇总导出
     *
     * @param taskIds
     * @param term
     * @param response
     */
    @RequestMapping("/evaluation/result")
    public void toEvaluationResult(@Param("taskIds") String taskIds, String term, HttpServletResponse response) {
        HSSFWorkbook workbook = new HSSFWorkbook();
        CellStyle cellStyle0 = workbook.createCellStyle();
        Sheet sheet = workbook.createSheet("评教情况汇总表");

        cellStyle0.setAlignment(HorizontalAlignment.CENTER);
        cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle0.setWrapText(true);

        sheet.addMergedRegion(new CellRangeAddress(0, 3, 0, 0));//学期
        sheet.addMergedRegion(new CellRangeAddress(0, 3, 1, 1));//评教时间
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 2, 4));//评教客体(教师)
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 5, 16));//评教主题参与度
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 2, 2));//参与数（人）
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 3, 3));//参评人数
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 4, 4));//评教客体（教师）覆盖面（%）
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 5, 7));//学生
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 8, 10));//同行
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 11, 13));//校领导
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 14, 16));//社会

        sheet.addMergedRegion(new CellRangeAddress(2, 3, 5, 5));//参与数（人）
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 6, 6));//参评人数
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 7, 7));//学生参与比例（%）
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 8, 8));//参与数（人）
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 9, 9));//参评人数
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 10, 10));//同行参与比例（%）
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 11, 11));//参与数（人）
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 12, 12));//参评人数
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 13, 13));//校领导参与比例（%）
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 14, 14));//参与数（人）
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 15, 15));//参评人数
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 16, 16));//社会参与比例154（%）#835fa8

        sheet.setColumnWidth(0, 12 * 256);
        sheet.setColumnWidth(1, 12 * 256);
        sheet.setColumnWidth(2, 12 * 256);
        sheet.setColumnWidth(3, 12 * 256);
        sheet.setColumnWidth(4, 12 * 256);


        Row row0 = sheet.createRow(0);
        Row row1 = sheet.createRow(1);
        Row row2 = sheet.createRow(2);
        Row row3 = sheet.createRow(3);

        row3.setHeightInPoints(30);

        Cell cell00 = row0.createCell(0);
        cell00.setCellValue("学期");
        cell00.setCellStyle(cellStyle0);

        Cell cell01 = row0.createCell(1);
        cell01.setCellValue("评教时间");
        cell01.setCellStyle(cellStyle0);

        Cell cell02 = row0.createCell(2);
        cell02.setCellValue("评教客体(教师)");
        cell02.setCellStyle(cellStyle0);

        Cell cell03 = row0.createCell(5);
        cell03.setCellValue("评教主体参与度153");
        cell03.setCellStyle(cellStyle0);

        Cell cell103 = row2.createCell(2);
        cell103.setCellValue("实际参评人数");
        cell103.setCellStyle(cellStyle0);

        Cell cell104 = row2.createCell(3);
        cell104.setCellValue("应参评人数");
        cell104.setCellStyle(cellStyle0);

        Cell cell105 = row2.createCell(4);
        cell105.setCellValue("评教客体\n（教师）覆\n盖面（%）");
        cell105.setCellStyle(cellStyle0);

        Cell cell107 = row1.createCell(5);
        cell107.setCellValue("学生");
        cell107.setCellStyle(cellStyle0);

        Cell cell108 = row1.createCell(8);
        cell108.setCellValue("同行");
        cell108.setCellStyle(cellStyle0);

        Cell cell109 = row1.createCell(11);
        cell109.setCellValue("校领导");
        cell109.setCellStyle(cellStyle0);

        Cell cell110 = row1.createCell(14);
        cell110.setCellValue("社会");
        cell110.setCellStyle(cellStyle0);

        Cell cel300 = row2.createCell(5);
        cel300.setCellValue("实际参评人数");
        cel300.setCellStyle(cellStyle0);

        Cell cel301 = row2.createCell(6);
        cel301.setCellValue("应参评人数");
        cel301.setCellStyle(cellStyle0);

        Cell cel302 = row2.createCell(7);
        cel302.setCellValue("学生参与比例（%）");
        cel302.setCellStyle(cellStyle0);

        Cell cel303 = row2.createCell(8);
        cel303.setCellValue("实际参评人数");
        cel303.setCellStyle(cellStyle0);

        Cell cel304 = row2.createCell(9);
        cel304.setCellValue("应参评人数");
        cel304.setCellStyle(cellStyle0);

        Cell cel305 = row2.createCell(10);
        cel305.setCellValue("同行参与比例（%）");
        cel305.setCellStyle(cellStyle0);

        Cell cel306 = row2.createCell(11);
        cel306.setCellValue("实际参评人数");
        cel306.setCellStyle(cellStyle0);

        Cell cel307 = row2.createCell(12);
        cel307.setCellValue("应参评人数");
        cel307.setCellStyle(cellStyle0);

        Cell cel308 = row2.createCell(13);
        cel308.setCellValue("校领导参与比例（%）");
        cel308.setCellStyle(cellStyle0);

        Cell cel309 = row2.createCell(14);
        cel309.setCellValue("实际参评人数");
        cel309.setCellStyle(cellStyle0);

        Cell cel310 = row2.createCell(15);
        cel310.setCellValue("应参评人数");
        cel310.setCellStyle(cellStyle0);

        Cell cel311 = row2.createCell(16);
        cel311.setCellValue("社会参与比例154（%）");
        cel311.setCellStyle(cellStyle0);

        List<EvaluationTask> evaluationTaskList = evaluationService.getEvaluationTaskByTaskIds(taskIds);
        int i = 4;
        String oldFlag = "";
        try {
            oldFlag = evaluationTaskList.get(0).getTerm();
        } catch (Exception e) {

        }

        Row row = sheet.createRow(i);
        for (EvaluationTask evaluationTask : evaluationTaskList) {
            if (!oldFlag.equals(evaluationTask.getTerm())) {
                oldFlag = evaluationTask.getTerm();
                i = i + 1;
                row = sheet.createRow(i);
            }
            NumberFormat format = NumberFormat.getPercentInstance();
            format.setMaximumFractionDigits(2);//设置保留几位小数
            String name = evaluationTask.getName();
            String taskType = evaluationTask.getTaskType();
            Cell cell0 = row.createCell(0);
            cell0.setCellValue(evaluationTask.getTerm());
            Cell cell1 = row.createCell(1);
            cell1.setCellValue(evaluationTask.getEnd());
            Cell cell2 = row.createCell(2);
            cell2.setCellValue(evaluationTask.getNumberEmp());
            Cell cell3 = row.createCell(3);
            cell3.setCellValue(evaluationTask.getTotalNumberEmp());
            Cell cell4 = row.createCell(4);
            cell4.setCellValue(format.format(Double.parseDouble(evaluationTask.getNumberEmp())/Double.parseDouble(evaluationTask.getTotalNumberEmp())));
            switch (taskType) {
                case "1":
                    Cell cell5 = row.createCell(5);
                    cell5.setCellValue(evaluationTask.getNumber());
                    Cell cell6 = row.createCell(6);
                    cell6.setCellValue(evaluationTask.getTotalNumber());
                    Cell cell7 = row.createCell(7);
                    cell7.setCellValue(format.format(Double.parseDouble(evaluationTask.getNumber())/Double.parseDouble(evaluationTask.getTotalNumber())));
                    break;
                case "4":
                    Cell cell8 = row.createCell(8);
                    cell8.setCellValue(evaluationTask.getNumber());
                    Cell cell9 = row.createCell(9);
                    cell9.setCellValue(evaluationTask.getTotalNumber());
                    Cell cell10 = row.createCell(10);
                    cell10.setCellValue(format.format(Double.parseDouble(evaluationTask.getNumber())/Double.parseDouble(evaluationTask.getTotalNumber())));
                    break;
                case "3":
                    Cell cell11 = row.createCell(11);
                    cell11.setCellValue(evaluationTask.getNumber());
                    Cell cell12 = row.createCell(12);
                    cell12.setCellValue(evaluationTask.getTotalNumber());
                    Cell cell13 = row.createCell(13);
                    cell13.setCellValue(format.format(Double.parseDouble(evaluationTask.getNumber())/Double.parseDouble(evaluationTask.getTotalNumber())));
                    break;
                case "2":
                    Cell cell14 = row.createCell(14);
                    cell14.setCellValue(evaluationTask.getNumber());
                    Cell cell15 = row.createCell(15);
                    cell15.setCellValue(evaluationTask.getTotalNumber());
                    Cell cell16 = row.createCell(16);
                    cell16.setCellValue(format.format(Double.parseDouble(evaluationTask.getNumber())/Double.parseDouble(evaluationTask.getTotalNumber())));
                    break;
                default:
                    break;
            }
        }

        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("评教情况汇总表.xls", "utf-8"));
            os = response.getOutputStream();
            workbook.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                }
                workbook.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


    @RequestMapping("/evaluation/allEcharts")
    public String allEcharts(Model model) {
        model.addAttribute("term",parameterService.getParameterValue());
        return "/business/evaluation/employee/echarts/allEcharts";
    }

    @ResponseBody
    @RequestMapping("/evaluation/echartsMenu/getAllEvaluationEcharts")
    public Map getLeaderEcharts(String term) {
        EchartsMenu echartsMenu = new EchartsMenu();
        echartsMenu.setTerm(term);
        Map map = evaluationService.getAllEvaluationEcharts(echartsMenu);
        return map;
    }
    @ResponseBody
    @RequestMapping("/evaluation/getUserTask")
    public Message getUserTask(String loginId){
        List<EvaluationTask> evaluationTasks = evaluationService.getTasksByGroupId(CommonUtil.getPersonId());
        if(evaluationTasks.size()>0) {
            return new Message(0, "您还有未完成的评价任务，不可录入成绩！", null);
        }else {
            return new Message(1, "", null);
        }
    }
}
