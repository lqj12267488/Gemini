package com.goisan.system.dao;

import com.goisan.system.bean.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Admin on 2017/5/3.
 */
@Repository
public interface CommonDao {

    List<AutoComplete> getPersonByName(@Param("name") String name);
    List<Select2> getUserDict(String name);

    List<Select2> getRoleSelect();

    List<Select2> getTableDict(TableDict tableDict);

    List<Select2> getDistinctTableDict(TableDict tableDict);

    List<AutoComplete> getPersonDept(@Param("examId") String examId);

    List<AutoComplete> getPersonDeptByPname(@Param("name")String name);

    List<AutoComplete> getCoures();

    List<AutoComplete> getCouresByName(String name);

    List<AutoComplete> getClassBean();
    List<AutoComplete> getIdCard();
    List<AutoComplete> getDorm();

    List<AutoComplete> getClassBeanByDept(String deptId);

    List<Tree> getEmpTree();

    List<Tree> getStuTree();

    List<Tree> getStuTreeNotClass();

    List<Tree> getParentTree();

    List<AutoComplete> getStudentClass();

    List<AutoComplete> getStudentClassByName(@Param("name") String name);

    List<AutoComplete> getStudentPerson();

    List<AutoComplete> getDept();

    List<AutoComplete> getDeptByName(@Param("name") String name);

    String getSysDictVal(@Param("code") String code, @Param("dicName") String dicName);

    List<Select2> getSelectDept(@Param("type") String type);

    List<Select2> getMajorByDeptId(@Param("deptId") String deptId);

    List<Select2> getSysDict(@Param("name") String name, @Param("where") String where);

    //返回的Select对象的属性id值为字典表的id
    List<Select2> getSysDictSelect(@Param("name") String name, @Param("where") String where);

    List<Select2> getMajorCodeByDeptId(String deptId);

    List<Select2> getClassIdByMajor(@Param("majorCode") String majorCode, @Param("trainingLevel")
            String trainingLevel, @Param("majorDirection") String majorDirection);

    List<Select2> getClassByPlan(@Param("majorCode") String majorCode, @Param("trainingLevel")
            String trainingLevel, @Param("majorDirection") String majorDirection,@Param("term")String term);

    List<Select2> getMajorCodeAndTrainingLeavelByDeptId(String deptId);

    List<Select2> getMajorShowByDeptId(String deptId);

    List<Select2> getClassByMajorShow(String majorShow);

    List<Select2> getStudentByClassId(String classId);

    List<AutoComplete> getTextBook();

    List<Select2> getDepartments();

    List<Select2> getClassByDeptId(@Param("deptId")String deptId);
    List<Select2> getClassByDeptId1(@Param("deptId")String deptId,@Param("name")String name);

    List<Select2> getSelectUserByDeptId(@Param("deptId") String deptId);

    List<Select2> getMajorByDeptId2(@Param("deptId") String deptId);

    String getClassIdByMajorIdAndClassName(@Param("majorId") String majorId, @Param("className") String className);

    String getClassIdByStudentId(String id);

    String getStudentNameByIdCard(String idcard);

    ClassBean getClassByClassId(String id);

    List<String> getSysDictName(@Param("name") String name, @Param("where") String where);

    List<String> getTableDictNameBy(TableDict tableDict);

    List<String> getUserDictName(String dicType);

    String getDeptIdByPersonId(String id);
}
