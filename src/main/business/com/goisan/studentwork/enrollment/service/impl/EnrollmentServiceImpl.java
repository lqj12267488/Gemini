package com.goisan.studentwork.enrollment.service.impl;

import com.goisan.studentwork.enrollment.bean.Enrollment;
import com.goisan.studentwork.enrollment.bean.EnrollmentStudent;
import com.goisan.studentwork.enrollment.dao.EnrollmentDao;
import com.goisan.studentwork.enrollment.service.EnrollmentService;
import com.goisan.system.bean.*;
import com.goisan.system.dao.LoginUserDao;
import com.goisan.system.dao.StudentDao;
import com.goisan.system.tools.CommonUtil;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/8/30.
 */
@Service
@Transactional
public class EnrollmentServiceImpl implements EnrollmentService {
    @Resource
    private EnrollmentDao enrollmentDao;
    @Resource
    private StudentDao studentDao;
    @Resource
    private LoginUserDao loginUserDao;

    public List<Enrollment> getEnrollmentList(Enrollment enrollment) {
        return enrollmentDao.getEnrollmentList(enrollment);
    }

    public List<EnrollmentStudent> getStuEnrollmentList(EnrollmentStudent enrollmentStudent) {
        return enrollmentDao.getStuEnrollmentList(enrollmentStudent);
    }

    public List<Enrollment> getMajorEnrollmentList(Enrollment enrollment) {
        return enrollmentDao.getMajorEnrollmentList(enrollment);
    }


    public List<EnrollmentStudent> getEnrollmentStudentList(EnrollmentStudent enrollmentStudent) {
        return enrollmentDao.getEnrollmentStudentList(enrollmentStudent);
    }

//    public EnrollmentStudent getDepartmentsId(EnrollmentStudent enrollmentStudent) {
//        return enrollmentDao.getDepartmentsId(enrollmentStudent);
//    }

    public List<EnrollmentStudent> getDistributeStudentList(EnrollmentStudent enrollmentStudent) {
        return enrollmentDao.getDistributeStudentList(enrollmentStudent);
    }


    public void saveEnrollment(Enrollment enrollment) {
        enrollmentDao.saveEnrollment(enrollment);
    }

    public Enrollment selectEnrollmentByMajorId(String majorId, String year) {
        return enrollmentDao.selectEnrollmentByMajorId(majorId, year);
    }

    public void updateEnrollment(Enrollment enrollment) {
        enrollmentDao.updateEnrollment(enrollment);
    }

    public void updateBatchEnrollment(Enrollment enrollment) {
        enrollmentDao.updateBatchEnrollment(enrollment);
    }

    public List<Enrollment> findEnrollmentListByIds(String major_id) {
        return enrollmentDao.findEnrollmentListByIds(major_id);
    }

    public EnrollmentStudent getEnrollmentStudentById(String studentId) {
        return enrollmentDao.getEnrollmentStudentById(studentId);
    }

    public List<EnrollmentStudent> findEnrollmentStudentListByIds(String ids) {
        return enrollmentDao.findEnrollmentStudentListByIds(ids);
    }

    public List<EnrollmentStudent> checkEnrollmentStudentListByIds(String ids) {
        return enrollmentDao.checkEnrollmentStudentListByIds(ids);
    }

    public void delEnrollmentStudent(String studentId) {
        enrollmentDao.delEnrollmentStudent(studentId);
        //studentDao.delClassStudentRelation(studentId);
        //studentDao.delStudent(studentId);
        //loginUserDao.deleteStudentUserAcountByStudentId(studentId);
    }

    public List<EnrollmentStudent> checkEnrollmentIdCard(String idCard) {
        return enrollmentDao.checkEnrollmentIdCard(idCard);
    }

    public void insertEnrollmentStudent(EnrollmentStudent enrollmentStudent) {
        enrollmentDao.insertEnrollmentStudent(enrollmentStudent);
    }

    public void updateEnrollmentStudent(EnrollmentStudent enrollmentStudent) {
        enrollmentDao.updateEnrollmentStudent(enrollmentStudent);
    }


    public void updateAllStuMaintain(EnrollmentStudent enrollmentStudent) {
        enrollmentDao.updateAllStuMaintain(enrollmentStudent);
    }

    public void updateAllStuMaintainCancel(EnrollmentStudent enrollmentStudent) {
        enrollmentDao.updateAllStuMaintainCancel(enrollmentStudent);
    }

