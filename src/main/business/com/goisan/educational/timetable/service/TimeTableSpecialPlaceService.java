package com.goisan.educational.timetable.service;

import com.goisan.educational.timetable.bean.TimeTable;
import com.goisan.educational.timetable.bean.TimeTableSpecialPlace;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface TimeTableSpecialPlaceService {


    void saveTimeTableSpecialPlace(TimeTableSpecialPlace timeTableSpecialPlace);

    void updateTimeTableSpecialPlace(TimeTableSpecialPlace timeTableSpecialPlace);

    List<TimeTableSpecialPlace> getTimeTableSpecialPlaceList(TimeTableSpecialPlace timeTableSpecialPlace);

    void deleteTimeTableSpecialPlace(String id);

    TimeTableSpecialPlace getTimeTableSpecialPlaceById(String id);

    List<Select2> getTimeTableSpecialPlaceList4Select();
}
