package com.goisan.educational.timetable.service.impl;


import com.goisan.educational.timetable.bean.TimeTable;
import com.goisan.educational.timetable.bean.TimeTableSpecialPlace;
import com.goisan.educational.timetable.dao.TimeTableDao;
import com.goisan.educational.timetable.dao.TimeTableSpecialPlaceDao;
import com.goisan.educational.timetable.service.TimeTableService;
import com.goisan.educational.timetable.service.TimeTableSpecialPlaceService;
import com.goisan.system.bean.Select2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TimeTableSpecialPlaceServiceImpl implements TimeTableSpecialPlaceService {

    @Autowired
    private TimeTableSpecialPlaceDao timeTableSpecialPlaceDao;


    @Override
    public void saveTimeTableSpecialPlace(TimeTableSpecialPlace timeTableSpecialPlace) {
        timeTableSpecialPlaceDao.saveTimeTableSpecialPlace(timeTableSpecialPlace);
    }

    @Override
    public void updateTimeTableSpecialPlace(TimeTableSpecialPlace timeTableSpecialPlace) {
        timeTableSpecialPlaceDao.updateTimeTableSpecialPlace(timeTableSpecialPlace);
    }

    @Override
    public List<TimeTableSpecialPlace> getTimeTableSpecialPlaceList(TimeTableSpecialPlace timeTableSpecialPlace) {
        return timeTableSpecialPlaceDao.getTimeTableSpecialPlaceList(timeTableSpecialPlace);
    }

    @Override
    public void deleteTimeTableSpecialPlace(String id) {
        timeTableSpecialPlaceDao.deleteTimeTableSpecialPlace(id);
    }

    @Override
    public TimeTableSpecialPlace getTimeTableSpecialPlaceById(String id) {
        return timeTableSpecialPlaceDao.getTimeTableSpecialPlaceById(id);
    }

    @Override
    public List<Select2> getTimeTableSpecialPlaceList4Select() {
        return timeTableSpecialPlaceDao.getTimeTableSpecialPlaceList4Select();
    }
}
