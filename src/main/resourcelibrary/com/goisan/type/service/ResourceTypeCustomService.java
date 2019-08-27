package com.goisan.type.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ResourceTypeCustomService {

    List<BaseBean> getResourceTypeCustomList(BaseBean baseBean);

    void saveResourceTypeCustom(BaseBean baseBean);

    BaseBean getResourceTypeCustomById(String id);

    void updateResourceTypeCustom(BaseBean baseBean);

    void delResourceTypeCustom(String id);

    String checkTypeCustom(String id);
}