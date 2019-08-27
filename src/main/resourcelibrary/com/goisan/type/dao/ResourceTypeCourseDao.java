package com.goisan.type.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ResourceTypeCourseDao {

    List<BaseBean> getResourceTypeCourseList(BaseBean baseBean);

    void saveResourceTypeCourse(BaseBean baseBean);

    BaseBean getResourceTypeCourseById(String id);

    void updateResourceTypeCourse(BaseBean baseBean);

    void delResourceTypeCourse(String id);

    String checkTypeCourse(String id);
}
