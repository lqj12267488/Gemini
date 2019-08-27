package com.goisan.educational.timetable.dao;

import com.goisan.educational.timetable.bean.TimeTable;
import com.goisan.educational.timetable.bean.TimeTableExcel;
import com.goisan.system.bean.Select2;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TimeTableDao {


    List<TimeTable> getTimeTableByName(@Param("name")String name,@Param("id") String id);

    void saveTimeTable(TimeTable timeTable);

    void updateTimeTable(TimeTable timeTable);

    List<TimeTable> getTimeTableList(TimeTable timeTable);

    void deleteTimeTable(String id);

    TimeTable getTimeTableById(String id);

    List<TimeTableExcel> getTimeTableExcelList(String id);
}
