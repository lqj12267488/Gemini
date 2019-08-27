package com.goisan.system.service.impl;

import com.goisan.system.bean.*;
import com.goisan.system.dao.RoleDao;
import com.goisan.system.service.RoleService;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Date;
import java.util.*;

/**
 * Created by admin on 2017/4/26.
 */
@Service
public class RoleServiceImpl implements RoleService {
    @Resource
    private RoleDao roleDao;


    public List<Role> getRoleList(String id) {
        return roleDao.getRoleList(id);
    }

    public List<Role> getRoleList(Role role) {
        return roleDao.getRoleList(role);
    }

    public Role getRoleById(String id) {
        return roleDao.getRoleById(id);
    }

    public void addRole(String pId) {
        roleDao.addRole(pId);
    }

    public void deleteRoleById(String id) {
        roleDao.deleteRoleById(id);
    }

    public void delRoleEmpDeptRelationByRoleid(String id) {
        roleDao.delRoleEmpDeptRelationByRoleid(id);
    }

    public void deleteRoleResourceByRoleid(String id) {
        roleDao.deleteRoleResourceByRoleid(id);
    }

    public void updateRole(Role role) {
        roleDao.updateRole(role);
    }

    public void insertRole(Role role) {
        roleDao.insertRole(role);
    }

    public List<RoleResRelation> getRoleMenuRelationByRole(String role) {
        return roleDao.getRoleMenuRelationByRole(role);
    }

    public List<RoleEmpDeptRelation> getEmpDeptByRole(String roleid) {
        return roleDao.getEmpDeptByRole(roleid);
    }

    public void saveRelation(String roleid, String relationids) {
        Date date = new Date(new java.util.Date().getTime());
        roleDao.deleteRoleResourceByRoleid(roleid);
        String[] idlist = relationids.split(",");
        HashMap roleMap = new HashMap();
        for (int num = 0; num < idlist.length; num++){
            roleMap.put(idlist[num],"");
        }
        List list = new ArrayList();
        int i = 0;
        Iterator iter = roleMap.entrySet().iterator();
        while (iter.hasNext()) {
            i++;
            Map.Entry entry = (Map.Entry) iter.next();
            String key = (String)entry.getKey();
            list.add(key);
            if(i % 100 ==0){
                roleDao.updateRoleResRel(date, roleid, CommonUtil.getLoginUser().getUserAccount(),
                        "",list);
                list = new ArrayList();
            }
        }
        if(i % 100 !=0){
            roleDao.updateRoleResRel(date, roleid, CommonUtil.getLoginUser().getUserAccount(),
                    "",list);
        }

    }

    public void insertRoleEmpDeptRelation(RoleEmpDeptRelation r) {
        roleDao.insertRoleEmpDeptRelation(r);
    }

    public void insertRoleStuClassRelation(RoleStuClassRelation r) {
        roleDao.insertRoleStuClassRelation(r);
    }

    public void delRoleStuClassRelationByRoleid(String roleid) {
        roleDao.delRoleStuClassRelationByRoleid(roleid);
    }

    public void delRoleEmpDeptRelationByRoleidAndInsertRoleEmpDeptRelation(String roleid,
                                                                           String checkList) {
        roleDao.delRoleEmpDeptRelationByRoleid(roleid);
        if (checkList.length() > 0) {
            String[] check = checkList.split("@@@");
            for (int i = 0; i < check.length; i++) {
                RoleEmpDeptRelation r = new RoleEmpDeptRelation();
                r.setRoleid(roleid);
                String a = check[i];
                String[] b = a.split("@");
                r.setDeptid(b[0].toString());
                r.setPersonid(b[1].toString());
                r.setCreator(CommonUtil.getPersonId());
                r.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
                r.setCreateTime(CommonUtil.getDate());
                roleDao.insertRoleEmpDeptRelation(r);
            }
        }

    }

    public void delAndSaveStuRelation(String roleid, String checkList) {
        roleDao.delRoleStuClassRelationByRoleid(roleid);
        Date date = new Date(new java.util.Date().getTime());
        if (checkList.length() > 0) {
            String[] check = checkList.split("@@@");
            for (int i = 0; i < check.length; i++) {
                RoleStuClassRelation r = new RoleStuClassRelation();
                r.setRoleId(roleid);
                String a = check[i];
                String[] b = a.split("@");
                r.setClassId(b[0].toString());
                r.setStudentId(b[1].toString());
                r.setCreator(CommonUtil.getPersonId());
                r.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
                roleDao.insertRoleStuClassRelation(r);
            }
        }
    }

    public void delAndSaveParStuRelation(String roleid, String checkList) {
        roleDao.delRoleParStuRelationByRoleid(roleid);
        Date date = new Date(new java.util.Date().getTime());
        if (checkList.length() > 0) {
            String[] check = checkList.split("@");
            for (int i = 0; i < check.length; i++) {
                RoleParentStuRelation r = new RoleParentStuRelation();
                r.setRoleId(roleid);
                String a = check[i];
                String[] b = a.split(",");
                r.setParentId(b[0].toString());
                r.setStudentId(b[1].toString());
                r.setCreator(CommonUtil.getPersonId());
                r.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
                roleDao.insertRoleParStuRelation(r);
            }
        }
    }

    public RoleEmpDeptRelation getEmpDeptByRoleIdAndPersonId(String roleId, String personId){

        return this.roleDao.getEmpDeptByRoleIdAndPersonId(roleId, personId);
    }
}
