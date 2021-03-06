package com.goisan.system.service;

import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Student;
import com.goisan.system.bean.StudentChangeLog;

import java.util.List;

/**
 * Created by admin on 2017/6/28.
 */
public interface StudentChangeLogService {

    List<StudentChangeLog> getStudentChangeLogList(StudentChangeLog studentChangeLog);

    Select2 getClassByStudentId(String personId);

    Select2 getStatusByStudentId(String personId);

    void saveLog(StudentChangeLog studentChangeLog);

    void updateStudentStatus(Student student);
    void updateReason(Student student);

    void updateGradStudentStatusByClass( String classId,String studentStatus);
    void updateNoGradStudentStatusByClass(String classId);

    List<StudentChangeLog> getStudentChangeStatisticsList(StudentChangeLog studentChangeLog);
}
