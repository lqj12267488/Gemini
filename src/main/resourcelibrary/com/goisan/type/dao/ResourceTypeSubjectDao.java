package com.goisan.type.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ResourceTypeSubjectDao {

    List<BaseBean> getResourceTypeSubjectList(BaseBean baseBean);

    void saveResourceTypeSubject(BaseBean baseBean);

    BaseBean getResourceTypeSubjectById(String id);

    void updateResourceTypeSubject(BaseBean baseBean);

    void delResourceTypeSubject(String id);

    String checkTypeSubject(String id);
}
