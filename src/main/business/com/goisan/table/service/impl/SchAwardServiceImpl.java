package com.goisan.table.service.impl;

import com.goisan.table.dao.SchAwardDao;
import com.goisan.table.service.SchAwardService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SchAwardServiceImpl implements SchAwardService {

    @Resource
    private SchAwardDao schAwardDao;

    @Override
    public List<BaseBean> getSchAwardList(BaseBean baseBean) {
        return schAwardDao.getSchAwardList(baseBean);
    }

    @Override
    public void saveSchAward(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        schAwardDao.saveSchAward(baseBean);
    }

    @Override
    public BaseBean getSchAwardById(String id) {
        return schAwardDao.getSchAwardById(id);
    }

    @Override
    public void updateSchAward(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        schAwardDao.updateSchAward(baseBean);
    }

    @Override
    public void delSchAward(String id) {
        schAwardDao.delSchAward(id);
    }
}
