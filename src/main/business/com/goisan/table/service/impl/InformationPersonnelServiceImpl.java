package com.goisan.table.service.impl;

import com.goisan.table.dao.InformationPersonnelDao;
import com.goisan.table.service.InformationPersonnelService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class InformationPersonnelServiceImpl implements InformationPersonnelService {

    @Resource
    private InformationPersonnelDao informationPersonnelDao;

    @Override
    public List<BaseBean> getInformationPersonnelList(BaseBean baseBean) {
        return informationPersonnelDao.getInformationPersonnelList(baseBean);
    }

    @Override
    public void saveInformationPersonnel(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        informationPersonnelDao.saveInformationPersonnel(baseBean);
    }

    @Override
    public BaseBean getInformationPersonnelById(String id) {
        return informationPersonnelDao.getInformationPersonnelById(id);
    }

    @Override
    public void updateInformationPersonnel(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        informationPersonnelDao.updateInformationPersonnel(baseBean);
    }

    @Override
    public void delInformationPersonnel(String id) {
        informationPersonnelDao.delInformationPersonnel(id);
    }
}
