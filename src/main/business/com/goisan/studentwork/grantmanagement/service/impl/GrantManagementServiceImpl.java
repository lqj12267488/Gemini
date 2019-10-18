package com.goisan.studentwork.grantmanagement.service.impl;

import com.goisan.studentwork.grantmanagement.bean.GrantManagement;
import com.goisan.studentwork.grantmanagement.dao.GrantManagementDao;
import com.goisan.studentwork.grantmanagement.service.GrantManagementService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Student;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class GrantManagementServiceImpl implements GrantManagementService {
    @Resource
    private GrantManagementDao grantManagementDao;

    @Override
    public List<GrantManagement> getGrantManagementList(GrantManagement grantManagement) {
        List<GrantManagement> grantManagementList = grantManagementDao.getGrantManagementList(grantManagement);
        return grantManagementList;
    }

    @Override
    public void insertGrantManagement(GrantManagement grantManagement) {
        grantManagementDao.insertGrantManagement(grantManagement);
    }

    @Override
    public GrantManagement getGrantManagementById(String id) {
        return grantManagementDao.getGrantManagementById(id);
    }

    @Override
    public void updateGrantManagementById(GrantManagement grantManagement) {
        grantManagementDao.updateGrantManagementById(grantManagement);
    }

    @Override
    public void deleteGrantManagementById(String id) {
        grantManagementDao.deleteGrantManagementById(id);
    }

    @Override
    public String getPersonNameById(String personId) {
        return grantManagementDao.getPersonNameById(personId);
    }

    @Override
    public String getDeptNameById(String deptId) {
        return grantManagementDao.getDeptNameById(deptId);
    }

    @Override
    public List<GrantManagement> getProcessList(GrantManagement grantManagement) {
        return grantManagementDao.getProcessList(grantManagement);
    }

    @Override
    public List<AutoComplete> autoCompleteDept(GrantManagement grantManagement) {
        return grantManagementDao.autoCompleteDept(grantManagement);
    }

    @Override
    public List<AutoComplete> autoCompleteEmployee(GrantManagement grantManagement) {
        return grantManagementDao.autoCompleteEmployee(grantManagement);
    }

    @Override
    public List<GrantManagement> getCompleteList(GrantManagement grantManagement) {
        return grantManagementDao.getCompleteList(grantManagement);
    }

    @Override
    public GrantManagement getLeaveBy(String id) {
        return grantManagementDao.getLeaveBy(id);
    }

    @Override
    public Student getStudentByStudentId(String studentId) {
        Student studentByStudentId = grantManagementDao.getStudentByStudentId(studentId);
        return studentByStudentId;
    }

    @Override
    public List<GrantManagement> getGrantManagementSearchList(GrantManagement grantManagement) {
        return grantManagementDao.getGrantManagementSearchList(grantManagement);
    }

    @Override
    public String getStudentId(String name) {
       return grantManagementDao.getStudentId(name);
    }
}
