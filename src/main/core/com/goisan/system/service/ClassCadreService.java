package com.goisan.system.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ClassCadreService {

    List<BaseBean> getClassCadreList(BaseBean baseBean);

    void saveClassCadre(BaseBean baseBean);

    BaseBean getClassCadreById(String id);

    void updateClassCadre(BaseBean baseBean);

    void delClassCadre(String id);

}