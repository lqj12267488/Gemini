package com.goisan.studentwork.studentrewardpunish.service.impl;

import com.goisan.studentwork.studentrewardpunish.bean.*;
import com.goisan.studentwork.studentrewardpunish.dao.StudentRewardPunishDao;
import com.goisan.studentwork.studentrewardpunish.service.StudentRewardPunishService;
import com.goisan.system.bean.Role;
import com.goisan.system.bean.Student;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wq on 2017/9/20.
 */
@Service
public class StudentRewardPunishServiceImpl implements StudentRewardPunishService {
    @Resource
    private StudentRewardPunishDao studentRewardPunishDao;

    public List<Role> getRoleByCurrentLogin(String roleId){
        return studentRewardPunishDao.getRoleByCurrentLogin(roleId);
    }

    // 通过学生Id获取性别和身份证号
    public Student getStudentSexIdcard(String studentId){
        return studentRewardPunishDao.getStudentSexIdcard(studentId);
    }
// 学校奖学金信息维护 2017/09/20
    public List<SchoolBurse> getSchoolBurseList(SchoolBurse schoolBurse){
        return studentRewardPunishDao.getSchoolBurseList(schoolBurse);
    }
    public SchoolBurse getSchoolBurseById(String id){
        return studentRewardPunishDao.getSchoolBurseById(id);
    }
    public void insertSchoolBurse(SchoolBurse schoolBurse){
        studentRewardPunishDao.insertSchoolBurse(schoolBurse);
    }
    public void updateSchoolBurseById(SchoolBurse schoolBurse){
        studentRewardPunishDao.updateSchoolBurseById(schoolBurse);
    }
    public void deleteSchoolBurseById(String id){
        studentRewardPunishDao.deleteSchoolBurseById(id);
    }

    // 政府奖学金信息维护 2017/09/20
    public List<StateBurse> getStateBurseList(StateBurse stateBurse){
        return studentRewardPunishDao.getStateBurseList(stateBurse);
    }
    public StateBurse getStateBurseById(String id){
        return studentRewardPunishDao.getStateBurseById(id);
    }
    public void insertStateBurse(StateBurse stateBurse){
        studentRewardPunishDao.insertStateBurse(stateBurse);
    }
    public void updateStateBurseById(StateBurse stateBurse){
        studentRewardPunishDao.updateStateBurseById(stateBurse);
    }
    public void deleteStateBurseById(String id){
        studentRewardPunishDao.deleteStateBurseById(id);
    }

    // 全日制奖学金信息维护 2017/09/20
    public List<FullBurse> getFullBurseList(FullBurse fullBurse){
        return studentRewardPunishDao.getFullBurseList(fullBurse);
    }
    public FullBurse getFullBurseById(String id){
        return studentRewardPunishDao.getFullBurseById(id);
    }
    public void insertFullBurse(FullBurse fullBurse){
        studentRewardPunishDao.insertFullBurse(fullBurse);
    }
    public void updateFullBurseById(FullBurse fullBurse){
        studentRewardPunishDao.updateFullBurseById(fullBurse);
    }
    public void deleteFullBurseById(String id){
        studentRewardPunishDao.deleteFullBurseById(id);
    }

    // 免学费信息维护 2017/09/20
    public List<TuitionFree> getTuitionFreeList(TuitionFree tuitionFree){
        return studentRewardPunishDao.getTuitionFreeList(tuitionFree);
    }
    public TuitionFree getTuitionFreeById(String id){
        return studentRewardPunishDao.getTuitionFreeById(id);
    }
    public void insertTuitionFree(TuitionFree tuitionFree){
        studentRewardPunishDao.insertTuitionFree(tuitionFree);
    }
    public void updateTuitionFreeById(TuitionFree tuitionFree){
        studentRewardPunishDao.updateTuitionFreeById(tuitionFree);
    }
    public void deleteTuitionFreeById(String id){
        studentRewardPunishDao.deleteTuitionFreeById(id);
    }

    // 学校助学金信息维护 2017/09/20
    public List<Grants> getGrantsList(Grants grants){
        return studentRewardPunishDao.getGrantsList(grants);
    }
    public Grants getGrantsById(String id){
        return studentRewardPunishDao.getGrantsById(id);
    }
    public void insertGrants(Grants grants){
        studentRewardPunishDao.insertGrants(grants);
    }
    public void updateGrantsById(Grants grants){
        studentRewardPunishDao.updateGrantsById(grants);
    }
    public void deleteGrantsById(String id){
        studentRewardPunishDao.deleteGrantsById(id);
    }

