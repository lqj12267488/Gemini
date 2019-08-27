package com.goisan.collection.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ResourceCollectionService {

    List<BaseBean> getResourceCollectionList(BaseBean baseBean);

    void saveResourceCollection(BaseBean baseBean);

    BaseBean getResourceCollectionById(String id);

    void updateResourceCollection(BaseBean baseBean);

    void delResourceCollection(String id);

}