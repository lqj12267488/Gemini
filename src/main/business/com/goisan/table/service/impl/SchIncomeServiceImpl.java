package com.goisan.table.service.impl;

import com.goisan.table.dao.SchIncomeDao;
import com.goisan.table.service.SchIncomeService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SchIncomeServiceImpl implements SchIncomeService {

    @Resource
    private SchIncomeDao schIncomeDao;

    @Override
    public List<BaseBean> getSchIncomeList(BaseBean baseBean) {
        return schIncomeDao.getSchIncomeList(baseBean);
    }

    @Override
    public void saveSchIncome(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        schIncomeDao.saveSchIncome(baseBean);
    }

    @Override
    public BaseBean getSchIncomeById(String id) {
        return schIncomeDao.getSchIncomeById(id);
    }

    @Override
    public void updateSchIncome(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        schIncomeDao.updateSchIncome(baseBean);
    }

    @Override
    public void delSchIncome(String id) {
        schIncomeDao.delSchIncome(id);
    }
}
