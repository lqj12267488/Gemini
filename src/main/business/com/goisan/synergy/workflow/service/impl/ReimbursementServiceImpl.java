package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.Reimbursement;
import com.goisan.synergy.workflow.dao.ReimbursementDao;
import com.goisan.synergy.workflow.service.ReimbursementService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.IndexUnAudti;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ReimbursementServiceImpl implements ReimbursementService {
    @Resource
    private ReimbursementDao reimbursementDao;

    public List<Reimbursement> reimbursementInfo(Reimbursement reimbursement) {
        return reimbursementDao.reimbursementInfo(reimbursement);
    }

    public String getPersonNameById(String personId) {
        return reimbursementDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return reimbursementDao.getDeptNameById(deptId);
    }

    public void insertReimbursement(Reimbursement reimbursement) {
        reimbursementDao.insertReimbursement(reimbursement);
    }

    public void updateReimbursement(Reimbursement reimbursement) {
        reimbursementDao.updateReimbursement(reimbursement);
    }

    public void deleteReimbursement(String id) {
        reimbursementDao.deleteReimbursement(id);
    }

    public Reimbursement getReimbursementById(String id) {
        return reimbursementDao.getReimbursementById(id);
    }

    public List<Reimbursement> getReimbursementProcess(Reimbursement reimbursement) {
        return reimbursementDao.getReimbursementProcess(reimbursement);
    }

    public List<Reimbursement> getReimbursementComplete(Reimbursement reimbursement) {
        return reimbursementDao.getReimbursementComplete(reimbursement);
    }

    public List<AutoComplete> selectDept() {
        return reimbursementDao.selectDept();
    }

    public List<AutoComplete> selectPerson() {
        return reimbursementDao.selectPerson();
    }

    public String getWorkflowIdByWorkflowCode(String workflowCode) {
        return reimbursementDao.getWorkflowIdByWorkflowCode(workflowCode);
    }

    public List<IndexUnAudti> getUnRelationList(String workflowId, String personId, String id, String wid) {
        return reimbursementDao.getUnRelationList(workflowId,personId,id,wid);
    }

    public List<IndexUnAudti> getRelationListById(String personId, String wid, String id) {
        return reimbursementDao.getRelationListById(personId,wid,id);
    }
}
