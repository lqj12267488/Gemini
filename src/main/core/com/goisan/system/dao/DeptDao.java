package com.goisan.system.dao;

import com.goisan.system.bean.Dept;
import com.goisan.system.bean.EmpDeptTree;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import org.springframework.stereotype.Repository;

import java.util.List;


/**
 * Created by Admin on 2017/4/19.
 */
@Repository
public interface DeptDao {
    List<Tree> getDeptTree();
    List<Tree> getDeptTeachTree();

    List<Tree> getTeachDeptTree();

    List<Dept> getDeptListByParentId(String pId);

    void saveDept(Dept dept);

    Dept getDeptById(String id);

    void deleteDeptById(String id);

    void updateDept(Dept dept);

    List<EmpDeptTree> getDeptAndPersonTree(String roleid);

    List<Dept> getDeptListByPersonId(String personId);

    String getMaxId(String pId);

    List<Select2> checkDeptName(Dept dept);

    List<String> getEmpByDeptId(String id);

    List<Dept> getDeptByDeptName(String deptName);
}
