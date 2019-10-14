package com.goisan.table.service.impl;

import com.goisan.table.dao.InCampusPraDao;
import com.goisan.table.service.InCampusPraService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class InCampusPraServiceImpl implements InCampusPraService {

    @Resource
    private InCampusPraDao inCampusPraDao;

    @Override
    public List<BaseBean> getInCampusPraList(BaseBean baseBean) {
        return inCampusPraDao.getInCampusPraList(baseBean);
    }

    @Override
    public void saveInCampusPra(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        inCampusPraDao.saveInCampusPra(baseBean);
    }

    @Override
    public BaseBean getInCampusPraById(String id) {
        return inCampusPraDao.getInCampusPraById(id);
    }

    @Override
    public void updateInCampusPra(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        inCampusPraDao.updateInCampusPra(baseBean);
    }

    @Override
    public void delInCampusPra(String id) {
        inCampusPraDao.delInCampusPra(id);
    }
}
