package com.goisan.educational.arrayclass.dao;

import com.goisan.educational.arrayclass.bean.*;
import com.goisan.system.bean.BaseBean;

import java.util.List;

/**
 * Created by Zym on 2017/8/7 0013.
 */
public interface ArrayClassResultClassDao {

    /**
     * hanyue start
     */
    List<BaseBean> getArrayClassStudentClassList(BaseBean baseBean);
    List<StudentArrayClassLook> getArrayClassStudentClassByClass(ArrayClassStudent arrayClassStudent);
    List<ArrayClassTime> getArrayClassTimeByStudent(ArrayClassStudent arrayClassStudent);
    List<StudentArrayClassLook> selectArrayClassResultStudentList(StudentArrayClassLook studentArrayClassLook);
    StudentArrayClassLook selectArrayClassResultStudentById(String id);
    List<StudentArrayClassLook> selectResultStudentList();
    void insertStudentArrayClass(StudentArrayClassLook studentArrayClassLook);
    void deleteStudentArrayClass();
    boolean insertStudent();
    List<StudentArrayClassLook> selectResultStudent();
    String selectStudentName(String studentId);

    List<ArrayClassRoom> getArrayClassRoomPlaceList(ArrayClassRoom arrayClassRoom);
    List<ArrayclassResultClass> getArrayclassResultClassByPlace(ArrayClassRoom arrayClassRoom);
    List<ArrayClassTime> getArrayClassTimeByPlace(ArrayClassRoom arrayClassRoom);
    /**
     * hanyue end
     */


    /**
     * yangshuang start
     */

    List<ArrayClass> getArrayClassList(ArrayClass arrayClass);

    void delResultClass(ArrayclassResultClass resultClass);

    List<ArrayClassClass> getClassListByArrayClassId(ArrayClassClass arrayclassId);

    List<ArrayclassResultClass> getResultClass(ArrayclassResultClass resultClass);

    List<ArrayclassArray> getArrayclassArrayListByClass(ArrayClassClass arrayCalassClass);
    List<ArrayClassCondition> getArrayClassConditionByClass(ArrayClassClass arrayCalassClass);
    List<ArrayClassRoom> getArrayClassRoomByClass(ArrayClassClass arrayCalassClass);

    List<ArrayclassResultClass> getArrayclassResultClassByClass(ArrayClassClass arrayCalassClass);
    List<ArrayclassResultClass> getArrayclassResultClassOtherClass(ArrayClassClass arrayCalassClass);

    List<ArrayClassTime> geArrayClassTimeByClass(ArrayClassClass arrayCalassClass);

    void delClassResultByid(String id);

    void insertResultClass(ArrayclassResultClass arrayResultClass);

    void updateResultClass(ArrayclassResultClass arrayResultClass);

    List<StudentArrayClassLook> getArrayClassStudentClassByStudent(ArrayClassStudent arrayClassStudent);
    /**
     * yangshuang end
     */

    /**
     * 王强 start
     * @return
     */
    List<ArrayClassClass> getClassSyllabusList(ArrayClassClass arrayClassClass);
    List<ArrayclassResultClass> getClassSyllabusById(ArrayClassClass arrayClassClass);
    List<ArrayClassTime> getArrayClassTimeByClass(ArrayClassClass arrayClassClass);

    List<ArrayClassTeacher> getTeacherSyllabusList(ArrayClassTeacher arrayClassTeacher);
    List<ArrayclassResultClass> getTeacherSyllabusById(ArrayClassTeacher arrayClassTeacher);
    List<ArrayClassTime> getArrayClassTimeByTeacher(ArrayClassTeacher arrayClassTeacher);
    List<ArrayClass> getArrayClassTeacherList(StudentArrayClassLook studentArrayClassLook);
    List<String> getTeacherName(ArrayClassTeacher arrayClassTeacher);
    /**
     *王强 end
     * @return
     */


}
