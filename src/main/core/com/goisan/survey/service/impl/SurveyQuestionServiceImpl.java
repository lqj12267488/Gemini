package com.goisan.survey.service.impl;

import com.goisan.survey.dao.SurveyQuestionDao;
import com.goisan.survey.service.SurveyQuestionService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SurveyQuestionServiceImpl implements SurveyQuestionService {
@Resource
private SurveyQuestionDao surveyQuestionDao;

    public List<BaseBean> getSurveyQuestionList(BaseBean baseBean) {
        return surveyQuestionDao.getSurveyQuestionList(baseBean);
    }

    public void saveSurveyQuestion(BaseBean baseBean) {
        surveyQuestionDao.saveSurveyQuestion(baseBean);
    }

    public BaseBean getSurveyQuestionById(String id) {
        return surveyQuestionDao.getSurveyQuestionById(id);
    }

    public void updateSurveyQuestion(BaseBean baseBean) {
        surveyQuestionDao.updateSurveyQuestion(baseBean);
    }

    public void delSurveyQuestion(String id) {
        surveyQuestionDao.delSurveyQuestion(id);
    }

    public String checkQuestionBySurveyid(String id) {
        return surveyQuestionDao.checkQuestionBySurveyid(id);
    }
}
