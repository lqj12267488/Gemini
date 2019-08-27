package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.DeviceBorrow;
import com.goisan.synergy.workflow.service.DeviceBorrowService;
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
public class DeviceBorrowController {


    @Resource
    private DeviceBorrowService deviceBorrowService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;

    /**
     * 设备借用申请跳转
     * request by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/deviceBorrow/request")
    public ModelAndView deviceBorrowList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/deviceBorrow/deviceBorrow");
        return mv;
    }

    /**
     * 设备借用URL
     * url by hanyue
     * modify by hanyue
     *
     * @param deviceBorrow
     * @return
     */
    @ResponseBody
    @RequestMapping("/deviceBorrow/getDeviceBorrowList")
    public Map<String, List<DeviceBorrow>> getDeviceBorrowList(DeviceBorrow deviceBorrow) {
        Map<String, List<DeviceBorrow>> deviceBorrowMap = new HashMap<String, List<DeviceBorrow>>();
        deviceBorrow.setCreator(CommonUtil.getPersonId());
        deviceBorrow.setCreateDept(CommonUtil.getDefaultDept());
        deviceBorrowMap.put("data", deviceBorrowService.getDeviceBorrowList(deviceBorrow));
        return deviceBorrowMap;
    }

    /**
     * 设备借用新增
     * add by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/deviceBorrow/editDeviceBorrow")
    public ModelAndView addDeviceBorrow() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/deviceBorrow/editDeviceBorrow");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date + 'T' + time;
        String personName = deviceBorrowService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = deviceBorrowService.getDeptNameById(CommonUtil.getDefaultDept());
        DeviceBorrow deviceBorrow = new DeviceBorrow();
        deviceBorrow.setRequester(personName);
        deviceBorrow.setRequestDate(datetime);
        deviceBorrow.setBorrowTime(datetime);
        deviceBorrow.setRevertTime(datetime);
        deviceBorrow.setRequestDept(deptName);
        mv.addObject("head", "设备借用新增");
        mv.addObject("deviceBorrow", deviceBorrow);
        return mv;
    }

    /**
     * 设备借用修改
     * update by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/deviceBorrow/getDeviceBorrowById")
    public ModelAndView getDeviceBorrowById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/deviceBorrow/editDeviceBorrow");
        DeviceBorrow deviceBorrow = deviceBorrowService.getDeviceBorrowById(id);
        mv.addObject("head", "设备借用修改");
        mv.addObject("deviceBorrow", deviceBorrow);
        return mv;
    }

    /**
     * 保存设备借用
     * save by hanyue
     * modify by hanyue
     *
     * @param deviceBorrow
     * @return
     */
    @ResponseBody
    @RequestMapping("/deviceBorrow/saveDeviceBorrow")
    public Message saveDeviceBorrow(DeviceBorrow deviceBorrow) {
        if (deviceBorrow.getId() == null || deviceBorrow.getId().equals("")) {
            deviceBorrow.setCreator(CommonUtil.getPersonId());
            deviceBorrow.setCreateDept(CommonUtil.getDefaultDept());
            deviceBorrow.setRequester(CommonUtil.getPersonId());
            deviceBorrow.setRequestDept(CommonUtil.getDefaultDept());
            deviceBorrow.setId(CommonUtil.getUUID());
            deviceBorrowService.insertDeviceBorrow(deviceBorrow);
            return new Message(1, "新增成功！", null);
        } else {
            deviceBorrow.setRequester(CommonUtil.getPersonId());
            deviceBorrow.setRequestDept(CommonUtil.getDefaultDept());
            deviceBorrow.setChanger(CommonUtil.getPersonId());
            deviceBorrow.setChangeDept(CommonUtil.getDefaultDept());
            deviceBorrowService.updateDeviceBorrowById(deviceBorrow);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 删除设备借用
     * delete by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/deviceBorrow/deleteDeviceBorrowById")
    public Message deleteDeviceBorrowById(String id) {
        deviceBorrowService.deleteDeviceBorrowById(id);
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
    @RequestMapping("/deviceBorrow/autoCompleteDept")
    public List<AutoComplete> autoCompleteDept() {
        return deviceBorrowService.autoCompleteDept();
    }

    /**
     * 人员自动提示框
     * person by hanyue
     * modify by hanyue
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/deviceBorrow/autoCompleteEmployee")
    public List<AutoComplete> autoCompleteEmployee() {
        return deviceBorrowService.autoCompleteEmployee();
    }

    /**
     * 代办业务跳转
     * agency business by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/deviceBorrow/process")
    public ModelAndView deviceBorrowProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/deviceBorrow/deviceBorrowProcess");
        return mv;
    }

    /**
     * 代办业务初始化
     * agency business initialize by hanyue
     * modify by hanyue
     *
     * @param deviceBorrow
     * @return
     */
    @ResponseBody
    @RequestMapping("/deviceBorrow/getProcessList")
    public Map<String, List<DeviceBorrow>> getProcessList(DeviceBorrow deviceBorrow) {
        Map<String, List<DeviceBorrow>> deviceBorrowMap = new HashMap<String, List<DeviceBorrow>>();
        deviceBorrow.setCreator(CommonUtil.getPersonId());
        deviceBorrow.setCreateDept(CommonUtil.getDefaultDept());
        deviceBorrow.setChanger(CommonUtil.getPersonId());
        deviceBorrow.setChangeDept(CommonUtil.getDefaultDept());
        deviceBorrowMap.put("data", deviceBorrowService.getProcessList(deviceBorrow));
        return deviceBorrowMap;
    }

    /**
     * 已办业务跳转
     * already done business by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/deviceBorrow/complete")
    public ModelAndView deviceBorrowComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/deviceBorrow/deviceBorrowComplete");
        return mv;
    }

    /**
     * 已办页面初始化
     * already done business initialize by hanyue
     * modify by hanyue
     *
     * @param deviceBorrow
     * @return
     */
    @ResponseBody
    @RequestMapping("/deviceBorrow/getCompleteList")
    public Map<String, List<DeviceBorrow>> getCompleteList(DeviceBorrow deviceBorrow) {
        Map<String, List<DeviceBorrow>> deviceBorrowMap = new HashMap<String, List<DeviceBorrow>>();
        deviceBorrow.setCreator(CommonUtil.getPersonId());
        deviceBorrow.setCreateDept(CommonUtil.getDefaultDept());
        deviceBorrow.setChanger(CommonUtil.getPersonId());
        deviceBorrow.setChangeDept(CommonUtil.getDefaultDept());
        deviceBorrowMap.put("data", deviceBorrowService.getCompleteList(deviceBorrow));
        return deviceBorrowMap;
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
    @RequestMapping("/deviceBorrow/auditDeviceBorrowEdit")
    public ModelAndView auditDeviceBorrowEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/deviceBorrow/editDeviceBorrowProcess");
        DeviceBorrow deviceBorrow = deviceBorrowService.getDeviceBorrowById(id);
        mv.addObject("head", "修改");
        mv.addObject("deviceBorrow", deviceBorrow);
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
    @RequestMapping("/deviceBorrow/auditDeviceBorrowById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/deviceBorrow/addDeviceBorrowProcess");
        DeviceBorrow deviceBorrow = deviceBorrowService.getDeviceBorrowById(id);
        mv.addObject("head", "审批");
        mv.addObject("deviceBorrow", deviceBorrow);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/deviceBorrow/printDeviceBorrow")
    public ModelAndView printDeviceBorrow(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/deviceBorrow/printDeviceBorrow");
        DeviceBorrow deviceBorrow = deviceBorrowService.getDeviceBorrowById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_DEVICEBORROW_WF01");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        String requestDate = deviceBorrow.getRequestDate().replace("T", " ");
        String revertTime = deviceBorrow.getRevertTime().replace("T", " ");
        String borrowTime = deviceBorrow.getBorrowTime().replace("T", " ");
        mv.addObject("requestDate", requestDate);
        mv.addObject("revertTime", revertTime);
        mv.addObject("borrowTime", borrowTime);
        mv.addObject("deviceBorrow", deviceBorrow);
        mv.addObject("workflowName", workflowName);
        return mv;
    }

}


