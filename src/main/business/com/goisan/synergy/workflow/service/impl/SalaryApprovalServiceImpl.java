package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.SalaryApproval;
import com.goisan.synergy.workflow.dao.SalaryApprovalDao;
import com.goisan.synergy.workflow.service.SalaryApprovalService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/7/18.
 */
@Service
public class SalaryApprovalServiceImpl implements SalaryApprovalService {
    @Resource
    private SalaryApprovalDao salaryApprovalDao;

    public List<SalaryApproval> getSalaryApprovalList(SalaryApproval salaryApproval){
        return salaryApprovalDao.getSalaryApprovalList(salaryApproval);
    }
    public SalaryApproval getSalaryApprovalById(String id){
        return salaryApprovalDao.getSalaryApprovalById(id);
    }
    public void insertSalaryApproval(SalaryApproval salaryApproval){
        salaryApprovalDao.insertSalaryApproval(salaryApproval);
    }
    public void updateSalaryApproval(SalaryApproval salaryApproval){
        salaryApprovalDao.updateSalaryApproval(salaryApproval);
    }
    public void deleteSalaryApproval(SalaryApproval salaryApproval){
        salaryApprovalDao.deleteSalaryApproval(salaryApproval);
    }
    public void deleteSalaryApprovalById(String id){
        salaryApprovalDao.deleteSalaryApprovalById(id);
    }
    public List<AutoComplete> autoCompleteDept() {
        return salaryApprovalDao.autoCompleteDept();
    }

    public List<AutoComplete> autoCompleteEmployee() {
        return salaryApprovalDao.autoCompleteEmployee();
    }

    public List<SalaryApproval> getProcessList(SalaryApproval salaryApproval) {
        return salaryApprovalDao.getProcessList(salaryApproval);
    }

    public List<SalaryApproval> getCompleteList(SalaryApproval salaryApproval) {
        return salaryApprovalDao.getCompleteList(salaryApproval);
    }

    public String getPersonNameById(String personId) {
        return salaryApprovalDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return salaryApprovalDao.getDeptNameById(deptId);
    }

    public void insertSalaryApprovalImport(SalaryApproval salaryApproval){
        salaryApprovalDao.insertSalaryApprovalImport(salaryApproval);
    }
}
