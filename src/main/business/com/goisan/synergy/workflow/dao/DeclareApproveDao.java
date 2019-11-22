package com.goisan.synergy.workflow.dao;

import com.goisan.personnel.leave.bean.Leave;
import com.goisan.synergy.workflow.bean.DeclareApprove;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface DeclareApproveDao {
    List<DeclareApprove> getDeclareApproveList(DeclareApprove declareApprove);
    List<AutoComplete> autoCompleteDept();
    List<AutoComplete> autoCompleteEmployee();
    List<DeclareApprove> getProcessList(DeclareApprove declareApprove);
    List<DeclareApprove> getCompleteList(DeclareApprove declareApprove);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
    DeclareApprove getLeaveById(String id);
    DeclareApprove getCancelById(String id);
}
