package com.goisan.educational.timetable.dao;

import com.goisan.educational.timetable.bean.TimeTableCourse;
import com.goisan.educational.timetable.bean.TimeTableDepartment;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TimeTableDepartmentDao {


    void saveTimeTableDepartment(TimeTableDepartment timeTableDepartment);

    void updateTimeTableDepartment(TimeTableDepartment timeTableDepartment);

    List<TimeTableDepartment> getTimeTableDepartmentList(TimeTableDepartment timeTableDepartment);

    void deleteTimeTableDepartment(String id);

    TimeTableDepartment getTimeTableDepartmentById(String id);

    List<Select2> getMajorCodeByDeptId(String id);

    List<Select2> getClassIdByMajorCode(String id);
}
