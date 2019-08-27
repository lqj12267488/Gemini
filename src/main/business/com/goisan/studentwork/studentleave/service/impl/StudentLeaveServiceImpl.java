package com.goisan.studentwork.studentleave.service.impl;

import com.goisan.studentwork.studentleave.bean.StudentLeave;
import com.goisan.studentwork.studentleave.dao.StudentLeaveDao;
import com.goisan.studentwork.studentleave.service.StudentLeaveService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class StudentLeaveServiceImpl implements StudentLeaveService {
    @Resource
    private StudentLeaveDao studentLeaveDao;
    public List<StudentLeave>getStudentLeaveList(StudentLeave studentLeave){return studentLeaveDao.getStudentLeaveList(studentLeave);}
    public void  insertStudentLeave(StudentLeave studentLeave){studentLeaveDao.insertStudentLeave(studentLeave);}
    public StudentLeave getStudentLeaveById(String id){return studentLeaveDao.getStudentLeaveById(id);}
    public void updateStudentLeaveById(StudentLeave studentLeave){studentLeaveDao.updateStudentLeaveById(studentLeave);}
    public void deleteStudentLeaveById(String id){studentLeaveDao.deleteStudentLeaveById(id);}
    public String getPersonNameById(String personId){return studentLeaveDao.getPersonNameById(personId);}
    public String getDeptNameById(String deptId){return studentLeaveDao.getDeptNameById(deptId);}
    public List<StudentLeave> getProcessList(StudentLeave studentLeave){return studentLeaveDao.getProcessList(studentLeave);}
    public List<AutoComplete>autoCompleteDept(StudentLeave studentLeave){return studentLeaveDao.autoCompleteDept(studentLeave);}
    public List<AutoComplete>autoCompleteEmployee(StudentLeave studentLeave){return studentLeaveDao.autoCompleteEmployee(studentLeave);}
    public   List<StudentLeave> getCompleteList(StudentLeave studentLeave){return studentLeaveDao.getCompleteList(studentLeave);}
    public  StudentLeave getLeaveBy(String id){return studentLeaveDao.getLeaveBy(id);}
    public   void updateStudentLeaveApp(StudentLeave studentLeave){studentLeaveDao.updateStudentLeaveApp(studentLeave);};

}
