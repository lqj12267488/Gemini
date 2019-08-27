package com.goisan.logistics.repair.controller;

import com.goisan.logistics.repair.service.RepairTypeService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.UserDic;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**报修类型管理
 * Created by wq on 2017/5/26.
 */

/*@CostController
public class RepairTypeController {
    @Resource
    private RepairTypeService repairTypeService;
    */
/*跳转到报修类型管理JSP*//*

    @RequestMapping("/repairType/repairTypeList")
    public ModelAndView repairTypeList(){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("core/userDic/addUserDic");
        return mv;
    }
    */
/*管理页面列表初始化*//*

    @ResponseBody
    @RequestMapping("/repairType/repairTypeAction")
    public Map<String,List<UserDic>> repairTypeAction() {
        Map<String, List<UserDic>> repairType = new HashMap<String, List<UserDic>>();
        repairType.put("data",repairTypeService.repairTypeAction(new UserDic()));
        return repairType;
    }
    */
/*新增界面跳转*//*

    @RequestMapping("/repairType/addRepairType")
    public ModelAndView addRepairType() {
        ModelAndView mv = new ModelAndView("business/logistics/repair/editRepairType");
        mv.addObject("head", "耗材新增");
        return mv;
    }
    */
/*修改界面跳转*//*

    @ResponseBody
    @RequestMapping("/repairType/editRepairType")
    public ModelAndView getRepairTypeById(String id) {
        ModelAndView mv = new ModelAndView("business/logistics/repair/editRepairType");
        UserDic userDic = repairTypeService.getRepairTypeById(id);
        mv.addObject("head", "耗材修改");
        mv.addObject("repairType", userDic);
        return mv;
    }

    /*删除行*/

/*新增和修改保存*//*

    @ResponseBody
    @RequestMapping("/repairType/saveRepairType")
    public Message saveRepairType(UserDic userDic){
        Date date = new Date(new java.util.Date().getTime());
        userDic.setCreateTime(CommonUtil.getDate());
        if(userDic.getId()==null || userDic.getId().equals("")){
            userDic.setCreator(CommonUtil.getLoginUser().getUserAccount());
            userDic.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            userDic.setId(CommonUtil.getUUID());
            repairTypeService.insertRepairType(userDic);
            return new Message(1, "新增成功！", null);
        }else{
            userDic.setChanger(CommonUtil.getLoginUser().getUserAccount());
            userDic.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            repairTypeService.updateRepairType(userDic);
            return new Message(1, "修改成功！", null);
        }
    }
    */
/*删除行*//*

    @ResponseBody
    @RequestMapping("/repairType/deleteRepairTypeById")
    public Message deleteDeptById(String id) {
        repairTypeService.deleteRepairTypeById(id);
        return new Message(1, "删除成功！", null);
    }
    */
/*查询id*//*

    @ResponseBody
    @RequestMapping("/repairType/getRepairTypeById")
    public ModelAndView getAssetsById(String id) {
        ModelAndView mv = new ModelAndView("business/logistics/repair/editRepairType");
        UserDic userDic = repairTypeService.getRepairTypeById(id);
        mv.addObject("head", "申请修改");
        mv.addObject("repairType", userDic);
        return mv;
    }
    */
/*查询报修类型数据表*//*

    @ResponseBody
    @RequestMapping("/repairType/getRepairTypeList")
    public Map<String, List<UserDic>> getRepairTypeList(UserDic userDic) {
        Map<String, List<UserDic>> softMap = new HashMap<String, List<UserDic>>();
        userDic.setCreator(CommonUtil.getPersonId());
        softMap.put("data", repairTypeService.getRepairTypeList(userDic));
        return softMap;
    }
    */
/*字段查重*//*

    @ResponseBody
    @RequestMapping("/repairType/checkName")
    public Message checkName(UserDic userDic){
        List size = repairTypeService.checkName(userDic);
        if(size.size()>0){
            return new Message(1, "耗材名称重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    @ResponseBody
    @RequestMapping("/repairType/checkCode")
    public Message checkCode(UserDic userDic){
        List size = repairTypeService.checkCode(userDic);
        if(size.size()>0){
            return new Message(2, "耗材编号重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    @ResponseBody
    @RequestMapping("/repairType/checkOrder")
    public Message checkOrder(UserDic userDic){
        List size = repairTypeService.checkOrder(userDic);
        if(size.size()>0){
            return new Message(3, "耗材排序重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    //取出未使用的序号
    @ResponseBody
    @RequestMapping("/repairType/getRepairTypeNoOrder")
    public List<String> getRepairTypeList() {
        List<String> list = repairTypeService.getRepairTypeNoOrder();
        List<String> ulist=new ArrayList<String>();
        boolean flag=true;
        for (int i = 1; i <100; i++) {
            for (String s:list) {
                if (i==Integer.parseInt(s)){
                    flag=false;
                    break;
                }
            }
            if(flag){
                ulist.add(""+i);
            }
        }
        return ulist;
    }
}
*/
