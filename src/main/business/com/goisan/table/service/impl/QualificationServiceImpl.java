package com.goisan.table.service.impl;

import com.goisan.table.dao.QualificationDao;
import com.goisan.table.service.QualificationService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class QualificationServiceImpl implements QualificationService {

    @Resource
    private QualificationDao qualificationDao;

    @Override
    public List<BaseBean> getQualificationList(BaseBean baseBean) {
        return qualificationDao.getQualificationList(baseBean);
    }

    @Override
    public void saveQualification(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        qualificationDao.saveQualification(baseBean);
    }

    @Override
    public BaseBean getQualificationById(String id) {
        return qualificationDao.getQualificationById(id);
    }

    @Override
    public void updateQualification(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        qualificationDao.updateQualification(baseBean);
    }

    @Override
    public void delQualification(String id) {
        qualificationDao.delQualification(id);
    }

    @Override
    public List<Map> getQualificationBySelect() {
        return qualificationDao.getQualificationBySelect();
    }
}
