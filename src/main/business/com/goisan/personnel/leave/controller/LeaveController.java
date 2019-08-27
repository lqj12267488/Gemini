package com.goisan.personnel.leave.controller;

import com.goisan.personnel.leave.bean.Leave;
import com.goisan.personnel.leave.service.LeaveService;
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
 * Created by hanyu on 2017/7/20.
 */
@Controller
public class LeaveController {
    @Resource
    private LeaveService leaveService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    /**
     * 请假申请申请跳转
     * request by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/leave/request")
    public ModelAndView leaveList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/leave/leave");
        return mv;
    }

    /**
     * 请假申请URL
     *  url by hanyue
     *  modify by hanyue
     * @param leave
     * @return
     */
    @ResponseBody
    @RequestMapping("/leave/getLeaveList")
    public Map<String,List<Leave>> getLeaveList(Leave leave) {
        Map<String, List<Leave>> leaveMap = new HashMap<String, List<Leave>>();
        leave.setCreator(CommonUtil.getPersonId());
        leave.setCreateDept(CommonUtil.getDefaultDept());
        leaveMap.put("data", leaveService.getLeaveList(leave));
        return leaveMap;
    }
    /**
     * 请假申请新增
     * add by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/leave/editLeave")
    public ModelAndView addLeave() {
        ModelAndView mv = new ModelAndView("/business/personnel/leave/editLeave");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        String personName = leaveService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = leaveService.getDeptNameById(CommonUtil.getDefaultDept());
        Leave leave=new Leave();
        leave.setRequester(personName);
        leave.setRequestDate(datetime);
        leave.setStartTime(date);
        leave.setRequestDept(deptName);
        mv.addObject("head", "请假申请新增");
        mv.addObject("leave", leave);
        return mv;
    }
    /**
     * 请假申请修改
     * update by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/leave/getLeaveById")
    public ModelAndView getLeaveById(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/leave/editLeave");
        mv.addObject("head", "请假申请修改");
        Leave leave = leaveService.getLeaveById(id);
        mv.addObject("leave", leave);
        return mv;
    }
    /**
     * 保存请假申请
     * save by hanyue
     * modify by hanyue
     * @param leave
     * @return
     */
    @ResponseBody
    @RequestMapping("/leave/saveLeave")
    public Message saveLeave(Leave leave){
        if(leave.getId()==null || leave.getId().equals("")){
            leave.setCreator(CommonUtil.getPersonId());
            leave.setCreateDept(CommonUtil.getDefaultDept());
            leave.setRequester(CommonUtil.getPersonId());
            leave.setRequestDept(CommonUtil.getDefaultDept());
            leave.setId(CommonUtil.getUUID());
            leaveService.insertLeave(leave);
            return new Message(1, "新增成功！", null);
        }else{
            leave.setChanger(CommonUtil.getPersonId());
            leave.setChangeDept(CommonUtil.getDefaultDept());
            leaveService.updateLeaveById(leave);
            return new Message(1, "修改成功！", null);
        }
    }
    /**
     * 删除请假申请
     * delete by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/leave/deleteLeaveById")
    public Message deleteLeaveById(String id) {
        leaveService.deleteLeaveById(id);
        return new Message(1, "删除成功！", null);
    }
    /**
     * 部门自动提示框
     * dept by hanyue
     * modify by hanyue
     * @return
     */
    @ResponseBody
    @RequestMapping("/leave/autoCompleteDept")
    public List<AutoComplete> autoCompleteDept() {
        return leaveService.autoCompleteDept();
    }
    /**
     * 人员自动提示框
     * person by hanyue
     * modify by hanyue
     * @return
     */
    @ResponseBody
    @RequestMapping("/leave/autoCompleteEmployee")
    public List<AutoComplete> autoCompleteEmployee() {
        return leaveService.autoCompleteEmployee();
    }
    /**
     * 代办业务跳转
     * agency business by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/leave/process")
    public ModelAndView leaveProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/leave/leaveProcess");
        return mv;
    }
    /**
     * 代办业务初始化
     * agency business initialize by hanyue
     * modify by hanyue
     * @param leave
     * @return
     */
    @ResponseBody
    @RequestMapping("/leave/getProcessList")
    public Map<String, List<Leave>> getProcessList(Leave leave) {
        Map<String, List<Leave>> leaveMap = new HashMap<String, List<Leave>>();
        leave.setCreator(CommonUtil.getPersonId());
        leave.setCreateDept(CommonUtil.getDefaultDept());
        leave.setChanger(CommonUtil.getPersonId());
        leave.setChangeDept(CommonUtil.getDefaultDept());
        leaveMap.put("data", leaveService.getProcessList(leave));
        return leaveMap;
    }
    @ResponseBody
    @RequestMapping("/leave/getLeaveCancelList")
    public Map<String, List<Leave>> getLeaveCancelList(Leave leave) {
        Map<String, List<Leave>> leaveMap = new HashMap<String, List<Leave>>();
        leave.setCreator(CommonUtil.getPersonId());
        leave.setCreateDept(CommonUtil.getDefaultDept());
        leave.setChanger(CommonUtil.getPersonId());
        leave.setChangeDept(CommonUtil.getDefaultDept());
        leaveMap.put("data", leaveService.getLeaveCancelList(leave));
        return leaveMap;
    }

    /**
     * 已办业务跳转
     * already done business by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/leave/complete")
    public ModelAndView leaveComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/leave/leaveComplete");
        return mv;
    }
    /**
     * 已办页面初始化
     * already done business initialize by hanyue
     * modify by hanyue
     * @param leave
     * @return
     */
    @ResponseBody
    @RequestMapping("/leave/getCompleteList")
    public Map<String, List<Leave>> getCompleteList(Leave leave) {
        Map<String, List<Leave>> leaveMap = new HashMap<String, List<Leave>>();
        leave.setCreator(CommonUtil.getPersonId());
        leave.setCreateDept(CommonUtil.getDefaultDept());
        leave.setChanger(CommonUtil.getPersonId());
        leave.setChangeDept(CommonUtil.getDefaultDept());
        leaveMap.put("data", leaveService.getCompleteList(leave));
        return leaveMap;
    }

    /**
     * 待办修改
     * agency update by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/leave/auditLeaveEdit")
    public ModelAndView auditLeaveEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/leave/editLeaveProcess");
        Leave leave = leaveService.getLeaveById(id);
        mv.addObject("head", "修改");
        mv.addObject("leave", leave);
        return mv;
    }
    /**
     * 查看流程轨迹
     * process trajectory by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/leave/auditLeaveById")
    public ModelAndView waitRolById(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/leave/addLeaveProcess");
        Leave leave = leaveService.getLeaveBy(id);
        mv.addObject("head", "审批");
        mv.addObject("leave", leave);
        return mv;
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/leave/printLeaves")
    public ModelAndView printLeaves(String id) {
        ModelAndView mv = new ModelAndView("/business/personnel/leave/printLeaves");
        String workflowName=workflowService.getWorkflowNameByWorkflowCode("T_RS_LEAVE_WF01");
        Leave leave = leaveService.getLeaveBy(id);
        String requestDate = leave.getRequestDate().replace("T"," ");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("requestDate", requestDate);
        mv.addObject("leave", leave);
        mv.addObject("workflowName",workflowName);
        return mv;
    }


}
