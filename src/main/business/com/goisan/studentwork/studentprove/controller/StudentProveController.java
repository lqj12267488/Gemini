package com.goisan.studentwork.studentprove.controller;

import com.goisan.studentwork.studentprove.bean.StudentProve;
import com.goisan.studentwork.studentprove.service.StudentProveService;
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
public class StudentProveController {

    @Resource
    private StudentProveService studentProveService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;

    /**
     * 在读证明申请跳转
     * request by hanlixu
     *
     * @return
     */
    @RequestMapping("/studentProve/request")
    public ModelAndView StudentProveList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/studentwork/studentprove/studentProve");
        return mv;
    }

    /**
     * 在读证明申请URL
     * URL by hanlixu
     *
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("studentProve/getStudentProveList")
    public Map<String, List<StudentProve>> getStudentProveList(StudentProve studentProve) {
        Map<String, List<StudentProve>> studentProveMap = new HashMap<String, List<StudentProve>>();
        studentProve.setCreator(CommonUtil.getPersonId());
        studentProve.setCreateDept(CommonUtil.getDefaultDept());
        studentProveMap.put("data", studentProveService.getStudentProveList(studentProve));
        return studentProveMap;
    }

    /**
     * 在读证明申请新增
     * add by hanlixu
     *
     * @return
     */
    @RequestMapping("/studentProve/editStudentProve")
    public ModelAndView addStudentProve() {
        ModelAndView mv = new ModelAndView("/business/studentwork/studentprove/editStudentProve");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date + 'T' + time;
        StudentProve studentProve = new StudentProve();
        Student student = studentProveService.getStudentByStudentId(CommonUtil.getPersonId());
        if (null == student) {

        } else {
            studentProve.setClassId(student.getClassId());
            studentProve.setStudentNumber(student.getStudentNumber());
            studentProve.setStudentId(student.getStudentId());
            studentProve.setMajorCode(student.getMajorCode());
        }
        studentProve.setRequestDate(datetime);
        mv.addObject("head", "在读证明申请新增");
        mv.addObject("studentProve", studentProve);
        return mv;
    }

    /**
     * 在读证明申请修改
     * update by hanlixu
     */
    @ResponseBody
    @RequestMapping("/studentProve/getStudentProveById")
    public ModelAndView getStudentProveById(String id) {
        ModelAndView mv = new ModelAndView("/business/studentwork/studentprove/editStudentProve");
        mv.addObject("head", "在读证明申请修改");
        StudentProve leave = studentProveService.getStudentProveById(id);
        mv.addObject("studentProve", leave);
        return mv;

    }

    /**
     * 保存在读证明申请
     */
    @ResponseBody
    @RequestMapping("/studentProve/saveStudentProve")
    public Message saveStudent(StudentProve studentProve) {
        if (studentProve.getId() == null || studentProve.getId().equals("")) {
            studentProve.setCreator(CommonUtil.getPersonId());
            studentProve.setCreateDept(CommonUtil.getDefaultDept());
            studentProve.setRequester(CommonUtil.getPersonId());
            studentProve.setId(CommonUtil.getUUID());
            studentProveService.insertStudentProve(studentProve);
            return new Message(1, "新增成功！", null);
        } else {
            studentProve.setChanger(CommonUtil.getPersonId());
            studentProve.setChangeDept(CommonUtil.getDefaultDept());
            studentProveService.updateStudentProveById(studentProve);
            return new Message(1, "修改成功！", null);
        }

    }

    /**
     * 删除在读证明申请
     */
    @ResponseBody
    @RequestMapping("/studentProve/deleteStudentProveById")
    public Message deleteStudentProveById(String id) {
        studentProveService.deleteStudentProveById(id);
        return new Message(1, "删除成功！", null);

    }

    /**
     * 部门自动提示框
     */
    @ResponseBody
    @RequestMapping("/studentProve/autoCompleteDept")
    public List<AutoComplete> autoCompleteDept() {
        StudentProve studentProve = new StudentProve();
        String deptId = CommonUtil.getDefaultDept();
        String level = CommonUtil.getLoginUser().getLevel();
        studentProve.setDeptId(deptId);
        studentProve.setLevel(level);
        return studentProveService.autoCompleteDept(studentProve);
    }

    /**
     * 人员自动提示框
     */
    @ResponseBody
    @RequestMapping("/studentProve/autoCompleteEmployee")
    public List<AutoComplete> autoCompleteEmployee() {
        StudentProve studentProve = new StudentProve();
        String deptId = CommonUtil.getDefaultDept();
        String level = CommonUtil.getLoginUser().getLevel();
        studentProve.setDeptId(deptId);
        studentProve.setLevel(level);
        return studentProveService.autoCompleteEmployee(studentProve);
    }

    /**
     * 待办业务跳转
     */
    @RequestMapping("/studentProve/process")
    public ModelAndView leaveProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/studentwork/studentprove/studentProveProcess");
        return mv;
    }

    /**
     * 待办业务初始化
     */
    @ResponseBody
    @RequestMapping("/studentProve/getProcessList")
    public Map<String, List<StudentProve>> getProcessList(StudentProve studentProve) {
        Map<String, List<StudentProve>> studentProveMap = new HashMap<String, List<StudentProve>>();
        studentProve.setCreator(CommonUtil.getPersonId());
        studentProve.setCreateDept(CommonUtil.getDefaultDept());
        studentProve.setChanger(CommonUtil.getPersonId());
        studentProve.setChangeDept(CommonUtil.getDefaultDept());
        studentProveMap.put("data", studentProveService.getProcessList(studentProve));
        return studentProveMap;
    }


    /**
     * 已办业务跳转
     */

    @RequestMapping("/studentProve/complete")
    public ModelAndView leaveComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentprove/studentProveComplete");
        return mv;
    }

    /**
     * 已办页面初始化
     */
    @ResponseBody
    @RequestMapping("/studentProve/getCompleteList")
    public Map<String, List<StudentProve>> getCompleteList(StudentProve studentProve) {
        Map<String, List<StudentProve>> studentProveMap = new HashMap<String, List<StudentProve>>();
        studentProve.setCreator(CommonUtil.getPersonId());
        studentProve.setCreateDept(CommonUtil.getDefaultDept());
        studentProve.setChanger(CommonUtil.getPersonId());
        studentProve.setChangeDept(CommonUtil.getDefaultDept());
        studentProveMap.put("data", studentProveService.getCompleteList(studentProve));
        return studentProveMap;
    }

    /**
     * 待办业务修改
     */
    @ResponseBody
    @RequestMapping("/studentProve/auditStudentProveEdit")
    public ModelAndView auditStudentProveEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/studentwork/studentprove/editStudentProveProcess");
        StudentProve leave = studentProveService.getStudentProveById(id);
        mv.addObject("head", "修改");
        mv.addObject("studentProve", leave);
        return mv;
    }


    /**
     * 查看流程轨迹
     */
    @ResponseBody
    @RequestMapping("/studentProve/auditStudentProveById")
    public ModelAndView waitRolById(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentprove/addStudentProveProcess");
        StudentProve leave = studentProveService.getLeaveBy(id);
        mv.addObject("head", "审批");
        mv.addObject("studentProve", leave);
        return mv;
    }

    /**
     * pc端打印
     */
    @ResponseBody
    @RequestMapping("/studentProve/printStudentProve")
    public ModelAndView printLeaves(String id) {
        ModelAndView mv = new ModelAndView("/business/studentwork/studentprove/printStudentProve");
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_XG_STUDENT_PROVE_WF01");
        StudentProve leave = studentProveService.getLeaveBy(id);
        String state = stampService.getStateById(id);
        List<Handle> list = stampService.getHandlebyId(id);
        int size = list.size();
        String requestDate = "";
        String agent = "";
        String departmentName = "";
        String departmentNameStudent = "";
        String grade = "";
        String number = "";
        grade = leave.getYears().substring(2, 4);
        for (Handle s : list) {
            requestDate = s.getHandleTime();
            if ("经办人".equals(s.getHandleRole())) {
                agent = s.getHandleName();
            }
            if ("部门负责人".equals(s.getHandleRole())) {
                departmentName = s.getHandleName();
            }
            if ("学生处负责人".equals(s.getHandleRole())) {
                departmentNameStudent = s.getHandleName();
            }
        }
        if ("".equals(requestDate)) {

        } else {
            requestDate = requestDate.split("-")[0] + "年" + requestDate.split("-")[1] + "月" + requestDate.split("-")[2].split(" ")[0] + "日";
        }
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
        StudentProve studentProve = new StudentProve();
        studentProve.setRequestDate(df.format(new Date()) + "");
        List<StudentProve> list1 = studentProveService.getStudentProveList(studentProve);
        if (list1.size() < 9) {
            number = df.format(new Date()).split("-")[0] + df.format(new Date()).split("-")[1] + df.format(new Date()).split("-")[2] + "00" + (list1.size() + 1);
        } else if (list1.size() < 99) {
            number = df.format(new Date()).split("-")[0] + df.format(new Date()).split("-")[1] + df.format(new Date()).split("-")[2] + "0" + (list1.size() + 1);
        } else {
            number = df.format(new Date()).split("-")[0] + df.format(new Date()).split("-")[1] + df.format(new Date()).split("-")[2] + (list1.size() + 1);
        }
        String newDate = df.format(new Date()).split("-")[0] + "年" + df.format(new Date()).split("-")[1] + "月" + df.format(new Date()).split("-")[2] + "日";
        mv.addObject("newDate", newDate);
        mv.addObject("requestDate", requestDate);
        mv.addObject("agent", agent);
        mv.addObject("number", number);
        mv.addObject("grade", grade);
        mv.addObject("departmentName", departmentName);
        mv.addObject("departmentNameStudent", departmentNameStudent);
        mv.addObject("studentProve", leave);
        mv.addObject("state", state);
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
        mv.addObject("projectName", projectName);
        return mv;
    }

}
