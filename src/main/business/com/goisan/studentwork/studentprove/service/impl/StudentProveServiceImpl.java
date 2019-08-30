package com.goisan.studentwork.studentprove.service.impl;

import com.goisan.studentwork.studentprove.bean.StudentProve;
import com.goisan.studentwork.studentprove.dao.StudentProveDao;
import com.goisan.studentwork.studentprove.service.StudentProveService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Student;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class StudentProveServiceImpl implements StudentProveService {
    @Resource
    private StudentProveDao studentProveDao;

    public List<StudentProve> getStudentProveList(StudentProve studentProve) {
        return studentProveDao.getStudentProveList(studentProve);
    }

    public void insertStudentProve(StudentProve studentProve) {
        studentProveDao.insertStudentProve(studentProve);
    }

    public StudentProve getStudentProveById(String id) {
        return studentProveDao.getStudentProveById(id);
    }

    public void updateStudentProveById(StudentProve studentProve) {
        studentProveDao.updateStudentProveById(studentProve);
    }

    public void deleteStudentProveById(String id) {
        studentProveDao.deleteStudentProveById(id);
    }

    public String getPersonNameById(String personId) {
        return studentProveDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return studentProveDao.getDeptNameById(deptId);
    }

    public List<StudentProve> getProcessList(StudentProve studentProve) {
        return studentProveDao.getProcessList(studentProve);
    }

    public List<AutoComplete> autoCompleteDept(StudentProve studentProve) {
        return studentProveDao.autoCompleteDept(studentProve);
    }

    public List<AutoComplete> autoCompleteEmployee(StudentProve studentProve) {
        return studentProveDao.autoCompleteEmployee(studentProve);
    }

    public List<StudentProve> getCompleteList(StudentProve studentProve) {
        return studentProveDao.getCompleteList(studentProve);
    }

    public StudentProve getLeaveBy(String id) {
        return studentProveDao.getLeaveBy(id);
    }

    public Student getStudentByStudentId(String studentId){
        return studentProveDao.getStudentByStudentId(studentId);
    }
}
