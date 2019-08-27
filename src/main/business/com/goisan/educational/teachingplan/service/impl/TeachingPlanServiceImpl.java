package com.goisan.educational.teachingplan.service.impl;

import com.goisan.educational.teachingplan.bean.TeachingPlan;
import com.goisan.educational.teachingplan.dao.TeachingPlanDao;
import com.goisan.educational.teachingplan.service.TeachingPlanService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TeachingPlanServiceImpl implements TeachingPlanService {
@Resource
private TeachingPlanDao teachingPlanDao;

    public List<TeachingPlan> selectList(TeachingPlan baseBean) {
        return teachingPlanDao.selectList(baseBean);
    }

    public void save(BaseBean baseBean) {
        teachingPlanDao.save(baseBean);
    }

    public BaseBean selectById(String id) {
        return teachingPlanDao.selectById(id);
    }

    public void update(BaseBean baseBean) {
        teachingPlanDao.update(baseBean);
    }

    public void del(String id) {
        teachingPlanDao.del(id);
    }

    public List<String> getClassNames(String classIds) {
        return teachingPlanDao.getClassNames(classIds);
    }

    public List<TeachingPlan> getProcessList(TeachingPlan teachingPlan){return teachingPlanDao.getProcessList(teachingPlan);}

    public List<TeachingPlan> getCompleteList(TeachingPlan teachingPlan){return teachingPlanDao.getCompleteList(teachingPlan);}

    public List<Select2> getCourseByMajor(String majorId){return teachingPlanDao.getCourseByMajor(majorId);}

    public List<Select2> getTextbookByMajor(String majorId){return teachingPlanDao.getTextbookByMajor(majorId);}

    public TeachingPlan getTeachingPlan(String id){ return teachingPlanDao.getTeachingPlan(id);}

    public TeachingPlan getTeachingPlan1(String id){return teachingPlanDao.getTeachingPlan1(id);}
}
