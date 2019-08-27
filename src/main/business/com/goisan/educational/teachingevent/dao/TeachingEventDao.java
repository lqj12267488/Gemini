package com.goisan.educational.teachingevent.dao;

import com.goisan.educational.teachingevent.bean.TeachingEvent;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by znw on 2017/7/13.
 */
@Repository
public interface TeachingEventDao {
    List<TeachingEvent> getTeachingEventList(TeachingEvent teachingEvent);
    void insertTeachingEvent(TeachingEvent teachingEvent);
    TeachingEvent getTeachingEventById(String id);
    void updateTeachingEventById(TeachingEvent teachingEvent);
    void deleteTeachingEventById(String id);
    List<TeachingEvent> getTeachingEventCountList(TeachingEvent teachingEvent);

}
