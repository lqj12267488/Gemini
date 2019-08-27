package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.Reimbursement;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.IndexUnAudti;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReimbursementDao {
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
    List<IndexUnAudti> getUnRelationList(@Param("workflowId") String workflowId, @Param("personId") String personId, @Param("id") String id, @Param("wid") String wid);
    List<IndexUnAudti> getRelationListById(@Param("personId") String personId, @Param("wid") String wid, @Param("id") String id);
}
