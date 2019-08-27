package com.goisan.survey.service.impl;

import com.goisan.survey.dao.SurveyOptionDao;
import com.goisan.survey.service.SurveyOptionService;
import com.goisan.system.bean.BaseBean;
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

    public void saveSurveyOption(BaseBean baseBean) {
        surveyOptionDao.saveSurveyOption(baseBean);
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

    public  String checkOptionBySurveyid(String id){
        return surveyOptionDao.checkOptionBySurveyid(id);
    }
}
