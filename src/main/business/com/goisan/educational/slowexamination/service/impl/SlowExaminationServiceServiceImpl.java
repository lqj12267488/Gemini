package com.goisan.educational.slowexamination.service.impl;

import com.goisan.educational.slowexamination.bean.SlowExamination;
import com.goisan.educational.slowexamination.dao.SlowExaminationDao;
import com.goisan.educational.slowexamination.service.SlowExaminationService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SlowExaminationServiceServiceImpl implements SlowExaminationService {
    @Resource
    private SlowExaminationDao slowExaminationDao;

    public List<SlowExamination> getSlowExaminationList(SlowExamination slowExamination) {
        return slowExaminationDao.getSlowExaminationList(slowExamination);
    }

    public String getPersonNameById(String personId) {
        return slowExaminationDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String defaultDept) {
        return slowExaminationDao.getDeptNameById(defaultDept);
    }

    public SlowExamination getSlowExaminationById(String id) {
        return slowExaminationDao.getSlowExaminationById(id);
    }

    public void insertSlowExamination(SlowExamination slowExamination) {
        slowExaminationDao.insertSlowExamination(slowExamination);
    }

    public void updateSlowExaminationById(SlowExamination slowExamination) {
        slowExaminationDao.updateSlowExaminationById(slowExamination);
    }

    public void deleteSlowExaminationById(String id) {
        slowExaminationDao.deleteSlowExaminationById(id);
    }

    public List<SlowExamination> slowExaminationProcessAction(SlowExamination slowExamination) {
        return slowExaminationDao.slowExaminationProcessAction(slowExamination);
    }

    public List<SlowExamination> slowExaminationCompleteAction(SlowExamination slowExamination) {
        return slowExaminationDao.slowExaminationCompleteAction(slowExamination);
    }

    public List<AutoComplete> selectDept() {
        return slowExaminationDao.selectDept();
    }

    public List<AutoComplete> selectPerson() {
        return slowExaminationDao.selectPerson();
    }

    public List checkCode(SlowExamination slowExamination) {
        return slowExaminationDao.checkCode(slowExamination);
    }

    public List checkName(SlowExamination slowExamination) {
        return slowExaminationDao.checkName(slowExamination);
    }

    public String getClassNameById(String personId) {
        return slowExaminationDao.getClassNameById(personId);
    }

    public String getMajorCodeById(String personId) {
        return slowExaminationDao.getMajorCodeById(personId);
    }

    public String getDeptIdById(String personId) {
        return slowExaminationDao.getDeptIdById(personId);
    }

    public String getClassIdById(String personId) {
        return slowExaminationDao.getClassIdById(personId);
    }

    @Override
    public List<Select2> getCourseSelect(SlowExamination slowExamination) {
        return slowExaminationDao.getCourseSelect(slowExamination);
    }
}
