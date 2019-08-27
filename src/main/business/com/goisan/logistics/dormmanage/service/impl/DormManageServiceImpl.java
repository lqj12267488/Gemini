package com.goisan.logistics.dormmanage.service.impl;

import com.goisan.logistics.dormmanage.bean.DormManage;
import com.goisan.logistics.dormmanage.bean.StudentDorm;
import com.goisan.logistics.dormmanage.bean.StudentPlanJob;
import com.goisan.logistics.dormmanage.bean.TeacherPlanJob;
import com.goisan.logistics.dormmanage.dao.DormManageDao;
import com.goisan.logistics.dormmanage.service.DormManageService;
import com.goisan.studentwork.studentrewardpunish.dao.StudentRewardPunishDao;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Student;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wq on 2017/9/20.
 */
@Service
public class DormManageServiceImpl implements DormManageService {
    @Resource
    private StudentRewardPunishDao studentRewardPunishDao;
    @Resource
    private DormManageDao dormManageDao;
    // 通过学生Id获取性别和身份证号
    public Student getStudentSexIdcardName(String studentId){
        return dormManageDao.getStudentSexIdcardName(studentId);
    }

    // 学校奖学金信息维护 2017/09/20
    public List<StudentDorm> getStudentDormList(StudentDorm studentDorm) {
        return dormManageDao.getStudentDormList(studentDorm);
    }

    @Override
    public void insertStudentDorm(StudentDorm studentDorm) {
        dormManageDao.insertStudentDorm(studentDorm);
    }

    @Override
    public StudentDorm getStudentDormById(StudentDorm studentDorm) {
        return dormManageDao.getStudentDormById(studentDorm);
    }

    @Override
    public void updateStudentDormById(StudentDorm studentDorm) {
        dormManageDao.updateStudentDormById(studentDorm);
    }

    @Override
    public void deleteStudentDormById(StudentDorm studentDorm) {
        dormManageDao.deleteStudentDormById(studentDorm);
    }

    @Override
    public List<StudentDorm> getStudentDormListLog(StudentDorm studentDorm) {
        return dormManageDao.getStudentDormListLog(studentDorm);
    }

    @Override
    public List<StudentDorm> getStudentPlanJobList(StudentPlanJob studentDorm) {
        return dormManageDao.getStudentPlanJobList(studentDorm);
    }

    @Override
    public void insertStudentPlanJob(StudentPlanJob studentDorm) {
        dormManageDao.insertStudentPlanJob(studentDorm);
    }

    @Override
    public StudentPlanJob getStudentPlanJobById(StudentPlanJob studentDorm) {
        return dormManageDao.getStudentPlanJobById(studentDorm);
    }

    @Override
    public void updateStudentPlanJobById(StudentPlanJob studentDorm) {
        dormManageDao.updateStudentPlanJobById(studentDorm);
    }

    @Override
    public void deleteStudentPlanJobById(StudentPlanJob studentDorm) {
        dormManageDao.deleteStudentPlanJobById(studentDorm);
    }

    @Override
    public List<TeacherPlanJob> getTeacherPlanJobList(TeacherPlanJob teacherPlanJob) {
        return dormManageDao.getTeacherPlanJobList(teacherPlanJob);
    }

    @Override
    public void insertTeacherPlanJob(TeacherPlanJob teacherPlanJob) {
        dormManageDao.insertTeacherPlanJob(teacherPlanJob);
    }

    @Override
    public TeacherPlanJob getTeacherPlanJobById(TeacherPlanJob teacherPlanJob) {
        return dormManageDao.getTeacherPlanJobById(teacherPlanJob);
    }

    @Override
    public void updateTeacherPlanJobById(TeacherPlanJob teacherPlanJob) {
        dormManageDao.updateTeacherPlanJobById(teacherPlanJob);
    }

    @Override
    public void deleteTeacherPlanJobById(TeacherPlanJob teacherPlanJob) {
        dormManageDao.deleteTeacherPlanJobById(teacherPlanJob);
    }

    @Override
    public List<DormManage> getDormManageList(DormManage dormManage) {
        return dormManageDao.getDormManageList(dormManage);
    }

    @Override
    public void insertDormManage(DormManage dormManage) {
        dormManageDao.insertDormManage(dormManage);
    }

    @Override
    public DormManage getDormManageById(DormManage dormManage) {
        return dormManageDao.getDormManageById(dormManage);
    }

    @Override
    public void updateDormManageById(DormManage dormManage) {
        dormManageDao.updateDormManageById(dormManage);
    }

    @Override
    public void deleteDormManageById(DormManage dormManage) {
        dormManageDao.deleteDormManageById(dormManage);
    }

    @Override
    public List<StudentDorm> checkStudentDorm(StudentDorm studentDorm) {
        return dormManageDao.checkStudentDorm(studentDorm);
    }

    @Override
    public List<StudentDorm> checkStudentDelete(StudentDorm studentDorm) {
        return dormManageDao.checkStudentDelete(studentDorm);
    }

    @Override
    public List<Select2> getStudentByClassIdNotDorm(String classId) {
        return dormManageDao.getStudentByClassIdNotDorm(classId);
    }

    @Override
    public void shiftShiftById(TeacherPlanJob teacherPlanJob) {
         dormManageDao.shiftShiftById(teacherPlanJob);
    }


}
