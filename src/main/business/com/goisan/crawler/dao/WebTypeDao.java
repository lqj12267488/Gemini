package com.goisan.crawler.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface WebTypeDao {

    List<BaseBean> getWebTypeList(BaseBean baseBean);

    void saveWebType(BaseBean baseBean);

    BaseBean getWebTypeById(String id);

    void updateWebType(BaseBean baseBean);

    void delWebType(String id);

}
