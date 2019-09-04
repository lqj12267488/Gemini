package com.goisan.survey.service;

import com.goisan.survey.bean.SurveyQuestion;
import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface SurveyQuestionService {

    List<SurveyQuestion> getSurveyQuestionList(SurveyQuestion surveyQuestion);

    List<SurveyQuestion> getSurveyQuestionBySurveyId(String id);

    void saveSurveyQuestion(BaseBean baseBean);

    SurveyQuestion getSurveyQuestionById(String id);

    void updateSurveyQuestion(BaseBean baseBean);

    void delSurveyQuestion(String id);

    String checkQuestionBySurveyid(String id);

}