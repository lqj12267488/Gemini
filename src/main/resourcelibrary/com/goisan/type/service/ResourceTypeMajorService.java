package com.goisan.type.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ResourceTypeMajorService {

    List<BaseBean> getResourceTypeMajorList(BaseBean baseBean);

    void saveResourceTypeMajor(BaseBean baseBean);

    BaseBean getResourceTypeMajorById(String id);

    void updateResourceTypeMajor(BaseBean baseBean);

    void delResourceTypeMajor(String id);

    String checkTypeMajor(String id);
}