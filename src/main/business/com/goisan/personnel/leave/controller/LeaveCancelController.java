package com.goisan.personnel.leave.controller;

import com.goisan.personnel.leave.bean.Leave;
import com.goisan.personnel.leave.bean.LeaveCancel;
import com.goisan.personnel.leave.service.LeaveCancelService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.service.WorkflowService;
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
 * Created by hanyu on 2017/7/21.
 */
@Controller
public class LeaveCancelController {
    @Resource
    private LeaveCancelService leaveCancelService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;

    /**
     * 销假申请申请跳转
     * request by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/leaveCancel/request")
    public ModelAndView leaveCancelList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/leavecancel/leaveCancel");
        return mv;
    }

    /**
     * 查询请假和销假页面跳转
     * request by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/leaveCancel/selectAll")
    public ModelAndView AllList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/leavecancel/selectAll");
        return mv;
    }

    /**
     * 销假申请URL
     * url by hanyue
     * modify by hanyue
     *
     * @param leaveCancel
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/getLeaveCancelList")
    public Map<String, List<LeaveCancel>> getLeaveCancelList(LeaveCancel leaveCancel) {
        Map<String, List<LeaveCancel>> leaveCancelMap = new HashMap<String, List<LeaveCancel>>();
        leaveCancel.setCreator(CommonUtil.getPersonId());
        leaveCancel.setCreateDept(CommonUtil.getDefaultDept());
        leaveCancelMap.put("data", leaveCancelService.getLeaveCancelList(leaveCancel));
        return leaveCancelMap;
    }

    /**
     * 请销假记录统计URL
     * url by hanyue
     * modify by hanyue
     *
     * @param leaveCancel
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/getAllList")
    public Map<String, List<LeaveCancel>> getAllList(LeaveCancel leaveCancel) {
        Map<String, List<LeaveCancel>> leaveCancelMap = new HashMap<String, List<LeaveCancel>>();
        leaveCancel.setCreator(CommonUtil.getPersonId());
        leaveCancel.setCreateDept(CommonUtil.getDefaultDept());
        leaveCancelMap.put("data", leaveCancelService.getAllList(leaveCancel));
        return leaveCancelMap;
    }

    /**
     * 销假申请新增
     * add by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/getLeaveCancelById")
    public ModelAndView getLeaveCancelById(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/leavecancel/editLeaveCancel");
        LeaveCancel leaveCancel = leaveCancelService.getLeaveCancelById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date + 'T' + time;
        String personName = leaveCancelService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = leaveCancelService.getDeptNameById(CommonUtil.getDefaultDept());
        leaveCancel.setCancelRequester(personName);
        leaveCancel.setCancelRequestDate(datetime);
        leaveCancel.setCancelStartTime(date);
        leaveCancel.setCancelRequestDept(deptName);
        mv.addObject("head", "销假申请新增");
        mv.addObject("leave", leaveCancel);
        return mv;
    }

    /**
     * 销假申请新增保存
     * save by hanyue
     * modify by hanyue
     *
     * @param leaveCancel
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/saveLeaveCancel")
    public Message saveLeaveCancel(LeaveCancel leaveCancel) {

        leaveCancel.setCreator(CommonUtil.getPersonId());
        leaveCancel.setCreateDept(CommonUtil.getDefaultDept());
        leaveCancel.setCancelRequester(CommonUtil.getPersonId());
        leaveCancel.setCancelRequestDept(CommonUtil.getDefaultDept());
        leaveCancelService.insertLeaveCancel(leaveCancel);
        return new Message(1, "新增成功！", null);

    }

    /**
     * 判断销假表中是否有当前ID的数据
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/selectLeaveCancel")
    public boolean selectLeaveCancel(String id) {
        List<LeaveCancel> list = leaveCancelService.selectLeaveCancel(id);
        if (list.size() > 0) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 销假申请修改
     * update by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/getById")
    public ModelAndView getById(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/leavecancel/addLeaveCancel");
        mv.addObject("head", "销假申请修改");
        LeaveCancel leaveCancel = leaveCancelService.getById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date + 'T' + time;
        String personName = leaveCancelService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = leaveCancelService.getDeptNameById(CommonUtil.getDefaultDept());
        leaveCancel.setCancelRequester(personName);
        leaveCancel.setCancelRequestDate(datetime);
        leaveCancel.setCancelRequestDept(deptName);
        mv.addObject("leave", leaveCancel);
        return mv;
    }

    /**
     * 修改保存
     * edit save by hanyue
     * modify by hanyue
     *
     * @param leaveCancel
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/editCancel")
    public Message editCancel(LeaveCancel leaveCancel) {
        leaveCancel.setCreator(CommonUtil.getPersonId());
        leaveCancel.setCreateDept(CommonUtil.getDefaultDept());
        leaveCancel.setCancelRequester(CommonUtil.getPersonId());
        leaveCancel.setCancelRequestDept(CommonUtil.getDefaultDept());
        leaveCancelService.updateLeaveCancelById(leaveCancel);
        return new Message(1, "修改成功！", null);

    }

    /**
     * 删除销假申请
     * delete by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/deleteLeaveCancelById")
    public Message deleteLeaveCancelById(String id) {
        leaveCancelService.deleteLeaveCancelById(id);
        return new Message(1, "删除成功！", null);
    }

    /**
     * 部门自动提示框
     * dept by hanyue
     * modify by hanyue
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/autoCompleteDept")
    public List<AutoComplete> autoCompleteDept() {
        return leaveCancelService.autoCompleteDept();
    }

    /**
     * 人员自动提示框
     * person by hanyue
     * modify by hanyue
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/autoCompleteEmployee")
    public List<AutoComplete> autoCompleteEmployee() {
        return leaveCancelService.autoCompleteEmployee();
    }

    /**
     * 代办业务跳转
     * agency business by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/leaveCancel/process")
    public ModelAndView leaveCancelProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/leavecancel/leaveCancelProcess");
        return mv;
    }

    /**
     * 代办业务初始化
     * agency business initialize by hanyue
     * modify by hanyue
     *
     * @param leaveCancel
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/getProcessList")
    public Map<String, List<LeaveCancel>> getProcessList(LeaveCancel leaveCancel) {
        Map<String, List<LeaveCancel>> leaveCancelMap = new HashMap<String, List<LeaveCancel>>();
        leaveCancel.setCreator(CommonUtil.getPersonId());
        leaveCancel.setCreateDept(CommonUtil.getDefaultDept());
        leaveCancel.setChanger(CommonUtil.getPersonId());
        leaveCancel.setChangeDept(CommonUtil.getDefaultDept());
        leaveCancelMap.put("data", leaveCancelService.getProcessList(leaveCancel));
        return leaveCancelMap;
    }

    /**
     * 已办业务跳转
     * already done business by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/leaveCancel/complete")
    public ModelAndView leaveCancelComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/leavecancel/leaveCancelComplete");
        return mv;
    }

    /**
     * 已办页面初始化
     * already done business initialize by hanyue
     * modify by hanyue
     *
     * @param leaveCancel
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/getCompleteList")
    public Map<String, List<LeaveCancel>> getCompleteList(LeaveCancel leaveCancel) {
        Map<String, List<LeaveCancel>> leaveCancelMap = new HashMap<String, List<LeaveCancel>>();
        leaveCancel.setCreator(CommonUtil.getPersonId());
        leaveCancel.setCreateDept(CommonUtil.getDefaultDept());
        leaveCancel.setChanger(CommonUtil.getPersonId());
        leaveCancel.setChangeDept(CommonUtil.getDefaultDept());
        leaveCancelMap.put("data", leaveCancelService.getCompleteList(leaveCancel));
        return leaveCancelMap;
    }

    /**
     * 待办修改
     * agency update by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/auditLeaveCancelEdit")
    public ModelAndView auditLeaveCancelEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/leavecancel/editProcess");
        LeaveCancel leaveCancel = leaveCancelService.getEditProcessById(id);
        mv.addObject("head", "修改");
        mv.addObject("leaveCancel", leaveCancel);
        return mv;
    }

    /**
     * 查看流程轨迹
     * process trajectory by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/auditLeaveCancelById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/leavecancel/addLeaveCancelProcess");
        LeaveCancel leaveCancel = leaveCancelService.getCancelById(id);
        mv.addObject("head", "审批");
        mv.addObject("leaveCancel", leaveCancel);
        return mv;
    }

    /**
     * 查看请假数据
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/auditLeaveById")
    public ModelAndView waitById(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/leavecancel/selectLeave");
        Leave leave = leaveCancelService.getLeaveById(id);
        mv.addObject("head", "查看详情");
        mv.addObject("leave", leave);
        return mv;
    }

    /**
     * 查询请假和销假表中对应该id的数据
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/selectOne")
    public ModelAndView selectOne(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/leavecancel/selectOne");
        LeaveCancel leaveCancel = leaveCancelService.selectOne(id);
        mv.addObject("head", "查看详情");
        mv.addObject("leave", leaveCancel);
        return mv;
    }

    /**
     * 查询销假表中对应该id的数据
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/selectLeaveCancelById")
    public boolean selectLeaveCancelById(String id) {
        List<LeaveCancel> list1 = leaveCancelService.selectLeaveCancelById(id);
        LeaveCancel leaveCancel11 = leaveCancelService.selectLeaveCancelId(id);
        if (list1.size() > 0) {
            return true;
        } else {
            return false;
        }
    }

    @ResponseBody
    @RequestMapping("/leaveCancel/LeaveCancelId")
    public String selectLeaveCancelId(String id) {
        LeaveCancel leaveCancel11 = leaveCancelService.selectLeaveCancelId(id);
        return leaveCancel11.getId();
    }

    /**
     * 获取销假的主键id
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/selectId")
    public String selectId(String id) {
        String str = leaveCancelService.selectId(id);
        return str;
    }

    /**
     * 判断销假的申请状态
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/selectFlag")
    public boolean selectFlag(String id) {
        String str = leaveCancelService.selectFlag(id);
        if (str.equals("0")) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * PC端打印
     */
    @ResponseBody
    @RequestMapping("/leaveCancel/printLeaveCancels")
    public ModelAndView printLeaves(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/leavecancel/printLeaveCancels");
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_RS_LEAVE_CANCEL_WF01");
        LeaveCancel leaveCancel = leaveCancelService.selectLeaveCancelId(id);
        String requestDate = leaveCancel.getCancelRequestDate().replace("T", " ");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("requestDate", requestDate);
        mv.addObject("leaveCancel", leaveCancel);
        mv.addObject("workflowName", workflowName);
        return mv;
    }

}


