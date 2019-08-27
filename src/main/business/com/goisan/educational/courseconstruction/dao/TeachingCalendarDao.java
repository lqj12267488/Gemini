package com.goisan.educational.courseconstruction.dao;

import com.goisan.educational.courseconstruction.bean.TeachingCalendar;
import com.goisan.educational.courseconstruction.bean.TeachingCalendarDetails;
import com.goisan.educational.major.bean.Major;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface TeachingCalendarDao {

    List<TeachingCalendar> getTeachingCalendarList(TeachingCalendar teachingCalendar);

    void saveTeachingCalendar(TeachingCalendar teachingCalendar);

    void updateTeachingCalendar(TeachingCalendar teachingCalendar);

    void deleteTeachingCalendar(String id);

    TeachingCalendar getTeachingCalendarById(String id);

    List<TeachingCalendarDetails> getTeachingCalendarDetailsListByCalendarId(String id);

    List<Map<String, Object>> getClass(String id);

    List<Map<String, Object>> getMajor(String id);

    void deleteTeachingCalendarDetails(String id);

    void saveTeachingCalendarDetails(TeachingCalendarDetails teachingCalendarDetails);

    Major getMajorByCode(String code);
}
