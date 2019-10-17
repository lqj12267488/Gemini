package com.goisan.table.service.impl;

import com.goisan.table.bean.Cooperate;
import com.goisan.table.dao.CooperateDao;
import com.goisan.table.service.CooperateService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CooperateServiceImpl implements CooperateService {

    @Resource
    private CooperateDao cooperateDao;

    @Override
    public List<BaseBean> getCooperateList(BaseBean baseBean) {
        return cooperateDao.getCooperateList(baseBean);
    }

    @Override
    public void saveCooperate(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        cooperateDao.saveCooperate(baseBean);
    }

    @Override
    public Cooperate getCooperateById(String id) {
        return cooperateDao.getCooperateById(id);
    }

    @Override
    public void updateCooperate(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        cooperateDao.updateCooperate(baseBean);
    }

    @Override
    public void delCooperate(String id) {
        cooperateDao.delCooperate(id);
    }

    @Override
    public List<String> selectMajorName() {
        return cooperateDao.selectMajorName();
    }
}
