package com.goisan.educational.teachingevent.service;

import com.goisan.educational.teachingevent.bean.TeachingEvent;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by znw on 2017/7/13.
 */
public interface TeachingEventService {
    List<TeachingEvent> getTeachingEventList(TeachingEvent teachingEvent);
    void insertTeachingEvent(TeachingEvent teachingEvent);
    TeachingEvent getTeachingEventById(String id);
    void updateTeachingEventById(TeachingEvent teachingEvent);
    void deleteTeachingEventById(String id);
    List<TeachingEvent> getTeachingEventCountList(TeachingEvent teachingEvent);

}
