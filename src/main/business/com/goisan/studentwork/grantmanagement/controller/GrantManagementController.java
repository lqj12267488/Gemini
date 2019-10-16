package com.goisan.studentwork.grantmanagement.controller;

import com.goisan.studentwork.grantmanagement.bean.GrantManagement;
import com.goisan.studentwork.grantmanagement.service.GrantManagementService;
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
public class GrantManagementController {
    @Resource
    private GrantManagementService grantmanagementService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;

    /**
     * 奖助学金申请跳转
     * request by lizhipeng
     *
     * @return
     */
    @RequestMapping("/grantmanagement/request")
    public ModelAndView GrantManagementList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/studentwork/grantmanagement/grantManagement");
        return mv;
    }

    /**
     * 奖助学金申请URL
     * URL by lizhipeng
     *
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("/grantmanagement/getGrantManagementList")
    public Map<String, List<GrantManagement>> getGrantManagementList(GrantManagement grantmanagement) {
        Map<String, List<GrantManagement>> grantmanagementMap = new HashMap<String, List<GrantManagement>>();
        grantmanagement.setCreator(CommonUtil.getPersonId());
        grantmanagement.setCreateDept(CommonUtil.getDefaultDept());
        grantmanagementMap.put("data", grantmanagementService.getGrantManagementList(grantmanagement));
        return grantmanagementMap;
    }

    /**
     * 奖助学金申请新增
     * add by lizhipeng
     *
     * @return
     */
    @RequestMapping("/grantmanagement/editGrantManagement")
    public ModelAndView addGrantManagement() {
        ModelAndView mv = new ModelAndView("/business/studentwork/grantmanagement/editGrantManagement");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date + 'T' + time;
        GrantManagement grantmanagement = new GrantManagement();
        Student student = grantmanagementService.getStudentByStudentId(CommonUtil.getPersonId());
        if (null == student) {

        } else {
            grantmanagement.setSex(student.getSex());
            grantmanagement.setDepartmentId(student.getDepartmentsId());
            grantmanagement.setClassId(student.getClassId());
            grantmanagement.setStudentId(student.getStudentId());
            grantmanagement.setMajorCode(student.getMajorCode());
        }
        grantmanagement.setRequestDate(datetime);
        mv.addObject("head", "奖助学金申请新增");
        mv.addObject("grantmanagement", grantmanagement);
        return mv;
    }

    /**
     * 奖助学金申请修改
     * update by lizhipeng
     */
    @ResponseBody
    @RequestMapping("/grantmanagement/getGrantManagementById")
    public ModelAndView getGrantManagementById(String id) {
        ModelAndView mv = new ModelAndView("/business/studentwork/grantmanagement/editGrantManagement");
        mv.addObject("head", "奖助学金申请修改");
        GrantManagement leave = grantmanagementService.getGrantManagementById(id);
        mv.addObject("grantmanagement", leave);
        return mv;

    }

    /**
     * 保存奖助学金申请
     */
    @ResponseBody
    @RequestMapping("/grantmanagement/saveGrantManagement")
    public Message saveStudent(GrantManagement grantmanagement) {
        if (grantmanagement.getId() == null || grantmanagement.getId().equals("")) {
            grantmanagement.setCreator(CommonUtil.getPersonId());
            grantmanagement.setCreateDept(CommonUtil.getDefaultDept());
            grantmanagement.setRequester(CommonUtil.getPersonId());
            grantmanagement.setId(CommonUtil.getUUID());
            grantmanagementService.insertGrantManagement(grantmanagement);
            return new Message(1, "新增成功！", null);
        } else {
            grantmanagement.setChanger(CommonUtil.getPersonId());
            grantmanagement.setChangeDept(CommonUtil.getDefaultDept());
            grantmanagementService.updateGrantManagementById(grantmanagement);
            return new Message(1, "修改成功！", null);
        }

    }

    /**
     * 删除奖助学金申请
     */
    @ResponseBody
    @RequestMapping("/grantmanagement/deleteGrantManagementById")
    public Message deleteGrantManagementById(String id) {
        grantmanagementService.deleteGrantManagementById(id);
        return new Message(1, "删除成功！", null);

    }

    /**
     * 部门自动提示框
     */
    @ResponseBody
    @RequestMapping("/grantmanagement/autoCompleteDept")
    public List<AutoComplete> autoCompleteDept() {
        GrantManagement grantmanagement = new GrantManagement();
        String deptId = CommonUtil.getDefaultDept();
        String level = CommonUtil.getLoginUser().getLevel();
        grantmanagement.setDeptId(deptId);
        grantmanagement.setLevel(level);
        return grantmanagementService.autoCompleteDept(grantmanagement);
    }

    /**
     * 人员自动提示框
     */
    @ResponseBody
    @RequestMapping("/grantmanagement/autoCompleteEmployee")
    public List<AutoComplete> autoCompleteEmployee() {
        GrantManagement grantmanagement = new GrantManagement();
        String deptId = CommonUtil.getDefaultDept();
        String level = CommonUtil.getLoginUser().getLevel();
        grantmanagement.setDeptId(deptId);
        grantmanagement.setLevel(level);
        return grantmanagementService.autoCompleteEmployee(grantmanagement);
    }

    /**
     * 待办业务跳转
     */
    @RequestMapping("/grantmanagement/process")
    public ModelAndView leaveProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/studentwork/grantmanagement/grantManagementProcess");
        return mv;
    }

    /**
     * 待办业务初始化
     */
    @ResponseBody
    @RequestMapping("/grantmanagement/getProcessList")
    public Map<String, List<GrantManagement>> getProcessList(GrantManagement grantmanagement) {
        Map<String, List<GrantManagement>> grantmanagementMap = new HashMap<String, List<GrantManagement>>();
        grantmanagement.setCreator(CommonUtil.getPersonId());
        grantmanagement.setCreateDept(CommonUtil.getDefaultDept());
        grantmanagement.setChanger(CommonUtil.getPersonId());
        grantmanagement.setChangeDept(CommonUtil.getDefaultDept());
        grantmanagementMap.put("data", grantmanagementService.getProcessList(grantmanagement));
        return grantmanagementMap;
    }


    /**
     * 已办业务跳转
     */

    @RequestMapping("/grantmanagement/complete")
    public ModelAndView leaveComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/grantmanagement/grantManagementComplete");
        return mv;
    }

    /**
     * 已办页面初始化
     */
    @ResponseBody
    @RequestMapping("/grantmanagement/getCompleteList")
    public Map<String, List<GrantManagement>> getCompleteList(GrantManagement grantmanagement) {
        Map<String, List<GrantManagement>> grantmanagementMap = new HashMap<String, List<GrantManagement>>();
        grantmanagement.setCreator(CommonUtil.getPersonId());
        grantmanagement.setCreateDept(CommonUtil.getDefaultDept());
        grantmanagement.setChanger(CommonUtil.getPersonId());
        grantmanagement.setChangeDept(CommonUtil.getDefaultDept());
        grantmanagementMap.put("data", grantmanagementService.getCompleteList(grantmanagement));
        return grantmanagementMap;
    }

    /**
     * 待办业务修改
     */
    @ResponseBody
    @RequestMapping("/grantmanagement/auditGrantManagementEdit")
    public ModelAndView auditGrantManagementEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/studentwork/grantmanagement/editGrantManagementProcess");
        GrantManagement leave = grantmanagementService.getGrantManagementById(id);
        mv.addObject("head", "修改");
        mv.addObject("grantmanagement", leave);
        return mv;
    }


    /**
     * 查看流程轨迹
     */
    @ResponseBody
    @RequestMapping("/grantmanagement/auditGrantManagementById")
    public ModelAndView waitRolById(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/grantmanagement/addGrantManagementProcess");
        GrantManagement leave = grantmanagementService.getLeaveBy(id);
        mv.addObject("head", "审批");
        mv.addObject("grantmanagement", leave);
        return mv;
    }

    /**
     * pc端打印
     */
    @ResponseBody
    @RequestMapping("/grantmanagement/printGrantManagement")
    public ModelAndView printLeaves(String id) {
        ModelAndView mv = new ModelAndView("/business/studentwork/grantmanagement/printGrantManagement");
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_XG_GRANT_MANAGEMENT_WF01");
        GrantManagement leave = grantmanagementService.getLeaveBy(id);
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
                agent = s.getRemark();
            }
            if ("部门负责人".equals(s.getHandleRole())) {
                departmentName = s.getRemark();
            }
            if ("学生处负责人".equals(s.getHandleRole())) {
                departmentNameStudent = s.getRemark();
            }
        }
        if ("".equals(requestDate)) {

        } else {
            requestDate = requestDate.split("-")[0] + "年" + requestDate.split("-")[1] + "月" + requestDate.split("-")[2].split(" ")[0] + "日";
        }
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
        GrantManagement grantmanagement = new GrantManagement();
        grantmanagement.setRequestDate(df.format(new Date()) + "");
        List<GrantManagement> list1 = grantmanagementService.getGrantManagementList(grantmanagement);
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
        mv.addObject("grantmanagement", leave);
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

    /**
     * 奖助学金查询跳转
     * request by lizhipeng
     *
     * @return
     */
    @RequestMapping("/grantmanagement/search")
    public ModelAndView GrantManagementSearch() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/studentwork/grantmanagement/grantManagementSearch");
        return mv;
    }

    /**
     * 奖助学金查询URL
     * URL by lizhipeng
     *
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("/grantmanagement/getGrantManagementSearchList")
    public Map<String, List<GrantManagement>> getGrantManagementSearchList(GrantManagement grantmanagement) {
        Map<String, List<GrantManagement>> grantmanagementMap = new HashMap<String, List<GrantManagement>>();
        grantmanagement.setCreator(CommonUtil.getPersonId());
        grantmanagement.setCreateDept(CommonUtil.getDefaultDept());
        grantmanagementMap.put("data", grantmanagementService.getGrantManagementSearchList(grantmanagement));
        return grantmanagementMap;
    }
}
