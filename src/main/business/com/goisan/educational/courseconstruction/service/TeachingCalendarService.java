package com.goisan.educational.courseconstruction.service;

import com.goisan.educational.courseconstruction.bean.TeachingCalendar;
import com.goisan.educational.courseconstruction.bean.TeachingCalendarDetails;
import com.goisan.educational.major.bean.Major;

import java.util.List;
import java.util.Map;

public interface TeachingCalendarService {

    List<TeachingCalendar> getTeachingCalendarList(TeachingCalendar teachingCalendar);

    void saveTeachingCalendar(TeachingCalendar teachingCalendar);

    void updateTeachingCalendar(TeachingCalendar teachingCalendar);

    void deleteTeachingCalendar(String id);

    TeachingCalendar getTeachingCalendarById(String id);

    Map<String, List<TeachingCalendarDetails[]>> getTeachingCalendarDetailsListByCalendarId(List<Map<String, Object>> classList, String id);

    List<Map<String, Object>> getClass(String id);

    List<Map<String, Object>> getMajor(String id);

    void deleteTeachingCalendarDetails(String id);

    void saveTeachingCalendarDetails(TeachingCalendarDetails teachingCalendarDetails);

    Major getMajorByCode(String code);
}
