package com.goisan.system.service.impl;

import com.goisan.educational.exam.bean.ExamCourseClass;
import com.goisan.educational.exam.dao.ExamDao;
import com.goisan.system.bean.ClassBean;
import com.goisan.system.bean.Student;
import com.goisan.system.dao.ClassDao;
import com.goisan.system.dao.StudentDao;
import com.goisan.system.service.ClassService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by admin on 2017/5/19.
 */
@Service
public class ClassServiceImpl implements ClassService {
    @Resource
    private ClassDao classDao;
    @Resource
    private StudentDao studentDao;
    @Resource
    private  ExamDao examDao;

    public  List<ClassBean> getClassByClass(ClassBean classBean){
        return classDao.getClassByClass(classBean);
    }

    public List<ClassBean> getClassList(ClassBean classBean){
        return classDao.getClassList(classBean);
    }

    public ClassBean getClassByClassid(String classId){
        return classDao.getClassByClassid(classId);
    }

    public void insertClass(ClassBean classBean){
        classDao.insertClass(classBean);
    }

    public void  updateClass(ClassBean classBean){
        classDao.updateClass(classBean);
    }

    public void delClass(String classId){
        classDao.delClass(classId);
    }

    public List<ClassBean> getClassListByStudentid(String studentid){
        return classDao.getClassListByStudentid(studentid);
    }

    public  List<ClassBean> findClassListByMajorCons(String departmentsId,String majorCode,String trainingLevel) {
        return classDao.findClassListByMajorCons(departmentsId,majorCode,trainingLevel);
    }

    @Override
    public ClassBean selectClassBeranByClassName(String className, String classType) {
        return classDao.selectClassBeranByClassName(className,classType);
    }

    @Override
    public int checkDeleteClass(String classId) {
        //删除班级校验是否有学生数据
        Student student=new Student();
        student.setClassId(classId);
        List<Student> studentList=studentDao.getStudentList(student);
        if(studentList.size()>0){
            return 1;
        }
        List<ExamCourseClass> examCourseClassList= examDao.findExamCourseListByClassId(classId);
        if(examCourseClassList.size()>0){
            return 2;
        }
        return 3;
    }
    @Override
    public List<Student> getStudentListByClassId(String classId){
       return classDao.getStudentListByClassId(classId);
    }
}
