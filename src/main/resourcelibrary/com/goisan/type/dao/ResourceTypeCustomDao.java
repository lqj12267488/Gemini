package com.goisan.type.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ResourceTypeCustomDao {

    List<BaseBean> getResourceTypeCustomList(BaseBean baseBean);

    void saveResourceTypeCustom(BaseBean baseBean);

    BaseBean getResourceTypeCustomById(String id);

    void updateResourceTypeCustom(BaseBean baseBean);

    void delResourceTypeCustom(String id);

    String checkTypeCustom(String id);
}
