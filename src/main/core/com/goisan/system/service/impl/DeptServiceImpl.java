package com.goisan.system.service.impl;

import com.goisan.system.bean.Dept;
import com.goisan.system.bean.EmpDeptTree;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import com.goisan.system.dao.DeptDao;
import com.goisan.system.service.DeptService;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Admin on 2017/4/19.
 */
@Service
public class DeptServiceImpl implements DeptService {
    @Resource
    private DeptDao deptDao;

    public List<Tree> getDeptTree() {
        return deptDao.getTeachDeptTree();
    }

    @Override
    public List<Tree> getDeptTeachTree() {
        return deptDao.getDeptTeachTree();
    }

    public String getNewDeptId(String pId) {
        String id = deptDao.getMaxId(pId);
        return CommonUtil.getnextId(id, pId);
    }

    public void saveDept(Dept dept) {
        deptDao.saveDept(dept);
    }

    public Dept getDeptById(String id) {
        return deptDao.getDeptById(id);
    }

    public List<Dept> getDeptListByPersonId(String personId) {
        return deptDao.getDeptListByPersonId(personId);
    }

    public void deleteDeptById(String id) {
        deptDao.deleteDeptById(id);
    }

    public void updateDept(Dept dept) {
        deptDao.updateDept(dept);
    }

    public List<EmpDeptTree> getDeptAndPersonTree(String roleid){
        return deptDao.getDeptAndPersonTree(roleid);
    }

    public List<Select2> checkDeptName(Dept dept){
        return deptDao.checkDeptName(dept);
    }

    @Override
    public List<String> getEmpByDeptId(String id) {
        return deptDao.getEmpByDeptId(id);
    }

    public List<Dept> getDeptByDeptName(String deptName){ return deptDao.getDeptByDeptName(deptName); }
}
