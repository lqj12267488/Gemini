package com.goisan.educational.place.classroom.service.impl;

import com.goisan.educational.place.classroom.bean.Classroom;
import com.goisan.educational.place.classroom.dao.ClassroomDao;
import com.goisan.educational.place.classroom.service.ClassroomService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**教室场地维护
 * Created by wq on 2017/7/15.
 */
@Service
public class ClassroomServiceImpl implements ClassroomService{
    @Resource
    ClassroomDao classroomDao;
    public List<Classroom> getClassroomList(Classroom classroom){
        return classroomDao.getClassroomList(classroom);
    }

    public Classroom getClassroomById(String id){
        return classroomDao.getClassroomById(id);
    }
    public void insertClassroom(Classroom classroom){
        classroomDao.insertClassroom(classroom);
    }
    public void updateClassroom(Classroom classroom){
        classroomDao.updateClassroom(classroom);
    }
    public void deleteClassroom(String id){
        classroomDao.deleteClassroom(id);
    }
    public List<AutoComplete> getPersonNameById(){
        return classroomDao.getPersonNameById();
    }
    public List<AutoComplete> getDeptNameById(){
        return classroomDao.getDeptNameById();
    }
    public List<Classroom> checkName(Classroom classroom) {
        return classroomDao.checkName(classroom);
    }
    public List<AutoComplete> selectClassroomName()  {
        return classroomDao.selectClassroomName();
    }
    public List<String> checkApplyClass(String id){return classroomDao.checkApplyClass(id);}
}