    //批量分班
    public void doDistributeClasses(String ids, String deptId, String majorCode, String trainingLevel, String
            classId, String majorDirection) {
        //更新登记学生记录表
        enrollmentDao.doDistributeClasses(ids, deptId, majorCode, trainingLevel, classId, majorDirection);
        List<Student> studentlist = studentDao.findStudentListByStudentId(ids);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
        String year = formatDate.format(new Date());
        String planNumber = enrollmentDao.selectRealNumberByIds(deptId, majorCode, trainingLevel, majorDirection, year);
        int newPlanNumber;
        if("".equals(planNumber) || null == planNumber){
            newPlanNumber = ids.split(",").length + 0;
        }else{
            newPlanNumber = ids.split(",").length + Integer.parseInt(planNumber);
        }

        //更新招生计划表
        Enrollment enrollment = new Enrollment();
        enrollment.setRealNumber(String.valueOf(newPlanNumber));
        enrollment.setTrainingLevel(trainingLevel);
        enrollment.setMajorCode(majorCode);
        enrollment.setDepartmentsId(deptId);
        enrollment.setMajorDirection(majorDirection);
        enrollmentDao.updateEnrollmentRealNumberByConditions(enrollment);
        List<EnrollmentStudent> list = enrollmentDao.findEnrollmentStudentListByIds(ids);
        if (studentlist.size() > 0) {
            //更新关系表
            ClassStudentRelation relation = new ClassStudentRelation();
            studentDao.batchUpdateRelation(ids, classId);
        } else {
            for (EnrollmentStudent enrollmentStudent : list) {
                //存学生表
                Student student = new Student();
                student.setStudentId(enrollmentStudent.getIdcard());
                student.setBirthday(enrollmentStudent.getBirthday());
                student.setHomePhone(enrollmentStudent.getHomePhone());
                student.setAddress(enrollmentStudent.getAddress());
                student.setNationality(enrollmentStudent.getNationality());
                student.setTel(enrollmentStudent.getTel());
                student.setNation(enrollmentStudent.getNation());
                student.setHouseholdRegisterPlace(enrollmentStudent.getHousePlace());
                student.setHouseProvince(enrollmentStudent.getHouseProvince());
                student.setHouseCity(enrollmentStudent.getHouseCity());
                student.setHouseCounty(enrollmentStudent.getHouseCounty());
                student.setHomePhone(enrollmentStudent.getHomePhone());
                student.setJoinYear(enrollmentStudent.getJoinYear());
                student.setJoinMonth(enrollmentStudent.getJoinMonth());
                student.setIdcard(enrollmentStudent.getIdcard());
                student.setName(enrollmentStudent.getName());
                student.setSex(enrollmentStudent.getSex());
                CommonUtil.save(student);
                studentDao.insertStudent(student);
                //存关系表
                ClassStudentRelation relation = new ClassStudentRelation();
                relation.setClassId(classId);
                relation.setStudentId(enrollmentStudent.getIdcard());
                CommonUtil.save(relation);
                studentDao.addRelation(relation);
                //存登录表
                LoginUser loginUser = new LoginUser();
                loginUser.setId(CommonUtil.getUUID());
                loginUser.setUserAccount(enrollmentStudent.getIdcard());
                loginUser.setPersonId(student.getStudentId());
                loginUser.setPassword((new SimpleHash("MD5", "123456", null, 1).toString()));
                loginUser.setUserType("1");
                loginUser.setCreateDept(CommonUtil.getDefaultDept());
                loginUser.setCreateTime(CommonUtil.getDate());
                loginUser.setCreator(CommonUtil.getPersonId());
                loginUser.setDefaultDeptId(student.getClassId());
                loginUser.setName(student.getName());
                loginUser.setIdCardPhotoUrl(enrollmentStudent.getIdCardPhotoUrl());
                loginUserDao.saveUser(loginUser);
            }
        }
    }

