package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface GeneralConstructionDao {

    List<BaseBean> getGeneralConstructionList(BaseBean baseBean);

    void saveGeneralConstruction(BaseBean baseBean);

    BaseBean getGeneralConstructionById(String id);

    void updateGeneralConstruction(BaseBean baseBean);

    void delGeneralConstruction(String id);

}
