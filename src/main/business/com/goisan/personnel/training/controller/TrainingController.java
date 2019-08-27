package com.goisan.personnel.training.controller;

import com.goisan.educational.exam.service.ExamService;
import com.goisan.personnel.training.bean.Training;
import com.goisan.personnel.training.bean.TrainingMember;
import com.goisan.personnel.training.service.TrainingService;
import com.goisan.synergy.workflow.service.FundsService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.Emp;
import com.goisan.system.bean.Tree;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.task.bean.SysTask;
import com.goisan.task.service.TaskService;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.service.WorkflowService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class TrainingController {
    @Resource
    private TrainingService trainingService;
    @Resource
    private StampService stampService;
    @Resource
    private ExamService examService;
    @Resource
    private TaskService taskService;
    @Resource
    private FundsService fundsService;
    @Resource
    private WorkflowService workflowService;


    /*组织培训*/
    //组织培训申请链接
    @RequestMapping("/training/department/request")
    public ModelAndView departmentRequest() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/training/department/departmentList");
        return mv;
    }


    //组织培训申请列表
    @ResponseBody
    @RequestMapping("/training/department/getTrainingList")
    public Map<String, List<Training>> getDepartmentTrainingList(Training departmentTraining, String flag) {
        if ("1".equals(flag)) {
            departmentTraining.setRequestFlag("2");
        } else {
            departmentTraining.setRequestFlag("0");
        }
        Map<String, List<Training>> trainingMap = new HashMap<String, List<Training>>();
        departmentTraining.setRequester(CommonUtil.getPersonId());
        departmentTraining.setCreator(CommonUtil.getPersonId());
        departmentTraining.setCreateDept(CommonUtil.getDefaultDept());
        trainingMap.put("data", trainingService.getDepartmentTrainingList(departmentTraining));
        return trainingMap;
    }

    //新增组织培训申请
    @RequestMapping("/training/department/editTraining")
    public ModelAndView editTraining() {
        ModelAndView mv = new ModelAndView("/business/personnel/training/department/editDepartment");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String now = formatDate.format(new Date());
        String personName = stampService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = stampService.getDeptNameById(CommonUtil.getDefaultDept());
        Training departmentTraining = new Training();
        departmentTraining.setRequester(personName);
        departmentTraining.setRequestDate(now);
        departmentTraining.setRequestDept(deptName);
        mv.addObject("head", "组织培训申请");
        mv.addObject("departmentTraining", departmentTraining);
        mv.addObject("now", now);
        return mv;
    }

    //保存组织培训
    @ResponseBody
    @RequestMapping("/training/department/saveTraining")
    public Message saveTraining(Training departmentTraining) {
        if (departmentTraining.getId() == null || departmentTraining.getId().equals("")) {
            CommonUtil.save(departmentTraining);
            departmentTraining.setRequester(CommonUtil.getPersonId());
            departmentTraining.setRequestDept(CommonUtil.getDefaultDept());
            departmentTraining.setId(CommonUtil.getUUID());
            departmentTraining.setTrainingForm("1");
            departmentTraining.setTrainingApplyNumber("0");
            //Training.setRequestFlag("0");
            trainingService.saveDepartmentTraining(departmentTraining);
            return new Message(1, "新增成功！", null);
        } else {
            CommonUtil.update(departmentTraining);
            trainingService.updateDepartmentTraining(departmentTraining);
            return new Message(1, "修改成功！", null);
        }
    }

    //组织培训修改
    @ResponseBody
    @RequestMapping("/training/department/getTrainingById")
    public ModelAndView getTrainingById(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/training/department/editDepartment");
        Training departmentTraining = trainingService.getDepartmentTrainingById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String now = formatDate.format(new Date());
        mv.addObject("head", "组织培训修改");
        mv.addObject("departmentTraining", departmentTraining);
        mv.addObject("now", now);
        return mv;
    }

    //删除组织培训
    @ResponseBody
    @RequestMapping("/training/department/deleteTrainingById")
    public Message deleteTrainingById(String id) {
        trainingService.delDepartmentTraining(id);
        return new Message(1, "删除成功！", null);
    }

    //组织培训审核
    @RequestMapping("/training/department/audit")
    public ModelAndView departmentAudit() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/training/department/departmentAudit");
        return mv;
    }

    //组织培训审核列表
    @ResponseBody
    @RequestMapping("/training/department/getAuditList")
    public Map<String, List<Training>> getDepartmentAuditList(Training Training) {
        Map<String, List<Training>> auditMap = new HashMap<String, List<Training>>();
        Training.setCreator(CommonUtil.getPersonId());
        Training.setCreateDept(CommonUtil.getDefaultDept());
        Training.setChanger(CommonUtil.getPersonId());
        Training.setChangeDept(CommonUtil.getDefaultDept());
        auditMap.put("data", trainingService.getDepartmentAuditList(Training));
        return auditMap;
    }

    //组织培训审核修改
    @ResponseBody
    @RequestMapping("/training/department/auditDepartmentEdit")
    public ModelAndView auditDepartmentEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/training/department/auditDepartmentEdit");
        Training departmentTraining = trainingService.getDepartmentTrainingById(id);
        mv.addObject("head", "修改");
        mv.addObject("departmentTraining", departmentTraining);
        return mv;
    }

    //查看组织培训流程轨迹
    @ResponseBody
    @RequestMapping("/training/department/auditDepartmentById")
    public ModelAndView auditDepartmentById(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/training/department/auditDepartment");
        Training departmentTraining = trainingService.getDepartmentTrainingById(id);
        mv.addObject("head", "审批");
        mv.addObject("departmentTraining", departmentTraining);
        return mv;
    }

    //组织培训查询
    @RequestMapping("/training/department/search")
    public ModelAndView departmentSearch() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/training/department/departmentSearch");
        return mv;
    }

    //组织培训查询列表
    @ResponseBody
    @RequestMapping("/training/department/getSearchList")
    public Map<String, List<Training>> getDepartmentSearchList(Training departmentTraining) {
        Map<String, List<Training>> auditMap = new HashMap<String, List<Training>>();
        departmentTraining.setCreator(CommonUtil.getPersonId());
        departmentTraining.setCreateDept(CommonUtil.getDefaultDept());
        departmentTraining.setChanger(CommonUtil.getPersonId());
        departmentTraining.setChangeDept(CommonUtil.getDefaultDept());
        auditMap.put("data", trainingService.getDepartmentSearchList(departmentTraining));
        return auditMap;
    }

    //组织培训上报
    @RequestMapping("/training/department/report")
    public ModelAndView departmentReport() {
        ModelAndView mv = new ModelAndView();
        String deptId = CommonUtil.getDefaultDept();
        mv.addObject("deptId", deptId);
        mv.setViewName("/business/personnel/training/department/departmentReport");
        return mv;
    }

    //组织培训参培教师跳转
    @RequestMapping("/training/department/reportTeacherList")
    public ModelAndView departmentReportTeacher(String deptId, String id, String trainingProjectName) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("trainingProjectName", trainingProjectName);
        mv.addObject("deptId", deptId);
        mv.addObject("id", id);
        mv.setViewName("/business/personnel/training/department/departmentReportTeacher");
        return mv;
    }

    //组织培训参培教师列表数据
    @ResponseBody
    @RequestMapping("/training/department/getReportMemberList")
    public Map<String, List<TrainingMember>> getDepartmentReportMemberList(TrainingMember trainingMember, String id) {
        String deptId = CommonUtil.getDefaultDept();
        Map<String, List<TrainingMember>> reportMap = new HashMap<String, List<TrainingMember>>();
        trainingMember.setCreator(CommonUtil.getPersonId());
        trainingMember.setCreateDept(CommonUtil.getDefaultDept());
        //trainingMember.setChanger(CommonUtil.getPersonId());
        //trainingMember.setChangeDept(CommonUtil.getDefaultDept());
        trainingMember.setTrainingId(id);
        trainingMember.setDeptId(deptId);
        reportMap.put("data", trainingService.getReportMemberList(trainingMember));
        return reportMap;
    }

    //上报参培教师
    @RequestMapping("/training/department/toReportTeacher")
    public ModelAndView toDepartmentReportTeacher(String deptId, String id) {
        ModelAndView mv = new ModelAndView();
        String overplus = trainingService.getTrainingOverPlusApplyNumber(id);
        mv.addObject("id", id);
        mv.addObject("deptId", deptId);
        mv.addObject("overplus", overplus);
        mv.setViewName("/business/personnel/training/department/reportDepartmentTeacher");
        return mv;
    }

    //人员树形下拉选
    @ResponseBody
    @RequestMapping("/training/department/getEmpTreeForReport")
    public Map<String, List> getEmpTreeForDepartmentReport(String deptId, String id) {
        List<Tree> empTree = new ArrayList<Tree>();
        empTree = trainingService.getEmpTreeByDeptId(deptId, id);
        Map<String, List> map = new HashMap<String, List>();
        map.put("tree", empTree);
        return map;
    }

    //校验参培教师
    @ResponseBody
    @RequestMapping("/training/department/checkReportTeacher")
    public Message checkDepartmentReportTeacher(String id) {
        String number = trainingService.getTrainingOverPlusApplyNumber(id);
        if ("0".equals(number)) {
            return new Message(1, "已没有名额,无法上报！", null);
        } else {
            return new Message(0, null, null);
        }

    }

    //校验保存参培教师
    @ResponseBody
    @RequestMapping("/training/department/checkSaveReportTeacher")
    public Message checkSaveDepartmentReportTeacher(String ids, String deptId, String id) {
        List<Emp> empList = examService.chooseEmpList(deptId, ids);
        String number = trainingService.getTrainingOverPlusApplyNumber(id);
        if (empList.size() > Integer.parseInt(number)) {
            return new Message(1, "选择上报数量超出剩余名额,请重新选择！", null);
        } else {
            return new Message(0, null, null);
        }

    }

    //保存参培教师
    @ResponseBody
    @RequestMapping("/training/department/saveReportTeacher")
    public Message saveDepartmentReportTeacher(String ids, String id, String deptId) {
        trainingService.saveDepartmentReportTeacher(ids, id, deptId);
        return new Message(1, "保存成功！", null);
    }

    //删除参培教师
    @ResponseBody
    @RequestMapping("/training/department/delReportTeacher")
    public Message delDepartmentReportTeacher(String memberId, String id) {
        trainingService.delReportTeacher(memberId);
        //修改数量
        Training training = new Training();
        training = trainingService.getDepartmentTrainingById(id);
        String applyNumber = training.getTrainingApplyNumber();
        int number = Integer.parseInt(applyNumber) - 1;
        training.setId(id);
        training.setTrainingApplyNumber(String.valueOf(number));
        trainingService.updateTraining(training);
        return new Message(1, "删除成功！", null);
    }

	                        /*个人培训*/

    //个人培训申请链接
    @RequestMapping("/training/personal/request")
    public ModelAndView personalRequest() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/training/personal/personalList");
        return mv;
    }

    //个人培训申请列表
    @ResponseBody
    @RequestMapping("/training/personal/getTrainingList")
    public Map<String, List<Training>> getPersonalTrainingList(Training personalTraining) {
        Map<String, List<Training>> trainingMap = new HashMap<String, List<Training>>();
        personalTraining.setCreator(CommonUtil.getPersonId());
        personalTraining.setCreateDept(CommonUtil.getDefaultDept());
        personalTraining.setRequester(CommonUtil.getPersonId());
        trainingMap.put("data", trainingService.getPersonalTrainingList(personalTraining));
        return trainingMap;
    }

    //新增个人培训申请
    @RequestMapping("/training/personal/editTraining")
    public ModelAndView editpersonalTraining() {
        ModelAndView mv = new ModelAndView("/business/personnel/training/personal/editPersonal");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String now = formatDate.format(new Date());
        String personName = stampService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = stampService.getDeptNameById(CommonUtil.getDefaultDept());
        Training personalTraining = new Training();
        personalTraining.setRequester(personName);
        personalTraining.setRequestDate(now);
        personalTraining.setTrainingPeopleNumber("1");
        personalTraining.setRequestDept(deptName);
        mv.addObject("head", "个人培训申请");
        mv.addObject("personalTraining", personalTraining);
        mv.addObject("now", now);
        return mv;
    }

    //保存个人培训
    @ResponseBody
    @RequestMapping("/training/personal/saveTraining")
    public Message savePersonalTraining(Training personalTraining) {
        if (personalTraining.getId() == null || personalTraining.getId().equals("")) {
            CommonUtil.save(personalTraining);
            personalTraining.setRequester(CommonUtil.getPersonId());
            personalTraining.setRequestDept(CommonUtil.getDefaultDept());
            personalTraining.setId(CommonUtil.getUUID());
            personalTraining.setTrainingForm("2");
            personalTraining.setTrainingApplyNumber("1");
            //Training.setRequestFlag("0");
            trainingService.savePersonalTraining(personalTraining);
            return new Message(1, "新增成功！", null);
        } else {
            CommonUtil.update(personalTraining);
            trainingService.updatePersonalTraining(personalTraining);
            return new Message(1, "修改成功！", null);
        }
    }

    //修改个人培训
    @ResponseBody
    @RequestMapping("/training/personal/getTrainingById")
    public ModelAndView getPersonalTrainingById(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/training/personal/editPersonal");
        Training personalTraining = trainingService.getPersonalTrainingById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String now = formatDate.format(new Date());
        mv.addObject("head", "个人培训修改");
        mv.addObject("personalTraining", personalTraining);
        mv.addObject("now",now);
        return mv;
    }

    //删除个人培训
    @ResponseBody
    @RequestMapping("/training/personal/deleteTrainingById")
    public Message deletePersonalTrainingById(String id) {
        trainingService.delPersonalTraining(id);
        return new Message(1, "删除成功！", null);
    }

    //个人培训审核
    @RequestMapping("/training/personal/audit")
    public ModelAndView personalAudit() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/training/personal/personalAudit");
        return mv;
    }

    //个人培训审核列表
    @ResponseBody
    @RequestMapping("/training/personal/getAuditList")
    public Map<String, List<Training>> getPersonalAuditList(Training Training) {
        Map<String, List<Training>> auditMap = new HashMap<String, List<Training>>();
        Training.setCreator(CommonUtil.getPersonId());
        Training.setCreateDept(CommonUtil.getDefaultDept());
        Training.setChanger(CommonUtil.getPersonId());
        Training.setChangeDept(CommonUtil.getDefaultDept());
        auditMap.put("data", trainingService.getPersonalAuditList(Training));
        return auditMap;
    }

    //个人培训审核修改
    @ResponseBody
    @RequestMapping("/training/personal/auditPersonalEdit")
    public ModelAndView auditPersonalEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/training/personal/auditPersonalEdit");
        Training personalTraining = trainingService.getDepartmentTrainingById(id);
        mv.addObject("head", "修改");
        mv.addObject("personalTraining", personalTraining);
        return mv;
    }

    //查看个人培训流程轨迹
    @ResponseBody
    @RequestMapping("/training/personal/auditPersonalById")
    public ModelAndView auditPersonalById(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/training/personal/auditPersonal");
        Training personalTraining = trainingService.getPersonalTrainingById(id);
        mv.addObject("head", "审批");
        mv.addObject("personalTraining", personalTraining);
        return mv;
    }

    //个人培训查询
    @RequestMapping("/training/personal/search")
    public ModelAndView personalSearch() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/training/personal/personalSearch");
        return mv;
    }

    //个人培训查询列表
    @ResponseBody
    @RequestMapping("/training/personal/getSearchList")
    public Map<String, List<Training>> getPersonalSearchList(Training personalTraining) {
        Map<String, List<Training>> auditMap = new HashMap<String, List<Training>>();
        personalTraining.setCreator(CommonUtil.getPersonId());
        personalTraining.setCreateDept(CommonUtil.getDefaultDept());
        personalTraining.setChanger(CommonUtil.getPersonId());
        personalTraining.setChangeDept(CommonUtil.getDefaultDept());
        auditMap.put("data", trainingService.getPersonalSearchList(personalTraining));
        return auditMap;
    }

    /*团体培训*/
    //团体培训申请链接
    @RequestMapping("/training/group/request")
    public ModelAndView groupRequest() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/training/group/groupList");
        return mv;
    }

    //团体培训申请列表
    @ResponseBody
    @RequestMapping("/training/group/getTrainingList")
    public Map<String, List<Training>> getGroupTrainingList(Training groupTraining, String flag) {
        if ("3".equals(flag)) {
            groupTraining.setRequestFlag("2");
        } else {
            groupTraining.setRequestFlag("0");
        }
        Map<String, List<Training>> trainingMap = new HashMap<String, List<Training>>();
        groupTraining.setRequester(CommonUtil.getPersonId());
        groupTraining.setCreator(CommonUtil.getPersonId());
        groupTraining.setCreateDept(CommonUtil.getDefaultDept());
        trainingMap.put("data", trainingService.getGroupTrainingList(groupTraining));
        return trainingMap;
    }

    //新增团体培训申请
    @RequestMapping("/training/group/editTraining")
    public ModelAndView editgroupTraining() {
        ModelAndView mv = new ModelAndView("/business/personnel/training/group/editGroup");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String now = formatDate.format(new Date());
        String personName = stampService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = stampService.getDeptNameById(CommonUtil.getDefaultDept());
        Training groupTraining = new Training();
        groupTraining.setRequester(personName);
        groupTraining.setRequestDate(now);
        groupTraining.setRequestDept(deptName);
        mv.addObject("head", "团体培训申请");
        mv.addObject("groupTraining", groupTraining);
        mv.addObject("now", now);
        return mv;
    }

    //保存团体培训
    @ResponseBody
    @RequestMapping("/training/group/saveTraining")
    public Message saveGroupTraining(Training groupTraining) {
        if (groupTraining.getId() == null || groupTraining.getId().equals("")) {
            CommonUtil.save(groupTraining);
            groupTraining.setRequester(CommonUtil.getPersonId());
            groupTraining.setRequestDept(CommonUtil.getDefaultDept());
            groupTraining.setId(CommonUtil.getUUID());
            groupTraining.setTrainingForm("3");
            groupTraining.setTrainingApplyNumber("0");
            //Training.setRequestFlag("0");
            trainingService.saveGroupTraining(groupTraining);
            return new Message(1, "新增成功！", null);
        } else {
            CommonUtil.update(groupTraining);
            trainingService.updateGroupTraining(groupTraining);
            return new Message(1, "修改成功！", null);
        }
    }

    //修改团体培训
    @ResponseBody
    @RequestMapping("/training/group/getTrainingById")
    public ModelAndView getgroupTrainingById(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/training/group/editGroup");
        Training groupTraining = trainingService.getGroupTrainingById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String now = formatDate.format(new Date());
        mv.addObject("head", "团体培训修改");
        mv.addObject("groupTraining", groupTraining);
        mv.addObject("now",now);
        return mv;
    }

    //删除团体培训
    @ResponseBody
    @RequestMapping("/training/group/deleteTrainingById")
    public Message deleteGroupTrainingById(String id) {
        trainingService.delGroupTraining(id);
        return new Message(1, "删除成功！", null);
    }

    //团体培训审核
    @RequestMapping("/training/group/audit")
    public ModelAndView groupAudit() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/training/group/groupAudit");
        return mv;
    }

    //团体培训审核列表
    @ResponseBody
    @RequestMapping("/training/group/getAuditList")
    public Map<String, List<Training>> getgroupAuditList(Training groupTraining) {
        Map<String, List<Training>> auditMap = new HashMap<String, List<Training>>();
        groupTraining.setCreator(CommonUtil.getPersonId());
        groupTraining.setCreateDept(CommonUtil.getDefaultDept());
        groupTraining.setChanger(CommonUtil.getPersonId());
        groupTraining.setChangeDept(CommonUtil.getDefaultDept());
        auditMap.put("data", trainingService.getGroupAuditList(groupTraining));
        return auditMap;
    }

    //团体培训审核修改
    @ResponseBody
    @RequestMapping("/training/group/auditGroupEdit")
    public ModelAndView auditGroupEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/training/group/auditGroupEdit");
        Training groupTraining = trainingService.getDepartmentTrainingById(id);
        mv.addObject("head", "修改");
        mv.addObject("groupTraining", groupTraining);
        return mv;
    }

    //查看团体培训流程轨迹
    @ResponseBody
    @RequestMapping("/training/group/auditGroupById")
    public ModelAndView auditGroupById(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/training/group/auditGroup");
        Training groupTraining = trainingService.getGroupTrainingById(id);
        mv.addObject("head", "审批");
        mv.addObject("groupTraining", groupTraining);
        return mv;
    }

    //团体培训查询
    @RequestMapping("/training/group/search")
    public ModelAndView groupSearch() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/training/group/groupSearch");
        return mv;
    }

    //团体培训查询列表
    @ResponseBody
    @RequestMapping("/training/group/getSearchList")
    public Map<String, List<Training>> getgroupSearchList(Training groupTraining) {
        Map<String, List<Training>> auditMap = new HashMap<String, List<Training>>();
        groupTraining.setCreator(CommonUtil.getPersonId());
        groupTraining.setCreateDept(CommonUtil.getDefaultDept());
        groupTraining.setChanger(CommonUtil.getPersonId());
        groupTraining.setChangeDept(CommonUtil.getDefaultDept());
        auditMap.put("data", trainingService.getGroupSearchList(groupTraining));
        return auditMap;
    }

    //团体培训上报
    @RequestMapping("/training/group/report")
    public ModelAndView groupReport() {
        ModelAndView mv = new ModelAndView();
        String deptId = CommonUtil.getDefaultDept();
        mv.addObject("deptId", deptId);
        mv.setViewName("/business/personnel/training/group/groupReport");
        return mv;
    }

    //团体培训参培教师跳转
    @RequestMapping("/training/group/reportTeacherList")
    public ModelAndView groupReportTeacher(String deptId, String id, String trainingProjectName) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("trainingProjectName", trainingProjectName);
        mv.addObject("deptId", deptId);
        mv.addObject("id", id);
        mv.setViewName("/business/personnel/training/group/groupReportTeacher");
        return mv;
    }

    //团体培训参培教师列表数据
    @ResponseBody
    @RequestMapping("/training/group/getReportMemberList")
    public Map<String, List<TrainingMember>> getGroupReportMemberList(TrainingMember trainingMember, String id) {
        String deptId = CommonUtil.getDefaultDept();
        Map<String, List<TrainingMember>> reportMap = new HashMap<String, List<TrainingMember>>();
        trainingMember.setCreator(CommonUtil.getPersonId());
        trainingMember.setCreateDept(CommonUtil.getDefaultDept());
        //trainingMember.setChanger(CommonUtil.getPersonId());
        //trainingMember.setChangeDept(CommonUtil.getDefaultDept());
        trainingMember.setTrainingId(id);
        trainingMember.setDeptId(deptId);
        reportMap.put("data", trainingService.getReportMemberList(trainingMember));
        return reportMap;
    }

    //上报参培教师
    @RequestMapping("/training/group/toReportTeacher")
    public ModelAndView toGroupReportTeacher(String deptId, String id) {
        ModelAndView mv = new ModelAndView();
        String overplus = trainingService.getTrainingOverPlusApplyNumber(id);
        mv.addObject("id", id);
        mv.addObject("deptId", deptId);
        mv.addObject("overplus", overplus);
        mv.setViewName("/business/personnel/training/group/reportGroupTeacher");
        return mv;
    }

    //人员树形下拉选
    @ResponseBody
    @RequestMapping("/training/group/getEmpTreeForReport")
    public Map<String, List> getEmpTreeForGroupReport(String deptId, String id) {
        List<Tree> empTree = new ArrayList<Tree>();
        empTree = trainingService.getEmpTreeByDeptId(deptId, id);
        //List<Training> selectedEmpList = trainingService.getSelectedEmpByDeptId(deptId);
        //map.put("selected", selectedEmpList);
        Map<String, List> map = new HashMap<String, List>();
        map.put("tree", empTree);
        return map;
    }

    //校验参培教师
    @ResponseBody
    @RequestMapping("/training/group/checkReportTeacher")
    public Message checkGroupReportTeacher(String id) {
        String number = trainingService.getTrainingOverPlusApplyNumber(id);
        if ("0".equals(number)) {
            return new Message(1, "已没有名额,无法上报！", null);
        } else {
            return new Message(0, null, null);
        }

    }

    //校验保存参培教师
    @ResponseBody
    @RequestMapping("/training/group/checkSaveReportTeacher")
    public Message checkSaveGroupReportTeacher(String ids, String deptId, String id) {
        List<Emp> empList = examService.chooseEmpList(deptId, ids);
        String number = trainingService.getTrainingOverPlusApplyNumber(id);
        if (empList.size() > Integer.parseInt(number)) {
            return new Message(1, "选择上报数量超出剩余名额,请重新选择！", null);
        } else {
            return new Message(0, null, null);
        }

    }

    //保存参培教师
    @ResponseBody
    @RequestMapping("/training/group/saveReportTeacher")
    public Message saveGroupReportTeacher(String ids, String id, String deptId) {
        trainingService.saveGroupReportTeacher(ids, id, deptId);
        return new Message(1, "保存成功！", null);
    }

    //删除参培教师
    @ResponseBody
    @RequestMapping("/training/group/delReportTeacher")
    public Message delGroupReportTeacher(String memberId, String id) {
        trainingService.delReportTeacher(memberId);
        //修改数量
        Training training = new Training();
        training = trainingService.getGroupTrainingById(id);
        String applyNumber = training.getTrainingApplyNumber();
        int number = Integer.parseInt(applyNumber) - 1;
        training.setId(id);
        training.setTrainingApplyNumber(String.valueOf(number));
        trainingService.updateTraining(training);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/training/department/upGetTrainingList")
    public Map<String, List<Training>> upGetDepartmentTrainingList(Training departmentTraining, String flag) {
        if ("1".equals(flag)) {
            departmentTraining.setRequestFlag("2");
        } else {
            departmentTraining.setRequestFlag("0");
        }
        Map<String, List<Training>> trainingMap = new HashMap<String, List<Training>>();
        departmentTraining.setRequester(CommonUtil.getPersonId());
        departmentTraining.setCreator(CommonUtil.getPersonId());
        departmentTraining.setCreateDept(CommonUtil.getDefaultDept());
        trainingMap.put("data", trainingService.upGetDepartmentTrainingList(departmentTraining));
        return trainingMap;
    }

    @ResponseBody
    @RequestMapping("/training/group/upGetTrainingList")
    public Map<String, List<Training>> upGetGroupTrainingList(Training groupTraining, String flag) {
        if ("3".equals(flag)) {
            groupTraining.setRequestFlag("2");
        } else {
            groupTraining.setRequestFlag("0");
        }
        Map<String, List<Training>> trainingMap = new HashMap<String, List<Training>>();
        groupTraining.setRequester(CommonUtil.getPersonId());
        groupTraining.setCreator(CommonUtil.getPersonId());
        groupTraining.setCreateDept(CommonUtil.getDefaultDept());
        trainingMap.put("data", trainingService.upGetGroupTrainingList(groupTraining));
        return trainingMap;
    }

    //首页待办点击详细
    @ResponseBody
    @RequestMapping("/training/searchTrainAudit")
    public ModelAndView searchTrainAudit(String businessId) {
        ModelAndView mv = new ModelAndView();
        String taskId = businessId;
        String personId = CommonUtil.getPersonId();
        SysTask sysTask = taskService.selectSysTaskByTaskId(taskId);
        String id = sysTask.getTaskBusinessId();
        Training training = trainingService.getDepartmentTrainingById(id);
        mv.addObject("training", training);
        mv.addObject("businessId", businessId);
        mv.addObject("personId", personId);
        mv.setViewName("/core/wf/indexTrainAudit");
        return mv;
    }

    /**
     * PC端团体培训打印
     */
    @ResponseBody
    @RequestMapping("/training/printGroupTraining")
    public ModelAndView printGroupTraining(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/training/group/printGroupTraining");
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_RS_TRAINING_WF03");
        Training groupTraining = trainingService.getGroupTrainingById(id);
        String requestDate = groupTraining.getRequestDate().replace("T", " ");
        String state = stampService.getStateById(id);
        List<Handle> list=stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("requestDate", requestDate);
        mv.addObject("groupTraining", groupTraining);
        mv.addObject("workflowName", workflowName);
        return mv;
    }

    /**
     * PC端部门培训打印
     */
    @ResponseBody
    @RequestMapping("/training/printDepartmentTraining")
    public ModelAndView printDepartmentTraining(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/training/department/printDepartmentTraining");
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_RS_TRAINING_WF01");
        Training departmentTraining = trainingService.getDepartmentTrainingById(id);
        String requestDate = departmentTraining.getRequestDate().replace("T", " ");
        String state = stampService.getStateById(id);
        List<Handle> list=stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("requestDate", requestDate);
        mv.addObject("departmentTraining", departmentTraining);
        mv.addObject("workflowName", workflowName);
        return mv;
    }

    /**
     * PC端部门培训打印
     */
    @ResponseBody
    @RequestMapping("/training/printPersonalTraining")
    public ModelAndView printPersonalTraining(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/training/personal/printPersonalTraining");
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_RS_TRAINING_WF02");
        Training personalTraining = trainingService.getPersonalTrainingById(id);
        String requestDate = personalTraining.getRequestDate().replace("T", " ");
        String state = stampService.getStateById(id);
        List<Handle> list=stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("requestDate", requestDate);
        mv.addObject("personalTraining", personalTraining);
        mv.addObject("workflowName", workflowName);
        return mv;
    }
}