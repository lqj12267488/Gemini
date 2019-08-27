package com.goisan.educational.teachingplan.dao;

import com.goisan.educational.teachingplan.bean.TeachingPlanDetail;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface TeachingPlanDetailDao {

    List<BaseBean> selectList(BaseBean baseBean);

    void save(BaseBean baseBean);

    BaseBean selectById(String id);

    void update(BaseBean baseBean);

    void del(String id);

    TeachingPlanDetail getPlanName(String planId);

    List<TeachingPlanDetail> getTeachingPlanDetail(String id);
}
