package com.goisan.table.service.impl;

import com.goisan.table.dao.QualificationTrainDao;
import com.goisan.table.service.QualificationTrainService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class QualificationTrainServiceImpl implements QualificationTrainService {

    @Resource
    private QualificationTrainDao qualificationTrainDao;

    @Override
    public List<BaseBean> getQualificationTrainList(BaseBean baseBean) {
        return qualificationTrainDao.getQualificationTrainList(baseBean);
    }

    @Override
    public void saveQualificationTrain(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        qualificationTrainDao.saveQualificationTrain(baseBean);
    }

    @Override
    public BaseBean getQualificationTrainById(String id) {
        return qualificationTrainDao.getQualificationTrainById(id);
    }

    @Override
    public void updateQualificationTrain(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        qualificationTrainDao.updateQualificationTrain(baseBean);
    }

    @Override
    public void delQualificationTrain(String id) {
        qualificationTrainDao.delQualificationTrain(id);
    }
}
