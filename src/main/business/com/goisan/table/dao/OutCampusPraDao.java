package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface OutCampusPraDao {

    List<BaseBean> getOutCampusPraList(BaseBean baseBean);

    void saveOutCampusPra(BaseBean baseBean);

    BaseBean getOutCampusPraById(String id);

    void updateOutCampusPra(BaseBean baseBean);

    void delOutCampusPra(String id);

}
