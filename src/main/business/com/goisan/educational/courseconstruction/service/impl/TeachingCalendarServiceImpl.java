package com.goisan.educational.courseconstruction.service.impl;


import com.goisan.educational.courseconstruction.bean.TeachingCalendar;
import com.goisan.educational.courseconstruction.bean.TeachingCalendarDetails;
import com.goisan.educational.courseconstruction.dao.TeachingCalendarDao;
import com.goisan.educational.courseconstruction.service.TeachingCalendarService;
import com.goisan.educational.major.bean.Major;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TeachingCalendarServiceImpl implements TeachingCalendarService {

    @Autowired
    private TeachingCalendarDao teachingCalendarDao;

    @Override
    public List<TeachingCalendar> getTeachingCalendarList(TeachingCalendar teachingCalendar) {
        return teachingCalendarDao.getTeachingCalendarList(teachingCalendar);
    }

    @Override
    public void saveTeachingCalendar(TeachingCalendar teachingCalendar) {
        teachingCalendarDao.saveTeachingCalendar(teachingCalendar);
    }

    @Override
    public void updateTeachingCalendar(TeachingCalendar teachingCalendar) {
        teachingCalendarDao.updateTeachingCalendar(teachingCalendar);
    }

    @Override
    public void deleteTeachingCalendar(String id) {
        teachingCalendarDao.deleteTeachingCalendar(id);
    }

    @Override
    public TeachingCalendar getTeachingCalendarById(String id) {
        return teachingCalendarDao.getTeachingCalendarById(id);
    }

    @Override
    public Map<String, List<TeachingCalendarDetails[]>> getTeachingCalendarDetailsListByCalendarId(List<Map<String, Object>> classList, String id) {
        Map<String, Integer> classMap = new HashMap<>();
        for (Map<String, Object> map : classList) {
            Object rownum = map.get("ROWNUM");
            classMap.put((String) map.get("CLASS_ID"), Integer.parseInt(rownum.toString()));
        }
        List<TeachingCalendarDetails> detailsList = teachingCalendarDao.getTeachingCalendarDetailsListByCalendarId(id);
        Map<String, List<TeachingCalendarDetails[]>> content = new HashMap<>();
        for (TeachingCalendarDetails details : detailsList) {
            List<TeachingCalendarDetails[]> list;
            if (content.get(details.getMonth()) == null) {
                list = new ArrayList<>();
                content.put(details.getMonth(), list);
            } else {
                list = content.get(details.getMonth());
            }
            TeachingCalendarDetails[] rowTmp = null;
            boolean flag = true;
            for (TeachingCalendarDetails[] row : list) {
                if (details.getWeek().equals(row[1].getWeek())) {
                    rowTmp = row;
                    flag = false;
                    break;
                }
            }
            if (flag) {
                rowTmp = new TeachingCalendarDetails[classList.size() + 2];
                list.add(rowTmp);
            }
            rowTmp[0] = details;
            rowTmp[1] = details;
            if (classMap.get(details.getClassId()) != null) {
                rowTmp[classMap.get(details.getClassId()) + 1] = details;
            } else {

            }
        }
        return content;
    }

    @Override
    public List<Map<String, Object>> getClass(String id) {
        return teachingCalendarDao.getClass(id);
    }

    @Override
    public List<Map<String, Object>> getMajor(String id) {
        return teachingCalendarDao.getMajor(id);
    }

    @Override
    public void deleteTeachingCalendarDetails(String id) {
        teachingCalendarDao.deleteTeachingCalendarDetails(id);
    }

    @Override
    public void saveTeachingCalendarDetails(TeachingCalendarDetails teachingCalendarDetails) {
        String date = teachingCalendarDetails.getDate();
        if (date.contains("-")) {
            String[] split = date.split("-");
            teachingCalendarDetails.setDate(split[0] + "日-" + split[1] + "日");
        }
        teachingCalendarDao.saveTeachingCalendarDetails(teachingCalendarDetails);
    }

    @Override
    public Major getMajorByCode(String code) {
        return teachingCalendarDao.getMajorByCode(code);
    }
}
