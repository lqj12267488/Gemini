package com.goisan.survey.service.impl;

import com.goisan.survey.bean.SurveyOption;
import com.goisan.survey.bean.SurveyQuestion;
import com.goisan.survey.dao.SurveyQuestionDao;
import com.goisan.survey.service.SurveyOptionService;
import com.goisan.survey.service.SurveyQuestionService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SurveyQuestionServiceImpl implements SurveyQuestionService {
    @Resource
    private SurveyQuestionDao surveyQuestionDao;
    @Resource
    private SurveyOptionService surveyOptionService;

    public List<SurveyQuestion> getSurveyQuestionList(SurveyQuestion surveyQuestion) {
        List<SurveyQuestion> questionList = surveyQuestionDao.getSurveyQuestionList(surveyQuestion);
        for(SurveyQuestion question: questionList){
            if(!question.getQuestionType().equals("1")){
                List<SurveyOption> list = surveyOptionService.getOptionListById(question.getQuestionId());
                question.setOptionList(list);
            }
        }
        return questionList;
    }

    public List<SurveyQuestion> getSurveyQuestionBySurveyId(String id){
        SurveyQuestion surveyQuestion = new SurveyQuestion();
        surveyQuestion.setSurveyId(id);
        List<SurveyQuestion> questionList = surveyQuestionDao.getSurveyQuestionList(surveyQuestion);
        for(SurveyQuestion question: questionList){
            if(question.getQuestionType().equals("1")){
                List list = surveyQuestionDao.getOptionResultById(id,question.getQuestionId());
                question.setResult(list);
            }else{
                List<SurveyOption> list = surveyQuestionDao.getOptionOrderById(id,question.getQuestionId());
                question.setOptionList(list);
            }
        }
        return questionList;
    }

    public void saveSurveyQuestion(BaseBean baseBean) {

        surveyQuestionDao.saveSurveyQuestion(baseBean);
    }

    public SurveyQuestion getSurveyQuestionById(String id) {
        return surveyQuestionDao.getSurveyQuestionById(id);
    }

    public void updateSurveyQuestion(BaseBean baseBean) {
        surveyQuestionDao.updateSurveyQuestion(baseBean);
    }

    public void delSurveyQuestion(String id) {
        surveyQuestionDao.delSurveyQuestion(id);
    }

    public String checkQuestionBySurveyid(String id) {
        return surveyQuestionDao.checkQuestionBySurveyid(id);
    }

}
