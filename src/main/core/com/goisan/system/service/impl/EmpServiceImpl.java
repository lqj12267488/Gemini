package com.goisan.system.service.impl;

import com.goisan.system.bean.*;
import com.goisan.system.dao.EmpDao;
import com.goisan.system.dao.LoginUserDao;
import com.goisan.system.dao.RoleDao;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.sql.Blob;
import java.util.List;

/**
 * Created by Admin on 2017/4/20.
 */
@Service
@Transactional(rollbackFor = {RuntimeException.class, Exception.class})
public class EmpServiceImpl implements EmpService {

    @Resource
    private EmpDao empDao;
    @Resource
    private LoginUserDao loginUserDao;
    @Resource
    private RoleDao roleDao;

    public String getStaffIdByPersonId(String personId){
        return empDao.getStaffIdByPersonId(personId);
    }

    @Override
    public Integer selEmpCountByName(String teacherName) {
        return empDao.selEmpCountByName(teacherName);
    }

    public List<Emp> getEmpList(Emp emp) {
        return empDao.getEmpList(emp);
    }

    public List<Emp> getEmpListByName(String name) {
        return empDao.getEmpListByName(name);
    }

    public void saveEmp(Emp emp, EmpDeptRelation edr, LoginUser loginUser) {
        empDao.saveEmp(emp);
        empDao.saveEmpDeptRelation(edr);
        loginUserDao.saveUser(loginUser);
    }

    public List<Emp> getEmpListByDeptId(Emp emp) {
        return empDao.getEmpListByDeptId(emp);
    }

    public List<EmpDeptRelation> getDeptByDeptIdAndPersonId(String personId, String deptId) {
        return empDao.getDeptByDeptIdAndPersonId(personId, deptId);
    }

    public void deleteEmp(String personId, String deptId) {
        empDao.deleteEmp(personId);
        empDao.deleteEmpDeptRelation(personId, deptId);
    }

    public Emp getEmpByEmpId(String id, String personId) {
        return empDao.getEmpByEmpId(personId);
    }

    public void deleteEmpDeptRelation(String personId, String deptId) {
        empDao.deleteEmpDeptRelation(personId, deptId);
    }

    public Emp getEmpByDeptIdAndPersonId(String personId, String deptId) {
        return empDao.getEmpByDeptIdAndPersonId(personId, deptId);
    }

    public void updateEmp(Emp emp) {
        empDao.updateEmp(emp);
    }

    public List<String> getDeptByPersonId(String personId) {
        return empDao.getDeptByPersonId(personId);
    }

    public String getPersonNameById(String personId) {
        return empDao.getPersonNameById(personId);
    }

    public String getPersonNameById1(String personId){ return empDao.getPersonNameById1(personId); }

    public String getDeptNameById(String deptId) {
        return empDao.getDeptNameById(deptId);
    }


    public void deleteEmpDeptRelation(String personId) {
        empDao.deleteEmpDept(personId);
    }

    public void saveEmpDeptRelation(EmpDeptRelation edr) {
        empDao.saveEmpDeptRelation(edr);
    }

    public Blob getPhotoByPersonid(String personId) {
        return empDao.getPhotoByPersonid(personId);
    }

    public List<Emp> GroupEmpByDept() {
        return empDao.GroupEmpByDept();
    }

    public List<String> getEmpRole(String personId, String deptId) {
        return empDao.getEmpRole(personId, deptId);
    }

    public List<Tree> getRoleList() {
        return empDao.getRoleList();
    }

    public void deleteRoleByPersonIdAndDeptId(String personId, String deptId) {
        empDao.deleteRoleByPersonIdAndDeptId(personId, deptId);
    }

    public Emp getEmpByIdCard(String idCard) {
        return empDao.getEmpByIdCard(idCard);
    }

    public LoginUser getEmpByPersonId(String personId) {
        return empDao.getEmpByPersonId(personId);
    }

    public void changeEmpRole(String ids, String personId, String deptId) {

        if (ids.length() > 0) {
            String[] roles = ids.split(",");
            String [] personIds = personId.split(",");
            for (String pi:personIds) {
                empDao.deleteRoleByPersonIdAndDeptId(personId, deptId);
            }
            for (String id : roles) {
                for (String person : personIds) {
                    RoleEmpDeptRelation roleEmpDeptRelation = new RoleEmpDeptRelation();
                    roleEmpDeptRelation.setId(CommonUtil.getUUID());
                    roleEmpDeptRelation.setPersonid(person);
                    roleEmpDeptRelation.setRoleid(id);
//                    List list = empDao.getDeptByPersonId(person);
//                    roleEmpDeptRelation.setDeptid(list.get(0).toString());
                    roleEmpDeptRelation.setDeptid(deptId);
                    roleEmpDeptRelation.setCreateDept(CommonUtil.getDefaultDept());
                    roleEmpDeptRelation.setCreator(CommonUtil.getPersonId());
                    roleDao.insertRoleEmpDeptRelation(roleEmpDeptRelation);
                }
            }
        }
    }

    @Override
    public List<Emp> getDeletedEmpList(Emp emp) {
        return empDao.getDeletedEmpList(emp);
    }

    @Override
    public void recoveryEmp(String personId) {
        empDao.recoveryEmp(personId);
    }

    @Override
    public List<Emp> getStaffId(Emp emp) {
        return empDao.getStaffId(emp);
    }

    public String getPersonLevel(String personId){
        return empDao.getPersonLevel(personId);
    }

    public void updateLevel(LoginUser loginUser){
        empDao.updateLevel(loginUser);
    }

    public  List<Select2> getLevels(int level){
        return empDao.getLevels(level);
    }

    public Emp getEmpByStaffId(String staffId){ return empDao.getEmpByStaffId(staffId); }

    public List<Emp> getEmpStaffId(String staffId){ return empDao.getEmpStaffId(staffId); }

    @Override
    public List<String> selectDeptName() {
        return empDao.selectDeptName();
    }

    @Override
    public List<Emp> selectList(String str) {
        return empDao.selectList(str);
    }

    @Override
    public List<Emp> selectList2(String deptName,String deptId) {
        return empDao.selectList2(deptName,deptId);
    }

    @Override
    public List<Emp> selectListByName(String str, String deptId) {
        return empDao.selectListByName(str,deptId);
    }

    @Override
    public void saveEmp1(Emp emp, EmpDeptRelation edr, LoginUser loginUser) {
        empDao.saveEmp(emp);
        empDao.saveEmpDeptRelation(edr);
        loginUserDao.saveUser(loginUser);
    }

    @Override
    public String selectName(String creator) {
        return empDao.selectName(creator);
    }


}
