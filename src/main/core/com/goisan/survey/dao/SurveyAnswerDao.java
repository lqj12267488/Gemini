package com.goisan.survey.dao;

import com.goisan.survey.bean.Survey;
import com.goisan.survey.bean.SurveyAnswer;
import com.goisan.system.bean.BaseBean;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SurveyAnswerDao {

    List<BaseBean> getSurveyAnswerList(BaseBean baseBean);

    List<Survey> getSurveyAnswerListByUserId(Survey baseBean);

    void saveSurveyAnswer(SurveyAnswer surveyAnswer);

    BaseBean getSurveyAnswerById(String id);

    void updateSurveyAnswer(BaseBean baseBean);

    void delSurveyAnswer(String id);

    List surveyAnswerServiceBySurveyId(@Param("id") String id);

}
