package com.goisan.survey.controller;

import com.goisan.studentwork.studentprove.service.StudentProveService;
import com.goisan.survey.bean.*;
import com.goisan.survey.service.SurveyAnswerService;
import com.goisan.survey.service.SurveyPersonService;
import com.goisan.survey.service.SurveyQuestionService;
import com.goisan.survey.service.SurveyService;
import com.goisan.system.bean.Student;
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
public class SurveyAnswerController {

    @Resource
    private SurveyAnswerService surveyAnswerService;
    @Resource
    private SurveyPersonService surveyPersonService;
    @Resource
    private SurveyService surveyService;
    @Resource
    private SurveyQuestionService surveyQuestionService;
    @Resource
    private StudentProveService studentProveService;
    @RequestMapping("/survey/answer/toSurveyAnswerList")
    public ModelAndView toList() {
        ModelAndView mv = new ModelAndView("/core/survey/answer/surveyAnswerList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/answer/getSurveyAnswerList")
    public Map getList(Survey surveyAnswer) {
        Student student = studentProveService.getStudentByStudentId(CommonUtil.getPersonId());
        if (null == student) {
            CommonUtil.save(surveyAnswer);
        } else {
            surveyAnswer.setCreator(student.getStudentId());
            surveyAnswer.setCreateDept(student.getClassId());
        }
        return CommonUtil.tableMap(surveyAnswerService.getSurveyAnswerListByUserId(surveyAnswer));
    }

    @RequestMapping("/survey/answer/toSurveyAnswerAdd")
    public ModelAndView toAdd(Model model) {
        ModelAndView mv = new ModelAndView("/core/survey/answer/surveyAnswerEdit");
        mv.addObject("head", "新增");
        return mv;
    }

    @RequestMapping("/survey/answer/toAnswer")
    public ModelAndView toAnswer(String id) {
        ModelAndView mv = new ModelAndView("/core/survey/answer/surveyAnswer");
        mv.addObject("data", surveyService.getSurveyById(id));

        SurveyQuestion surveyQuestion = new SurveyQuestion();
        surveyQuestion.setSurveyId(id);
        List<SurveyQuestion> questionList = surveyQuestionService.getSurveyQuestionList(surveyQuestion);
        mv.addObject("questionList", questionList);

        SurveyOption surveyOption = new SurveyOption();
        surveyOption.setSurveyId(id);
//        List optionList = surveyOptionService.getSurveyOptionList(surveyOption);
//        mv.addObject("optionList",optionList);
        mv.addObject("surveyId",id);
        mv.addObject("qList", CommonUtil.jsonUtil(questionList));
        return mv;

    }


    @ResponseBody
    @RequestMapping("/survey/answer/insertSurveyAnswer")
    public Message insertSurveyAnswer(String returnValue , String surveyId) {
        surveyAnswerService.insertSurveyAnswer(returnValue , surveyId);
        return new Message(0, "添加成功！", null);
    }


    @ResponseBody
    @RequestMapping("/survey/answer/saveSurveyAnswer")
    public Message save(SurveyAnswer surveyAnswer) {
        if (null == surveyAnswer.getAnswerId() || "".equals(surveyAnswer.getAnswerId())) {
            surveyAnswer.setAnswerId(CommonUtil.getUUID());
            CommonUtil.save(surveyAnswer);
            surveyAnswerService.saveSurveyAnswer(surveyAnswer);
            SurveyPerson survey = new SurveyPerson();
            survey.setSurveyId(surveyAnswer.getSurveyId());
            CommonUtil.update(survey);
            surveyPersonService.updateSurveyPersonFlag(survey);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(surveyAnswer);
            surveyAnswerService.updateSurveyAnswer(surveyAnswer);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/survey/answer/toSurveyAnswerEdit")
    public ModelAndView toEdit(String id) {
        ModelAndView mv = new ModelAndView("/core/survey/answer/surveyAnswerEdit");
        mv.addObject("data", surveyAnswerService.getSurveyAnswerById(id));
        mv.addObject("head", "修改");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/answer/delSurveyAnswer")
    public Message del(String id) {
        surveyAnswerService.delSurveyAnswer(id);
        return new Message(0, "删除成功！", null);
    }

}
