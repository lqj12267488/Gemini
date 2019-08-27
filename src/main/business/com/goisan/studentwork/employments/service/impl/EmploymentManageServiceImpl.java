package com.goisan.studentwork.employments.service.impl;

import com.goisan.studentwork.employments.bean.EmploymentManage;
import com.goisan.studentwork.employments.dao.EmploymentManageDao;
import com.goisan.studentwork.employments.service.EmploymentManageService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/8/11.
 */
@Service
public class EmploymentManageServiceImpl implements EmploymentManageService {
    @Resource
    private EmploymentManageDao employmentManageDao;
    public List<EmploymentManage> getEmploymentManageList(String employmentId){
        return employmentManageDao.getEmploymentManageList(employmentId);
    }
    public void insertEmploymentManage(EmploymentManage employmentManage){
        employmentManageDao.insertEmploymentManage(employmentManage);
    }
    public List<EmploymentManage> EmploymentManageAction(EmploymentManage employmentManage){
        return employmentManageDao.EmploymentManageAction(employmentManage);
    }
    public EmploymentManage getEmploymentManageById(String employmentId){
        return employmentManageDao.getEmploymentManageById(employmentId);
    }
    public void updateEmploymentManageById(EmploymentManage employmentManage){
        employmentManageDao.updateEmploymentManageById(employmentManage);
    }
    public void deleteEmploymentManageById(String employmentId){
        employmentManageDao.deleteEmploymentManageById(employmentId);
    }
    public EmploymentManage selectId(String employmentId){
        return employmentManageDao.selectId(employmentId);
    }

    public List<EmploymentManage> selectEmploymentStatistics(EmploymentManage employmentManage){return employmentManageDao.selectEmploymentStatistics(employmentManage);}
    public String selectEmploymentArea(String employmentUnitId){
        return employmentManageDao.selectEmploymentArea(employmentUnitId);
    }
    public String selectEmploymentType(String employmentId){
        return employmentManageDao.selectEmploymentType(employmentId);
    }
    public List<EmploymentManage> employmentSelectStatistics(EmploymentManage employmentManage){
        return employmentManageDao.employmentSelectStatistics(employmentManage);
    }

}
