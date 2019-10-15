package com.goisan.table.service.impl;

import com.goisan.table.bean.Associations;
import com.goisan.table.dao.AssociationsDao;
import com.goisan.table.service.AssociationsService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class AssociationsServiceImpl implements AssociationsService {

    @Resource
    private AssociationsDao associationsDao;

    @Override
    public List<Associations> getAssociationsList(BaseBean baseBean) {
        return associationsDao.getAssociationsList(baseBean);
    }

    @Override
    public void saveAssociations(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        associationsDao.saveAssociations(baseBean);
    }

    @Override
    public Associations getAssociationsById(String id) {
        return associationsDao.getAssociationsById(id);
    }

    @Override
    public void updateAssociations(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        associationsDao.updateAssociations(baseBean);
    }

    @Override
    public void delAssociations(String id) {
        associationsDao.delAssociations(id);
    }
}
