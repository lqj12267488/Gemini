package com.goisan.synergy.disInspection.service.impl;

import com.goisan.synergy.disInspection.bean.DiAnswer;
import com.goisan.synergy.disInspection.bean.DiRemark;
import com.goisan.synergy.disInspection.dao.DiAnswerDao;
import com.goisan.synergy.disInspection.dao.DiRemarkDao;
import com.goisan.synergy.disInspection.service.DiRemarkService;
import com.goisan.system.dao.FilesDao;
import com.goisan.system.tools.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created  By hanjie ON 2019/9/4
 */
@Service
public class DiRemarkServiceImpl implements DiRemarkService {

    @Autowired
    private DiRemarkDao diRemarkDao;

    @Autowired
    private DiAnswerDao diAnswerDao;

    @Autowired
    private FilesDao filesDao;

    @Override
    public List<DiRemark> getDiRemarkList(DiRemark  diRemark) {
        return diRemarkDao.getDiRemarkList(diRemark);
    }

    @Override
    public DiRemark getDiRemarkById(String str) {
        return diRemarkDao.getDiRemarkById(str);
    }

    @Override
    public void insertDiRemark(DiRemark diRemark) {
        diRemark.setCreator(CommonUtil.getPersonId());
        diRemark.setCreateDept(CommonUtil.getDefaultDept());
        diRemarkDao.insertDiRemark(diRemark);
    }

    @Override
    public void updateArcadById(DiRemark diRemark) {
        diRemark.setChangeDept(CommonUtil.getDefaultDept());
        diRemark.setChanger(CommonUtil.getPersonId());
        diRemarkDao.updateArcadById(diRemark);

    }

    @Override
    @Transactional
    public void delDiRemarkById(DiRemark diRemark) {
        diRemark.setChangeDept(CommonUtil.getDefaultDept());
        diRemark.setChanger(CommonUtil.getPersonId());
        diRemarkDao.delDiRemarkById(diRemark);
        diAnswerDao.delDiAnswerByRemarkId(diRemark);
        filesDao.delFilesByBusinessId(diRemark.getRemarkId());
    }
}
