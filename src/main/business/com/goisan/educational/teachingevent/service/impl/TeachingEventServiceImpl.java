package com.goisan.educational.teachingevent.service.impl;

import com.goisan.educational.teachingevent.bean.TeachingEvent;
import com.goisan.educational.teachingevent.dao.TeachingEventDao;
import com.goisan.educational.teachingevent.service.TeachingEventService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by znw on 2017/7/13.
 */
@Service
public class TeachingEventServiceImpl implements TeachingEventService {
    @Resource
    private TeachingEventDao teachingEventDao;

    public List<TeachingEvent> getTeachingEventList(TeachingEvent teachingEvent) {
        return teachingEventDao.getTeachingEventList(teachingEvent);
    }

    public void insertTeachingEvent(TeachingEvent teachingEvent) {
        teachingEventDao.insertTeachingEvent(teachingEvent);
    }

    public TeachingEvent getTeachingEventById(String id) {
        return teachingEventDao.getTeachingEventById(id);
    }

    public void updateTeachingEventById(TeachingEvent teachingEvent) {
        teachingEventDao.updateTeachingEventById(teachingEvent);
    }

    public void deleteTeachingEventById(String id) {
        teachingEventDao.deleteTeachingEventById(id);
    }

    public List<TeachingEvent> getTeachingEventCountList(TeachingEvent teachingEvent) {
        return teachingEventDao.getTeachingEventCountList(teachingEvent);
    }


}
