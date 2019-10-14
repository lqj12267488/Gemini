package com.goisan.table.service.impl;

import com.goisan.table.dao.ProEvaAgencyDao;
import com.goisan.table.service.ProEvaAgencyService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ProEvaAgencyServiceImpl implements ProEvaAgencyService {

    @Resource
    private ProEvaAgencyDao proEvaAgencyDao;

    @Override
    public List<BaseBean> getProEvaAgencyList(BaseBean baseBean) {
        return proEvaAgencyDao.getProEvaAgencyList(baseBean);
    }

    @Override
    public void saveProEvaAgency(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        proEvaAgencyDao.saveProEvaAgency(baseBean);
    }

    @Override
    public BaseBean getProEvaAgencyById(String id) {
        return proEvaAgencyDao.getProEvaAgencyById(id);
    }

    @Override
    public void updateProEvaAgency(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        proEvaAgencyDao.updateProEvaAgency(baseBean);
    }

    @Override
    public void delProEvaAgency(String id) {
        proEvaAgencyDao.delProEvaAgency(id);
    }
}
