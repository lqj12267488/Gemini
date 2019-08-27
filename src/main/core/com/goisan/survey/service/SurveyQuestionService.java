package com.goisan.survey.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface SurveyQuestionService {

    List<BaseBean> getSurveyQuestionList(BaseBean baseBean);

    void saveSurveyQuestion(BaseBean baseBean);

    BaseBean getSurveyQuestionById(String id);

    void updateSurveyQuestion(BaseBean baseBean);

    void delSurveyQuestion(String id);

    String checkQuestionBySurveyid(String id);

}