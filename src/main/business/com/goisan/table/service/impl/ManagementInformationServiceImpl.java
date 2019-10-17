package com.goisan.table.service.impl;

import com.goisan.table.dao.ManagementInformationDao;
import com.goisan.table.service.ManagementInformationService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ManagementInformationServiceImpl implements ManagementInformationService {

    @Resource
    private ManagementInformationDao managementInformationDao;

    @Override
    public List<BaseBean> getManagementInformationList(BaseBean baseBean) {
        return managementInformationDao.getManagementInformationList(baseBean);
    }

    @Override
    public void saveManagementInformation(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        managementInformationDao.saveManagementInformation(baseBean);
    }

    @Override
    public BaseBean getManagementInformationById(String id) {
        return managementInformationDao.getManagementInformationById(id);
    }

    @Override
    public void updateManagementInformation(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        managementInformationDao.updateManagementInformation(baseBean);
    }

    @Override
    public void delManagementInformation(String id) {
        managementInformationDao.delManagementInformation(id);
    }
}
