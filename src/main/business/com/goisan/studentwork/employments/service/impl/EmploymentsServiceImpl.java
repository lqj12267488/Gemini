package com.goisan.studentwork.employments.service.impl;

import com.goisan.studentwork.employments.bean.EmploymentManage;
import com.goisan.studentwork.employments.bean.Employments;
import com.goisan.studentwork.employments.dao.EmploymentsDao;
import com.goisan.studentwork.employments.service.EmploymentsService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/8/11.
 */
@Service
public class EmploymentsServiceImpl implements EmploymentsService{
    @Resource
    private EmploymentsDao employmentsDao;
    public List<Employments> getEmploymentsList(String employmentUnitId){return employmentsDao.getEmploymentsList(employmentUnitId);}
    public void insertEmployments(Employments employments){ employmentsDao.insertEmployments(employments);}
    public void insertEmployments1(Employments employments){employmentsDao.insertEmployments1(employments);}
    public List<Employments> EmploymentsAction(Employments employments){return employmentsDao.EmploymentsAction(employments);}
    public Employments getEmploymentsById(String employmentUnitId){return employmentsDao.getEmploymentsById(employmentUnitId);}
    public void updateEmploymentsById(Employments employments){employmentsDao.updateEmploymentsById(employments);}
    public void deleteEmploymentsById(String employmentUnitId){ employmentsDao.deleteEmploymentsById(employmentUnitId);}
    public Employments selectId(String employmentUnitId){return employmentsDao.selectId(employmentUnitId);}
    public Employments employmentList(String employmentUnitId){return employmentsDao.employmentList(employmentUnitId);}
    public List<EmploymentManage> getEmploymentsByInternshipUnitName(String internshipUnitName){return employmentsDao.getEmploymentsByInternshipUnitName(internshipUnitName);}
}
