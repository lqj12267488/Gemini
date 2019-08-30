package com.goisan.studentwork.studentprove.service;

import com.goisan.studentwork.studentprove.bean.StudentProve;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Student;

import java.util.List;

public interface StudentProveService {
    List<StudentProve> getStudentProveList(StudentProve studentProve);

    void insertStudentProve(StudentProve studentProve);

    StudentProve getStudentProveById(String id);

    void updateStudentProveById(StudentProve studentProve);

    void deleteStudentProveById(String id);

    String getPersonNameById(String personId);

    String getDeptNameById(String deptId);

    List<StudentProve> getProcessList(StudentProve studentProve);

    List<AutoComplete> autoCompleteDept(StudentProve studentProve);

    List<AutoComplete> autoCompleteEmployee(StudentProve studentProve);

    List<StudentProve> getCompleteList(StudentProve studentProve);

    StudentProve getLeaveBy(String id);

    Student getStudentByStudentId(String studentId);
}
