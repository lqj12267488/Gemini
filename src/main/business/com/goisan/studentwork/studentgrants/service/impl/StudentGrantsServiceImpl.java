package com.goisan.studentwork.studentgrants.service.impl;

import com.goisan.studentwork.studentgrants.bean.StudentGrants;
import com.goisan.studentwork.studentgrants.dao.StudentGrantsDao;
import com.goisan.studentwork.studentgrants.service.StudentGrantsService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/7/28.
 */
@Service
public class StudentGrantsServiceImpl implements StudentGrantsService {
    @Resource
    private StudentGrantsDao studentGrantsDao;
    public List<StudentGrants> getStudentGrantsList(StudentGrants studentGrants){return studentGrantsDao.getStudentGrantsList(studentGrants);}
    public void insertStudentGrants(StudentGrants studentGrants){studentGrantsDao.insertStudentGrants(studentGrants);}
    public StudentGrants getStudentGrantsById(String id){return studentGrantsDao.getStudentGrantsById(id);}
    public void updateStudentGrantsById(StudentGrants studentGrants){studentGrantsDao.updateStudentGrantsById(studentGrants);}
    public void deleteStudentGrantsById(String id){studentGrantsDao.deleteStudentGrantsById(id);}
//    public List<StudentGrants> getStudentGrantsListProcess(StudentGrants studentGrants) {
//        return studentGrantsDao.getStudentGrantsListProcess(studentGrants);
//    }
    public List<AutoComplete> selectDept() {
        return studentGrantsDao.selectDept();
    }
    public List<AutoComplete> selectPerson() {
        return studentGrantsDao.selectPerson();
    }
//    public List<StudentGrants> getStudentGrantsListComplete(StudentGrants studentGrants) {
//        return studentGrantsDao.getStudentGrantsListComplete(studentGrants);
//    }

    public String getPersonNameById(String personId) {
        return  studentGrantsDao.getPersonNameById(personId);
    }
    public String getDeptNameById(String deptId) {
        return studentGrantsDao.getDeptNameById(deptId);
    }

//    public List<StudentGrants> getStudentGrantsByGrantsId(String id) {
//        return null;
//    }
//    public List<StudentGrants> getStudentGrantsByGrantsid(String id){
//        return studentGrantsDao.getStudentGrantsByGrantsId(id);
//    }
    public List<Select2> getMajorCodeByDeptId(String deptId) {
        return studentGrantsDao.getMajorCodeByDeptId(deptId);
    }

    public List<Select2> getStudentByClassId(String classId) {
        return studentGrantsDao.getStudentByClassId(classId);
    }

//    public List<Select2> getStudentId(String studentId) {
//        return studentGrantsDao.getStudentId(studentId);
//    }

    public String getTrainingLevelByClassId(String classId) {
        return studentGrantsDao.getTrainingLevelByClassId(classId);
    }
}
