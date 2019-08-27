package com.goisan.system.service;

import com.goisan.system.bean.Role;
import com.goisan.system.bean.RoleEmpDeptRelation;
import com.goisan.system.bean.RoleResRelation;
import com.goisan.system.bean.RoleStuClassRelation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by admin on 2017/4/26.
 */
public interface RoleService {

    List<Role> getRoleList(String id);

    List<Role> getRoleList(Role role);

    Role getRoleById(String id);

    void addRole(String pId);

    void deleteRoleById(String id);

    void updateRole(Role role);

    void insertRole(Role role);

    List<RoleResRelation> getRoleMenuRelationByRole(String role);

    void saveRelation(String roleid, String relationids);

    List<RoleEmpDeptRelation> getEmpDeptByRole(String roleid);

    void delRoleEmpDeptRelationByRoleid(String id);

    void deleteRoleResourceByRoleid(String id);

    void insertRoleEmpDeptRelation(RoleEmpDeptRelation r);

    void insertRoleStuClassRelation(RoleStuClassRelation r);

    void delRoleStuClassRelationByRoleid(String roleid);

    @Transactional
    void delRoleEmpDeptRelationByRoleidAndInsertRoleEmpDeptRelation(String roleid, String
            checkList);

    @Transactional
    void delAndSaveStuRelation(String roleid, String checkList);

    @Transactional
    void delAndSaveParStuRelation(String roleid, String checkList);

    RoleEmpDeptRelation getEmpDeptByRoleIdAndPersonId(String roleId, String PersonId);
}
