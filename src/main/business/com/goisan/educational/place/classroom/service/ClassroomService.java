package com.goisan.educational.place.classroom.service;

import com.goisan.educational.place.classroom.bean.Classroom;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**教室场地维护
 * Created by wq on 2017/7/15.
 */
public interface ClassroomService {
    List<com.goisan.educational.place.classroom.bean.Classroom> getClassroomList(Classroom classroom);
    com.goisan.educational.place.classroom.bean.Classroom getClassroomById(String id);
    void insertClassroom(Classroom classroom);
    void updateClassroom(Classroom classroom);
    void deleteClassroom(String id);
    List<AutoComplete> getPersonNameById();
    List<AutoComplete> getDeptNameById();
    List<Classroom> checkName(Classroom classroom);
    List<AutoComplete> selectClassroomName();
    List<String> checkApplyClass(String id);
}
