package com.goisan.survey.dao;

import com.goisan.survey.bean.SurveyOption;
import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface SurveyOptionDao {

    List<BaseBean> getSurveyOptionList(BaseBean baseBean);

    void saveSurveyOption(SurveyOption surveyOption);

    BaseBean getSurveyOptionById(String id);

    void updateSurveyOption(BaseBean baseBean);

    void delSurveyOption(String id);

    List<SurveyOption> checkOptionBySurveyid(String id);

    void delOptionByQuestionId(String id);

    List<SurveyOption> getOptionListById(String questionId);
}
