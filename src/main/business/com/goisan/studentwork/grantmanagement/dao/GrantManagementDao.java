package com.goisan.studentwork.grantmanagement.dao;

import com.goisan.studentwork.grantmanagement.bean.GrantManagement;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Student;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GrantManagementDao {
    List<GrantManagement> getGrantManagementList(GrantManagement grantManagement);

    void insertGrantManagement(GrantManagement grantManagement);

    GrantManagement getGrantManagementById(String id);

    void updateGrantManagementById(GrantManagement grantManagement);

    void deleteGrantManagementById(String id);

    String getPersonNameById(String personId);

    String getDeptNameById(String deptId);

    List<GrantManagement> getProcessList(GrantManagement grantManagement);

    List<AutoComplete> autoCompleteDept(GrantManagement grantManagement);

    List<AutoComplete> autoCompleteEmployee(GrantManagement grantManagement);

    List<GrantManagement> getCompleteList(GrantManagement grantManagement);

    GrantManagement getLeaveBy(String id);

    Student getStudentByStudentId(String studentId);

    List<GrantManagement> getGrantManagementSearchList(GrantManagement grantManagement);

    String getStudentId(String name);
}
