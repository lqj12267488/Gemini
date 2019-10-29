package com.goisan.system.dao;

import com.goisan.system.bean.ClassBean;
import com.goisan.system.bean.Student;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by admin on 2017/5/19.
 */
@Repository
public interface ClassDao {
    List<ClassBean> getClassByClass(ClassBean classBean);

    List<ClassBean> getClassList(ClassBean classBean);

    ClassBean getClassByClassid(String classId);

    void insertClass(ClassBean classBean);

    void  updateClass(ClassBean classBean);

    void delClass(String classId);

    List<ClassBean> getClassListByStudentid(String studentid);

    List<ClassBean> findClassListByMajorCons(@Param("departmentsId") String departmentsId, @Param("majorCode") String
            majorCode, @Param("trainingLevel") String trainingLevel);

    ClassBean selectClassBeranByClassName(@Param("className")String className,@Param("classType")String classType);

    int checkDeleteClass(String classId);

    List<Student> getStudentListByClassId(String classId);

    List<Student> getZJStuListByClassId(@Param("classId")String classId);
    List<Student> getBYStuListByClassId(@Param("classId")String classId);
}
