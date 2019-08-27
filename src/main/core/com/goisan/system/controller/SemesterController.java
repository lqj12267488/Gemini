package com.goisan.system.controller;


import com.goisan.system.bean.Parameter;
import com.goisan.system.bean.SysDic;
import com.goisan.system.service.ParameterService;
import com.goisan.system.service.SysDicService;
import com.goisan.system.service.UserDicService;
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
public class SemesterController {
    @Resource
    private SysDicService sysDicService;
    @Resource
    private ParameterService parameterService;
    @RequestMapping("/semester")
    public ModelAndView semesterList(){
        ModelAndView mv=new ModelAndView("/core/semester/semester");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/semester/semesterList")
    public Map<String,List<SysDic>> semesterList(SysDic sysDic){
        Map<String, List<SysDic>> dicMap = new HashMap<String, List<SysDic>>();
        String xueqi=parameterService.getParameterValue();
        List<SysDic> sysDics=sysDicService.semesterList(sysDic);
        for(int i=0;i<sysDics.size();i++){
            if(sysDics.get(i).getDiccode().equals(xueqi)){
                sysDics.get(i).setName("是");
            }
            else {
                sysDics.get(i).setName(" ");
            }
        }
        dicMap.put("data",sysDics);
        return dicMap;
    }
    /*设置当前学期*/
    @ResponseBody
    @RequestMapping("/semester/updateSemester")
    public Message updateSemester(Parameter parameter){
            parameter.setChanger(CommonUtil.getPersonId());
            parameter.setChangeDept(CommonUtil.getDefaultDept());
            parameterService.updateSemester(parameter);
            parameterService.updateSyear(parameter);
            return new Message(1, "设置成功！", null);
        }
}
