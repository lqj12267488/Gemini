package com.goisan.system.service;

import com.goisan.system.bean.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Blob;
import java.util.List;

/**
 * Created by Admin on 2017/4/20.
 */
public interface EmpService {

    Integer selEmpCountByName (String teacherName);
    List<Emp> getEmpList(Emp emp);

    List<Emp> getEmpListByName(String name);

    void saveEmp(Emp emp, EmpDeptRelation edr, LoginUser loginUser);

    List<Emp> getEmpListByDeptId(Emp emp);

    List<EmpDeptRelation> getDeptByDeptIdAndPersonId(String personId, String deptId);

    void deleteEmp(String personId, String deptId);

    void deleteEmpDeptRelation(String personId, String deptId);

    Emp getEmpByDeptIdAndPersonId(String personId, String deptId);

    void updateEmp(Emp emp);

    List<String> getDeptByPersonId(String personId);

    String getPersonNameById(String personId);

    String getPersonNameById1(String personId);

    String getDeptNameById(String deptId);

    void deleteEmpDeptRelation(String personId);

    void saveEmpDeptRelation(EmpDeptRelation edr);

    Blob getPhotoByPersonid(String personId);

    List<Emp> GroupEmpByDept();

    List<String> getEmpRole(String personId, String deptId);

    List<Tree> getRoleList();

    void deleteRoleByPersonIdAndDeptId(String personId, String deptId);

    Emp getEmpByIdCard(String idCard);

    Emp getEmpByStaffId(String staffId);

    LoginUser getEmpByPersonId(String personId);

    Emp getEmpByEmpId(String id, String personId);

    @Transactional
    void changeEmpRole(String ids, String personId, String deptId);

    List<Emp> getDeletedEmpList(Emp emp);

    void recoveryEmp(String personId);

    List<Emp> getStaffId(Emp emp);

    String getStaffIdByPersonId(String personId);

    String getPersonLevel(String personId);

    void updateLevel(LoginUser loginUser);

    List<Select2> getLevels(int level);

    List<Emp> getEmpStaffId(String staffId);

    List<String> selectDeptName();

    List<Emp> selectList(String str);
    List<Emp> selectList2(String deptName,String deptId);

    List<Emp> selectListByName(String str, String deptId);

    void saveEmp1(Emp emp,EmpDeptRelation edr,LoginUser loginUser);

    String selectName(String creator);
}
