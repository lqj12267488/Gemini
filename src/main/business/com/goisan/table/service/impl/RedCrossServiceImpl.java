package com.goisan.table.service.impl;

import com.goisan.table.bean.RedCross;
import com.goisan.table.dao.RedCrossDao;
import com.goisan.table.service.RedCrossService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import com.sun.star.configuration.backend.BackendAccessException;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.UUID;

@Service
public class RedCrossServiceImpl implements RedCrossService {

    @Resource
    private RedCrossDao redCrossDao;

    @Override
    public List<BaseBean> getRedCrossList(BaseBean baseBean) {
        return redCrossDao.getRedCrossList(baseBean);
    }

    @Override
    public String  saveRedCross(RedCross baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        String id = UUID.randomUUID().toString();
        baseBean.setId(id);
        redCrossDao.saveRedCross(baseBean);
        return id;
    }

    @Override
    public BaseBean getRedCrossById(String id) {
        return redCrossDao.getRedCrossById(id);
    }

    @Override
    public void updateRedCross(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        redCrossDao.updateRedCross(baseBean);
    }

    @Override
    public void delRedCross(String id) {
        redCrossDao.delRedCross(id);
    }

    @Override
    public RedCross selectRedCross() {
        return redCrossDao.selectRedCross();
    }


}
