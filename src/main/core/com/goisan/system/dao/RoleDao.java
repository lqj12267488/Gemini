package com.goisan.system.dao;

import com.goisan.system.bean.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

/**
 * Created by admin on 2017/4/26.
 */
@Repository
public interface RoleDao {

    List<Role> getRoleList(String id);

    List<Role> getRoleList(Role role);

    Role getRoleById(String id);

    void addRole(String pId);

    void deleteRoleById(String id);

    void delRoleEmpDeptRelationByRoleid(String id);

    void updateRole(Role role);

    void insertRole(Role role);

    List<RoleResRelation> getRoleMenuRelationByRole(String role);

    void deleteRoleResourceByRoleid(String roleid);

    void updateRoleResRelation(RoleResRelation roleResRelation);

    void updateRoleResRel(@Param("createTime")Date createTime,@Param("roleid") String roleid, @Param("creator") String creator, @Param("createDept") String createDept , @Param("resource") List resource);

    List<RoleEmpDeptRelation> getEmpDeptByRole(String roleid);

    void insertRoleEmpDeptRelation(RoleEmpDeptRelation r);

    void insertRoleStuClassRelation(RoleStuClassRelation r);

    void delRoleStuClassRelationByRoleid(String roleid);

    void delRoleParStuRelationByRoleid(String roleid);

    void insertRoleParStuRelation(RoleParentStuRelation r);

    RoleEmpDeptRelation getEmpDeptByRoleIdAndPersonId(@Param("roleId") String roleId , @Param("personId")String personId);
}
