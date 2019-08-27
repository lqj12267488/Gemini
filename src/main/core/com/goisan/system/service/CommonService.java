package com.goisan.system.service;

import com.goisan.system.bean.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by Admin on 2017/5/3.
 */
@Service
public interface CommonService {
    List<Select2> getClassByPlan( String majorCode, String trainingLevel, String majorDirection,String term);
    List<AutoComplete> getPersonByName(String name);
    //返回的Select对象的属性id值为字典表的id
    List<Select2> getSysDictSelect(String name, String where);

    List<Select2> getSysDict(String name, String where);

    List<Select2> getUserDict(String name);

    List<Select2> getRoleSelect(String name);

    List<Select2> getTableDict(TableDict tableDict);

    List<AutoComplete> getPersonDept(String examId);

    List<AutoComplete> getPersonDeptByPname(String name);

    List<Tree> getEmpTree();

    List<Tree> getStuTree();

    List<Tree> getStuTreeNotClass();

    List<Tree> getParentTree();

    List<AutoComplete> getStudentClass();

    List<AutoComplete> getStudentClassByName(String name);

    List<AutoComplete> getStudentPerson();

    List<AutoComplete> getDept();

    List<AutoComplete> getDeptByName(String name);

    String getSysDictVal(String code, String dicName);

    List<Select2> getSelectDept(String type);

    List<Select2> getMajorByDeptId(String deptId);

    List<Select2> getMajorCodeByDeptId(String deptId);

    List<Select2> getClassIdByMajor(String majorCode, String trainingLevel, String majorDirection);

    List<Select2> getMajorCodeAndTrainingLeavelByDeptId(String deptId);

    List<Select2> getMajorShowByDeptId(String deptId);

    List<Select2> getClassByMajorShow(String majorShow);

    List<Select2> getStudentByClassId(String classId);

    List<AutoComplete> getTextBook();

    List<AutoComplete> getCoures();

    List<AutoComplete> getCouresByName(String name);

    List<AutoComplete> getClassBean();
    List<AutoComplete> getClassBeanByDept(String deptId);

    List<Select2> getDepartments();

    List<Select2> getClassByDeptId(String deptId);
    List<Select2> getClassByDeptId1(String deptId,String name);

    Map<String, String> getSysDicMap(String name);

    Map<String, String> getSysDicValueMap(String name);

    List<Select2> getSelectUserByDeptId(String deptId);

    List<Select2> getMajorByDeptId2(String deptId);

    String getClassIdByMajorIdAndClassName(String majorId, String className);

    String getClassIdByStudentId(String id);

    String getStudentNameByIdCard(String idcard);

    ClassBean getClassByClassId(String id);

    List<String> getSysDictName(@Param("name") String name, @Param("where") String where);

    List<String> getTableDictNameBy(TableDict tableDict);

    List<String> getUserDictName(String dicType);

    List<Select2> getDistinctTableDict(TableDict tableDict);

    String getDeptIdByPersonId(String id);
}
