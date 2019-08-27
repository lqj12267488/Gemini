package com.goisan.system.controller;

import com.goisan.system.bean.UserDic;
import com.goisan.system.service.DicMappingService;
import com.goisan.system.service.UserDicService;
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
 * Created by Administrator on 2017/7/12.
 */
@Controller
public class DicMappingController {
    @Resource
    private DicMappingService dicMappingService;
    @Resource
    private UserDicService userDicService;
    @RequestMapping("/userDic/dicMapping")
    public ModelAndView dicMappingList(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("/business/synergy/workflow/dicMapping/dicMapping");
        return modelAndView;
    }
    @ResponseBody
    @RequestMapping("/dicMapping/getDicMappingList")
    public Map<String,List<UserDic>> getDicMappingList(){
        Map<String, List<UserDic>> dicMap = new HashMap<String, List<UserDic>>();
        UserDic userDic=new UserDic();
        dicMap.put("data",dicMappingService.dicMappingAction(userDic));
        return dicMap;
    }

    @ResponseBody
    @RequestMapping("/dicMapping/addDicMapping")
    public ModelAndView addDicMapping(){
        ModelAndView mv = new ModelAndView("business/synergy/workflow/dicMapping/addDicMapping");
        return mv;
    }

    /*
  修改页面
   */
    @ResponseBody
    @RequestMapping("/dicMapping/editDicMapping")
    public ModelAndView getEditDicMapping(String id) {
        UserDic userDic=dicMappingService.getDicMappingID(id);
        ModelAndView mv = new ModelAndView("business/synergy/workflow/dicMapping/addDicMapping");
        mv.addObject("head", "耗材修改");
        mv.addObject("userDic", userDic);
        return mv;
    }

    /*新增与修改保存方法*/
    @ResponseBody
    @RequestMapping("/dicMapping/saveDicMapping")
    public Message saveUserDicSupplies(UserDic userDic){
        if(userDic.getId()==null || "".equals(userDic.getId())){
            userDic.setCreator(CommonUtil.getPersonId());
            userDic.setCreateDept(CommonUtil.getDefaultDept());
            userDic.setId(CommonUtil.getUUID());
            dicMappingService.insertDicMapping(userDic);
            return new Message(1, "新增成功！", null);
        }else{
            userDic.setChanger(CommonUtil.getPersonId());
            userDic.setChangeDept(CommonUtil.getDefaultDept());
            dicMappingService.updateDicMapping(userDic);
            return new Message(1, "修改成功！", null);
        }
    }

     /*删除方法*/
    @ResponseBody
    @RequestMapping("/dicMapping/deleteDicMapping")
    public Message deleteDeptById(String id) {
        dicMappingService.deleteDicMapping(id);
        //菜单,按钮权限删除
        return new Message(1, "删除成功！", null);
    }
    /*查询列 方法*/
    @ResponseBody
    @RequestMapping("/dicMapping/searchDicMapping")
    public Map<String, List<UserDic>> searchComputer(UserDic userDic) {
        Map<String, List<UserDic>> softMap = new HashMap<String, List<UserDic>>();
        softMap.put("data", dicMappingService.dicMappingSearch(userDic));
        return softMap;
    }
    /*
    详情 方法
    */
    @ResponseBody
    @RequestMapping("/dicMapping/detailDicMapping")
    public ModelAndView detailDicMapping(UserDic userDic) {
        /*UserDic userDic=new UserDic();
        userDic.setDictype(dictype);
        userDic.setName(dicname);*/
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/dicMapping/getDicMapping");
        mv.addObject("userDic", userDic);
       /* mv.addObject("name",dicname);*/
        return mv;
    }
    /*数据查询*/
    @ResponseBody
    @RequestMapping("/dicMapping/infoDicMapping")
    public Map<String, List<UserDic>> infoDicMapping(UserDic userDic) {
        Map<String, List<UserDic>> softMap = new HashMap<String, List<UserDic>>();
        softMap.put("data",dicMappingService.getDicMapping(userDic));
        return softMap;
    }

     /*字段查重*/
    @ResponseBody
    @RequestMapping("/dicMapping/checkName")
    public Message checkName(UserDic userDic){
        List size = dicMappingService.checkName(userDic);
        if(size.size()>0){
            return new Message(1, "字典名称重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    @ResponseBody
    @RequestMapping("/dicMapping/checkType")
    public Message checkCode(UserDic userDic){
        List size = dicMappingService.checkType(userDic);
        if(size.size()>0){
            return new Message(2, "字典类型重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    @ResponseBody
    @RequestMapping("/dicMapping/checkUrl")
    public Message checkOrder(UserDic userDic){
        List size = dicMappingService.checkUrl(userDic);
        if(size.size()>0){
            return new Message(3, "URL重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }

    /*用户字典新增页*/
     /*
    新增页
     */
    @RequestMapping("/userDic/addUserDic")
    public ModelAndView addUserDicSupplies(UserDic userDic) {
        /*UserDic userDic=new UserDic();
        userDic.setDictype(dictype);
        userDic.setName(name);*/
        ModelAndView mv = new ModelAndView("/core/userDic/addUserDic");
        mv.addObject("userDic",userDic);
        /*mv.addObject("name",name);*/
        mv.addObject("head", "新增数据");
        return mv;
    }
    /*
  修改页面
   */
    @ResponseBody
    @RequestMapping("/dicMapping/editDic")
    public ModelAndView editDic(String id) {
        UserDic userDic=dicMappingService.getDicID(id);
        ModelAndView mv = new ModelAndView("/core/userDic/addUserDic");
        mv.addObject("head", "字典修改");
        mv.addObject("userDic", userDic);
        return mv;
    }
    /*新增与修改保存方法*/
    @ResponseBody
    @RequestMapping("/userDic/saveDic")
    public Message saveDic(UserDic userDic){
        Date date = new Date(new java.util.Date().getTime());
        userDic.setCreateTime(CommonUtil.getDate());
        if(userDic.getId()==null || "".equals(userDic.getId())){
            userDic.setCreator(CommonUtil.getPersonId());
            userDic.setCreateDept(CommonUtil.getDefaultDept());
            userDic.setId(CommonUtil.getUUID());
            userDicService.insertUserDic(userDic);
            return new Message(1, "新增成功！", null);
        }else{
            userDic.setChanger(CommonUtil.getPersonId());
            userDic.setChangeDept(CommonUtil.getDefaultDept());
            userDicService.updateUserDicSupplies(userDic);
            return new Message(1, "修改成功！", null);
        }
    }
    @ResponseBody
    @RequestMapping("/userDic/dicName")
    public Message userName(UserDic userDic){
        List size = userDicService.checkName(userDic);
        if(size.size()>0){
            return new Message(1, "名称重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
}
