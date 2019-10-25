package com.goisan.table.service.impl;

import com.goisan.table.bean.InstitutionalArea;
import com.goisan.table.dao.InstitutionalAreaDao;
import com.goisan.table.service.InstitutionalAreaService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class InstitutionalAreaServiceImpl implements InstitutionalAreaService {

    @Resource
    private InstitutionalAreaDao institutionalAreaDao;

    @Override
    public List<BaseBean> getInstitutionalAreaList(BaseBean baseBean) {
        return institutionalAreaDao.getInstitutionalAreaList(baseBean);
    }

    @Override
    public void saveInstitutionalArea(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        institutionalAreaDao.saveInstitutionalArea(baseBean);
    }

    @Override
    public BaseBean getInstitutionalAreaById(String id) {
        return institutionalAreaDao.getInstitutionalAreaById(id);
    }

    @Override
    public void updateInstitutionalArea(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        institutionalAreaDao.updateInstitutionalArea(baseBean);
    }

    @Override
    public void delInstitutionalArea(String id) {
        institutionalAreaDao.delInstitutionalArea(id);
    }

    @Override
    public List<InstitutionalArea> checkYear(InstitutionalArea institutionalArea) {
        return institutionalAreaDao.checkYear(institutionalArea);
    }
}
