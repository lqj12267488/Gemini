package com.goisan.logistics.dormmanage.dao;

import com.goisan.logistics.dormmanage.bean.DormManage;
import com.goisan.logistics.dormmanage.bean.StudentDorm;
import com.goisan.logistics.dormmanage.bean.StudentPlanJob;
import com.goisan.logistics.dormmanage.bean.TeacherPlanJob;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Student;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wq on 2017/9/20.
 */
@Repository
public interface DormManageDao {
    Student getStudentSexIdcardName(String studentId);
   // 学生宿维护人员维护初始化方法 2018/03/08
    List<StudentDorm> getStudentDormList(StudentDorm studentDorm);
    //新增学生
    void insertStudentDorm(StudentDorm studentDorm);
    //修改回显
    StudentDorm getStudentDormById(StudentDorm studentDorm);
    //修改
    void updateStudentDormById(StudentDorm studentDorm);
    //删除人员
    void deleteStudentDormById(StudentDorm studentDorm);
    //删除人员日志
    List<StudentDorm> getStudentDormListLog(StudentDorm studentDorm);
 //学生排班菜单接口
    //学生排班菜单初始化方法
    List<StudentDorm> getStudentPlanJobList(StudentPlanJob studentDorm);
    //新增学生
     void insertStudentPlanJob(StudentPlanJob studentDorm);
     //修改回显
     StudentPlanJob getStudentPlanJobById(StudentPlanJob studentDorm);
    //修改
    void updateStudentPlanJobById(StudentPlanJob studentDorm);
    //删除人员
    void deleteStudentPlanJobById(StudentPlanJob studentDorm);
 //老师排班菜单接口
 //学生排班菜单初始化方法
    List<TeacherPlanJob> getTeacherPlanJobList(TeacherPlanJob teacherPlanJob);
    //新增学生
    void insertTeacherPlanJob(TeacherPlanJob teacherPlanJob);
    //修改回显
    TeacherPlanJob getTeacherPlanJobById(TeacherPlanJob teacherPlanJob);
    //修改
    void updateTeacherPlanJobById(TeacherPlanJob teacherPlanJob);
    //交班
    void shiftShiftById(TeacherPlanJob teacherPlanJob);
    //删除人员
    void deleteTeacherPlanJobById(TeacherPlanJob teacherPlanJob);
    //寝室管理菜单接口
    //寝室管理菜单初始化方法
    List<DormManage> getDormManageList(DormManage dormManage);
    //新增学生
    void insertDormManage(DormManage dormManage);
    //修改回显
    DormManage getDormManageById(DormManage dormManage);
    //修改
    void updateDormManageById(DormManage dormManage);
    //删除人员
    void deleteDormManageById(DormManage dormManage);
    //检查学生
    List<StudentDorm> checkStudentDorm(StudentDorm studentDorm);
    //删除学生校验
    List<StudentDorm> checkStudentDelete(StudentDorm studentDorm);
    List<Select2> getStudentByClassIdNotDorm(String classId);

}
