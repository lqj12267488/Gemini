package com.goisan.system.controller;

import com.goisan.system.bean.SysDic;
import com.goisan.system.service.SysDicService;
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

@Controller
public class SysDicController {
    @Resource
    private SysDicService sysDicService;
    /*主页*/
    @RequestMapping("/sysDic/sysDicMapping")
    public ModelAndView DicHome(){
        ModelAndView modelAndView=new ModelAndView("/core/sysDic/sysDicHome");
        return modelAndView;
    }
    /*主页数据查询*/
    @ResponseBody
    @RequestMapping("/sysDic/sysDicInfo")
    public Map<String,List<SysDic>> sysDicInfo(SysDic sysDic){
        Map<String, List<SysDic>> dicMap = new HashMap<String, List<SysDic>>();
        dicMap.put("data",sysDicService.sysDicInfo(sysDic));
        return dicMap;
    }
    /*新增*/
    @RequestMapping("/sysDic/editSysDic")
    public ModelAndView editSysDic(){
        ModelAndView modelAndView=new ModelAndView("/core/sysDic/editSysDic");
        return modelAndView;
    }
    /*修改*/
    @ResponseBody
    @RequestMapping("/sysDic/editSysDices")
    public ModelAndView editSysDices(String id) {
        SysDic sysDic=sysDicService.getSysDicID(id);
        ModelAndView modelAndView = new ModelAndView("/core/sysDic/editSysDic");
        modelAndView.addObject("head", "字典修改");
        modelAndView.addObject("sysDic", sysDic);
        return modelAndView;
    }
    /*新增与修改保存方法*/
    @ResponseBody
    @RequestMapping("/sysDic/saveSysDic")
    public Message saveSysDic(SysDic sysDic){
        if(sysDic.getId()==null || "".equals(sysDic.getId())){
            sysDic.setCreator(CommonUtil.getPersonId());
            sysDic.setCreateDept(CommonUtil.getDefaultDept());
            sysDic.setId(CommonUtil.getUUID());
            sysDicService.insertSysDic(sysDic);
            return new Message(1, "新增成功！", null);
        }else{
            sysDic.setChanger(CommonUtil.getPersonId());
            sysDic.setChangeDept(CommonUtil.getDefaultDept());
            sysDicService.updateSysDic(sysDic);
            return new Message(1, "修改成功！", null);
        }
    }
    /*判断是否有子页*/
    @ResponseBody
    @RequestMapping("/sysDic/checkDicMapping")
    public Message checkDicMapping(SysDic sysDic){
        List size = sysDicService.checkDicMapping(sysDic);
        if(size.size()>0){
            return new Message(1, "此字典下有子选项，请先删除子选项.", null);
        }else{
            return new Message(0, "", null);
        }
    }

    /*删除*/
    @ResponseBody
    @RequestMapping("/sysDic/deleteSysDic")
    public Message deleteSysDic(String id) {
        sysDicService.deleteSysDic(id);
        //菜单,按钮权限删除
        return new Message(1, "删除成功！", null);
    }
    /*子页*/
    @RequestMapping("/sysDic/addSysDicMapping")
    public ModelAndView addSysDicMapping(SysDic sysDic){
        String id = sysDic.getId();
        SysDic sysDicBean=sysDicService.getSysDicID(id);
        String Dicname = sysDicBean.getDicname();
        ModelAndView mv=new ModelAndView("/core/sysDic/addSysDicMapping");
        mv.addObject("Dicname",Dicname);
        mv.addObject("sysDic",sysDic);
        return mv;
    }
    /*子页数据查询*/
    @ResponseBody
    @RequestMapping("/sysDic/sysDicMappingInfo")
    public Map<String,List<SysDic>> sysDicMappingInfo(SysDic sysDic){
        Map<String, List<SysDic>> dicMap = new HashMap<String, List<SysDic>>();
        dicMap.put("data",sysDicService.sysDicMappingInfo(sysDic));
        return dicMap;
    }
    /*子页新增*/
    @RequestMapping("/sysDic/editSysDicMapping")
    public ModelAndView editSysDicMapping(SysDic sysDic){
        ModelAndView modelAndView=new ModelAndView("/core/sysDic/editSysDicMapping");
        modelAndView.addObject("sysDic",sysDic);
        return modelAndView;
    }
    /*修改*/
    @ResponseBody
    @RequestMapping("/sysDic/editDices")
    public ModelAndView editDices(String id) {
        SysDic sysDic=sysDicService.getSysDicID(id);
        ModelAndView modelAndView = new ModelAndView("/core/sysDic/editSysDicMapping");
        modelAndView.addObject("head", "字典修改");
        modelAndView.addObject("sysDic", sysDic);
        return modelAndView;
    }
     /*子页新增与修改保存方法*/
    @ResponseBody
    @RequestMapping("/sysDic/saveSysDicMapping")
    public Message saveSysDicMapping(SysDic sysDic){
        if(sysDic.getId()==null || "".equals(sysDic.getId()) || "undefined".equals(sysDic.getId())){
            sysDic.setCreator(CommonUtil.getPersonId());
            sysDic.setCreateDept(CommonUtil.getDefaultDept());
            sysDic.setId(CommonUtil.getUUID());
            sysDicService.insertSysDicMapping(sysDic);
            return new Message(1, "新增成功！", null);
        }else{
            sysDic.setChanger(CommonUtil.getPersonId());
            sysDic.setChangeDept(CommonUtil.getDefaultDept());
            sysDicService.updateSysDic(sysDic);
            return new Message(1, "修改成功！", null);
        }
    }
    /*字典名称重复性校验*/
    @ResponseBody
    @RequestMapping("/sysDic/checkName")
    public Message checkName(SysDic sysDic){
        List size = sysDicService.checkName(sysDic);
        if(size.size()>0){
            return new Message(1, "字典名称重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    /*字典编码重复性校验*/
    @ResponseBody
    @RequestMapping("/sysDic/checkCode")
    public Message checkCode(SysDic sysDic){
        List size = sysDicService.checkCode(sysDic);
        if(size.size()>0){
            return new Message(2, "字典编码重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    /*子页名称重复性校验*/
    @ResponseBody
    @RequestMapping("/sysDic/sysDicName")
    public Message sysDicName(SysDic sysDic){
        List size = sysDicService.sysDicName(sysDic);
        if(size.size()>0){
            return new Message(1, "字典名称重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    /*子页编码重复性校验*/
    @ResponseBody
    @RequestMapping("/sysDic/sysDicCode")
    public Message sysDicCode(SysDic sysDic){
        List size = sysDicService.sysDicCode(sysDic);
        if(size.size()>0){
            return new Message(2, "字典编码重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
}