    //学生分班
    @Transactional
    public void doDistributeClass(String id, String deptId, String majorCode, String trainingLevel, String classId,
                                  String majorDirection) {
        //更新登记学生记录表
        enrollmentDao.doDistributeClass(id, deptId, majorCode, trainingLevel, majorDirection, classId);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
        String year = formatDate.format(new Date());
        String planNumber = enrollmentDao.selectRealNumberByIds(deptId, majorCode, trainingLevel, majorDirection, year);
        //更新招生计划表
        int newPlanNumber = 1 + Integer.parseInt(planNumber);
        Enrollment enrollment = new Enrollment();
        enrollment.setRealNumber(String.valueOf(newPlanNumber));
        enrollment.setTrainingLevel(trainingLevel);
        enrollment.setMajorCode(majorCode);
        enrollment.setDepartmentsId(deptId);
        enrollment.setMajorDirection(majorDirection);
        enrollment.setYear(year);
        enrollmentDao.updateEnrollmentRealNumberByConditions(enrollment);
        //校验学生表是否存在学生数据
        List<Student> list = studentDao.checkIdCard(id);
        if (list.size() > 0) {
            //更新学生班级关系表
            ClassStudentRelation relation = new ClassStudentRelation();
            relation.setClassId(classId);
            relation.setStudentId(id);
            studentDao.updateRelation(relation);

        } else {
            //存学生表
            EnrollmentStudent enrollmentStudent = enrollmentDao.getEnrollmentStudentById(id);
            Student student = new Student();
            student.setStudentId(enrollmentStudent.getIdcard());
            student.setBirthday(enrollmentStudent.getBirthday());
            student.setHomePhone(enrollmentStudent.getHomePhone());
            student.setAddress(enrollmentStudent.getAddress());
            student.setNationality(enrollmentStudent.getNationality());
            student.setTel(enrollmentStudent.getTel());
            student.setNation(enrollmentStudent.getNation());
            student.setHouseholdRegisterPlace(enrollmentStudent.getHousePlace());
            student.setHouseProvince(enrollmentStudent.getHouseProvince());
            student.setHouseCity(enrollmentStudent.getHouseCity());
            student.setHouseCounty(enrollmentStudent.getHouseCounty());
            student.setHomePhone(enrollmentStudent.getHomePhone());
            student.setJoinYear(enrollmentStudent.getJoinYear());
            student.setJoinMonth(enrollmentStudent.getJoinMonth());
            student.setIdcard(enrollmentStudent.getIdcard());
            student.setName(enrollmentStudent.getName());
            student.setSex(enrollmentStudent.getSex());
            CommonUtil.save(student);
            studentDao.insertStudent(student);
            //插入学生班级关系表
            ClassStudentRelation relation = new ClassStudentRelation();
            relation.setClassId(classId);
            relation.setStudentId(enrollmentStudent.getIdcard());
            CommonUtil.save(relation);
            studentDao.addRelation(relation);
            //存登录表
            LoginUser loginUser = new LoginUser();
            loginUser.setId(CommonUtil.getUUID());
            loginUser.setUserAccount(enrollmentStudent.getIdcard());
            loginUser.setPersonId(student.getStudentId());
            loginUser.setPassword((new SimpleHash("MD5", "123456", null, 1).toString()));
            loginUser.setUserType("1");
            loginUser.setCreateDept(CommonUtil.getDefaultDept());
            loginUser.setCreateTime(CommonUtil.getDate());
            loginUser.setCreator(CommonUtil.getPersonId());
            loginUser.setDefaultDeptId(student.getClassId());
            loginUser.setName(student.getName());
            loginUserDao.saveUser(loginUser);
        }


    }

    public void updateEnrollmentRealNumberByConditions(Enrollment enrollment) {
        enrollmentDao.updateEnrollmentRealNumberByConditions(enrollment);
    }

    public String selectRealNumberByIds(String deptId, String majorCode, String trainingLevel, String majorDirection,
                                        String year) {
        return enrollmentDao.selectRealNumberByIds(deptId, majorCode, trainingLevel, majorDirection, year);
    }

    public List<Enrollment> findOverYearsList(Enrollment enrollment) {
        return enrollmentDao.findOverYearsList(enrollment);

    }

    public List<SysDic> findYearsList() {
        return enrollmentDao.findYearsList();

    }

    public List<EnrollmentStudent> getStudentInfoList(EnrollmentStudent enrollmentStudent) {
        return enrollmentDao.getStudentInfoList(enrollmentStudent);
    }

    public void deleteEnrollment(Enrollment enrollment) {
        enrollmentDao.deleteEnrollment(enrollment);
    }

    public void batchDeleteEnrollment(Enrollment enrollment) {
        enrollmentDao.batchDeleteEnrollment(enrollment);
    }

    public EnrollmentStudent getStudentDetailsResultList(EnrollmentStudent enrollmentStudent){
        return enrollmentDao.getStudentDetailsResultList(enrollmentStudent);
    }

    public Map getEnrollmentStudent(EnrollmentStudent enrollmentStudent){
        Map map = new HashMap();
        EnrollmentStudent enrollment= enrollmentDao.getStudentDetailsResultList(enrollmentStudent);
            map.put("enrollment",enrollment);
        return map;
    }
}
