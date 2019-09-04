package com.goisan.survey.dao;

import com.goisan.survey.bean.Survey;
import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface SurveyDao {

    List<BaseBean> getSurveyList(BaseBean baseBean);

    List<BaseBean> getSurveyListByPerson(BaseBean baseBean);

    void saveSurvey(BaseBean baseBean);

    BaseBean getSurveyById(String id);

    void updateSurvey(BaseBean baseBean);

    void updateSurveyFlag(BaseBean baseBean);

    void delSurvey(String id);

    void delQuestionBySurveyId(String id);

    void delOptionBySurveyId(String id);

    void delPersonBySurveyId(String id);

    void delAnswerBySurveyId(String id);

    List<Survey> getSurveyEditList(Survey survey);

    List<Survey> getSurveyExport(Survey survey);

}
