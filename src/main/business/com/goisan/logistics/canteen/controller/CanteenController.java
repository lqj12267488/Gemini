package com.goisan.logistics.canteen.controller;

import com.goisan.logistics.canteen.bean.Canteen;
import com.goisan.logistics.canteen.service.CanteenService;
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
public class CanteenController {
    @Resource
    private CanteenService canteenService;
    @RequestMapping("/canteenList/skip")
    public ModelAndView studentBurseList(){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/logistics/canteen/canteenList");
        return mv;
    }
    //页面数据源
    @ResponseBody
    @RequestMapping("/canteen/canteenList")
    public Map<String,List<Canteen>> getcanteenList(Canteen canteen){
        String create = CommonUtil.getPersonId();
        canteen.setCreator(create);
        String level = CommonUtil.getLoginUser().getLevel();
        String dept = CommonUtil.getDefaultDept();
        canteen.setLevel(level);
        canteen.setCreateDept(dept);
        List<Canteen> list=canteenService.getCanteenList(canteen);
        Map<String,List<Canteen>> map=new HashMap<String, List<Canteen>>();
        map.put("data", list);
        return map;
    }
     //新增学生
    @ResponseBody
    @RequestMapping("/canteen/canteenEdit")
    public ModelAndView editcanteen(String id){
        ModelAndView mv=new ModelAndView();
        mv.setViewName("/business/logistics/canteen/canteenEdit");
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
    @RequestMapping("/canteen/canteenSave")
    public Message savecanteen(Canteen canteen){
        if(canteen.getId()==""||canteen.getId()==null){
            canteen.setCreator(CommonUtil.getPersonId());
            canteen.setCreateDept(CommonUtil.getDefaultDept());
            canteenService.insertCanteen(canteen);
            return new Message(1,"新增成功！",null);
        }else{
            canteen.setChanger(CommonUtil.getPersonId());
            canteen.setChangeDept(CommonUtil.getDefaultDept());
            canteenService.updateCanteenById(canteen);
            return new Message(1,"修改成功！",null);
        }
    }

    @ResponseBody
    @RequestMapping("/canteen/getcanteenById")
    public ModelAndView getcanteenById(Canteen canteen){
        Canteen canteen1 = canteenService.getCanteenById(canteen);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "修改");
        mv.addObject("canteen", canteen1);
        mv.setViewName("/business/logistics/canteen/canteenEdit");
        return mv;
    }
    //删除方法
    @ResponseBody
    @RequestMapping("/canteen/canteenDelete")
    public Message deletecanteen(Canteen canteen){
        canteenService.deleteCanteenById(canteen);
        return new Message(1,"删除成功！",null);
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping("/canteenStaffList/skip")
    public ModelAndView canteenStaffList(){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/logistics/canteen/canteenStaffList");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/canteen/canteenStaffList")
    public Map<String,List<Canteen>> getcanteenStaffList(Canteen canteen){
        String create = CommonUtil.getPersonId();
        canteen.setCreator(create);
        String level = CommonUtil.getLoginUser().getLevel();
        String dept = CommonUtil.getDefaultDept();
        canteen.setLevel(level);
        canteen.setCreateDept(dept);
        List<Canteen> list=canteenService.getCanteenStaffList(canteen);
        Map<String,List<Canteen>> map=new HashMap<String, List<Canteen>>();
        map.put("data", list);
        return map;
    }
    @ResponseBody
    @RequestMapping("/canteen/canteenStaffEdit")
    public ModelAndView editcanteenStaff(Canteen canteen){
        ModelAndView mv=new ModelAndView();
        mv.setViewName("/business/logistics/canteen/canteenStaffEdit");
        String level = CommonUtil.getLoginUser().getLevel();
        String dept = CommonUtil.getDefaultDept();
        mv.addObject("level",level);
        mv.addObject("dept",dept);
        Canteen canteen1 = canteenService.getCanteenStaffById(canteen);
        mv.addObject("canteen", canteen1);
        if(canteen.getId()==""||canteen.getId()==null){
            mv.addObject("head","新增");
        }else{
            mv.addObject("head", "修改");
        }
        return mv;
    }
    @ResponseBody
    @RequestMapping("/canteen/canteenStaffSave")
    public Message savecanteenStaff(Canteen canteen){
        if(canteen.getId()==""||canteen.getId()==null){
            canteen.setCreator(CommonUtil.getPersonId());
            canteen.setCreateDept(CommonUtil.getDefaultDept());
            canteenService.insertCanteenStaff(canteen);
            return new Message(1,"新增成功！",null);
        }else{
            canteen.setChanger(CommonUtil.getPersonId());
            canteen.setChangeDept(CommonUtil.getDefaultDept());
            canteenService.updateCanteenStaffById(canteen);
            return new Message(1,"修改成功！",null);
        }
    }
    //删除方法
    @ResponseBody
    @RequestMapping("/canteen/canteenStaffDelete")
    public Message deletecanteenStaff(Canteen canteen){
        canteenService.deleteCanteenStaffById(canteen);
        return new Message(1,"删除成功！",null);
    }

    @ResponseBody
    @RequestMapping("/canteen/checkcanteenStaffById")
    public Message checkcanteenStaffById(Canteen canteen){
        canteenService.checkCanteenStaffById(canteen);
        return new Message(1,"名称下存在人员信息，请先删除该食堂的人员！",null);
    }
}
