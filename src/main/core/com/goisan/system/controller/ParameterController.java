package com.goisan.system.controller;

import com.goisan.system.bean.Parameter;
import com.goisan.system.service.ParameterService;
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
public class ParameterController {
    @Resource
    private ParameterService parameterService;
    /*主页*/
    @RequestMapping("/parameter")
    public ModelAndView Parameter(){
        ModelAndView mv=new ModelAndView("/core/parameter/parameter");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/parameter/parameterInfo")
    public Map<String,List<Parameter>> parameterInfo(Parameter parameter){
        Map<String,List<Parameter>> map=new HashMap<String, List<Parameter>>();
        map.put("data",parameterService.parameterInfo(parameter));
        return map;
    }
    /*新增页*/
    @RequestMapping("/parameter/addParameter")
    public ModelAndView editParameter(){
        ModelAndView mv=new ModelAndView("/core/parameter/editParameter");
        return mv;
    }
    /*修改页*/
    @ResponseBody
    @RequestMapping("/parameter/editParameter")
    public ModelAndView editSysDices(String id) {
        Parameter parameter=parameterService.getParameterID(id);
        ModelAndView modelAndView = new ModelAndView("/core/parameter/editParameter");
        modelAndView.addObject("head", "字典修改");
        modelAndView.addObject("parameter", parameter);
        return modelAndView;
    }
    /*新增修改保存*/
    @ResponseBody
    @RequestMapping("/parameter/saveParameter")
    public Message saveParameter(Parameter parameter){
        if(parameter.getId()==null || "".equals(parameter.getId())){
            parameter.setCreator(CommonUtil.getPersonId());
            parameter.setCreateDept(CommonUtil.getDefaultDept());
            parameter.setId(CommonUtil.getUUID());
            parameterService.insertParameter(parameter);
            return new Message(1, "新增成功！", null);
        }else{
            parameter.setChanger(CommonUtil.getPersonId());
            parameter.setChangeDept(CommonUtil.getDefaultDept());
            parameterService.updateParameter(parameter);
            return new Message(1, "修改成功！", null);
        }
    }
    /*删除*/
    @ResponseBody
    @RequestMapping("/parameter/deleteParameter")
    public Message deleteParameter(String id) {
        parameterService.deleteParameter(id);
        return new Message(1, "删除成功！", null);
    }
    /*参数名称重复性校验*/
    @ResponseBody
    @RequestMapping("/parameter/checkName")
    public Message checkName(Parameter parameter){
        List size = parameterService.checkName(parameter);
        if(size.size()>0){
            return new Message(1, "参数名称重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    /*参数代码重复性校验*/
    @ResponseBody
    @RequestMapping("/parameter/checkCode")
    public Message checkCode(Parameter parameter){
        List size = parameterService.checkCode(parameter);
        if(size.size()>0){
            return new Message(2, "参数代码重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    /*参数类型重复性校验*//*
    @ResponseBody
    @RequestMapping("/parameter/checkType")
    public Message checkType(Parameter parameter){
        List size = parameterService.checkType(parameter);
        if(size.size()>0){
            return new Message(3, "参数类型重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    *//*参数值重复性校验*//*
    @ResponseBody
    @RequestMapping("/parameter/checkValue")
    public Message checkValue(Parameter parameter){
        List size = parameterService.checkValue(parameter);
        if(size.size()>0){
            return new Message(4, "参数值重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }*/
}
