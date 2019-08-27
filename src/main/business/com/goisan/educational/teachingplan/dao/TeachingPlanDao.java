package com.goisan.educational.teachingplan.dao;

import com.goisan.educational.teachingplan.bean.TeachingPlan;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Select2;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;
@Repository
public interface TeachingPlanDao {

    List<TeachingPlan> selectList(TeachingPlan baseBean);

    void save(BaseBean baseBean);

    BaseBean selectById(String id);

    void update(BaseBean baseBean);

    void del(String id);

    List<String> getClassNames(@Param("classIds") String classIds);

    List<TeachingPlan> getProcessList(TeachingPlan teachingPlan);

    List<TeachingPlan> getCompleteList(TeachingPlan teachingPlan);

    List<Select2> getCourseByMajor(String majorId);

    List<Select2> getTextbookByMajor(String majorId);

    TeachingPlan getTeachingPlan(String id);

    TeachingPlan getTeachingPlan1(String id);
}
