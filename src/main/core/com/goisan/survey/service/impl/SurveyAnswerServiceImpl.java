package com.goisan.survey.service.impl;

import com.goisan.survey.bean.Survey;
import com.goisan.survey.bean.SurveyAnswer;
import com.goisan.survey.dao.SurveyAnswerDao;
import com.goisan.survey.service.SurveyAnswerService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SurveyAnswerServiceImpl implements SurveyAnswerService {
    @Resource
    private SurveyAnswerDao surveyAnswerDao;

    public List<BaseBean> getSurveyAnswerList(BaseBean baseBean) {
        return surveyAnswerDao.getSurveyAnswerList(baseBean);
    }

    public List<Survey> getSurveyAnswerListByUserId(Survey baseBean) {
        return surveyAnswerDao.getSurveyAnswerListByUserId(baseBean);
    }

    public void saveSurveyAnswer(SurveyAnswer surveyAnswer) {
        if (surveyAnswer.getAnswerResult().length() > 0) {
            String[] check = surveyAnswer.getAnswerResult().split("@@@@");
            SurveyAnswer surveyResult = new SurveyAnswer();
            surveyResult.setSurveyId(surveyAnswer.getSurveyId());
            surveyResult.setPersonId(CommonUtil.getPersonId());
            surveyResult.setPersonDept(CommonUtil.getLoginUser().getDefaultDeptId());
            CommonUtil.save(surveyResult);
            for (int i = 0; i < check.length; i++) {
                String a = check[i];
                String[] b = a.split("##");
                surveyResult.setAnswerId(CommonUtil.getUUID());
                surveyResult.setQuestionId(b[0].toString());
                surveyResult.setAnswerResult(b[1].toString());
                surveyAnswerDao.saveSurveyAnswer(surveyResult);
            }
        }
    }

    public void insertSurveyAnswer(String returnValue ,String surveyId){
        SurveyAnswer surveyResult = new SurveyAnswer();
        surveyResult.setSurveyId(surveyId);
        surveyResult.setPersonId(CommonUtil.getPersonId());
        surveyResult.setPersonDept(CommonUtil.getLoginUser().getDefaultDeptId());

        String[] resuleList = returnValue.split("@@@@");
        for (int i = 0; i < resuleList.length; i++) {
            String a = resuleList[i];
            String[] b = a.split("##");
            surveyResult.setAnswerId(CommonUtil.getUUID());
            surveyResult.setQuestionId(b[0].toString());
            surveyResult.setAnswerResult(b[1].toString());
            surveyAnswerDao.saveSurveyAnswer(surveyResult);
        }
    }
    public BaseBean getSurveyAnswerById(String id) {
        return surveyAnswerDao.getSurveyAnswerById(id);
    }

    public void updateSurveyAnswer(BaseBean baseBean) {
        surveyAnswerDao.updateSurveyAnswer(baseBean);
    }

    public void delSurveyAnswer(String id) {
        surveyAnswerDao.delSurveyAnswer(id);
    }

    public List surveyAnswerServiceBySurveyId(String id) {
        return surveyAnswerDao.surveyAnswerServiceBySurveyId(id);    }


}
