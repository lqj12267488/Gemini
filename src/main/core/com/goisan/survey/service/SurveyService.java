package com.goisan.survey.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface SurveyService {

    List<BaseBean> getSurveyList(BaseBean baseBean);

    List<BaseBean> getSurveyListByPerson(BaseBean baseBean);

    void saveSurvey(BaseBean baseBean);

    BaseBean getSurveyById(String id);

    void updateSurvey(BaseBean baseBean);

    void updateSurveyFlag(BaseBean baseBean);

    void delSurvey(String id);

}