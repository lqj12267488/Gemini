package com.goisan.survey.dao;

import com.goisan.survey.bean.SurveyOption;
import com.goisan.survey.bean.SurveyQuestion;
import com.goisan.system.bean.BaseBean;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SurveyQuestionDao {

    List<SurveyQuestion> getSurveyQuestionList(SurveyQuestion surveyQuestion);

    void saveSurveyQuestion(BaseBean baseBean);

    SurveyQuestion getSurveyQuestionById(String id);

    void updateSurveyQuestion(BaseBean baseBean);

    void delSurveyQuestion(String id);

    String checkQuestionBySurveyid(String id);

    List getOptionResultById(@Param("surveyId") String surveyId, @Param("questionId") String questionId);

    List<SurveyOption> getOptionOrderById(@Param("surveyId") String surveyId, @Param("questionId") String questionId);


}
