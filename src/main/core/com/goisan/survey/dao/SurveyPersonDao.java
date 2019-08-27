package com.goisan.survey.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface SurveyPersonDao {

    List<BaseBean> getSurveyPersonList(BaseBean baseBean);

    void saveSurveyPerson(BaseBean baseBean);

    BaseBean getSurveyPersonById(String id);

    void updateSurveyPerson(BaseBean baseBean);

    void updateSurveyPersonFlag(BaseBean baseBean);

    void delSurveyPerson(String id);

    String checkPersonBySurveyid(String id);

}
