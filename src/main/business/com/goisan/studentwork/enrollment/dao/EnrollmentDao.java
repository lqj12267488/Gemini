package com.goisan.studentwork.enrollment.dao;

import com.goisan.studentwork.enrollment.bean.Enrollment;
import com.goisan.studentwork.enrollment.bean.EnrollmentStudent;
import com.goisan.system.bean.SysDic;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/8/30.
 */
@Repository
public interface EnrollmentDao {
    List<Enrollment> getEnrollmentList(Enrollment enrollment);

    List<EnrollmentStudent> getStuEnrollmentList(EnrollmentStudent enrollmentStudent);

    List<Enrollment> getMajorEnrollmentList(Enrollment enrollment);

    List<EnrollmentStudent> getEnrollmentStudentList(EnrollmentStudent enrollmentStudent);

//    EnrollmentStudent getDepartmentsId(EnrollmentStudent enrollmentStudent);

    List<EnrollmentStudent> getDistributeStudentList(EnrollmentStudent enrollmentStudent);

    void saveEnrollment(Enrollment enrollment);

    void updateEnrollment(Enrollment enrollment);

    Enrollment selectEnrollmentByMajorId(@Param("majorId")  String majorId,@Param("year") String year);

    void updateBatchEnrollment(Enrollment enrollment);

    List<Enrollment> findEnrollmentListByIds(String major_id);

    EnrollmentStudent getEnrollmentStudentById(String studentId);

    List<EnrollmentStudent> findEnrollmentStudentListByIds(@Param("ids") String ids);

    List<EnrollmentStudent> checkEnrollmentStudentListByIds(@Param("ids")  String ids);

    void delEnrollmentStudent(String studentId);

    List<EnrollmentStudent> checkEnrollmentIdCard(String idCard);

    void insertEnrollmentStudent(EnrollmentStudent enrollmentStudent);

    void updateEnrollmentStudent(EnrollmentStudent enrollmentStudent);

    void updateAllStuMaintain(EnrollmentStudent enrollmentStudent);

    void updateAllStuMaintainCancel(EnrollmentStudent enrollmentStudent);

    void doDistributeClasses(@Param("ids") String ids, @Param("deptId") String deptId, @Param("majorCode") String majorCode, @Param("trainingLevel") String trainingLevel, @Param("classId") String classId,@Param("majorDirection") String majorDirection);

    void doDistributeClass(@Param("id") String id, @Param("deptId") String deptId, @Param("majorCode") String majorCode, @Param("trainingLevel") String trainingLevel,  @Param("majorDirection") String majorDirection,@Param("classId") String classId);

    void updateEnrollmentRealNumberByConditions(Enrollment enrollment);

    String selectRealNumberByIds(@Param("deptId") String deptId,@Param("majorCode") String majorCode,@Param("trainingLevel") String trainingLevel,@Param("majorDirection") String majorDirection,@Param("year") String year);

    List<Enrollment> findOverYearsList(Enrollment enrollment);

    List<SysDic> findYearsList();

    List<EnrollmentStudent> getStudentInfoList(EnrollmentStudent enrollmentStudent);

    void deleteEnrollment(Enrollment enrollment);

    void batchDeleteEnrollment(Enrollment enrollment);

    EnrollmentStudent getStudentDetailsResultList(EnrollmentStudent enrollmentStudent);

    Map getEnrollmentStudent(EnrollmentStudent enrollmentStudent);
}
