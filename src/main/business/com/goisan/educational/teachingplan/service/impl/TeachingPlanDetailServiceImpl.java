package com.goisan.educational.teachingplan.service.impl;

import com.goisan.educational.teachingplan.bean.TeachingPlanDetail;
import com.goisan.educational.teachingplan.dao.TeachingPlanDetailDao;
import com.goisan.educational.teachingplan.service.TeachingPlanDetailService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TeachingPlanDetailServiceImpl implements TeachingPlanDetailService {
@Resource
private TeachingPlanDetailDao teachingPlanDetailDao;

    public List<BaseBean> selectList(BaseBean baseBean) {
        return teachingPlanDetailDao.selectList(baseBean);
    }

    public void save(BaseBean baseBean) {
        teachingPlanDetailDao.save(baseBean);
    }

    public BaseBean selectById(String id) {
        return teachingPlanDetailDao.selectById(id);
    }

    public void update(BaseBean baseBean) {
        teachingPlanDetailDao.update(baseBean);
    }

    public void del(String id) {
        teachingPlanDetailDao.del(id);
    }

    public TeachingPlanDetail getPlanName(String planId) {
        return teachingPlanDetailDao.getPlanName(planId );
    }

    public List<TeachingPlanDetail> getTeachingPlanDetail(String id){ return teachingPlanDetailDao.getTeachingPlanDetail(id);}
}
