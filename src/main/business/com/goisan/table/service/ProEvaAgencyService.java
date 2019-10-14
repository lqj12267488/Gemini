package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ProEvaAgencyService {

    List<BaseBean> getProEvaAgencyList(BaseBean baseBean);

    void saveProEvaAgency(BaseBean baseBean);

    BaseBean getProEvaAgencyById(String id);

    void updateProEvaAgency(BaseBean baseBean);

    void delProEvaAgency(String id);

}