package com.goisan.survey.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface SurveyOptionDao {

    List<BaseBean> getSurveyOptionList(BaseBean baseBean);

    void saveSurveyOption(BaseBean baseBean);

    BaseBean getSurveyOptionById(String id);

    void updateSurveyOption(BaseBean baseBean);

    void delSurveyOption(String id);

    String checkOptionBySurveyid(String id);
}
