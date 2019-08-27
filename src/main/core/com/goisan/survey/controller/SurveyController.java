package com.goisan.survey.controller;

import com.goisan.survey.bean.Survey;
import com.goisan.survey.bean.SurveyOption;
import com.goisan.survey.bean.SurveyQuestion;
import com.goisan.survey.service.SurveyOptionService;
import com.goisan.survey.service.SurveyPersonService;
import com.goisan.survey.service.SurveyQuestionService;
import com.goisan.survey.service.SurveyService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Controller
public class SurveyController {

    @Resource
    private SurveyService surveyService;
    @Resource
    private SurveyQuestionService surveyQuestionService;
    @Resource
    private SurveyOptionService surveyOptionService;
    @Resource
    private SurveyPersonService surveyPersonService;

    @RequestMapping("/survey/toSurveyList")
    public ModelAndView toList() {
        ModelAndView mv = new ModelAndView("/core/survey/surveyList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/getSurveyList")
    public Map getList(Survey survey) {
        return CommonUtil.tableMap(surveyService.getSurveyList(survey));
    }

    @RequestMapping("/survey/toSurveyAdd")
    public ModelAndView toAdd() {
        ModelAndView mv = new ModelAndView("/core/survey/surveyEdit");
        mv.addObject("head", "新增");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/saveSurvey")
    public Message save(Survey survey) {
        if ("".equals(survey.getSurveyId())) {
            survey.setSurveyId(CommonUtil.getUUID());
            CommonUtil.save(survey);
            surveyService.saveSurvey(survey);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(survey);
            surveyService.updateSurvey(survey);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/survey/toSurveyEdit")
    public ModelAndView toEdit(String id) {
        ModelAndView mv = new ModelAndView("/core/survey/surveyEdit");
        mv.addObject("head", "修改");
        mv.addObject("data", surveyService.getSurveyById(id));
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/delSurvey")
    public Message del(String id) {
        surveyService.delSurvey(id);
        return new Message(0, "删除成功！", null);
    }


    @RequestMapping("/survey/toSurveyPreview")
    public ModelAndView toSurveyPreview(String id) {
        ModelAndView mv = new ModelAndView("/core/survey/surveyPreview");
        mv.addObject("data", surveyService.getSurveyById(id));

        SurveyQuestion surveyQuestion = new SurveyQuestion();
        surveyQuestion.setSurveyId(id);
        List questionList = surveyQuestionService.getSurveyQuestionList(surveyQuestion);
        mv.addObject("questionList", questionList);

        SurveyOption surveyOption = new SurveyOption();
        surveyOption.setSurveyId(id);
        List optionList = surveyOptionService.getSurveyOptionList(surveyOption);
        mv.addObject("optionList",optionList);
        mv.addObject("surveyId",id);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/checkSurvey")
    public Message checkSurvey(Survey survey) {
        String msg ="";
        String checkQuestion = surveyQuestionService.checkQuestionBySurveyid(survey.getSurveyId());
        if(null == checkQuestion || checkQuestion.equals("0")){
            msg = msg + "没有设置问题，";
        }
        String checkOption = surveyOptionService.checkOptionBySurveyid(survey.getSurveyId());
        if(null == checkOption || checkOption.equals("0")){
            msg = msg + "没有设置选项，";
        }
        String checkPerson = surveyPersonService.checkPersonBySurveyid(survey.getSurveyId());
        if(null == checkPerson || checkPerson.equals("0")){
            msg = msg + "没有设置答卷人，";
        }

        if(msg.equals("")){
            survey.setCheckFlag("1");
            CommonUtil.update(survey);
            surveyService.updateSurveyFlag(survey);
            return new Message(1, "验证成功！", "success");
        }else{
            return new Message(0, msg+"请先设置！", "error");
        }
    }

    @ResponseBody
    @RequestMapping("/survey/changeStartFlaf")
    public Message changeStartFlaf(Survey survey) {
        CommonUtil.update(survey);
        surveyService.updateSurveyFlag(survey);
        return new Message(1, "启动成功！", "success");
    }

    // 家长查看
    @RequestMapping("/survey/toSurveyListPerson")
    public ModelAndView toSurveyListPerson() {
        ModelAndView mv = new ModelAndView("/core/survey/parent/surveyListByParent");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/getSurveyListByPerson")
    public Map getListByPerson(Survey survey) {
        CommonUtil.save(survey);
        return CommonUtil.tableMap(surveyService.getSurveyListByPerson(survey));
    }

    @RequestMapping("/survey/toSurveyFill")
    public ModelAndView toSurveyFill(String id) {
        ModelAndView mv = new ModelAndView("/core/survey/parent/surveyFill");
        mv.addObject("data", surveyService.getSurveyById(id));

        SurveyQuestion surveyQuestion = new SurveyQuestion();
        surveyQuestion.setSurveyId(id);
        List questionList = surveyQuestionService.getSurveyQuestionList(surveyQuestion);
        mv.addObject("questionList", questionList);

        mv.addObject("questionListMap", CommonUtil.jsonUtil(questionList));

        SurveyOption surveyOption = new SurveyOption();
        surveyOption.setSurveyId(id);
        List optionList = surveyOptionService.getSurveyOptionList(surveyOption);
        mv.addObject("optionList",optionList);
        mv.addObject("surveyId",id);
        return mv;
    }


}
