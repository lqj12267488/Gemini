package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ScholarshipMgeDao {

    List<BaseBean> getScholarshipMgeList(BaseBean baseBean);

    void saveScholarshipMge(BaseBean baseBean);

    BaseBean getScholarshipMgeById(String id);

    void updateScholarshipMge(BaseBean baseBean);

    void delScholarshipMge(String id);

}
