package com.goisan.system.service;

import com.goisan.system.bean.Dept;
import com.goisan.system.bean.EmpDeptTree;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;

import java.util.List;

/**
 * Created by Admin on 2017/4/19.
 */

public interface DeptService {
    List<Tree> getDeptTree();
    List<Tree> getDeptTeachTree();

    String getNewDeptId(String pId);

    void saveDept(Dept dept);

    Dept getDeptById(String id);

    void deleteDeptById(String id);

    void updateDept(Dept dept);

    List<Dept> getDeptListByPersonId(String personId);

    List<EmpDeptTree> getDeptAndPersonTree(String role_id);

    List<Select2> checkDeptName(Dept dept);


    List<String> getEmpByDeptId(String id);
    List<Dept> getDeptByDeptName(String deptName);
}
