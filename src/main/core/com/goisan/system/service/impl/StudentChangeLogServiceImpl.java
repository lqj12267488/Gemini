package com.goisan.system.service.impl;

import com.goisan.system.bean.EmpChangeLog;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Student;
import com.goisan.system.bean.StudentChangeLog;
import com.goisan.system.dao.StudentChangeLogDao;
import com.goisan.system.service.StudentChangeLogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by admin on 2017/6/28.
 */
@Service
public class StudentChangeLogServiceImpl implements StudentChangeLogService {
    @Resource
    private StudentChangeLogDao studentChangeLogDao;

   public List<StudentChangeLog> getStudentChangeLogList(StudentChangeLog studentChangeLog){
        return studentChangeLogDao.getStudentChangeLogList(studentChangeLog);
   }

   public Select2 getClassByStudentId(String personId){
        return studentChangeLogDao.getClassByStudentId(personId);
   }

   public Select2 getStatusByStudentId(String personId){
        return studentChangeLogDao.getStatusByStudentId(personId);
   }

    public void saveLog(StudentChangeLog studentChangeLog){
        studentChangeLogDao.saveLog(studentChangeLog);
    }

    public void updateStudentStatus(Student student){
        studentChangeLogDao.updateStudentStatus(student);
    }

    @Override
    public void updateReason(Student student) {
        studentChangeLogDao.updateReason(student);
    }

    @Override
    public void updateGradStudentStatusByClass(String classId,String studentStatus) {
        studentChangeLogDao.updateGradStudentStatusByClass(classId,studentStatus);
    }

    @Override
    public void updateNoGradStudentStatusByClass(String classId) {
        studentChangeLogDao.updateNoGradStudentStatusByClass(classId);
    }

    public List<StudentChangeLog> getStudentChangeStatisticsList(StudentChangeLog studentChangeLog) {
        return studentChangeLogDao.getStudentChangeStatisticsList(studentChangeLog);
    }

}
