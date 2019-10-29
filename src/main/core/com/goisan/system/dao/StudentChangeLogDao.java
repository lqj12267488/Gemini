package com.goisan.system.dao;

import com.goisan.system.bean.EmpChangeLog;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Student;
import com.goisan.system.bean.StudentChangeLog;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by admin on 2017/6/28.
 */
@Repository
public interface StudentChangeLogDao {
    List<StudentChangeLog> getStudentChangeLogList(StudentChangeLog studentChangeLog);

    Select2 getClassByStudentId(String personId);

    Select2 getStatusByStudentId(String personId);

    void saveLog(StudentChangeLog studentChangeLog);

    void updateStudentStatus(Student student);
    void updateGradStudentStatusByClass(@Param("classId") String classId ,@Param("studentStatus") String studentStatus);
    void updateNoGradStudentStatusByClass(@Param("classId") String classId);
    void updateReason(Student student);

    List<StudentChangeLog> getStudentChangeStatisticsList(StudentChangeLog studentChangeLog);
}
