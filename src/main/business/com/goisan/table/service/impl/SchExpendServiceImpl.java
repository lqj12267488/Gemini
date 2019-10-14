package com.goisan.table.service.impl;

import com.goisan.table.dao.SchExpendDao;
import com.goisan.table.service.SchExpendService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SchExpendServiceImpl implements SchExpendService {

    @Resource
    private SchExpendDao schExpendDao;

    @Override
    public List<BaseBean> getSchExpendList(BaseBean baseBean) {
        return schExpendDao.getSchExpendList(baseBean);
    }

    @Override
    public void saveSchExpend(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        schExpendDao.saveSchExpend(baseBean);
    }

    @Override
    public BaseBean getSchExpendById(String id) {
        return schExpendDao.getSchExpendById(id);
    }

    @Override
    public void updateSchExpend(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        schExpendDao.updateSchExpend(baseBean);
    }

    @Override
    public void delSchExpend(String id) {
        schExpendDao.delSchExpend(id);
    }
}
