package com.goisan.synergy.workflow.service.impl;

import com.goisan.personnel.leave.bean.Leave;
import com.goisan.synergy.workflow.bean.DeclareApprove;
import com.goisan.synergy.workflow.dao.DeclareApproveDao;
import com.goisan.synergy.workflow.service.DeclareApproveService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class DeclareApproveServiceImpl implements DeclareApproveService {
    @Resource
    private DeclareApproveDao declareApproveDao;

    @Override
    public List<DeclareApprove> getDeclareApproveList(DeclareApprove declareApprove) {
        return declareApproveDao.getDeclareApproveList(declareApprove);
    }


    @Override
    public List<AutoComplete> autoCompleteDept() {
        return declareApproveDao.autoCompleteDept();
    }

    @Override
    public List<AutoComplete> autoCompleteEmployee() {
        return declareApproveDao.autoCompleteEmployee();
    }

    @Override
    public List<DeclareApprove> getProcessList(DeclareApprove declareApprove) {
        return declareApproveDao.getProcessList(declareApprove);
    }

    @Override
    public List<DeclareApprove> getCompleteList(DeclareApprove declareApprove) {
        return declareApproveDao.getCompleteList(declareApprove);
    }

    @Override
    public String getPersonNameById(String personId) {
        return declareApproveDao.getPersonNameById(personId);
    }

    @Override
    public String getDeptNameById(String deptId) {
        return declareApproveDao.getDeptNameById(deptId);
    }

    @Override
    public DeclareApprove getLeaveById(String id) {
        return declareApproveDao.getLeaveById(id);
    }


    @Override
    public DeclareApprove getCancelById(String id) {
        return declareApproveDao.getCancelById(id);
    }


}
