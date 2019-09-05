package com.goisan.studentwork.studentreissue.service;

import com.goisan.studentwork.studentreissue.bean.StudentReissue;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

public interface StudentReissueService {
    List<StudentReissue> getStudentReissueList(StudentReissue studentReissue);

    void insertStudentReissue(StudentReissue studentReissue);

    StudentReissue getStudentReissueById(String id);

    void updateStudentReissueById(StudentReissue studentReissue);

    void deleteStudentReissueById(String id);

    String getPersonNameById(String personId);

    String getDeptNameById(String deptId);

    List<StudentReissue> getProcessList(StudentReissue studentReissue);

    List<StudentReissue> getCompleteList(StudentReissue studentReissue);

    StudentReissue getLeaveBy(String id);

    List<AutoComplete> autoCompleteDept();

    List<AutoComplete> autoCompleteEmployee();
}
