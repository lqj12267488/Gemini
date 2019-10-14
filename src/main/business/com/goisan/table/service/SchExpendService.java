package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface SchExpendService {

    List<BaseBean> getSchExpendList(BaseBean baseBean);

    void saveSchExpend(BaseBean baseBean);

    BaseBean getSchExpendById(String id);

    void updateSchExpend(BaseBean baseBean);

    void delSchExpend(String id);

}