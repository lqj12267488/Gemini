package com.goisan.survey.controller;

import com.goisan.survey.bean.SurveyOption;
import com.goisan.survey.service.SurveyOptionService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Map;

@Controller
// @RequestMapping("")
public class SurveyOptionController {

    @Resource
    private SurveyOptionService surveyOptionService;

    @RequestMapping("/survey/option/toSurveyOptionList")
    public ModelAndView toList(String id,String checkFlag) {
        ModelAndView mv = new ModelAndView("/core/survey/option/surveyOptionList");
        mv.addObject("surveyId",id);
        mv.addObject("checkFlag",checkFlag);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/option/getSurveyOptionList")
    public Map getList(SurveyOption surveyOption) {
        return CommonUtil.tableMap(surveyOptionService.getSurveyOptionList(surveyOption));
    }

    @RequestMapping("/survey/option/toSurveyOptionAdd")
    public ModelAndView toAdd(Model model) {
        ModelAndView mv = new ModelAndView("/core/survey/option/surveyOptionEdit");
        mv.addObject("head", "新增");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/option/saveSurveyOption")
    public Message save(SurveyOption surveyOption) {
        if ("".equals(surveyOption.getOptionId())) {
            surveyOption.setOptionId(CommonUtil.getUUID());
            CommonUtil.save(surveyOption);
            surveyOptionService.saveSurveyOption(surveyOption);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(surveyOption);
            surveyOptionService.updateSurveyOption(surveyOption);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/survey/option/toSurveyOptionEdit")
    public ModelAndView toEdit(String id) {
        ModelAndView mv = new ModelAndView("/core/survey/option/surveyOptionEdit");
        mv.addObject("data", surveyOptionService.getSurveyOptionById(id));
        mv.addObject("head", "修改");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/option/delSurveyOption")
    public Message del(String id) {
        surveyOptionService.delSurveyOption(id);
        return new Message(0, "删除成功！", null);
    }

}
