package com.goisan.survey.service;

import com.goisan.survey.bean.SurveyOption;
import com.goisan.survey.bean.SurveyQuestion;
import com.goisan.system.bean.BaseBean;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface SurveyOptionService {

    List<BaseBean> getSurveyOptionList(BaseBean baseBean);

    void saveSurveyOption(SurveyOption surveyOption);

    BaseBean getSurveyOptionById(String id);

    void updateSurveyOption(BaseBean baseBean);

    void delSurveyOption(String id);

    List<SurveyOption> checkOptionBySurveyid(String id);

    @Transactional
    void addSurveyOption(SurveyQuestion surveyQuestion, String checkval);

    void delOptionByQuestionId(String questionId);

    List<SurveyOption> getOptionListById(String questionId);
}