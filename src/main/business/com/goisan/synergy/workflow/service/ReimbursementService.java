package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.Reimbursement;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.IndexUnAudti;

import java.util.List;

public interface ReimbursementService {
    List<Reimbursement> reimbursementInfo(Reimbursement reimbursement);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
    void insertReimbursement(Reimbursement reimbursement);
    void updateReimbursement(Reimbursement reimbursement);
    void deleteReimbursement(String id);
    Reimbursement getReimbursementById(String id);
    List<Reimbursement> getReimbursementProcess(Reimbursement reimbursement);
    List<Reimbursement> getReimbursementComplete(Reimbursement reimbursement);
    List<AutoComplete> selectDept();
    List<AutoComplete> selectPerson();
    String getWorkflowIdByWorkflowCode(String workflowCode);
    List<IndexUnAudti> getUnRelationList(String workflowId, String personId, String id, String wid);
    List<IndexUnAudti> getRelationListById(String personId, String wid, String id);
}
