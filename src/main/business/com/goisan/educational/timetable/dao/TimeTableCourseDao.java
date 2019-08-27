package com.goisan.educational.timetable.dao;

import com.goisan.educational.timetable.bean.TimeTable;
import com.goisan.educational.timetable.bean.TimeTableCourse;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TimeTableCourseDao {


    void saveTimeTableCourse(TimeTableCourse timeTableCourse);

    void updateTimeTableCourse(TimeTableCourse timeTableCourse);

    List<TimeTableCourse> getTimeTableCourseList(TimeTableCourse timeTableCourse);

    void deleteTimeTableCourse(String id);

    TimeTableCourse getTimeTableCourseById(String id);
}
