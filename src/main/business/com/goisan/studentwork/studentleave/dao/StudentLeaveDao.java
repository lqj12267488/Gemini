package com.goisan.studentwork.studentleave.dao;

import com.goisan.studentwork.studentleave.bean.StudentLeave;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentLeaveDao {
    List<StudentLeave> getStudentLeaveList(StudentLeave studentLeave);
    void insertStudentLeave(StudentLeave studentLeave);
    StudentLeave getStudentLeaveById(String id);
    void updateStudentLeaveById(StudentLeave studentLeave);
    void deleteStudentLeaveById(String id);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
    List<StudentLeave>getProcessList(StudentLeave studentLeave);
    List<AutoComplete>autoCompleteDept(StudentLeave studentLeave);
    List<AutoComplete>autoCompleteEmployee(StudentLeave studentLeave);
    List<StudentLeave> getCompleteList(StudentLeave studentLeave);
    StudentLeave getLeaveBy(String id);
    void updateStudentLeaveApp(StudentLeave studentLeave);

}
