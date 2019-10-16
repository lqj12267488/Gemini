package com.goisan.studentwork.studentleave.controller;

import com.goisan.studentwork.internships.service.InternshipManageService;
import com.goisan.studentwork.studentleave.bean.StudentLeave;
import com.goisan.studentwork.studentleave.service.StudentLeaveService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Student;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.service.WorkflowService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class StudentLeaveController {

    @Resource
    private StudentLeaveService studentLeaveService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    @Resource
    private InternshipManageService internshipManageService;
    /**
     * 学生请假申请跳转
     * request by hanlixu
     *
     * @return
     */
    @RequestMapping("/studentLeave/request")
    public ModelAndView StudentLeaveList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/studentwork/studentleave/studentLeave");
        return mv;
    }

    /**
     * 学生请假申请URL
     * URL by hanlixu
     *
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("/studentLeave/getStudentLeaveList")
    public Map<String, List<StudentLeave>> getStudentLeaveList(StudentLeave studentLeave) {
        Map<String, List<StudentLeave>> studentLeaveMap = new HashMap<String, List<StudentLeave>>();
        studentLeave.setCreator(CommonUtil.getPersonId());
        studentLeave.setCreateDept(CommonUtil.getDefaultDept());
        studentLeaveMap.put("data", studentLeaveService.getStudentLeaveList(studentLeave));
        return studentLeaveMap;
    }

    /**
     * 请假申请新增
     * add by hanlixu
     *
     * @return
     */
    @RequestMapping("/studentLeave/editStudentLeave")
    public ModelAndView addStudentLeave() {
        ModelAndView mv = new ModelAndView("/business/studentwork/studentleave/editStudentLeave");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date + 'T' + time;
        String personName = studentLeaveService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = studentLeaveService.getDeptNameById(CommonUtil.getDefaultDept());
        StudentLeave studentLeave = new StudentLeave();
        studentLeave.setRequester(personName);
        studentLeave.setRequestDate(datetime);
        studentLeave.setStartTime(date);
        studentLeave.setRequestDept(deptName);
        mv.addObject("head", "学生请假申请新增");
        mv.addObject("leave", studentLeave);
        return mv;
    }

    /**
     * 请假申请修改
     * update by hanlixu
     */
    @ResponseBody
    @RequestMapping("/studentLeave/getStudentLeaveById")
    public ModelAndView getStudentLeaveById(String id) {
        ModelAndView mv = new ModelAndView("/business/studentwork/studentleave/editStudentLeave2");
        mv.addObject("head", "学生请假申请修改");
        StudentLeave leave = studentLeaveService.getStudentLeaveById(id);
//        String studentNumber=leave.getStudentNumber();
//        Student student =internshipManageService.selectStudent(studentNumber);
//        String studentName=student.getName();
//        leave.setStudentName(studentName);
//        leave.setStudentNumber(studentNumber);
        mv.addObject("leave", leave);
        return mv;

    }

    /**
     * 保存请假申请
     */
    @ResponseBody
    @RequestMapping("/studentLeave/saveStudentLeave")
    public Message saveStudent(StudentLeave studentLeave) {
        if (studentLeave.getId() == null || studentLeave.getId().equals("")) {
            studentLeave.setCreator(CommonUtil.getPersonId());
            studentLeave.setCreateDept(CommonUtil.getDefaultDept());
            studentLeave.setRequester(CommonUtil.getPersonId());
            studentLeave.setRequestDept(CommonUtil.getDefaultDept());
            studentLeave.setId(CommonUtil.getUUID());
            studentLeaveService.insertStudentLeave(studentLeave);
            return new Message(1, "新增成功！", null);
        } else {
            studentLeave.setChanger(CommonUtil.getPersonId());
            studentLeave.setChangeDept(CommonUtil.getDefaultDept());
            studentLeaveService.updateStudentLeaveById(studentLeave);
            return new Message(1, "修改成功！", null);
        }

    }

    /**
     * 删除请假申请
     */
    @ResponseBody
    @RequestMapping("/studentLeave/deleteStudentLeaveById")
    public Message deleteStudentLeaveById(String id) {
        studentLeaveService.deleteStudentLeaveById(id);
        return new Message(1, "删除成功！", null);

    }

    /**
     * 部门自动提示框
     */
    @ResponseBody
    @RequestMapping("/studentLeave/autoCompleteDept")
    public List<AutoComplete> autoCompleteDept(){
      StudentLeave studentLeave= new StudentLeave();
      String deptId = CommonUtil.getDefaultDept();
      String level = CommonUtil.getLoginUser().getLevel();
      studentLeave.setDeptId(deptId);
      studentLeave.setLevel(level);
      return studentLeaveService.autoCompleteDept(studentLeave);
    }
    /**
     * 人员自动提示框
     *
     */
    @ResponseBody
    @RequestMapping("/studentLeave/autoCompleteEmployee")
    public List<AutoComplete>autoCompleteEmployee(){
        StudentLeave studentLeave = new StudentLeave();
        String deptId = CommonUtil.getDefaultDept();
        String level = CommonUtil.getLoginUser().getLevel();
        studentLeave.setDeptId(deptId);
        studentLeave.setLevel(level);
        return studentLeaveService.autoCompleteEmployee(studentLeave);
    }

    /**
     * 待办业务跳转
     */
    @RequestMapping("/studentLeave/process")
    public ModelAndView leaveProcess(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/studentwork/studentleave/studentLeaveProcess");
        return mv;
    }
    /**
     * 待办业务初始化
     *
     */
    @ResponseBody
    @RequestMapping("/studentLeave/getProcessList")
    public Map<String,List<StudentLeave>>getProcessList(StudentLeave studentLeave){
        Map<String,List<StudentLeave>> studentLeaveMap = new HashMap<String,List<StudentLeave>>();
        studentLeave.setCreator(CommonUtil.getPersonId());
        studentLeave.setCreateDept(CommonUtil.getDefaultDept());
        studentLeave.setChanger(CommonUtil.getPersonId());
        studentLeave.setChangeDept(CommonUtil.getDefaultDept());
        studentLeaveMap.put("data",studentLeaveService.getProcessList(studentLeave));
        return studentLeaveMap;
    }


    /**
     * 已办业务跳转
     */

    @RequestMapping("/studentLeave/complete")
    public ModelAndView leaveComplete(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentleave/studentLeaveComplete");
        return mv;
    }

    /**
     * 已办页面初始化
     */
    @ResponseBody
    @RequestMapping("/studentLeave/getCompleteList")
    public Map<String,List<StudentLeave>>getCompleteList(StudentLeave studentLeave){
        Map<String,List<StudentLeave>> studentLeaveMap = new HashMap<String,List<StudentLeave>>();
        studentLeave.setCreator(CommonUtil.getPersonId());
        studentLeave.setCreateDept(CommonUtil.getDefaultDept());
        studentLeave.setChanger(CommonUtil.getPersonId());
        studentLeave.setChangeDept(CommonUtil.getDefaultDept());
        studentLeaveMap.put("data",studentLeaveService.getCompleteList(studentLeave));
        return studentLeaveMap;
    }

    /**
     * 待办业务修改
     */
    @ResponseBody
    @RequestMapping("/studentLeave/auditStudentLeaveEdit")
    public ModelAndView auditStudentLeaveEdit(String id){
        ModelAndView mv = new ModelAndView("/business/studentwork/studentleave/editStudentLeaveProcess");
        StudentLeave leave = studentLeaveService.getStudentLeaveById(id);
        mv.addObject("head", "修改");
        mv.addObject("leave", leave);
        return mv;
     }


    /**
     * 查看流程轨迹
     */
       @ResponseBody
       @RequestMapping("/studentLeave/auditStudentLeaveById")
       public ModelAndView waitRolById(String id){
           ModelAndView mv = new ModelAndView();
           mv.setViewName("/business/studentwork/studentleave/addStudentLeaveProcess");
           StudentLeave leave = studentLeaveService.getLeaveBy(id);
           mv.addObject("head", "审批");
           mv.addObject("leave", leave);
           return mv;
       }

    /**pc端打印
     *
     *
     */
       @ResponseBody
       @RequestMapping("/studentLeave/printLeaves")
        public ModelAndView printLeaves(String id){
           ModelAndView mv = new ModelAndView("/business/studentwork/studentleave/printStudentLeaves");
           String workflowName=workflowService.getWorkflowNameByWorkflowCode("	T_XG_STUDENT_LEAVE_WF01");
           StudentLeave  leave = studentLeaveService.getLeaveBy(id);
           String requestDate = leave.getRequestDate().replace("T"," ");
           mv.addObject("requestDate", requestDate);
           mv.addObject("leave", leave);
           mv.addObject("workflowName",workflowName);
           String state = stampService.getStateById(id);
           List<Handle> list= stampService.getHandlebyId(id);
           int size=list.size();
           mv.addObject("handleList", list);
           mv.addObject("size",size);
           mv.addObject("state",state);
           final Properties properties = new Properties();
           FileInputStream in = null;
           try {
               in = new FileInputStream(this.getClass().getResource("/").getPath() + "/config.properties");
               BufferedReader bf = new BufferedReader(new InputStreamReader(in));
               properties.load(bf);
           } catch (FileNotFoundException e) {
               e.printStackTrace();
           } catch (IOException e) {
               e.printStackTrace();
           }
           String projectName = CommonUtil.getprojectName();
           mv.addObject("projectName",projectName);
           return mv;
 }




}
