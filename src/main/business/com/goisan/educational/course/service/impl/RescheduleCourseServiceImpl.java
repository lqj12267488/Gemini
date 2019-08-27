package com.goisan.educational.course.service.impl;

import com.goisan.educational.course.bean.RescheduleCourse;
import com.goisan.educational.course.dao.RescheduleCourseDao;
import com.goisan.educational.course.service.RescheduleCourseService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class RescheduleCourseServiceImpl implements RescheduleCourseService {

    @Resource
    private RescheduleCourseDao rescheduleCourseDao;

    @Override
    public List<RescheduleCourse> getRescheduleCourseList(RescheduleCourse rescheduleCourse) {
        return rescheduleCourseDao.getRescheduleCourseList(rescheduleCourse);
    }

    @Override
    public void insertRescheduleCourse(RescheduleCourse rescheduleCourse) {
        rescheduleCourseDao.insertRescheduleCourse(rescheduleCourse);
    }

    @Override
    public RescheduleCourse getRescheduleCourseById(RescheduleCourse rescheduleCourse) {
        return rescheduleCourseDao.getRescheduleCourseById(rescheduleCourse);
    }

    @Override
    public void updRescheduleCourseById(RescheduleCourse rescheduleCourse) {
        rescheduleCourseDao.updRescheduleCourseById(rescheduleCourse);
    }

    @Override
    public void delRescheduleCourseById(RescheduleCourse rescheduleCourse) {
        rescheduleCourseDao.delRescheduleCourseById(rescheduleCourse);
    }

    @Override
    public void updRCWithSubmit(RescheduleCourse rescheduleCourse) {
        rescheduleCourseDao.updRCWithSubmit(rescheduleCourse);
    }

    @Override
    public RescheduleCourse getApproveRCById(RescheduleCourse rescheduleCourse) {
        return rescheduleCourseDao.getApproveRCById(rescheduleCourse);
    }

    @Override
    public void updRCWithDeptApprove(RescheduleCourse rescheduleCourse) {
        rescheduleCourseDao.updRCWithDeptApprove(rescheduleCourse);
    }

    @Override
    public void updRCWithDeptOverrule(RescheduleCourse rescheduleCourse) {
        rescheduleCourseDao.updRCWithDeptOverrule(rescheduleCourse);
    }

    @Override
    public RescheduleCourse getMajorSchoolByDeptId(RescheduleCourse rescheduleCourse) {
        return rescheduleCourseDao.getMajorSchoolByDeptId(rescheduleCourse);
    }

    @Override
    public void updRCWithOfficeApprove(RescheduleCourse rescheduleCourse) {
        rescheduleCourseDao.updRCWithOfficeApprove(rescheduleCourse);
    }

    @Override
    public void updRCWithOfficeOverrule(RescheduleCourse rescheduleCourse) {
        rescheduleCourseDao.updRCWithOfficeOverrule(rescheduleCourse);
    }

    @Override
    public void updRCWithOfficeAndDeptOverrule(RescheduleCourse rescheduleCourse) {
        rescheduleCourseDao.updRCWithOfficeAndDeptOverrule(rescheduleCourse);
    }

    @Override
    public List<RescheduleCourse> getRCQueryList(RescheduleCourse rescheduleCourse) {
        return rescheduleCourseDao.getRCQueryList(rescheduleCourse);
    }

    @Override
    public RescheduleCourse toExcelRCById(RescheduleCourse rescheduleCourse) {
        return rescheduleCourseDao.toExcelRCById(rescheduleCourse);
    }

    @Override
    public String getTTKSPId(String tTKcode) {
        return rescheduleCourseDao.getTTKSPId(tTKcode);
    }

    @Override
    public void updRCWithOfficeSubmit(RescheduleCourse rescheduleCourse) {
            rescheduleCourseDao.updRCWithOfficeSubmit(rescheduleCourse);
    }

    @Override
    public void updRCWithOffOverNoDept(RescheduleCourse rescheduleCourse) {
        rescheduleCourseDao.updRCWithOffOverNoDept(rescheduleCourse);
    }

}
