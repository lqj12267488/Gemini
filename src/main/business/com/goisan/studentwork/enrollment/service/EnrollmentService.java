package com.goisan.studentwork.enrollment.service;

import com.goisan.studentwork.enrollment.bean.Enrollment;
import com.goisan.studentwork.enrollment.bean.EnrollmentStudent;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Student;
import com.goisan.system.bean.SysDic;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/8/30.
 */
public interface EnrollmentService {
    List<Enrollment> getEnrollmentList(Enrollment enrollment);

    List<EnrollmentStudent> getStuEnrollmentList(EnrollmentStudent EnrollmentStudent);

    List<Enrollment> getMajorEnrollmentList(Enrollment enrollment);

    List<EnrollmentStudent> getEnrollmentStudentList(EnrollmentStudent enrollmentStudent);

//    EnrollmentStudent getDepartmentsId(EnrollmentStudent enrollmentStudent);

    List<EnrollmentStudent> getDistributeStudentList(EnrollmentStudent enrollmentStudent);

    void saveEnrollment(Enrollment enrollment);

    Enrollment selectEnrollmentByMajorId(String majorId,String year);

    void updateEnrollment(Enrollment enrollment);

    void updateBatchEnrollment(Enrollment enrollment);

    List<Enrollment> findEnrollmentListByIds(String major_id);

    EnrollmentStudent getEnrollmentStudentById(String studentId);

    List<EnrollmentStudent> findEnrollmentStudentListByIds(String ids);

    List<EnrollmentStudent> checkEnrollmentStudentListByIds(String ids);

    void delEnrollmentStudent(String studentId);

    List<EnrollmentStudent> checkEnrollmentIdCard(String idCard);

    void insertEnrollmentStudent(EnrollmentStudent enrollmentStudent);

    void updateEnrollmentStudent(EnrollmentStudent enrollmentStudent);

    void updateAllStuMaintain(EnrollmentStudent enrollmentStudent);

    void updateAllStuMaintainCancel(EnrollmentStudent enrollmentStudent);

    void doDistributeClasses(String ids,String deptId,String majorCode,String trainingLevel,String classId,String majorDirection);

    void doDistributeClass(String id,String deptId,String majorCode,String trainingLevel,String majorDirection,String classId);

    void updateEnrollmentRealNumberByConditions(Enrollment enrollment);

    String selectRealNumberByIds(String deptId, String majorCode,String trainingLevel, String majorDirection,String year);

    List<Enrollment> findOverYearsList(Enrollment enrollment);

    List<SysDic> findYearsList();

    List<EnrollmentStudent> getStudentInfoList(EnrollmentStudent enrollmentStudent);

    void deleteEnrollment(Enrollment enrollment);

    void batchDeleteEnrollment(Enrollment enrollment);

    EnrollmentStudent getStudentDetailsResultList(EnrollmentStudent enrollmentStudent);

    Map getEnrollmentStudent(EnrollmentStudent enrollmentStudent);
}
