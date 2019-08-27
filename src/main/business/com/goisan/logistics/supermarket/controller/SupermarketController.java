package com.goisan.logistics.supermarket.controller;

import com.goisan.logistics.supermarket.bean.Supermarket;
import com.goisan.logistics.supermarket.service.SupermarketService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wq on 2017/9/20.
 */
@Controller
public class SupermarketController {
    @Resource
    private SupermarketService supermarketService;
    @RequestMapping("/supermarketList/skip")
    public ModelAndView studentBurseList(){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/logistics/supermarket/supermarketList");
        return mv;
    }
    //页面数据源
    @ResponseBody
    @RequestMapping("/Supermarket/SupermarketList")
    public Map<String,List<Supermarket>> getSupermarketList(Supermarket supermarket){
        String create = CommonUtil.getPersonId();
        supermarket.setCreator(create);
        String level = CommonUtil.getLoginUser().getLevel();
        String dept = CommonUtil.getDefaultDept();
        supermarket.setLevel(level);
        supermarket.setCreateDept(dept);
        List<Supermarket> list=supermarketService.getSupermarketList(supermarket);
        Map<String,List<Supermarket>> map=new HashMap<String, List<Supermarket>>();
        map.put("data", list);
        return map;
    }
     //新增学生
    @ResponseBody
    @RequestMapping("/Supermarket/SupermarketEdit")
    public ModelAndView editSupermarket(String id){
        ModelAndView mv=new ModelAndView();
        mv.setViewName("/business/logistics/supermarket/supermarketEdit");
        String level = CommonUtil.getLoginUser().getLevel();
        String dept = CommonUtil.getDefaultDept();
        mv.addObject("level",level);
        mv.addObject("dept",dept);
        if(id==""||id==null){
            mv.addObject("head","新增");
        }else{
            mv.addObject("head", "修改");
        }
        return mv;
    }
    @ResponseBody
    @RequestMapping("/Supermarket/SupermarketSave")
    public Message saveSupermarket(Supermarket supermarket){
        if(supermarket.getId()==""||supermarket.getId()==null){
            supermarket.setCreator(CommonUtil.getPersonId());
            supermarket.setCreateDept(CommonUtil.getDefaultDept());
            supermarketService.insertSupermarket(supermarket);
            return new Message(1,"新增成功！",null);
        }else{
            supermarket.setChanger(CommonUtil.getPersonId());
            supermarket.setChangeDept(CommonUtil.getDefaultDept());
            supermarketService.updateSupermarketById(supermarket);
            return new Message(1,"修改成功！",null);
        }
    }

    @ResponseBody
    @RequestMapping("/Supermarket/getSupermarketById")
    public ModelAndView getSupermarketById(Supermarket supermarket){
        Supermarket Supermarket1 = supermarketService.getSupermarketById(supermarket);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "修改");
        mv.addObject("Supermarket", Supermarket1);
        mv.setViewName("/business/logistics/supermarket/supermarketEdit");
        return mv;
    }
    //删除方法
    @ResponseBody
    @RequestMapping("/Supermarket/SupermarketDelete")
    public Message deleteSupermarket(Supermarket supermarket){
        supermarketService.deleteSupermarketById(supermarket);
        return new Message(1,"删除成功！",null);
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping("/supermarketStaffList/skip")
    public ModelAndView supermarketStaffList(){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/logistics/supermarket/supermarketStaffList");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/Supermarket/SupermarketStaffList")
    public Map<String,List<Supermarket>> getSupermarketStaffList(Supermarket supermarket){
        String create = CommonUtil.getPersonId();
        supermarket.setCreator(create);
        String level = CommonUtil.getLoginUser().getLevel();
        String dept = CommonUtil.getDefaultDept();
        supermarket.setLevel(level);
        supermarket.setCreateDept(dept);
        List<Supermarket> list=supermarketService.getSupermarketStaffList(supermarket);
        Map<String,List<Supermarket>> map=new HashMap<String, List<Supermarket>>();
        map.put("data", list);
        return map;
    }
    @ResponseBody
    @RequestMapping("/Supermarket/SupermarketStaffEdit")
    public ModelAndView editSupermarketStaff(Supermarket supermarket){
        ModelAndView mv=new ModelAndView();
        mv.setViewName("/business/logistics/supermarket/supermarketStaffEdit");
        String level = CommonUtil.getLoginUser().getLevel();
        String dept = CommonUtil.getDefaultDept();
        mv.addObject("level",level);
        mv.addObject("dept",dept);
        Supermarket Supermarket1 = supermarketService.getSupermarketStaffById(supermarket);
        mv.addObject("Supermarket", Supermarket1);
        if(supermarket.getId()==""||supermarket.getId()==null){
            mv.addObject("head","新增");
        }else{
            mv.addObject("head", "修改");
        }
        return mv;
    }
    @ResponseBody
    @RequestMapping("/Supermarket/SupermarketStaffSave")
    public Message saveSupermarketStaff(Supermarket supermarket){
        if(supermarket.getId()==""||supermarket.getId()==null){
            supermarket.setCreator(CommonUtil.getPersonId());
            supermarket.setCreateDept(CommonUtil.getDefaultDept());
            supermarketService.insertSupermarketStaff(supermarket);
            return new Message(1,"新增成功！",null);
        }else{
            supermarket.setChanger(CommonUtil.getPersonId());
            supermarket.setChangeDept(CommonUtil.getDefaultDept());
            supermarketService.updateSupermarketStaffById(supermarket);
            return new Message(1,"修改成功！",null);
        }
    }
    //删除方法
    @ResponseBody
    @RequestMapping("/Supermarket/SupermarketStaffDelete")
    public Message deleteSupermarketStaff(Supermarket supermarket){
        supermarketService.deleteSupermarketStaffById(supermarket);
        return new Message(1,"删除成功！",null);
    }

    @ResponseBody
    @RequestMapping("/Supermarket/checkSupermarketStaffById")
    public Message checkSupermarketStaffById(Supermarket supermarket){
        supermarketService.checkSupermarketStaffById(supermarket);
        return new Message(1,"该名称下已存在人员，请先删除人员！",null);
    }
}
