package com.goisan.survey.controller;

import com.goisan.survey.bean.SurveyOption;
import com.goisan.survey.bean.SurveyQuestion;
import com.goisan.survey.service.SurveyOptionService;
import com.goisan.survey.service.SurveyQuestionService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Controller
// @RequestMapping("")
public class SurveyQuestionController {

    @Resource
    private SurveyQuestionService surveyQuestionService;
    @Resource
    private SurveyOptionService surveyOptionService;

    @RequestMapping("/survey/question/toSurveyQuestionList")
    public ModelAndView toList(String id,String checkFlag,String surveyType) {
        ModelAndView mv = new ModelAndView("/core/survey/question/surveyQuestionList");
        mv.addObject("surveyId",id);
        mv.addObject("checkFlag",checkFlag);
        mv.addObject("surveyType",surveyType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/question/getSurveyQuestionList")
    public Map getList(SurveyQuestion surveyQuestion) {
        return CommonUtil.tableMap(surveyQuestionService.getSurveyQuestionList(surveyQuestion));
    }

    @RequestMapping("/survey/question/toSurveyQuestionAdd")
    public ModelAndView toAdd() {
        ModelAndView mv = new ModelAndView("/core/survey/question/surveyQuestionAdd");
        mv.addObject("head", "新增");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/question/saveSurveyQuestion")
    public Message save(SurveyQuestion surveyQuestion , String checkval) {
        if ( null == surveyQuestion.getQuestionId() ||  "".equals(surveyQuestion.getQuestionId()) ) {
            surveyQuestion.setQuestionId(CommonUtil.getUUID());
            CommonUtil.save(surveyQuestion);
            surveyQuestionService.saveSurveyQuestion(surveyQuestion);
            if(!surveyQuestion.getQuestionType().equals("1")){
                surveyOptionService.addSurveyOption(surveyQuestion,checkval);
            }
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(surveyQuestion);
            surveyQuestionService.updateSurveyQuestion(surveyQuestion);
            if(!surveyQuestion.getQuestionType().equals("1")){
                surveyOptionService.delOptionByQuestionId(surveyQuestion.getQuestionId());
                surveyOptionService.addSurveyOption(surveyQuestion,checkval);
            }
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/survey/question/toSurveyQuestionEdit")
    public ModelAndView toEdit(String id) {
        ModelAndView mv = new ModelAndView("/core/survey/question/surveyQuestionEdit");
        SurveyQuestion surveyQuestion = surveyQuestionService.getSurveyQuestionById(id);
        mv.addObject("data", surveyQuestion);
        if(null!= surveyQuestion && null!= surveyQuestion.getQuestionType() && !surveyQuestion.getQuestionType().equals("1")){
            List<SurveyOption> date = surveyOptionService.getOptionListById(id);
            mv.addObject("option",date );
            mv.addObject("optionDate", CommonUtil.jsonUtil(date) );
        }
        mv.addObject("head", "修改");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/question/delSurveyQuestion")
    public Message del(String id) {
        surveyQuestionService.delSurveyQuestion(id);
        return new Message(0, "删除成功！", null);
    }

}
