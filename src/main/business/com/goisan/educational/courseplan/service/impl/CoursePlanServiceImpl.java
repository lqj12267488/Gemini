package com.goisan.educational.courseplan.service.impl;

import com.goisan.educational.courseplan.bean.CoursePlan;
import com.goisan.educational.courseplan.bean.CoursePlanDetail;
import com.goisan.educational.courseplan.bean.CoursePlanExcel;
import com.goisan.educational.courseplan.bean.CourseplanTerm;
import com.goisan.educational.courseplan.dao.CoursePlanDao;
import com.goisan.educational.courseplan.service.CoursePlanService;
import com.goisan.educational.textbook.bean.TextBook;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CoursePlanServiceImpl implements CoursePlanService {
    @Resource
    private CoursePlanDao coursePlanDao;

    public List<CoursePlan> selectList(CoursePlan coursePlan) {
        return coursePlanDao.selectList(coursePlan);
    }

    public void save(BaseBean baseBean) {
        coursePlanDao.save(baseBean);
    }

    public BaseBean selectById(String id) {
        return coursePlanDao.selectById(id);
    }

    public void update(BaseBean baseBean) {
        coursePlanDao.update(baseBean);
    }

    public void del(String id) {
        coursePlanDao.del(id);
    }

    public List<CoursePlanDetail> getPlanDetails(CoursePlanDetail coursePlanDetail) {
        return coursePlanDao.getPlanDetails(coursePlanDetail);
    }

    public CoursePlanDetail getPlanDetail(String id) {
        return coursePlanDao.getPlanDetail(id);
    }

    public void savePlanDetail(CoursePlanDetail coursePlanDetail) {
        coursePlanDao.savePlanDetail(coursePlanDetail);
    }

    public void updatePlanDetail(CoursePlanDetail coursePlanDetail) {
        coursePlanDao.updatePlanDetail(coursePlanDetail);
    }

    public List<Select2> getTextbook() {
        return coursePlanDao.getTextbook();
    }

    public List<Select2> getCourse(String courseType) {
        return coursePlanDao.getCourse(courseType);
    }

    public void delPlanDetail(String id) {
        coursePlanDao.delPlanDetail(id);
    }

    public List<CourseplanTerm> getPlanTerms(CourseplanTerm courseplanTerm) {
        return coursePlanDao.getPlanTerms(courseplanTerm);
    }

    public void savePlanTerm(CourseplanTerm courseplanTerm) {
        coursePlanDao.savePlanTerm(courseplanTerm);
    }

    public void updatePlanTerm(CourseplanTerm courseplanTerm) {
        coursePlanDao.updatePlanTerm(courseplanTerm);
    }

    public void delPlanTerm(String id) {
        coursePlanDao.delPlanTerm(id);
    }

    public CourseplanTerm getPlanTerm(String id) {
        return coursePlanDao.getPlanTerm(id);
    }

    @Override
    public List<String> getArrayClassCourseIdsPlanByCouesePlanId(String id) {
        return coursePlanDao.getArrayClassCourseIdsPlanByCouesePlanId(id);
    }

    public int checkPlanName(CoursePlan coursePlan) {
        return coursePlanDao.checkPlanName(coursePlan);
    }

    @Override
    public List<CoursePlanExcel> getCoursePlanExcelList(String planName) {
        return coursePlanDao.getCoursePlanExcelList(planName);
    }

}
