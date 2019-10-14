package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface SchIncomeService {

    List<BaseBean> getSchIncomeList(BaseBean baseBean);

    void saveSchIncome(BaseBean baseBean);

    BaseBean getSchIncomeById(String id);

    void updateSchIncome(BaseBean baseBean);

    void delSchIncome(String id);

}