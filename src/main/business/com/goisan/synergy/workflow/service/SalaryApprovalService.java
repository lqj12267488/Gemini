package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.SalaryApproval;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by hanyu on 2017/7/18.
 */
public interface SalaryApprovalService {
    List<SalaryApproval> getSalaryApprovalList(SalaryApproval salaryApproval);
    SalaryApproval getSalaryApprovalById(String id);
    void insertSalaryApproval(SalaryApproval salaryApproval);
    void updateSalaryApproval(SalaryApproval salaryApproval);
    void deleteSalaryApproval(SalaryApproval salaryApproval);
    void deleteSalaryApprovalById(String id);
    List<AutoComplete> autoCompleteDept();
    List<AutoComplete> autoCompleteEmployee();
    List<SalaryApproval> getProcessList(SalaryApproval salaryApproval);
    List<SalaryApproval> getCompleteList(SalaryApproval salaryApproval);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
    void insertSalaryApprovalImport(SalaryApproval salaryApproval);
}
