package com.goisan.studentwork.studentgrants.dao;


import com.goisan.studentwork.studentgrants.bean.StudentGrants;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.ClassBean;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/7/28.
 */
@Repository
public interface StudentGrantsDao {
    List<StudentGrants> getStudentGrantsList(StudentGrants studentGrants);
    void insertStudentGrants(StudentGrants studentGrants);
    void updateStudentGrantsById(StudentGrants studentGrants);
    void deleteStudentGrantsById(String id);
    //回显,通过修改的id
    StudentGrants getStudentGrantsById(String id);
//    List<StudentGrants> getStudentGrantsListProcess(StudentGrants studentGrants);
    List<AutoComplete> selectDept();
    List<AutoComplete> selectPerson();
//    List<StudentGrants> getStudentGrantsListComplete(StudentGrants studentGrants);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
//    List<StudentGrants> getStudentGrantsByGrantsId(String id);
    List<Select2> getMajorCodeByDeptId(String deptId);
    List<Select2> getStudentByClassId(String classId);
//    List<Select2> getStudentId(String studentId);
    String getTrainingLevelByClassId(String classId);
}
