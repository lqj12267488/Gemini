package com.goisan.survey.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface SurveyOptionService {

    List<BaseBean> getSurveyOptionList(BaseBean baseBean);

    void saveSurveyOption(BaseBean baseBean);

    BaseBean getSurveyOptionById(String id);

    void updateSurveyOption(BaseBean baseBean);

    void delSurveyOption(String id);

    String checkOptionBySurveyid(String id);

}