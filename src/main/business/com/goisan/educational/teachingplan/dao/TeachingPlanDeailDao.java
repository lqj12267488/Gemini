package com.goisan.educational.teachingplan.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface TeachingPlanDeailDao {

    List<BaseBean> selectList(BaseBean baseBean);

    void save(BaseBean baseBean);

    BaseBean selectById(String id);

    void update(BaseBean baseBean);

    void del(String id);

}
