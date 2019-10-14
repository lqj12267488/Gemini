package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ScholarshipMgeService {

    List<BaseBean> getScholarshipMgeList(BaseBean baseBean);

    void saveScholarshipMge(BaseBean baseBean);

    BaseBean getScholarshipMgeById(String id);

    void updateScholarshipMge(BaseBean baseBean);

    void delScholarshipMge(String id);

}