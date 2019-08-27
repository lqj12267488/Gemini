package com.goisan.educational.teachingplan.service;

import com.goisan.educational.teachingplan.bean.TeachingPlan;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Select2;

import java.util.List;

public interface TeachingPlanService {

    List<TeachingPlan> selectList(TeachingPlan baseBean);

    void save(BaseBean baseBean);

    BaseBean selectById(String id);

    void update(BaseBean baseBean);

    void del(String id);

    List<String> getClassNames(String classIds);

    List<TeachingPlan> getProcessList(TeachingPlan teachingPlan);

    List<TeachingPlan> getCompleteList(TeachingPlan teachingPlan);

    List<Select2> getCourseByMajor(String majorId);

    List<Select2> getTextbookByMajor(String majorId);

    TeachingPlan getTeachingPlan(String id);

    TeachingPlan getTeachingPlan1(String id);
}