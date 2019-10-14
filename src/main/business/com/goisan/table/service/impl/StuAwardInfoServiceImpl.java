package com.goisan.table.service.impl;

import com.goisan.table.dao.StuAwardInfoDao;
import com.goisan.table.service.StuAwardInfoService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class StuAwardInfoServiceImpl implements StuAwardInfoService {

    @Resource
    private StuAwardInfoDao stuAwardInfoDao;

    @Override
    public List<BaseBean> getStuAwardInfoList(BaseBean baseBean) {
        return stuAwardInfoDao.getStuAwardInfoList(baseBean);
    }

    @Override
    public void saveStuAwardInfo(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        stuAwardInfoDao.saveStuAwardInfo(baseBean);
    }

    @Override
    public BaseBean getStuAwardInfoById(String id) {
        return stuAwardInfoDao.getStuAwardInfoById(id);
    }

    @Override
    public void updateStuAwardInfo(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        stuAwardInfoDao.updateStuAwardInfo(baseBean);
    }

    @Override
    public void delStuAwardInfo(String id) {
        stuAwardInfoDao.delStuAwardInfo(id);
    }
}
