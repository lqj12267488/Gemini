package com.goisan.table.service.impl;

import com.goisan.table.dao.FixedAssetsDao;
import com.goisan.table.service.FixedAssetsService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class FixedAssetsServiceImpl implements FixedAssetsService {

    @Resource
    private FixedAssetsDao fixedAssetsDao;

    @Override
    public List<BaseBean> getFixedAssetsList(BaseBean baseBean) {
        return fixedAssetsDao.getFixedAssetsList(baseBean);
    }

    @Override
    public void saveFixedAssets(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        fixedAssetsDao.saveFixedAssets(baseBean);
    }

    @Override
    public BaseBean getFixedAssetsById(String id) {
        return fixedAssetsDao.getFixedAssetsById(id);
    }

    @Override
    public void updateFixedAssets(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        fixedAssetsDao.updateFixedAssets(baseBean);
    }

    @Override
    public void delFixedAssets(String id) {
        fixedAssetsDao.delFixedAssets(id);
    }
}
