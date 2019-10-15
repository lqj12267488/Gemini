package com.goisan.system.service.impl;

import com.goisan.system.bean.*;
import com.goisan.system.dao.CommonDao;
import com.goisan.system.service.CommonService;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Admin on 2017/5/3.
 */
@Service
public class CommonServiceImpl implements CommonService {
    @Resource
    private CommonDao commonDao;

    @Override
    public List<AutoComplete> getIdCard() {
        return commonDao.getIdCard();
    }

    @Override
    public List<AutoComplete> getDorm() {
        return commonDao.getDorm();
    }

    @Override
    public List<Select2> getClassByPlan(String majorCode, String trainingLevel, String majorDirection, String term) {
        return commonDao.getClassByPlan(majorCode,trainingLevel,majorDirection,term);
    }

    public  List<AutoComplete> getPersonByName(String name){
        return this.commonDao.getPersonByName(name);
    }
    public List<Select2> getUserDict(String name) {
        return commonDao.getUserDict(name);
    }

    public List<Select2> getRoleSelect(String name) {
        return commonDao.getRoleSelect();
    }

    public List<Select2> getSysDict(String name, String where) {
        return commonDao.getSysDict(name, where);
    }

    //返回的Select对象的属性id值为字典表的id
    public List<Select2> getSysDictSelect(String name, String where){
        return commonDao.getSysDictSelect(name, where);
    }

    public List<Select2> getTableDict(TableDict tableDict) {
        return commonDao.getTableDict(tableDict);
    }


    public List<Select2> getDistinctTableDict(TableDict tableDict) {
        return commonDao.getDistinctTableDict(tableDict);
    }

    public List<AutoComplete> getPersonDept(String examId) {
        return commonDao.getPersonDept(examId);
    }

    @Override
    public List<AutoComplete> getPersonDeptByPname(String name) {
        return this.commonDao.getPersonDeptByPname(name);
    }

    public List<Tree> getEmpTree() {
        return commonDao.getEmpTree();
    }

    public List<Tree> getStuTree() {
        return commonDao.getStuTree();
    }

    public List<Tree> getStuTreeNotClass() {
        return commonDao.getStuTreeNotClass();
    }

    public List<Tree> getParentTree() {
        return commonDao.getParentTree();
    }

    public List<AutoComplete> getStudentClass() {
        return commonDao.getStudentClass();
    }

    @Override
    public List<AutoComplete> getStudentClassByName(String name) {
        return this.commonDao.getStudentClassByName(name);
    }

    public List<AutoComplete> getStudentPerson() {
        return commonDao.getStudentPerson();
    }

    public List<AutoComplete> getDept() {
        return commonDao.getDept();
    }

    @Override
    public List<AutoComplete> getDeptByName(String name) {
        return this.commonDao.getDeptByName(name);
    }

    public String getSysDictVal(String code, String dicName) {
        return commonDao.getSysDictVal(code, dicName);
    }

    public List<Select2> getSelectDept(String type) {
        return commonDao.getSelectDept(type);
    }

    public List<Select2> getMajorByDeptId(String deptId) {
        return commonDao.getMajorByDeptId(deptId);
    }

    public List<Select2> getMajorCodeByDeptId(String deptId) {
        return commonDao.getMajorCodeByDeptId(deptId);
    }

    public List<Select2> getClassIdByMajor(String majorCode, String trainingLevel, String
            majorDirection) {
        return commonDao.getClassIdByMajor(majorCode, trainingLevel, majorDirection);
    }

    public List<Select2> getMajorCodeAndTrainingLeavelByDeptId(String deptId) {
        return commonDao.getMajorCodeAndTrainingLeavelByDeptId(deptId);
    }

    public List<Select2> getMajorShowByDeptId(String deptId) {
        return commonDao.getMajorShowByDeptId(deptId);
    }

    public List<Select2> getClassByMajorShow(String majorShow) {
        return commonDao.getClassByMajorShow(majorShow);
    }

    public List<Select2> getStudentByClassId(String classId) {
        return commonDao.getStudentByClassId(classId);
    }

    public List<AutoComplete> getTextBook() {
        return commonDao.getTextBook();
    }

    @Override
    public List<Select2> getDepartments() {
        return commonDao.getDepartments();
    }

    public List<AutoComplete> getCoures() {
        return commonDao.getCoures();
    }

    @Override
    public List<AutoComplete> getCouresByName(String name) {
        return this.commonDao.getCouresByName(name);
    }

    public List<AutoComplete> getClassBean() {
        return commonDao.getClassBean();
    }

    @Override
    public List<AutoComplete> getClassBeanByDept(String deptId) {
        return commonDao.getClassBeanByDept(deptId);
    }

    @Override
    public List<Select2> getClassByDeptId(String deptId) {
        return commonDao.getClassByDeptId(deptId);
    }
    @Override
    public List<Select2> getClassByDeptId1(String deptId,String name) {
        return commonDao.getClassByDeptId1(deptId,name);
    }
    @Override
    public Map<String, String> getSysDicMap(String name) {
        List<Select2> sysDict = commonDao.getSysDict(name, "");
        Map<String, String> map = new HashMap<>();
        for (Select2 select2 : sysDict) {
            map.put(select2.getText(), select2.getId());
        }
        return map;
    }

    @Override
    public Map<String, String> getSysDicValueMap(String name) {
        List<Select2> sysDict = commonDao.getSysDict(name, "");
        Map<String, String> map = new HashMap<>();
        for (Select2 select2 : sysDict) {
            map.put(select2.getId(), select2.getText());
        }
        return map;
    }

    @Override
    public List<Select2> getSelectUserByDeptId(String deptId) {
        return commonDao.getSelectUserByDeptId(deptId);
    }

    @Override
    public List<Select2> getMajorByDeptId2(String deptId) {
        return commonDao.getMajorByDeptId2(deptId);
    }

    @Override
    public String getClassIdByMajorIdAndClassName(String majorId, String className) {
        return commonDao.getClassIdByMajorIdAndClassName(majorId, className);
    }

    public String getClassIdByStudentId(String id) {
        return commonDao.getClassIdByStudentId(id);
    }

    public String getStudentNameByIdCard(String idcard) {
        return commonDao.getStudentNameByIdCard(idcard);
    }

    public ClassBean getClassByClassId(String id) {
        return commonDao.getClassByClassId(id);
    }

    public List<String> getSysDictName(@Param("name") String name, @Param("where") String where){
        return commonDao.getSysDictName(name,where);
    }

    public List<String> getTableDictNameBy(TableDict tableDict){
        return commonDao.getTableDictNameBy(tableDict);
    }

    public List<String> getUserDictName(String dicType){
        return commonDao.getUserDictName(dicType);
    }

    public String getDeptIdByPersonId(String id){ return commonDao.getDeptIdByPersonId(id);}

    @Override
    public List<RoleEmpDeptRelation> getRoleByPersonId(String personId) {
        return commonDao.getRoleByPersonId(personId);
    }

    @Override
    public List<RoleEmpDeptRelation> getRoleByPersonId1(String personId) {
        return commonDao.getRoleByPersonId1(personId);
    }
}
