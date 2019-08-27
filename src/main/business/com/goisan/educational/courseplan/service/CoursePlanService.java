package com.goisan.educational.courseplan.service;

import com.goisan.educational.courseplan.bean.CoursePlan;
import com.goisan.educational.courseplan.bean.CoursePlanDetail;
import com.goisan.educational.courseplan.bean.CoursePlanExcel;
import com.goisan.educational.courseplan.bean.CourseplanTerm;
import com.goisan.educational.textbook.bean.TextBook;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Select2;

import java.util.List;

public interface CoursePlanService {

    List<CoursePlan> selectList(CoursePlan coursePlan);

    void save(BaseBean baseBean);

    BaseBean selectById(String id);

    void update(BaseBean baseBean);

    void del(String id);

    List<CoursePlanDetail> getPlanDetails(CoursePlanDetail coursePlanDetail);

    CoursePlanDetail getPlanDetail(String id);

    void savePlanDetail(CoursePlanDetail coursePlanDetail);

    void updatePlanDetail(CoursePlanDetail coursePlanDetail);

    List<Select2> getTextbook();

    List<Select2> getCourse(String courseType);

    void delPlanDetail(String id);

    List getPlanTerms(CourseplanTerm courseplanTerm);

    void savePlanTerm(CourseplanTerm courseplanTerm);

    void updatePlanTerm(CourseplanTerm courseplanTerm);

    void delPlanTerm(String id);

    CourseplanTerm getPlanTerm(String id);

    List<String> getArrayClassCourseIdsPlanByCouesePlanId(String id);

    int checkPlanName(CoursePlan coursePlan);

    List<CoursePlanExcel> getCoursePlanExcelList(String planName);

}
