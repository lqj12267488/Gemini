package com.goisan.studentwork.studentreissue.service.impl;

import com.goisan.studentwork.studentreissue.bean.StudentReissue;
import com.goisan.studentwork.studentreissue.dao.StudentReissueDao;
import com.goisan.studentwork.studentreissue.service.StudentReissueService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class StudentReissueServiceImpl implements StudentReissueService {
    @Resource
    private StudentReissueDao studentReissueDao;

   public List<StudentReissue> getStudentReissueList(StudentReissue studentReissue){
       return studentReissueDao.getStudentReissueList(studentReissue);
   }

   public void insertStudentReissue(StudentReissue studentReissue){
       studentReissueDao.insertStudentReissue(studentReissue);
   }

   public StudentReissue getStudentReissueById(String id){
       return studentReissueDao.getStudentReissueById(id);
   }

   public void updateStudentReissueById(StudentReissue studentReissue){
       studentReissueDao.updateStudentReissueById(studentReissue);
   }

   public void deleteStudentReissueById(String id){
       studentReissueDao.deleteStudentReissueById(id);
   }

   public String getPersonNameById(String personId){
       return studentReissueDao.getPersonNameById(personId);
   }

   public String getDeptNameById(String deptId){
       return studentReissueDao.getDeptNameById(deptId);
   }

   public List<StudentReissue> getProcessList(StudentReissue studentReissue){
       return studentReissueDao.getProcessList(studentReissue);
   }

   public List<StudentReissue> getCompleteList(StudentReissue studentReissue){
       return studentReissueDao.getCompleteList(studentReissue);
   }

   public StudentReissue getLeaveBy(String id){
       return studentReissueDao.getLeaveBy(id);
   }

   public  List<AutoComplete> autoCompleteDept(){ return studentReissueDao.autoCompleteDept(); }

   public  List<AutoComplete> autoCompleteEmployee(){ return studentReissueDao.autoCompleteEmployee(); }
}
