package com.goisan.table.service.impl;

import com.goisan.table.dao.OutCampusPraDao;
import com.goisan.table.service.OutCampusPraService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class OutCampusPraServiceImpl implements OutCampusPraService {

    @Resource
    private OutCampusPraDao outCampusPraDao;

    @Override
    public List<BaseBean> getOutCampusPraList(BaseBean baseBean) {
        return outCampusPraDao.getOutCampusPraList(baseBean);
    }

    @Override
    public void saveOutCampusPra(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        outCampusPraDao.saveOutCampusPra(baseBean);
    }

    @Override
    public BaseBean getOutCampusPraById(String id) {
        return outCampusPraDao.getOutCampusPraById(id);
    }

    @Override
    public void updateOutCampusPra(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        outCampusPraDao.updateOutCampusPra(baseBean);
    }

    @Override
    public void delOutCampusPra(String id) {
        outCampusPraDao.delOutCampusPra(id);
    }
}
