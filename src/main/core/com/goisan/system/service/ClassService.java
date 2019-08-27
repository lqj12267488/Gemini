package com.goisan.system.service;

import com.goisan.system.bean.ClassBean;
import com.goisan.system.bean.Student;

import java.util.List;

/**
 * Created by admin on 2017/5/19.
 */
public interface ClassService {
    List<ClassBean> getClassByClass(ClassBean classBean);

    List<ClassBean> getClassList(ClassBean classBean);

    ClassBean getClassByClassid(String classId);

    void insertClass(ClassBean classBean);

    void  updateClass(ClassBean classBean);

    void delClass(String classId);

    List<ClassBean> getClassListByStudentid(String studentid);

    List<ClassBean>findClassListByMajorCons(String departmentsId, String majorCode, String trainingLevel);

    ClassBean selectClassBeranByClassName(String className, String classType);

    int checkDeleteClass(String classId);

    List<Student> getStudentListByClassId(String classId);

}
