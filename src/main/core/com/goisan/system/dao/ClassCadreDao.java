package com.goisan.system.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ClassCadreDao {

    List<BaseBean> getClassCadreList(BaseBean baseBean);

    void saveClassCadre(BaseBean baseBean);

    BaseBean getClassCadreById(String id);

    void updateClassCadre(BaseBean baseBean);

    void delClassCadre(String id);

}