    // 助学贷款信息维护 2017/09/20
    public List<StudentLoan> getStudentLoanList(StudentLoan studentLoan){
        return studentRewardPunishDao.getStudentLoanList(studentLoan);
    }
    public StudentLoan getStudentLoanById(String id){
        return studentRewardPunishDao.getStudentLoanById(id);
    }
    public void insertStudentLoan(StudentLoan studentLoan){
        studentRewardPunishDao.insertStudentLoan(studentLoan);
    }
    public void updateStudentLoanById(StudentLoan studentLoan){
        studentRewardPunishDao.updateStudentLoanById(studentLoan);
    }
    public void deleteStudentLoanById(String id){
        studentRewardPunishDao.deleteStudentLoanById(id);
    }

    // 优秀学生干部信息维护 2017/09/20
    public List<StudentCadres> getStudentCadresList(StudentCadres studentCadres){
        return studentRewardPunishDao.getStudentCadresList(studentCadres);
    }
    public StudentCadres getStudentCadresById(String id){
        return studentRewardPunishDao.getStudentCadresById(id);
    }
    public void insertStudentCadres(StudentCadres studentCadres){
        studentRewardPunishDao.insertStudentCadres(studentCadres);
    }
    public void updateStudentCadresById(StudentCadres studentCadres){
        studentRewardPunishDao.updateStudentCadresById(studentCadres);
    }
    public void deleteStudentCadresById(String id){
        studentRewardPunishDao.deleteStudentCadresById(id);
    }

    // 市三好班级信息维护 2017/09/20
    public List<MiyoshiClass> getMiyoshiClassList(MiyoshiClass miyoshiClass){
        return studentRewardPunishDao.getMiyoshiClassList(miyoshiClass);
    }
    public MiyoshiClass getMiyoshiClassById(String id){
        return studentRewardPunishDao.getMiyoshiClassById(id);
    }
    public void insertMiyoshiClass(MiyoshiClass miyoshiClass){
        studentRewardPunishDao.insertMiyoshiClass(miyoshiClass);
    }
    public void updateMiyoshiClassById(MiyoshiClass miyoshiClass){
        studentRewardPunishDao.updateMiyoshiClassById(miyoshiClass);
    }
    public void deleteMiyoshiClassById(String id){
        studentRewardPunishDao.deleteMiyoshiClassById(id);
    }
    public MiyoshiClass getHeadTeacherByClassId(String classId){
        return studentRewardPunishDao.getHeadTeacherByClassId(classId);
    }

    // 学生惩处信息维护 2017/09/20
    public List<StudentPunish> getStudentPunishList(StudentPunish studentPunish){
        return studentRewardPunishDao.getStudentPunishList(studentPunish);
    }
    public StudentPunish getStudentPunishById(String id){
        return studentRewardPunishDao.getStudentPunishById(id);
    }
    public void insertStudentPunish(StudentPunish studentPunish){
        studentRewardPunishDao.insertStudentPunish(studentPunish);
    }
    public void updateStudentPunishById(StudentPunish studentPunish){
        studentRewardPunishDao.updateStudentPunishById(studentPunish);
    }
    public void deleteStudentPunishById(String id){
        studentRewardPunishDao.deleteStudentPunishById(id);
    }

    public StudentPunish getStudentCancelTime(String punishTime){
        return studentRewardPunishDao.getStudentCancelTime(punishTime);
    }
    public StudentPunish getStudentCancelTime1(String punishTime){
        return studentRewardPunishDao.getStudentCancelTime1(punishTime);
    }
    //学生惩处信息查询
    public List<StudentPunish> getSelectStudentPunishList(StudentPunish studentPunish){
        return studentRewardPunishDao.getSelectStudentPunishList(studentPunish);
    }
    // 学生惩处信息维护 2017/09/20
    public List<StudentPunish> getRewardPunishCountList(StudentPunish studentPunish){
        return studentRewardPunishDao.getRewardPunishCountList(studentPunish);
    }
}
