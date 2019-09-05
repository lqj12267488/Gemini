package com.goisan.survey.service.impl;

import com.goisan.survey.bean.Survey;
import com.goisan.survey.dao.SurveyDao;
import com.goisan.survey.service.SurveyService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SurveyServiceImpl implements SurveyService {
@Resource
private SurveyDao surveyDao;

    public List<BaseBean> getSurveyList(BaseBean baseBean) {
        return surveyDao.getSurveyList(baseBean);
    }

    public List<BaseBean> getSurveyListByPerson(BaseBean baseBean) {
        return surveyDao.getSurveyListByPerson(baseBean);
    }

    public void saveSurvey(BaseBean baseBean) {
        surveyDao.saveSurvey(baseBean);
    }

    public BaseBean getSurveyById(String id) {
        return surveyDao.getSurveyById(id);
    }

    public void updateSurvey(BaseBean baseBean) {
        surveyDao.updateSurvey(baseBean);
    }

    public void updateSurveyFlag(BaseBean baseBean) {
        surveyDao.updateSurveyFlag(baseBean);
    }

    public void delSurvey(String id) {
        surveyDao.delSurvey(id);
        surveyDao.delQuestionBySurveyId(id);
        surveyDao.delOptionBySurveyId(id);
        surveyDao.delPersonBySurveyId(id);
        surveyDao.delAnswerBySurveyId(id);

    }

    public List<Survey> getSurveyEditList(Survey survey){
        return surveyDao.getSurveyEditList(survey);
    }

    public List<Survey> getSurveyExport(Survey survey){ return surveyDao.getSurveyExport(survey); }
}
