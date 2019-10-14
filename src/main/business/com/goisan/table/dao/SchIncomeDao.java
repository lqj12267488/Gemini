package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface SchIncomeDao {

    List<BaseBean> getSchIncomeList(BaseBean baseBean);

    void saveSchIncome(BaseBean baseBean);

    BaseBean getSchIncomeById(String id);

    void updateSchIncome(BaseBean baseBean);

    void delSchIncome(String id);

}
