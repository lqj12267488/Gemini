package com.goisan.educational.timetable.service;

import com.goisan.educational.timetable.bean.TimeTable;
import com.goisan.educational.timetable.bean.TimeTableCourse;
import com.goisan.educational.timetable.bean.TimeTableDepartment;
import com.goisan.system.bean.Select2;

import java.util.List;

public interface TimeTableDepartmentService {

    void saveTimeTableDepartment(TimeTableDepartment timeTableDepartment);

    void updateTimeTableDepartment(TimeTableDepartment timeTableDepartment);

    List<TimeTableDepartment> getTimeTableDepartmentList(TimeTableDepartment timeTableDepartment);

    void deleteTimeTableDepartment(String id);

    TimeTableDepartment getTimeTableDepartmentById(String id);

    List<Select2> getMajorCodeByDeptId(String id);

    List<Select2> getClassIdByMajorCode(String id);
}
