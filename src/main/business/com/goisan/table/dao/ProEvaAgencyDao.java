package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ProEvaAgencyDao {

    List<BaseBean> getProEvaAgencyList(BaseBean baseBean);

    void saveProEvaAgency(BaseBean baseBean);

    BaseBean getProEvaAgencyById(String id);

    void updateProEvaAgency(BaseBean baseBean);

    void delProEvaAgency(String id);

}
