package com.goisan.educational.arrayclass.service.impl;

import com.goisan.educational.arrayclass.bean.*;
import com.goisan.educational.arrayclass.dao.ArrayClassResultClassDao;
import com.goisan.educational.arrayclass.service.ArrayClassResultClassService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ArrayClassResultClassServiceImpl implements ArrayClassResultClassService {
    @Resource
    private ArrayClassResultClassDao arrayClassResultClassDao;

    /**
     * hanyue start
     */
    public List<BaseBean> getArrayClassStudentClassList(BaseBean baseBean){
        return arrayClassResultClassDao.getArrayClassStudentClassList(baseBean);
    }
    public List<StudentArrayClassLook> getArrayClassStudentClassByClass(ArrayClassStudent arrayClassStudent){
        return arrayClassResultClassDao.getArrayClassStudentClassByClass(arrayClassStudent);
    }
    public List<ArrayClassTime> getArrayClassTimeByStudent(ArrayClassStudent arrayClassStudent){
        return arrayClassResultClassDao.getArrayClassTimeByStudent(arrayClassStudent);
    }
    public List<StudentArrayClassLook> selectArrayClassResultStudentList(StudentArrayClassLook studentArrayClassLook){
        return arrayClassResultClassDao.selectArrayClassResultStudentList(studentArrayClassLook);
    }
    public StudentArrayClassLook selectArrayClassResultStudentById(String id){
        return arrayClassResultClassDao.selectArrayClassResultStudentById(id);
    }
    public void insertStudentArrayClass(StudentArrayClassLook studentArrayClassLook){
        arrayClassResultClassDao.insertStudentArrayClass(studentArrayClassLook);
    }
    public boolean insertStudent(){
        List<StudentArrayClassLook> list1=arrayClassResultClassDao.selectResultStudentList();
        for(int i=0;i<list1.size();i++){
            arrayClassResultClassDao.insertStudentArrayClass(list1.get(i));
        }
        return true;
    }
    public List<StudentArrayClassLook> selectResultStudent(){
        return arrayClassResultClassDao.selectResultStudentList();
    }
    public void deleteStudentArrayClass(){
        arrayClassResultClassDao.deleteStudentArrayClass();
    }
    public List<StudentArrayClassLook> selectResultStudentList(){
        return arrayClassResultClassDao.selectResultStudentList();
    }
    public String selectStudentName(String studentId){
        return arrayClassResultClassDao.selectStudentName(studentId);
    }

    public List<ArrayClassRoom> getArrayClassRoomPlaceList(ArrayClassRoom arrayClassRoom){
        return arrayClassResultClassDao.getArrayClassRoomPlaceList(arrayClassRoom);
    }
    public List<ArrayclassResultClass> getArrayclassResultClassByPlace(ArrayClassRoom arrayClassRoom){
        return arrayClassResultClassDao.getArrayclassResultClassByPlace(arrayClassRoom);
    }
    public List<ArrayClassTime> getArrayClassTimeByPlace(ArrayClassRoom arrayClassRoom){
        return arrayClassResultClassDao.getArrayClassTimeByPlace(arrayClassRoom);
    }
    /**
     * hanyue end
     */


    /**
     * yangshuang start
     */

    public List<ArrayClass> getArrayClassList(ArrayClass arrayClass) {
        return arrayClassResultClassDao.getArrayClassList(arrayClass);
    }

    public void delResultClass(ArrayclassResultClass resultClass) {
        arrayClassResultClassDao.delResultClass(resultClass);
    }

    public List<ArrayClassClass> getClassListByArrayClassId(ArrayClassClass arrayclassId){
        return arrayClassResultClassDao.getClassListByArrayClassId(arrayclassId);
    }

    public List<ArrayclassResultClass> getResultClass(ArrayclassResultClass resultClass){
        return arrayClassResultClassDao.getResultClass(resultClass);
    }

    public List<ArrayclassArray> getArrayclassArrayListByClass(ArrayClassClass arrayCalassClass){
        return arrayClassResultClassDao.getArrayclassArrayListByClass(arrayCalassClass);
    }

    public List<ArrayClassCondition> getArrayClassConditionByClass(ArrayClassClass arrayCalassClass){
        return arrayClassResultClassDao.getArrayClassConditionByClass(arrayCalassClass);
    }

    public List<ArrayClassRoom> getArrayClassRoomByClass(ArrayClassClass arrayCalassClass){
        return arrayClassResultClassDao.getArrayClassRoomByClass(arrayCalassClass);
    }

    public List<ArrayclassResultClass> getArrayclassResultClassByClass(ArrayClassClass arrayCalassClass){
        return arrayClassResultClassDao.getArrayclassResultClassByClass(arrayCalassClass);
    }

    public List<ArrayclassResultClass> getArrayclassResultClassOtherClass(ArrayClassClass arrayCalassClass){
        return arrayClassResultClassDao.getArrayclassResultClassOtherClass(arrayCalassClass);
    }

    public List<ArrayClassTime> geArrayClassTimeByClass(ArrayClassClass arrayCalassClass){
        return arrayClassResultClassDao.geArrayClassTimeByClass(arrayCalassClass);
    }

    public void delClassResultByid(String id){
        arrayClassResultClassDao.delClassResultByid(id);
    }

    public void insertResultClass(ArrayclassResultClass arrayResultClass){
        arrayClassResultClassDao.insertResultClass(arrayResultClass);
    }

    public void updateResultClass(ArrayclassResultClass arrayResultClass){
        arrayClassResultClassDao.updateResultClass(arrayResultClass);
    }

    public List<StudentArrayClassLook> getArrayClassStudentClassByStudent(ArrayClassStudent arrayClassStudent){
        return arrayClassResultClassDao.getArrayClassStudentClassByStudent(arrayClassStudent);
    }

    /**
     * yangshuang end
     */

    /**
     * 王强 start
     * @return
     */
    public List<ArrayClassClass> getClassSyllabusList(ArrayClassClass arrayClassClass){
        return arrayClassResultClassDao.getClassSyllabusList(arrayClassClass);
    }
    public List<ArrayclassResultClass> getClassSyllabusById(ArrayClassClass arrayClassClass){
        return arrayClassResultClassDao.getClassSyllabusById(arrayClassClass);
    }
    public List<ArrayClassTime> getArrayClassTimeByClass(ArrayClassClass arrayClassClass){
        return arrayClassResultClassDao.getArrayClassTimeByClass(arrayClassClass);
    }

    public List<ArrayClassTeacher> getTeacherSyllabusList(ArrayClassTeacher arrayClassTeacher){
        return arrayClassResultClassDao.getTeacherSyllabusList(arrayClassTeacher);
    }
    public List<ArrayclassResultClass> getTeacherSyllabusById(ArrayClassTeacher arrayClassTeacher){
        return arrayClassResultClassDao.getTeacherSyllabusById(arrayClassTeacher);
    }
    public List<ArrayClassTime> getArrayClassTimeByTeacher(ArrayClassTeacher arrayClassTeacher){
        return arrayClassResultClassDao.getArrayClassTimeByTeacher(arrayClassTeacher);
    }
    public List<ArrayClass> getArrayClassTeacherList(StudentArrayClassLook studentArrayClassLook){
        return arrayClassResultClassDao.getArrayClassTeacherList(studentArrayClassLook);
    }
    public List<String> getTeacherName(ArrayClassTeacher arrayClassTeacher){
        return arrayClassResultClassDao.getTeacherName(arrayClassTeacher);
    }
    /**
     *王强 end
     * @return
     */

}
