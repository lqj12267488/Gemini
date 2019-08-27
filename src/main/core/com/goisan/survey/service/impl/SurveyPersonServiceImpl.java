package com.goisan.survey.service.impl;

import com.goisan.survey.bean.SurveyPerson;
import com.goisan.survey.dao.SurveyPersonDao;
import com.goisan.survey.service.SurveyPersonService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.RoleParentStuRelation;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Date;
import java.util.List;

@Service
public class SurveyPersonServiceImpl implements SurveyPersonService {
    @Resource
    private SurveyPersonDao surveyPersonDao;

    public List<BaseBean> getSurveyPersonList(BaseBean baseBean) {
        return surveyPersonDao.getSurveyPersonList(baseBean);
    }

    public void saveSurveyPerson(BaseBean baseBean) {
        surveyPersonDao.saveSurveyPerson(baseBean);
    }

    public BaseBean getSurveyPersonById(String id) {
        return surveyPersonDao.getSurveyPersonById(id);
    }

    public void updateSurveyPerson(BaseBean baseBean) {
        surveyPersonDao.updateSurveyPerson(baseBean);
    }

    public void updateSurveyPersonFlag(BaseBean baseBean) {
        surveyPersonDao.updateSurveyPersonFlag(baseBean);
    }

    public void delSurveyPerson(String id) {
        surveyPersonDao.delSurveyPerson(id);
    }

    public void delAndSaveSurveyParent(String surveyId, String checkList) {
        surveyPersonDao.delSurveyPerson(surveyId);
        if (checkList.length() > 0) {
            String[] check = checkList.split("@");
            for (int i = 0; i < check.length; i++) {
                String a = check[i];
                String[] b = a.split(",");
                SurveyPerson surveyPerson = new SurveyPerson();
                surveyPerson.setId(CommonUtil.getUUID());
                surveyPerson.setPersonId(b[0].toString());
                surveyPerson.setPersonDept(b[1].toString());
                surveyPerson.setPersonType("3");
                surveyPerson.setAnswerFlag("0");
                surveyPerson.setSurveyId(surveyId);
                surveyPerson.setCreator(CommonUtil.getPersonId());
                surveyPerson.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
                surveyPersonDao.saveSurveyPerson(surveyPerson);
            }
        }
    }

    public String checkPersonBySurveyid(String id) {
        return  surveyPersonDao.checkPersonBySurveyid(id);
    }


}
