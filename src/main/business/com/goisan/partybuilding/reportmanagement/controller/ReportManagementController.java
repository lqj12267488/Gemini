package com.goisan.partybuilding.reportmanagement.controller;
import com.goisan.partybuilding.reportmanagement.bean.ReportManagement;
import com.goisan.partybuilding.reportmanagement.service.ReportManagementService;
import com.goisan.studentwork.grantmanagement.service.GrantManagementService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Student;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.system.tools.UpperMoney;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.service.DefinitionService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/5/6 0006.
 */
@Controller
public class ReportManagementController {
    @Resource
    private ReportManagementService reportManagementService;
    @Resource
    private EmpService empService;
    @Resource
    private GrantManagementService grantmanagementService;

    /**
     * 申请页面*/
    @RequestMapping("/reportManagement/request")
    public ModelAndView fundsList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/partybuilding/reportManagement/reportManagementIndex");
        return mv;
    }
    /**
     * 待办页面*/
    @RequestMapping("/reportManagement/process")
    public ModelAndView reportManagementProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/partybuilding/reportManagement/reportManagementProcess");
        return mv;
    }
    /**
     * 已办页面*/
    @RequestMapping("/reportManagement/complete")
    public ModelAndView reportManagementComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/partybuilding/reportManagement/reportManagementComplete");
        return mv;
    }
    /**
     * 申请列表查询语句*/
    @ResponseBody
    @RequestMapping("/reportManagement/getReportManagementList")
    public Map<String, List<ReportManagement>> getReportManagementList(ReportManagement reportManagement) {
        Map<String, List<ReportManagement>> loanMap = new HashMap<String, List<ReportManagement>>();
        reportManagement.setCreator(CommonUtil.getPersonId());
        reportManagement.setCreateDept(CommonUtil.getDefaultDept());
        loanMap.put("data", reportManagementService.getReportManagementList(reportManagement));
        return loanMap;
    }
    /**
     * 待办列表查询语句*/
    @ResponseBody
    @RequestMapping("/reportManagement/getReportManagementProcessList")
    public Map<String, List<ReportManagement>> getReportManagementProcessList(ReportManagement reportManagement ) {
        Map<String, List<ReportManagement>> fundsMap = new HashMap<String, List<ReportManagement>>();
        reportManagement.setCreator(CommonUtil.getPersonId());
        reportManagement.setCreateDept(CommonUtil.getDefaultDept());
        List<ReportManagement> r = reportManagementService.reportManagementProcessList(reportManagement);
        fundsMap.put("data", r);
        return fundsMap;
    }
    /**
     * 新增修改页面*/
    @ResponseBody
    @RequestMapping("/reportManagement/editReportManagement")
    public ModelAndView editReportManagement(String id) {
        ModelAndView mv = new ModelAndView();
        ReportManagement reportManagement=new ReportManagement();
        if(id==null || id==""){
            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
            String date = formatDate.format(new Date());
            String time = formatTime.format(new Date());
            String datetime = date+"T"+time;
          if ("0".equals(CommonUtil.getLoginUser().getUserType())){
              String personName = empService.getPersonNameById(CommonUtil.getPersonId());
              String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
              reportManagement.setManager(personName);
              reportManagement.setRequestDept(deptName);
              reportManagement.setStudentTeacherType("1");
              mv.addObject("name",personName);
              mv.addObject("dept",deptName);
          }else{
              Student student = grantmanagementService.getStudentByStudentId(CommonUtil.getPersonId());
              reportManagement.setManager(student.getName());
              reportManagement.setRequestDept(student.getClassShow());
              reportManagement.setStudentTeacherType("0");
              mv.addObject("name",student);
              mv.addObject("dept",student);
          }
            reportManagement.setRequestDate(datetime);
            mv.addObject("head", "新增申请");
        }else {
            reportManagement = reportManagementService.getReportManagementById(id);
            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
            String date = formatDate.format(new Date());
            String time = formatTime.format(new Date());
            String datetime = date + "T" + time;

            if ("0".equals(CommonUtil.getLoginUser().getUserType())){
                String personName = empService.getPersonNameById(CommonUtil.getPersonId());
                String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
                reportManagement.setManager(personName);
                reportManagement.setRequestDept(deptName);
                reportManagement.setStudentTeacherType("1");
                mv.addObject("name",personName);
                mv.addObject("dept",deptName);
            }else{
                Student student = grantmanagementService.getStudentByStudentId(CommonUtil.getPersonId());
                reportManagement.setManager(student.getName());
                reportManagement.setRequestDept(student.getClassShow());
                reportManagement.setStudentTeacherType("0");
                mv.addObject("name",student);
                mv.addObject("dept",student);
            }
            reportManagement.setRequestDate(datetime);
            mv.addObject("head", "修改申请");
        }
        mv.setViewName("/business/partybuilding/reportManagement/editReportManagement");
        mv.addObject("reportManagement", reportManagement);
        return mv;
    }
    /**
     * 新增修改保存方法*/
    @ResponseBody
    @RequestMapping("/reportManagement/saveReportManagement")
    public Message saveReportManagement(ReportManagement reportManagement){
        reportManagement.setRequestDept(CommonUtil.getLoginUser().getDefaultDeptId());
        reportManagement.setManager(CommonUtil.getPersonId());
        if(reportManagement.getId()==null || ("").equals(reportManagement.getId())){
            reportManagement.setCreator(CommonUtil.getPersonId());
            reportManagement.setCreateDept(CommonUtil.getDefaultDept());
            reportManagement.setId(CommonUtil.getUUID());
            reportManagement.setRequestFlag("0");
            if ("0".equals(CommonUtil.getLoginUser().getUserType())){
                reportManagement.setStudentTeacherType("1");
                reportManagementService.insertReportManagement(reportManagement);
                return new Message(1, "新增成功！", null);
            }else{
                reportManagement.setStudentTeacherType("0");
                reportManagementService.insertReportManagement(reportManagement);
                return new Message(1, "新增成功！", null);
            }

        }else{
            reportManagement.setChanger(CommonUtil.getPersonId());
            reportManagement.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            if ("0".equals(CommonUtil.getLoginUser().getUserType())){
                reportManagement.setStudentTeacherType("1");
                reportManagementService.updateReportManagement(reportManagement);
                return new Message(1, "修改成功！", null);
            }else{
                reportManagement.setStudentTeacherType("0");
                reportManagementService.updateReportManagement(reportManagement);
                return new Message(1, "修改成功！", null);
            }
        }
    }
    /**
     * 删除方法*/
    @ResponseBody
    @RequestMapping("/reportManagement/deleteReportManagementById")
    public Message deleteReportManagementById(String id) {
        reportManagementService.deleteById(id);
        return new Message(1, "删除成功！", null);
    }
    /**
     * 办理页面*/
    @ResponseBody
    @RequestMapping("/reportManagement/auditReportManagementById")
    public ModelAndView auditReportManagementById(String id,String name) {
        ModelAndView mv = new ModelAndView("/business/partybuilding/reportManagement/auditReportManagementProcess");
        ReportManagement reportManagement = reportManagementService.getReportManagementById(id);
        if ("1".equals(reportManagement.getStudentTeacherType())){
            String personName = empService.getPersonNameById(CommonUtil.getPersonId());
            String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
            reportManagement.setManager(personName);
            reportManagement.setRequestDept(deptName);
            mv.addObject("name",personName);
            mv.addObject("dept",deptName);
        }else{
            String studentId =  grantmanagementService.getStudentId(name);
            Student student = grantmanagementService.getStudentByStudentId(studentId);
            reportManagement.setManager(student.getName());
            reportManagement.setRequestDept(student.getClassShow());
            mv.addObject("name",student);
            mv.addObject("dept",student);
        }

        mv.addObject("reportManagement", reportManagement);
        mv.addObject("head", "审批");
        return mv;
    }
    /**
     * 驳回修改方法*/
    @ResponseBody
    @RequestMapping("/reportManagement/auditEditReportManagement")
    public ModelAndView auditEditReportManagement(String id,String name) {
        ModelAndView mv = new ModelAndView("/business/partybuilding/reportManagement/auditEditReportManagement");
        ReportManagement reportManagement = reportManagementService.getReportManagementById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;

        if ("1".equals(reportManagement.getStudentTeacherType())){
            String personName = empService.getPersonNameById(CommonUtil.getPersonId());
            String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
            reportManagement.setManager(personName);
            reportManagement.setRequestDept(deptName);
            mv.addObject("name",personName);
            mv.addObject("dept",deptName);
        }else{
            String studentId =  grantmanagementService.getStudentId(name);
            Student student = grantmanagementService.getStudentByStudentId(studentId);
            reportManagement.setManager(student.getName());
            reportManagement.setRequestDept(student.getClassShow());
            mv.addObject("name",student);
            mv.addObject("dept",student);
        }
        reportManagement.setRequestDate(datetime);
        mv.addObject("head", "修改");
        mv.addObject("reportManagement", reportManagement);
        return mv;
    }
    /**
     * 已办列表查询语句*/
    @ResponseBody
    @RequestMapping("/reportManagement/getReportManagementCompleteList")
    public Map<String, List<ReportManagement>> getReportManagementCompleteList(ReportManagement reportManagement) {
        Map<String, List<ReportManagement>> fundsMap = new HashMap<String, List<ReportManagement>>();
        reportManagement.setCreator(CommonUtil.getPersonId());
        reportManagement.setCreateDept(CommonUtil.getDefaultDept());
        List<ReportManagement> r = reportManagementService.reportManagementCompleteList(reportManagement);
        fundsMap.put("data", r);
        return fundsMap;
    }

    /**
     * 查询关联事物是否有数据
     */
    @ResponseBody
    @RequestMapping("/reportManagement/searchCR")
    public Message getReportManagementDetailList(String id) {
        List<ReportManagement> list = reportManagementService.getReportManagementDetailList(id);
        String msg = reportManagementService.getWorkFlowbyBusinessId(id);
        if (list.size() > 0) {
            return new Message(1, msg, null);
        } else {
            return new Message(0, "", null);
        }
    }

}
