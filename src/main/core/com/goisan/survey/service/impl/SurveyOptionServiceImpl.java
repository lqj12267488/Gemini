package com.goisan.survey.service.impl;

import com.goisan.survey.bean.SurveyOption;
import com.goisan.survey.bean.SurveyQuestion;
import com.goisan.survey.dao.SurveyOptionDao;
import com.goisan.survey.service.SurveyOptionService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SurveyOptionServiceImpl implements SurveyOptionService {
    @Resource
    private SurveyOptionDao surveyOptionDao;

    public List<BaseBean> getSurveyOptionList(BaseBean baseBean) {
        return surveyOptionDao.getSurveyOptionList(baseBean);
    }

    public void saveSurveyOption(SurveyOption surveyOption) {
        surveyOptionDao.saveSurveyOption(surveyOption);
    }

    public BaseBean getSurveyOptionById(String id) {
        return surveyOptionDao.getSurveyOptionById(id);
    }

    public void updateSurveyOption(BaseBean baseBean) {
        surveyOptionDao.updateSurveyOption(baseBean);
    }

    public void delSurveyOption(String id) {
        surveyOptionDao.delSurveyOption(id);
    }

    public  List<SurveyOption> checkOptionBySurveyid(String id){
        return surveyOptionDao.checkOptionBySurveyid(id);
    }

    public void addSurveyOption(SurveyQuestion surveyQuestion , String checkval){
        String[] checkList = checkval.split("##");
        SurveyOption surveyOption = new SurveyOption();
        surveyOption.setQuestionId(surveyQuestion.getQuestionId());
        surveyOption.setSurveyId(surveyQuestion.getSurveyId());
        CommonUtil.save(surveyOption);
        int i =0;
        for(String check : checkList){
            i++;
            surveyOption.setOptionId(CommonUtil.getUUID());
            if( surveyQuestion.getQuestionType().equals("4") ||  surveyQuestion.getQuestionType().equals("5") ){
                String[] val = check.split(",");
                surveyOption.setOptionValue(val[0]);
                surveyOption.setOptionCode(val[1]);
            }else{
                surveyOption.setOptionValue(check);
            }
            surveyOption.setOptionOrder(i+"");
            surveyOptionDao.saveSurveyOption(surveyOption);
        }
    }

    public void delOptionByQuestionId(String questionId){
        surveyOptionDao.delOptionByQuestionId(questionId);
    }

    public List<SurveyOption> getOptionListById(String questionId){
       return surveyOptionDao.getOptionListById(questionId);
    }

}
