package com.goisan.educational.timetable.service.impl;


import com.goisan.educational.timetable.bean.TimeTableCourse;
import com.goisan.educational.timetable.dao.TimeTableCourseDao;
import com.goisan.educational.timetable.service.TimeTableCourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TimeTableCourseServiceImpl implements TimeTableCourseService {

    @Autowired
    private TimeTableCourseDao timeTableCourseDao;


    @Override
    public void saveTimeTableCourse(TimeTableCourse timeTableCourse) {
        timeTableCourseDao.saveTimeTableCourse(timeTableCourse);
    }

    @Override
    public void updateTimeTableCourse(TimeTableCourse timeTableCourse) {
        timeTableCourseDao.updateTimeTableCourse(timeTableCourse);
    }

    @Override
    public List<TimeTableCourse> getTimeTableCourseList(TimeTableCourse timeTableCourse) {
        return timeTableCourseDao.getTimeTableCourseList(timeTableCourse);
    }


    @Override
    public void deleteTimeTableCourse(String id) {
        timeTableCourseDao.deleteTimeTableCourse(id);
    }

    @Override
    public TimeTableCourse getTimeTableCourseById(String id) {
        return timeTableCourseDao.getTimeTableCourseById(id);
    }




}
