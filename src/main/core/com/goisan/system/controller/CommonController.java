package com.goisan.system.controller;

import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.TableDict;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.CommonService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Admin on 2017/5/3.
 */
@Controller
public class CommonController {

    @Resource
    private CommonService commonService;

    @ResponseBody
    @RequestMapping("/common/getSysDict")
    public List<Select2> getSysDict(String name, String where) {
        return commonService.getSysDict(name, where);
    }

    @ResponseBody
    @RequestMapping("/common/getSysDictSelect")
    public List<Select2> getSysDictSelect(String name, String where) {
        return commonService.getSysDictSelect(name, where);
    }

    @ResponseBody
    @RequestMapping("/common/getUserDict")
    public List<Select2> getUserDict(String name) {
        return commonService.getUserDict(name);
    }

    @ResponseBody
    @RequestMapping("/common/getTableDict")
    public List<Select2> getTableDict(TableDict tableDict) {
        return commonService.getTableDict(tableDict);
    }

    @ResponseBody
    @RequestMapping("/common/getDistinctTableDict")
    public List<Select2> getDistinctTableDict(TableDict tableDict) {
        return commonService.getDistinctTableDict(tableDict);
    }

    @ResponseBody
    @RequestMapping("/common/checkTableDict")
    public boolean checkTableDict(TableDict tableDict) {
        List<Select2> selectList = commonService.getTableDict(tableDict);
        if (null == selectList || selectList.size() == 0)
            return true;
        else
            return false;
    }

    //zTree公共方法
    public List<Tree> getDictToTree(List<Select2> selectList) {
        List<Tree> treeList = new ArrayList<Tree>();
        for (int i = 0; i < selectList.size(); i++) {
            Select2 select = selectList.get(i);
            Tree tree = new Tree();
            tree.setId(select.getId());
            tree.setName(select.getText());
            treeList.add(tree);
        }
        return treeList;
    }

    @ResponseBody
    @RequestMapping("/common/getUserDictToTree")
    public List<Tree> getUserDictToTree(String name) {
        List<Select2> selectList = commonService.getUserDict(name);
        return getDictToTree(selectList);
    }

    @ResponseBody
    @RequestMapping("/common/getSysDictToTree")
    public List<Tree> getSysDictToTree(String name) {
        List<Select2> selectList = commonService.getSysDict(name, "");
        return getDictToTree(selectList);
    }

    @ResponseBody
    @RequestMapping("/common/getRoleSelect")
    public List<Select2> getRoleSelect(String name) {
        return commonService.getRoleSelect(name);
    }

    @ResponseBody
    @RequestMapping("/common/getTextBook")
    public List<AutoComplete> getTextBook() {
        return commonService.getTextBook();
    }

    @ResponseBody
    @RequestMapping("/common/getPersonDept")
    public List<AutoComplete> getPersonDept(String examId) {
        List<AutoComplete> personDept = commonService.getPersonDept(examId);
        return personDept;
    }

    @ResponseBody
    @RequestMapping("/common/getIdCard")
    public List<AutoComplete> getIdCard() {
        return commonService.getIdCard();
    }

    @ResponseBody
    @RequestMapping("/common/getDorm")
    public List<AutoComplete> getDorm() {
        return commonService.getDorm();
    }

    @ResponseBody
    @RequestMapping("/common/getPersonDeptByPname")
    public List<AutoComplete> getPersonDeptByPname(String name) {
        return commonService.getPersonDeptByPname(name);
    }

    @ResponseBody
    @RequestMapping("/common/getPersonByName")
    public List<AutoComplete> getPersonByName(String name) {
        return commonService.getPersonByName(name);
    }

    @ResponseBody
    @RequestMapping("/common/getCoures")
    public List<AutoComplete> getCoures() {
        return commonService.getCoures();
    }

    @ResponseBody
    @RequestMapping("/common/getCouresByName")
    public List<AutoComplete> getCouresByName(String name) {
        return commonService.getCouresByName(name);
    }

    @ResponseBody
    @RequestMapping("/common/getClassBean")
    public List<AutoComplete> getClassBean() {
        return commonService.getClassBean();
    }

