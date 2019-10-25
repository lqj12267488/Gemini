package com.goisan.table.service.impl;

import com.goisan.table.bean.GeneralConstruction;
import com.goisan.table.dao.GeneralConstructionDao;
import com.goisan.table.service.GeneralConstructionService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class GeneralConstructionServiceImpl implements GeneralConstructionService {

    @Resource
    private GeneralConstructionDao generalConstructionDao;

    @Override
    public List<BaseBean> getGeneralConstructionList(BaseBean baseBean) {
        return generalConstructionDao.getGeneralConstructionList(baseBean);
    }

    @Override
    public void saveGeneralConstruction(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        generalConstructionDao.saveGeneralConstruction(baseBean);
    }

    @Override
    public BaseBean getGeneralConstructionById(String id) {
        return generalConstructionDao.getGeneralConstructionById(id);
    }

    @Override
    public void updateGeneralConstruction(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        generalConstructionDao.updateGeneralConstruction(baseBean);
    }

    @Override
    public void delGeneralConstruction(String id) {
        generalConstructionDao.delGeneralConstruction(id);
    }

    @Override
    public List<GeneralConstruction> checkYear(GeneralConstruction generalConstruction) {
        return generalConstructionDao.checkYear(generalConstruction);
    }
}
