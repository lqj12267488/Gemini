package com.goisan.table.service.impl;

import com.goisan.table.dao.ContactInformationDao;
import com.goisan.table.service.ContactInformationService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ContactInformationServiceImpl implements ContactInformationService {

    @Resource
    private ContactInformationDao contactInformationDao;

    @Override
    public List<BaseBean> getContactInformationList(BaseBean baseBean) {
        return contactInformationDao.getContactInformationList(baseBean);
    }

    @Override
    public void saveContactInformation(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        contactInformationDao.saveContactInformation(baseBean);
    }

    @Override
    public BaseBean getContactInformationById(String id) {
        return contactInformationDao.getContactInformationById(id);
    }

    @Override
    public void updateContactInformation(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        contactInformationDao.updateContactInformation(baseBean);
    }

    @Override
    public void delContactInformation(String id) {
        contactInformationDao.delContactInformation(id);
    }
}
