package com.goisan.educational.timetable.service.impl;


import com.goisan.educational.timetable.bean.TimeTableCourse;
import com.goisan.educational.timetable.bean.TimeTableDepartment;
import com.goisan.educational.timetable.dao.TimeTableCourseDao;
import com.goisan.educational.timetable.dao.TimeTableDepartmentDao;
import com.goisan.educational.timetable.service.TimeTableCourseService;
import com.goisan.educational.timetable.service.TimeTableDepartmentService;
import com.goisan.system.bean.Select2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TimeTableDepartmentServiceImpl implements TimeTableDepartmentService {

    @Autowired
    private TimeTableDepartmentDao timeTableDepartmentDao;


    @Override
    public void saveTimeTableDepartment(TimeTableDepartment timeTableDepartment) {
        timeTableDepartmentDao.saveTimeTableDepartment(timeTableDepartment);
    }

    @Override
    public void updateTimeTableDepartment(TimeTableDepartment timeTableDepartment) {
        timeTableDepartmentDao.updateTimeTableDepartment(timeTableDepartment);
    }

    @Override
    public List<TimeTableDepartment> getTimeTableDepartmentList(TimeTableDepartment timeTableDepartment) {
        return timeTableDepartmentDao.getTimeTableDepartmentList(timeTableDepartment);
    }

    @Override
    public void deleteTimeTableDepartment(String id) {
        timeTableDepartmentDao.deleteTimeTableDepartment(id);
    }

    @Override
    public TimeTableDepartment getTimeTableDepartmentById(String id) {
        return timeTableDepartmentDao.getTimeTableDepartmentById(id);
    }

    @Override
    public List<Select2> getMajorCodeByDeptId(String id) {
        return timeTableDepartmentDao.getMajorCodeByDeptId(id);
    }

    @Override
    public List<Select2> getClassIdByMajorCode(String id) {
        return timeTableDepartmentDao.getClassIdByMajorCode(id);
    }
}
