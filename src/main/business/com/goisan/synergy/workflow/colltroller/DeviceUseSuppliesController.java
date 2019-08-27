package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.service.DeviceUseSuppliesService;
import com.goisan.system.bean.UserDic;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/5/17.
 */
@Controller
public class DeviceUseSuppliesController {
    /*
    显示耗材的JSP
     */
    @Resource
    private DeviceUseSuppliesService deviceUseSuppliesService;
    @RequestMapping("/deviceUsesupplies")
    public ModelAndView deviceUseSuppliesList(){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/synergy/workflow/deviceUse/deviceUseSupplies");
        return mv;
    }
    /*
    显示JSP中列表部分的数据
     */
    @ResponseBody
    @RequestMapping("/deviceUse/getDeviceUseSuppliesList")
    public Map<String,List<UserDic>> getDeviceUseSuppliesList() {
        Map<String, List<UserDic>> deviceUseSupplies = new HashMap<String, List<UserDic>>();
        //todo
        deviceUseSupplies.put("data",deviceUseSuppliesService.deviceUseSuppliesAction(new UserDic()));
        return deviceUseSupplies;
    }
    /*
    耗材新增页
     */
    @RequestMapping("/deviceUse/addDeviceUseSupplies")
    public ModelAndView addDeviceUseSupplies() {
        ModelAndView mv = new ModelAndView("business/synergy/workflow/deviceUse/addDeviceUseSupplies");
        mv.addObject("head", "设备新增");
        return mv;
    }
    /*
    新增保存
     */
    @ResponseBody
    @RequestMapping("/deviceUse/insertDeviceUseSupplies")
    public Message insertDeviceUseSupplies(UserDic userDic){
        Date date = new Date(new java.util.Date().getTime());
        userDic.setCreator(CommonUtil.getPersonId());
        userDic.setCreateDept(CommonUtil.getDefaultDept());
        userDic.setCreateTime(CommonUtil.getDate());
        userDic.setId(CommonUtil.getUUID());
        deviceUseSuppliesService.insertDeviceUseSupplies(userDic);
        return new Message(1, "新增成功！", null);
    }

    @ResponseBody
    @RequestMapping("/deviceUse/saveDeviceUseSupplies")
    public Message saveDeviceUseSupplies(UserDic userDic){
        Date date = new Date(new java.util.Date().getTime());
        userDic.setCreateTime(CommonUtil.getDate());
        if(userDic.getId()==null || userDic.getId().equals("")){
            userDic.setCreator(CommonUtil.getPersonId());
            userDic.setCreateDept(CommonUtil.getDefaultDept());
            userDic.setId(CommonUtil.getUUID());
            deviceUseSuppliesService.insertDeviceUseSupplies(userDic);
            return new Message(1, "新增成功！", null);
        }else{
            userDic.setChanger(CommonUtil.getPersonId());
            userDic.setChangeDept(CommonUtil.getDefaultDept());
            deviceUseSuppliesService.updateDeviceUseSupplies(userDic);
            return new Message(1, "修改成功！", null);
        }
    }
    /*
   修改页面
    */
    @ResponseBody
    @RequestMapping("/deviceUse/getDeviceUseSuppliesById")
    public ModelAndView getDeviceUseSuppliesById(String id) {
        ModelAndView mv = new ModelAndView("business/synergy/workflow/deviceUse/editDeviceUseSupplies");
        UserDic userDic = deviceUseSuppliesService.getDeviceUseSuppliesById(id);
        mv.addObject("head", "设备修改");
        mv.addObject("deviceUseSupplies", userDic);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/deviceUse/updateDeviceUseSupplies")
    public Message updateDeviceUseSupplies(UserDic userDic) {
        Date date = new Date(new java.util.Date().getTime());
        userDic.setChanger(CommonUtil.getPersonId());
        userDic.setChangeDept(CommonUtil.getDefaultDept());
        userDic.setChangeTime(CommonUtil.getDate());
        deviceUseSuppliesService.updateDeviceUseSupplies(userDic);
        return new Message(1, "修改成功！", null);
    }

    @ResponseBody
    @RequestMapping("/deviceUse/deleteDeviceUseSuppliesById")
    public Message deleteDeptById(String id) {
        deviceUseSuppliesService.deleteDeviceUseSuppliesById(id);
        //菜单,按钮权限删除
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/deviceUseSupplies/searchDeviceUseSupplies")
    public Map<String, List<UserDic>> searchDeviceUseSupplies(UserDic userDic) {
        Map<String, List<UserDic>> softMap = new HashMap<String, List<UserDic>>();
        userDic.setCreator(CommonUtil.getPersonId());
        softMap.put("data", deviceUseSuppliesService.getCompleteDeviceUseSuppliesList(userDic));
        return softMap;
    }
    /**
     * 字段查重
     */
    @ResponseBody
    @RequestMapping("/deviceUseSupplies/checkName")
    public Message checkName(UserDic userDic){
        List size = deviceUseSuppliesService.checkName(userDic);
        if(size.size()>0){
            return new Message(1, "设备名称重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    @ResponseBody
    @RequestMapping("/deviceUseSupplies/checkCode")
    public Message checkCode(UserDic userDic){
        List size = deviceUseSuppliesService.checkCode(userDic);
        if(size.size()>0){
            return new Message(2, "设备编号重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    @ResponseBody
    @RequestMapping("/deviceUseSupplies/checkOrder")
    public Message checkOrder(UserDic userDic){
        List size = deviceUseSuppliesService.checkOrder(userDic);
        if(size.size()>0){
            return new Message(3, "设备排序重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
}

