package com.goisan.survey.service;

import com.goisan.survey.bean.SurveyAnswer;
import com.goisan.system.bean.BaseBean;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface SurveyAnswerService {

    List<BaseBean> getSurveyAnswerList(BaseBean baseBean);

    @Transactional
    void saveSurveyAnswer(SurveyAnswer surveyAnswer);

    BaseBean getSurveyAnswerById(String id);

    void updateSurveyAnswer(BaseBean baseBean);

    void delSurveyAnswer(String id);

}