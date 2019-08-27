package com.goisan.educational.place.classroom.dao;

import com.goisan.educational.place.classroom.bean.Classroom;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

/**教室场地维护
 * Created by wq on 2017/7/15.
 */
@Repository
public interface ClassroomDao {
    List<Classroom> getClassroomList(Classroom classroom);
    Classroom getClassroomById(String id);
    void insertClassroom(Classroom classroom);
    void updateClassroom(Classroom classroom);
    void deleteClassroom(String id);
    List<AutoComplete> getPersonNameById();
    List<AutoComplete> getDeptNameById();
    List<Classroom> checkName(Classroom classroom);
    List<AutoComplete> selectClassroomName();
    List<String> checkApplyClass(String id);
}
