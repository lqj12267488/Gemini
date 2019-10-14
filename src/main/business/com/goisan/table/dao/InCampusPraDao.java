package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface InCampusPraDao {

    List<BaseBean> getInCampusPraList(BaseBean baseBean);

    void saveInCampusPra(BaseBean baseBean);

    BaseBean getInCampusPraById(String id);

    void updateInCampusPra(BaseBean baseBean);

    void delInCampusPra(String id);

}
