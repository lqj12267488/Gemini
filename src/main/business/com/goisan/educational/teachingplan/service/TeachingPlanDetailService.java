package com.goisan.educational.teachingplan.service;

import com.goisan.educational.teachingplan.bean.TeachingPlanDetail;
import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface TeachingPlanDetailService {

    List<BaseBean> selectList(BaseBean baseBean);

    void save(BaseBean baseBean);

    BaseBean selectById(String id);

    void update(BaseBean baseBean);

    void del(String id);

    TeachingPlanDetail getPlanName(String planId);

    List<TeachingPlanDetail> getTeachingPlanDetail(String id);
}