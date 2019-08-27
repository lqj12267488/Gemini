package com.goisan.survey.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface SurveyQuestionDao {

    List<BaseBean> getSurveyQuestionList(BaseBean baseBean);

    void saveSurveyQuestion(BaseBean baseBean);

    BaseBean getSurveyQuestionById(String id);

    void updateSurveyQuestion(BaseBean baseBean);

    void delSurveyQuestion(String id);

    String checkQuestionBySurveyid(String id);
}
