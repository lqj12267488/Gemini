package com.goisan.educational.timetable.service;

import com.goisan.educational.timetable.bean.TimeTable;
import com.goisan.educational.timetable.bean.TimeTableCourse;
import com.goisan.system.bean.Select2;

import java.util.List;

public interface TimeTableCourseService {

    void saveTimeTableCourse(TimeTableCourse timeTableCourse);

    void updateTimeTableCourse(TimeTableCourse timeTableCourse);

    List<TimeTableCourse> getTimeTableCourseList(TimeTableCourse timeTableCourse);

    void deleteTimeTableCourse(String id);

    TimeTableCourse getTimeTableCourseById(String id);
}
