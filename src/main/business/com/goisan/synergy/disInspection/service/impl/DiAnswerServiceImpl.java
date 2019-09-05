package com.goisan.synergy.disInspection.service.impl;

import com.goisan.synergy.disInspection.bean.DiAnswer;
import com.goisan.synergy.disInspection.dao.DiAnswerDao;
import com.goisan.synergy.disInspection.service.DiAnswerService;
import com.goisan.system.tools.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created  By hanjie ON 2019/9/5
 */
@Service
public class DiAnswerServiceImpl implements DiAnswerService {

    @Autowired
    private DiAnswerDao diAnswerDao;
    @Override
    public List<DiAnswer> getDiAnswerList(DiAnswer diAnswer) {
        diAnswer.setAnswerPerson(CommonUtil.getPersonId());
        return diAnswerDao.getDiAnswerList(diAnswer);
    }

    @Override
    public void insertDiAnswer(DiAnswer diAnswer) {
        diAnswer.setCreateDept(CommonUtil.getDefaultDept());
        diAnswer.setCreator(CommonUtil.getPersonId());
        diAnswerDao.insertDiAnswer(diAnswer);
    }

    @Override
    public DiAnswer getDiAnswerByRemarkId(DiAnswer diAnswer) {
        diAnswer.setAnswerPerson(CommonUtil.getPersonId());
       return diAnswerDao.getDiAnswerByRemarkId(diAnswer);
    }

    @Override
    public List<DiAnswer> getDiReAnsList(DiAnswer diAnswer) {
        return diAnswerDao.getDiReAnsList(diAnswer);
    }
}
