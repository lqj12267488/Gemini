package com.goisan.personnel.teachManageinfo.service.impl;

import com.goisan.personnel.teachManageinfo.bean.TeachMgeInfo;
import com.goisan.personnel.teachManageinfo.dao.TeachMgeInfoDao;
import com.goisan.personnel.teachManageinfo.service.TeachMgeInfoService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TeachMgeInfoServiceImpl implements TeachMgeInfoService {

    @Resource
    private TeachMgeInfoDao teachMgeInfoDao;

    @Override
    public List<BaseBean> getTeachMgeInfoList(BaseBean baseBean) {
        return teachMgeInfoDao.getTeachMgeInfoList(baseBean);
    }

    @Override
    public void saveTeachMgeInfo(BaseBean baseBean) {
        TeachMgeInfo teachMgeInfo = (TeachMgeInfo) baseBean;
        BaseBean info = teachMgeInfoDao.getTeachMgeInfoByPersonId(teachMgeInfo.getPersonId());
        if (null == info){
            CommonUtil.save(baseBean);
            teachMgeInfoDao.saveTeachMgeInfo(baseBean);
        }else {
            CommonUtil.update(baseBean);
            teachMgeInfoDao.updateTeachMgeInfo(baseBean);
        }
    }

    @Override
    public BaseBean getTeachMgeInfoById(String id,String deptId) {
        return teachMgeInfoDao.getTeachMgeInfoById(id,deptId);
    }
}