    @ResponseBody
    @RequestMapping("/common/getClassBeanByDept")
    public List<AutoComplete> getClassBeanByDept(String deptId) {
        return commonService.getClassBeanByDept(deptId);
    }

    @ResponseBody
    @RequestMapping("/common/getDept")
    public List<AutoComplete> getDept() {
        return commonService.getDept();
    }

    //通过名字获取部门
    @ResponseBody
    @RequestMapping("/common/getDeptByName")
    public List<AutoComplete> getDeptByName(String name) {
        return commonService.getDeptByName(name);
    }

    @ResponseBody
    @RequestMapping("/common/getSelectUserByDeptId")
    public List<Select2> getSelectUserByDeptId(String deptId) {
        return commonService.getSelectUserByDeptId(deptId);
    }


    @ResponseBody
    @RequestMapping("/common/getStudentClass")
    public List<AutoComplete> getStudentClass() {
        return commonService.getStudentClass();
    }

    @ResponseBody
    @RequestMapping("/common/getStudentClassByName")
    public List<AutoComplete> getStudentClassByName(String name) {
        return commonService.getStudentClassByName(name);
    }

    @ResponseBody
    @RequestMapping("/common/getStudentPerson")
    public List<AutoComplete> getStudentPerson() {
        return commonService.getStudentPerson();
    }

    @ResponseBody
    @RequestMapping("/common/getSelectDept")
    public List<Select2> getSelectDept(String type) {
        return commonService.getSelectDept(type);
    }

    @ResponseBody
    @RequestMapping("/common/getMajorByDeptId")
    public List<Select2> getMajorByDeptId(String deptId) {
        return commonService.getMajorByDeptId(deptId);
    }

    @ResponseBody
    @RequestMapping("/common/getMajorCodeByDeptId")
    public List<Select2> getMajorCodeByDeptId(String deptId) {
        return commonService.getMajorCodeByDeptId(deptId);
    }

    @ResponseBody
    @RequestMapping("/common/getTableToTree")
    public List<Tree> getTableToTree(TableDict tableDict) {
        List<Select2> selectList = commonService.getTableDict(tableDict);
        return getDictToTree(selectList);
    }

    @ResponseBody
    @RequestMapping("common/getClassIdByMajor")
    public List<Select2> getClassIdByMajor(String majorCode, String trainingLevel, String majorDirection) {
        return commonService.getClassIdByMajor(majorCode, trainingLevel, majorDirection);
    }

    /**
     *根据教学任务，专业，获取班级
     */
    @ResponseBody
    @RequestMapping("common/getClassByPlan")
    public List<Select2> getClassByPlan(String majorCode, String trainingLevel, String majorDirection,String term) {
        return commonService.getClassByPlan(majorCode, trainingLevel, majorDirection,term);
    }

    @ResponseBody
    @RequestMapping("/common/getMajorCodeAndTrainingLeavelByDeptId")
    public List<Select2> getMajorCodeAndTrainingLeavelByDeptId(String deptId) {
        return commonService.getMajorCodeAndTrainingLeavelByDeptId(deptId);
    }

    //通过系部查询专业-方向-层次
    @ResponseBody
    @RequestMapping("/common/getMajorShowByDeptId")
    public List<Select2> getMajorShowByDeptId(String deptId) {
        return commonService.getMajorShowByDeptId(deptId);
    }

    //通过专业-方向-层次下拉选择查询班级
    @ResponseBody
    @RequestMapping("/common/getClassByMajorShow")
    public List<Select2> getClassByMajorShow(String majorShow) {
        return commonService.getClassByMajorShow(majorShow);
    }

    //通过班级id获取学生列表
    @ResponseBody
    @RequestMapping("/common/getStudentByClassId")
    public List<Select2> getStudentByClassId(String classId) {
        return commonService.getStudentByClassId(classId);
    }

    /**
     * 获取系部下拉选
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/common/getDepartments")
    public List<Select2> getDepartments() {
        return commonService.getDepartments();
    }

    // 提交等待頁面
    @RequestMapping("/common/commonSaveLoading")
    public ModelAndView commonSaveLoading() {
        return new ModelAndView("/common/saveLoading");
    }

}
