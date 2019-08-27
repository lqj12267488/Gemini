package com.goisan.studentwork.studentrewardpunish.service;

import com.goisan.studentwork.studentrewardpunish.bean.*;
import com.goisan.system.bean.Role;
import com.goisan.system.bean.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by wq on 2017/9/20.
 */
public interface StudentRewardPunishService {
    List<Role> getRoleByCurrentLogin(@Param("roleId") String roleId);
    Student getStudentSexIdcard(String studentId);
// 学校奖学金信息维护 2017/09/20
    List<SchoolBurse> getSchoolBurseList(SchoolBurse schoolBurse);
    SchoolBurse getSchoolBurseById(String id);
    void insertSchoolBurse(SchoolBurse schoolBurse);
    void updateSchoolBurseById(SchoolBurse schoolBurse);
    void deleteSchoolBurseById(String id);

// 政府奖学金信息维护 2017/09/20
    List<StateBurse> getStateBurseList(StateBurse stateBurse);
    StateBurse getStateBurseById(String id);
    void insertStateBurse(StateBurse stateBurse);
    void updateStateBurseById(StateBurse stateBurse);
    void deleteStateBurseById(String id);

    // 全日制奖学金信息维护 2017/09/20
    List<FullBurse> getFullBurseList(FullBurse fullBurse);
    FullBurse getFullBurseById(String id);
    void insertFullBurse(FullBurse fullBurse);
    void updateFullBurseById(FullBurse fullBurse);
    void deleteFullBurseById(String id);

    // 免学费信息维护 2017/09/20
    List<TuitionFree> getTuitionFreeList(TuitionFree tuitionFree);
    TuitionFree getTuitionFreeById(String id);
    void insertTuitionFree(TuitionFree tuitionFree);
    void updateTuitionFreeById(TuitionFree tuitionFree);
    void deleteTuitionFreeById(String id);

    // 学校助学金信息维护 2017/09/20
    List<Grants> getGrantsList(Grants grants);
    Grants getGrantsById(String id);
    void insertGrants(Grants grants);
    void updateGrantsById(Grants grants);
    void deleteGrantsById(String id);

    // 助学贷款信息维护 2017/09/20
    List<StudentLoan> getStudentLoanList(StudentLoan studentLoan);
    StudentLoan getStudentLoanById(String id);
    void insertStudentLoan(StudentLoan studentLoan);
    void updateStudentLoanById(StudentLoan studentLoan);
    void deleteStudentLoanById(String id);

    // 优秀学生干部信息维护 2017/09/20
    List<StudentCadres> getStudentCadresList(StudentCadres studentCadres);
    StudentCadres getStudentCadresById(String id);
    void insertStudentCadres(StudentCadres studentCadres);
    void updateStudentCadresById(StudentCadres studentCadres);
    void deleteStudentCadresById(String id);

    // 市三好班级信息维护 2017/09/20
    List<MiyoshiClass> getMiyoshiClassList(MiyoshiClass miyoshiClass);
    MiyoshiClass getMiyoshiClassById(String id);
    void insertMiyoshiClass(MiyoshiClass miyoshiClass);
    void updateMiyoshiClassById(MiyoshiClass miyoshiClass);
    void deleteMiyoshiClassById(String id);
    MiyoshiClass getHeadTeacherByClassId(String classId);

    //学生惩处信息维护
    List<StudentPunish> getStudentPunishList(StudentPunish studentPunish);
    StudentPunish getStudentPunishById(String id);
    void insertStudentPunish(StudentPunish studentPunish);
    void updateStudentPunishById(StudentPunish studentPunish);
    void deleteStudentPunishById(String id);
    StudentPunish getStudentCancelTime(String punishTime);
    StudentPunish getStudentCancelTime1(String punishTime);
    //学生惩处信息查询
    List<StudentPunish> getSelectStudentPunishList(StudentPunish studentPunish);
    //学生奖惩信息统计
    List<StudentPunish> getRewardPunishCountList(StudentPunish studentPunish);
}
