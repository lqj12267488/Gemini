package com.goisan.system.controller;

import com.goisan.system.bean.UserDic;
import com.goisan.system.service.UserDicService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/5/25.
 */
@Controller
public class UserDicController {
    @Resource
    private UserDicService userDicService;
    String dt="";
    /*选择菜单路径*/
    /*{dictype} 获取dictype数据*/
    @RequestMapping("/userDic/{dictype}")
    public ModelAndView selectURL(@PathVariable("dictype") String dictype){
        dt=dictype;
        String dicurl = userDicService.selectDicType(dictype);
        ModelAndView mv = new ModelAndView(dicurl);
        return mv;
    }
    /*
    显示字典列表中的数据
    */
    @ResponseBody
    @RequestMapping("/userDic/getUserDicList")
    public Map<String,List<UserDic>> getUserDicList() {
        Map<String, List<UserDic>> userSupplies = new HashMap<String, List<UserDic>>();
        userSupplies.put("data",userDicService.userDicAction(dt));
        return userSupplies;
    }
    /*
    新增页
     */
    @RequestMapping("/userDic/addUserDicSupplies")
    public ModelAndView addUserDicSupplies(String urlName) {
        ModelAndView mv = new ModelAndView(urlName);
        mv.addObject("head", "新增数据");
        return mv;
    }
    /*新增与修改保存方法*/
    @ResponseBody
    @RequestMapping("/userDic/saveUserDicSupplies")
    public Message saveUserDicSupplies(UserDic userDic){
        Date date = new Date(new java.util.Date().getTime());
        userDic.setCreateTime(CommonUtil.getDate());
        if(userDic.getId()==null || "".equals(userDic.getId())){
            userDic.setCreator(CommonUtil.getPersonId());
            userDic.setCreateDept(CommonUtil.getDefaultDept());
            userDic.setId(CommonUtil.getUUID());
            String name=userDicService.selectName(dt);
            userDic.setDictype(dt);
            userDic.setName(name);
            userDicService.insertUserDic(userDic);
            return new Message(1, "新增成功！", null);
        }else{
            userDic.setChanger(CommonUtil.getPersonId());
            userDic.setChangeDept(CommonUtil.getDefaultDept());
            userDicService.updateUserDicSupplies(userDic);
            return new Message(1, "修改成功！", null);
        }
    }
    /*
   修改页面
    */
    @ResponseBody
    @RequestMapping("/userDic/editUserDic")
    public ModelAndView getEditUserDic(String id,String editUrl) {
        ModelAndView mv = new ModelAndView(editUrl);
        UserDic userDic = userDicService.getUserDicById(id,dt);
        mv.addObject("head", "修改");
        mv.addObject("userDic", userDic);
        return mv;
    }


    /*删除方法*/
    @ResponseBody
    @RequestMapping("/userDic/deleteUserDicById")
    public Message deleteDeptById(String id) {
        userDicService.deleteUserDicById(id);
        //菜单,按钮权限删除
        return new Message(1, "删除成功！", null);
    }
    /*查询列方法*/
    @ResponseBody
    @RequestMapping("/userDic/searchUserDic")
    public Map<String, List<UserDic>> searchUserDic(UserDic userDic) {
        Map<String, List<UserDic>> softMap = new HashMap<String, List<UserDic>>();
        userDic.setCreator(CommonUtil.getPersonId());
        userDic.setDictype(dt);
        softMap.put("data", userDicService.getUserDicComplete(userDic));
        return softMap;
    }
    /**
     * 字段查重
     */
    @ResponseBody
    @RequestMapping("/userDic/checkName")
    public Message checkName(UserDic userDic){
        userDic.setDictype(dt);
        List size = userDicService.checkName(userDic);
        if(size.size()>0){
            return new Message(1, "名称重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    @ResponseBody
    @RequestMapping("/userDic/checkCode")
    public Message checkCode(UserDic userDic){
        userDic.setDictype(dt);
        List size = userDicService.checkCode(userDic);
        if(size.size()>0){
            return new Message(2, "编号重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    /*重复性校验*/
    @ResponseBody
    @RequestMapping("/userDic/checkOrder")
    public Message checkOrder(UserDic userDic){
        userDic.setDictype(dt);
        List size = userDicService.checkOrder(userDic);
        if(size.size()>0){
            return new Message(3, "排序重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
}