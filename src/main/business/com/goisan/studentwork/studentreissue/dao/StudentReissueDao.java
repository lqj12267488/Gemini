package com.goisan.studentwork.studentreissue.dao;

import com.goisan.studentwork.studentreissue.bean.StudentReissue;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentReissueDao {
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
}
