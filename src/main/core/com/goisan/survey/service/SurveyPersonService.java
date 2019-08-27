package com.goisan.survey.service;

import com.goisan.system.bean.BaseBean;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface SurveyPersonService {

    List<BaseBean> getSurveyPersonList(BaseBean baseBean);

    void saveSurveyPerson(BaseBean baseBean);

    BaseBean getSurveyPersonById(String id);

    void updateSurveyPerson(BaseBean baseBean);

    void updateSurveyPersonFlag(BaseBean baseBean);

    void delSurveyPerson(String id);

    @Transactional
    void delAndSaveSurveyParent(String surveyId, String checkList);

    String checkPersonBySurveyid(String id);

}