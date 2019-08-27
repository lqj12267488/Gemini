package com.goisan.system.dao;

import com.goisan.system.bean.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.sql.Blob;
import java.util.List;

/**
 * Created by Admin on 2017/4/20.
 */
@Repository
public interface EmpDao {

    Integer selEmpCountByName (String teacherName);
    List<Emp> getEmpList(Emp emp);

    String getStaffIdByPersonId(String personId);

    List<Emp> getEmpListByName(String name);

    void saveEmp(Emp emp);

    void saveEmpDeptRelation(EmpDeptRelation edr);

    List<Emp> getEmpListByDeptId(Emp emp);

    void deleteEmp(String personId);

    void deleteEmpDeptRelation(@Param("personId") String personId, @Param("deptId") String deptId);

    List<EmpDeptRelation> getDeptByDeptIdAndPersonId(@Param("personId") String personId,
                                                     @Param("deptId") String deptId);

    Emp getEmpByEmpId(String personId);

    Emp getEmpByDeptIdAndPersonId(@Param("personId") String personId,
                                  @Param("deptId") String deptId);

    void updateEmp(Emp emp);

    List<String> getDeptByPersonId(String personId);

    String getPersonNameById(String personId);

    String getPersonNameById1(String personId);

    String getDeptNameById(String deptId);

    void deleteEmpDept(String personId);

    Blob getPhotoByPersonid(String personId);

    List<Emp> GroupEmpByDept();

    List<String> getEmpRole(@Param("personId") String personId, @Param("deptId") String deptId);

    List<Tree> getRoleList();

    void deleteRoleByPersonIdAndDeptId(@Param("personId") String personId, @Param("deptId") String deptId);

    Emp getEmpByIdCard(String idCard);

    Emp getEmpByStaffId(String staffId);

    LoginUser getEmpByPersonId(String personId);

    List<Emp> getDeletedEmpList(Emp emp);

    void recoveryEmp(String personId);

    List<Emp> getStaffId(Emp emp);

    String getPersonLevel(String personId);

    void updateLevel(LoginUser loginUser);

    List<Select2> getLevels(int level);

    /**
     * 校验教师编号是否重复
     * @param staffId
     * @return
     */
    List<Emp> getEmpStaffId(String staffId);
}
