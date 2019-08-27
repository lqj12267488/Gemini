package com.goisan.studentwork.studentleave.service;

import com.goisan.studentwork.studentleave.bean.StudentLeave;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

public interface StudentLeaveService {
    List<StudentLeave> getStudentLeaveList(StudentLeave studentLeave);
    void insertStudentLeave(StudentLeave studentleave);
    public StudentLeave getStudentLeaveById(String id);
    void updateStudentLeaveById(StudentLeave studentLeave);
    void deleteStudentLeaveById(String id);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
    List<StudentLeave> getProcessList(StudentLeave studentLeave);
    List<AutoComplete>autoCompleteDept(StudentLeave studentLeave);
    List<AutoComplete>autoCompleteEmployee(StudentLeave studentLeave);
    List<StudentLeave> getCompleteList(StudentLeave studentLeave);
    StudentLeave getLeaveBy(String id);
    void updateStudentLeaveApp(StudentLeave studentLeave);
}
