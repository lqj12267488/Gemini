package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.DeviceUse;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.service.FilesService;
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
 * Created by Administrator on 2017/5/6/006.
 */
@Controller
public class DeviceUseController {
    @Resource
    private com.goisan.synergy.workflow.service.DeviceUseService DeviceUseService;
    @Resource
    private FilesService filesService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;

    /*
    RequestMapping 是数据库中的resource_url字段的数据
    mv.setViewName 是存放jsp路径的。
     */
    //设备调用申请跳转
    @RequestMapping("/deviceUse/request")
    public ModelAndView deviceUseList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/deviceuse/deviceUse");
        return mv;
    }

    /**
     * 设备调用申请首页
     */
    @ResponseBody
    @RequestMapping("/deviceUse/getDeviceUseList")
    public Map<String, List<DeviceUse>> getDeviceUseList(DeviceUse deviceUse) {
        Map<String, List<DeviceUse>> deviceUseMap = new HashMap<String, List<DeviceUse>>();
        deviceUse.setCreator(CommonUtil.getPersonId());
        deviceUse.setCreateDept(CommonUtil.getDefaultDept());
        deviceUseMap.put("data", DeviceUseService.deviceUseAction(deviceUse));
        return deviceUseMap;
    }
    /*
     *设备调用新增页
     */
    @RequestMapping("/deviceUse/editDeviceUse")
    public ModelAndView addDeviceUse() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/deviceuse/editDeviceUse");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        DeviceUse deviceUse=new DeviceUse();
        deviceUse.setRequestDate(datetime);
        String personName = DeviceUseService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = DeviceUseService.getDeptNameById(CommonUtil.getDefaultDept());
       deviceUse.setRequester(personName);
       deviceUse.setRequestDept(deptName);
        mv.addObject("head", "新增申请");
        mv.addObject("deviceUse",deviceUse);
        return mv;
    }
    /*
     *新增页面
     */
    @ResponseBody
    @RequestMapping("/deviceUse/insertDeviceUse")
    public Message insertDeviceUse(DeviceUse DeviceUse){
        DeviceUse.setCreator(CommonUtil.getPersonId());
        DeviceUse.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        DeviceUse.setCreateTime(CommonUtil.getDate());
        DeviceUse.setId(CommonUtil.getUUID());
        DeviceUseService.insertDeviceUse(DeviceUse);
        return new Message(1, "新增成功！", null);
    }

    /**
     * 新增以及修改保存方法
     */
    @ResponseBody
    @RequestMapping("/deviceUse/saveDeviceUse")
    public Message saveDeviceUse(DeviceUse deviceUse){
        /*Date date = new Date(new java.util.Date().getTime());*/
        deviceUse.setCreateTime(CommonUtil.getDate());
        if(deviceUse.getId()==null || deviceUse.getId().equals("")){
            deviceUse.setCreator(CommonUtil.getPersonId());
            deviceUse.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            deviceUse.setId(CommonUtil.getUUID());
            deviceUse.setManager(CommonUtil.getPersonId());
            deviceUse.setRequestDept(CommonUtil.getDefaultDept());
            DeviceUseService.insertDeviceUse(deviceUse);
            return new Message(1, "新增成功！", null);
        }else{
            deviceUse.setManager(CommonUtil.getPersonId());
            deviceUse.setRequestDept(CommonUtil.getDefaultDept());
            deviceUse.setChanger(CommonUtil.getPersonId());
            deviceUse.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            DeviceUseService.updateDeviceUse(deviceUse);
            return new Message(1, "修改成功！", null);
        }
    }
    /*
     *修改页面
     */
    @ResponseBody
    @RequestMapping("/deviceUse/getDeviceUseById")
    public ModelAndView getDeviceUseById(String id) {
        ModelAndView mv = new ModelAndView("business/synergy/workflow/deviceuse/editDeviceUse");
        DeviceUse deviceUse = DeviceUseService.getDeviceUseById(id);
        mv.addObject("head", "设备调用修改");
        mv.addObject("deviceUse", deviceUse);
        return mv;
    }

    /**
     * 删除方法
     */
    @ResponseBody
    @RequestMapping("/deviceUse/deleteDeviceUseById")
    public Message deleteRoleById(String id) {
        DeviceUseService.deleteDeviceUseById(id);
        filesService.delFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }
    /*
     *获取部门自动完成框
     */
    @ResponseBody
    @RequestMapping("/deviceUse/getDept")
    public List<AutoComplete> getDept() {
        return DeviceUseService.selectDept();
    }
    /*
     *获取人员自动完成框
     */
    @ResponseBody
    @RequestMapping("/deviceUse/getPerson")
    public List<AutoComplete> getPerson() {
        return DeviceUseService.selectPerson();
    }

    //待办业务跳转
    @RequestMapping("/deviceUse/process")
    public ModelAndView deviceUseListProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/deviceuse/deviceUseProcess");
        return mv;
    }
    /**
     * 设备调用待办页
     */
    @ResponseBody
    @RequestMapping("/deviceUse/getDeviceUseListProcess")
    public Map<String, List<DeviceUse>> getDeviceUseListProcess(DeviceUse deviceUse) {
        Map<String, List<DeviceUse>> deviceUseMap = new HashMap<String, List<DeviceUse>>();
        if ("%%".equals(deviceUse.getRequestDept())){
            deviceUse.setRequestDept(null);
        }
        if ("%%".equals(deviceUse.getRequester())){
            deviceUse.setRequester(null);
        }
        deviceUse.setCreator(CommonUtil.getPersonId());
        deviceUse.setCreateDept(CommonUtil.getDefaultDept());
        deviceUse.setChanger(CommonUtil.getPersonId());
        deviceUse.setChangeDept(CommonUtil.getDefaultDept());
        deviceUseMap.put("data", DeviceUseService.getDeviceUseListProcess(deviceUse));
        return deviceUseMap;
    }
    //已办业务跳转
    @RequestMapping("/deviceUse/complete")
    public ModelAndView deviceUseListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/deviceuse/deviceUseComplete");
        return mv;
    }
    /**
     * 设备调用已办页
     */
    @ResponseBody
    @RequestMapping("/deviceUse/getDeviceUseListComplete")
    public Map<String, List<DeviceUse>> getDeviceUseListComplete(DeviceUse deviceUse) {
        Map<String, List<DeviceUse>> deviceUseMap = new HashMap<String, List<DeviceUse>>();
        deviceUse.setCreator(CommonUtil.getPersonId());
        deviceUse.setCreateDept(CommonUtil.getDefaultDept());
        deviceUse.setChanger(CommonUtil.getPersonId());
        deviceUse.setChangeDept(CommonUtil.getDefaultDept());
        deviceUseMap.put("data", DeviceUseService.getDeviceUseListComplete(deviceUse));
        return deviceUseMap;
    }
    //待办修改
    @ResponseBody
    @RequestMapping("/deviceUse/auditDeviceUseEdit")
    public ModelAndView auditDeviceUseEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/deviceuse/editDeviceUseProcess");
        DeviceUse deviceUse = DeviceUseService.getDeviceUseById(id);
        mv.addObject("head", "修改");
        mv.addObject("deviceUse", deviceUse);
        return mv;
    }
    //查看流程轨迹
    @ResponseBody
    @RequestMapping("/deviceUse/auditDeviceUseById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/deviceuse/addDeviceUseProcess");
        DeviceUse deviceUse = DeviceUseService.getDeviceUseById(id);
        mv.addObject("head", "审批");
        mv.addObject("deviceUse", deviceUse);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/deviceUse/printDeviceUse")
    public ModelAndView printDeviceUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/deviceuse/printDeviceUse");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        DeviceUse deviceUse = DeviceUseService.getDeviceUseById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_DEVICEUSE_WF01");
        String requestDate = deviceUse.getRequestDate().replace("T", " ");
        mv.addObject("requestDate", requestDate);
        mv.addObject("deviceUse", deviceUse);
        mv.addObject("workflowName", workflowName);
        return mv;
    }
}
