package com.goisan.studentwork.studentreissue.controller;

import com.github.stuxuhai.jpinyin.PinyinException;
import com.github.stuxuhai.jpinyin.PinyinFormat;
import com.github.stuxuhai.jpinyin.PinyinHelper;
import com.goisan.studentwork.studentprove.service.StudentProveService;
import com.goisan.studentwork.studentreissue.bean.StudentReissue;
import com.goisan.studentwork.studentreissue.service.StudentReissueService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.Student;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.service.WorkflowService;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import sun.misc.BASE64Encoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

import static java.lang.Integer.parseInt;

@Controller
public class StudentReissueController {
    @Resource
    private StudentProveService studentProveService;
    @Resource
    private StudentReissueService studentReissueService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;

    /**
     * 学生证补办申请跳转
     * request by hanlixu
     *
     * @return
     */
    @RequestMapping("/studentReissue/request")
    public ModelAndView StudentReissueList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/studentwork/studentreissue/studentReissue");
        return mv;
    }

    /**
     * 学生证补办申请URL
     * URL by hanlixu
     *
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("studentReissue/getStudentReissueList")
    public Map<String, List<StudentReissue>> getStudentReissueList(StudentReissue studentReissue) {
        Map<String, List<StudentReissue>> studentReissueMap = new HashMap<String, List<StudentReissue>>();
        studentReissue.setCreator(CommonUtil.getPersonId());
        studentReissue.setCreateDept(CommonUtil.getDefaultDept());
        studentReissueMap.put("data", studentReissueService.getStudentReissueList(studentReissue));
        return studentReissueMap;
    }
    @ResponseBody
    @RequestMapping("/studentReissue/autoCompleteDept")
    public List<AutoComplete> autoCompleteDept() {
        return studentReissueService.autoCompleteDept();
    }

    @ResponseBody
    @RequestMapping("/studentReissue/autoCompleteEmployee")
    public List<AutoComplete> autoCompleteEmployee() {
        return studentReissueService.autoCompleteEmployee();
    }

    /**
     * 学生证补办申请新增
     * add by hanlixu
     *
     * @return
     */
    @RequestMapping("/studentReissue/editStudentReissue")
    public ModelAndView addStudentReissue(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("/business/studentwork/studentreissue/editStudentReissue");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date + 'T' + time;
        StudentReissue studentReissue = new StudentReissue();
        Student student = studentProveService.getStudentByStudentId(CommonUtil.getPersonId());
        if (null == student) {

        } else {
            studentReissue.setClassId(student.getClassId());
            studentReissue.setStudentNumber(student.getStudentNumber());
            studentReissue.setStudentId(student.getStudentId());
            studentReissue.setMajorCode(student.getMajorCode());
            studentReissue.setNation(student.getNation());
            studentReissue.setSex(student.getSex());
            studentReissue.setFamilyAddress(student.getAddress());
            studentReissue.setIdcard(student.getIdcard());
            studentReissue.setPhone(student.getTel());
        }
        studentReissue.setRequestDate(datetime);
        mv.addObject("head", "学生证补办申请新增");
        mv.addObject("studentReissue", studentReissue);
        return mv;
    }

    /**
     * 学生证补办申请修改
     * update by hanlixu
     */
    @ResponseBody
    @RequestMapping("/studentReissue/getStudentReissueById")
    public ModelAndView getStudentReissueById(String id) {
        ModelAndView mv = new ModelAndView("/business/studentwork/studentreissue/editStudentReissue");
        mv.addObject("head", "学生证补办申请修改");
        StudentReissue leave = studentReissueService.getStudentReissueById(id);
        mv.addObject("studentReissue", leave);
        return mv;

    }

    /**
     * 保存学生证补办申请
     */
    @ResponseBody
    @RequestMapping("/studentReissue/saveStudentReissue")
    public Message saveStudentReissue(HttpServletRequest request, StudentReissue studentReissue, @RequestParam(value = "file", required = false) MultipartFile file) {
        byte[] bytes;
        String img = null;
        try {
            bytes = file.getBytes();
            BASE64Encoder encoder = new BASE64Encoder();
            img = encoder.encode(bytes);
        } catch (IOException e) {
            e.printStackTrace();
        }
        studentReissue.setImg(img.replace("\\r|\\n", ""));
        if (studentReissue.getId() == null || studentReissue.getId().equals("")) {
            studentReissue.setCreator(CommonUtil.getPersonId());
            studentReissue.setCreateDept(CommonUtil.getDefaultDept());
            studentReissue.setRequester(CommonUtil.getPersonId());
            studentReissue.setId(CommonUtil.getUUID());
            studentReissueService.insertStudentReissue(studentReissue);
            return new Message(1, "新增成功！", null);
        } else {
            studentReissue.setChanger(CommonUtil.getPersonId());
            studentReissue.setChangeDept(CommonUtil.getDefaultDept());
            studentReissueService.updateStudentReissueById(studentReissue);
            return new Message(1, "修改成功！", null);
        }
    }


    /**
     * 删除学生证补办申请
     */
    @ResponseBody
    @RequestMapping("/studentReissue/deleteStudentReissueById")
    public Message deleteStudentReissueById(String id) {
        studentReissueService.deleteStudentReissueById(id);
        return new Message(1, "删除成功！", null);

    }

    /**
     * 待办业务跳转
     */
    @RequestMapping("/studentReissue/process")
    public ModelAndView leaveProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/studentwork/studentreissue/studentReissueProcess");
        return mv;
    }

    /**
     * 待办业务初始化
     */
    @ResponseBody
    @RequestMapping("/studentReissue/getProcessList")
    public Map<String, List<StudentReissue>> getProcessList(StudentReissue studentReissue) {
        Map<String, List<StudentReissue>> studentReissueMap = new HashMap<String, List<StudentReissue>>();
        studentReissue.setCreator(CommonUtil.getPersonId());
        studentReissue.setChanger(CommonUtil.getPersonId());
        studentReissueMap.put("data", studentReissueService.getProcessList(studentReissue));
        return studentReissueMap;
    }


    /**
     * 已办业务跳转
     */

    @RequestMapping("/studentReissue/complete")
    public ModelAndView leaveComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentreissue/studentReissueComplete");
        return mv;
    }

    /**
     * 已办页面初始化
     */
    @ResponseBody
    @RequestMapping("/studentReissue/getCompleteList")
    public Map<String, List<StudentReissue>> getCompleteList(StudentReissue studentReissue) {
        Map<String, List<StudentReissue>> studentReissueMap = new HashMap<String, List<StudentReissue>>();
        studentReissue.setCreator(CommonUtil.getPersonId());
        studentReissue.setCreateDept(CommonUtil.getDefaultDept());
        studentReissue.setChanger(CommonUtil.getPersonId());
        studentReissue.setChangeDept(CommonUtil.getDefaultDept());
        studentReissueMap.put("data", studentReissueService.getCompleteList(studentReissue));
        return studentReissueMap;
    }

    /**
     * 待办业务修改
     */
    @ResponseBody
    @RequestMapping("/studentReissue/auditStudentReissueEdit")
    public ModelAndView auditStudentReissueEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/studentwork/studentreissue/editStudentReissueProcess");
        StudentReissue leave = studentReissueService.getStudentReissueById(id);
        mv.addObject("head", "修改");
        mv.addObject("studentReissue", leave);
        return mv;
    }


    /**
     * 查看流程轨迹
     */
    @ResponseBody
    @RequestMapping("/studentReissue/auditStudentReissueById")
    public ModelAndView waitRolById(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentreissue/addStudentReissueProcess");
        StudentReissue leave = studentReissueService.getLeaveBy(id);
        mv.addObject("head", "审批");
        mv.addObject("studentReissue", leave);
        return mv;
    }

    /**
     * pc端打印
     */
    @ResponseBody
    @RequestMapping("/studentReissue/printStudentReissue")
    public ModelAndView printLeaves(String id) {
        ModelAndView mv = new ModelAndView("/business/studentwork/studentreissue/printStudentReissue");
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_XG_STUDENT_REISSUE_WF01");
        StudentReissue leave = studentReissueService.getLeaveBy(id);
        leave.setRequestDate(leave.getRequestDate().split("T")[0].split("-")[0]+"年"+leave.getRequestDate().split("T")[0].split("-")[1]+"月"+leave.getRequestDate().split("T")[0].split("-")[2]+"日");
        mv.addObject("studentReissue", leave);
        mv.addObject("workflowName", workflowName);
        String state = stampService.getStateById(id);
        List<Handle> list = stampService.getHandlebyId(id);
        int size = list.size();
        String agent = "";
        String requestDate = "";
        String departmentName = "";
        String departmentNameStudent = "";

        String agentNames = "";
        String departmentNames = "";
        String departmentStudentNames = "";

        String departmentNameRequestDate = "";
        String departmentNameStudentRequestDate = "";
        String agentRequestDate = "";

        String number = "";
        for (Handle s : list) {
            requestDate = s.getHandleTime();
            if ("年级组组长".equals(s.getHandleRole())) {
                agentNames = s.getHandleName();
                agent = s.getRemark();
                agentRequestDate =  s.getHandleTime().split(" ")[0].split("-")[0]+"年"+s.getHandleTime().split(" ")[0].split("-")[1]+"月"+s.getHandleTime().split(" ")[0].split("-")[2]+"日";
            }
            if ("部门负责人".equals(s.getHandleRole())) {
                departmentNames = s.getHandleName();
                departmentName = s.getRemark();
                departmentNameRequestDate =  s.getHandleTime().split(" ")[0].split("-")[0]+"年"+s.getHandleTime().split(" ")[0].split("-")[1]+"月"+s.getHandleTime().split(" ")[0].split("-")[2]+"日";
            }
            if ("学生处负责人".equals(s.getHandleRole())) {
                departmentStudentNames = s.getHandleName();
                departmentNameStudent = s.getRemark();
                departmentNameStudentRequestDate =  s.getHandleTime().split(" ")[0].split("-")[0]+"年"+s.getHandleTime().split(" ")[0].split("-")[1]+"月"+s.getHandleTime().split(" ")[0].split("-")[2]+"日";
            }
        }
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
        StudentReissue studentProve = new StudentReissue();
        studentProve.setRequestDate(df.format(new Date()) + "");
        if ("".equals(requestDate)) {

        } else {
            requestDate = requestDate.split("-")[0] + "年" + requestDate.split("-")[1] + "月" + requestDate.split("-")[2].split(" ")[0] + "日";
        }
        List<StudentReissue> list1 = studentReissueService.getStudentReissueList(studentProve);
        if (list1.size() < 9) {
            number = df.format(new Date()).split("-")[0] + df.format(new Date()).split("-")[1] + df.format(new Date()).split("-")[2] + "00" + (list1.size() + 1);
        } else if (list1.size() < 99) {
            number = df.format(new Date()).split("-")[0] + df.format(new Date()).split("-")[1] + df.format(new Date()).split("-")[2] + "0" + (list1.size() + 1);
        } else {
            number = df.format(new Date()).split("-")[0] + df.format(new Date()).split("-")[1] + df.format(new Date()).split("-")[2] + (list1.size() + 1);
        }
        String newDate = df.format(new Date()).split("-")[0] + "年" + df.format(new Date()).split("-")[1] + "月" + df.format(new Date()).split("-")[2] + "日";
        mv.addObject("newDate", newDate);
        mv.addObject("agentNames", agentNames);
        mv.addObject("agentRequestDate", agentRequestDate);
        mv.addObject("departmentNames", departmentNames);
        mv.addObject("departmentNameRequestDate", departmentNameRequestDate);
        mv.addObject("departmentStudentNames", departmentStudentNames);
        mv.addObject("departmentNameStudentRequestDate", departmentNameStudentRequestDate);
        mv.addObject("number", number);
        mv.addObject("requestDate", requestDate);
        mv.addObject("agent", agent);
        mv.addObject("departmentName", departmentName);
        mv.addObject("departmentNameStudent", departmentNameStudent);
        mv.addObject("size", size);
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
