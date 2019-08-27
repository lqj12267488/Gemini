package com.goisan.educational.timetable.service.impl;


import com.goisan.educational.timetable.bean.TimeTable;
import com.goisan.educational.timetable.bean.TimeTableExcel;
import com.goisan.educational.timetable.dao.TimeTableDao;
import com.goisan.educational.timetable.service.TimeTableService;
import com.goisan.system.bean.Select2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TimeTableServiceImpl implements TimeTableService {

    @Autowired
    private TimeTableDao timeTableDao;


    @Override
    public List<TimeTable> getTimeTableByName(String name,String id) {
        return this.timeTableDao.getTimeTableByName(name,id);
    }

    @Override
    public void saveTimeTable(TimeTable timeTable) {
        timeTableDao.saveTimeTable(timeTable);
    }

    @Override
    public void updateTimeTable(TimeTable timeTable) {
        timeTableDao.updateTimeTable(timeTable);
    }

    @Override
    public List<TimeTable> getTimeTableList(TimeTable timeTable) {
        return timeTableDao.getTimeTableList(timeTable);
    }

    @Override
    public void deleteTimeTable(String id) {
        timeTableDao.deleteTimeTable(id);
    }

    @Override
    public TimeTable getTimeTableById(String id) {
        return timeTableDao.getTimeTableById(id);
    }

    @Override
    public List<TimeTableExcel> getTimeTableExcelList(String id) {
        return timeTableDao.getTimeTableExcelList(id);
    }
}
