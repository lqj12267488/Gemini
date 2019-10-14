package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface OutCampusPraService {

    List<BaseBean> getOutCampusPraList(BaseBean baseBean);

    void saveOutCampusPra(BaseBean baseBean);

    BaseBean getOutCampusPraById(String id);

    void updateOutCampusPra(BaseBean baseBean);

    void delOutCampusPra(String id);

}