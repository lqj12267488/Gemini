package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.Declare;
import com.goisan.synergy.workflow.dao.DeclareDao;
import com.goisan.synergy.workflow.service.DeclareService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Emp;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import javax.annotation.Resource;
import java.util.List;

@Service
public class DeclareServiceImpl implements DeclareService {
    @Resource
    private DeclareDao declareDao;

    @Override
    public List<Declare> getDeclareList(Declare declare) {
        return declareDao.getDeclareList(declare);
    }

    @Override
    public void insertDeclare(Declare declare) {
        declareDao.insertDeclare(declare);
    }

    @Override
    public Declare getDeclareById(String id) {
        return declareDao.getDeclareById(id);
    }

    @Override
    public void updateDeclareById(Declare declare) {
        declareDao.updateDeclareById(declare);
    }

    @Override
    public void deleteDeclareById(String id) {
        declareDao.deleteDeclareById(id);
    }

    @Override
    public String getPersonNameById(String personId) {
        return declareDao.getPersonNameById(personId);
    }

    @Override
    public String getDeptNameById(String deptId) {
        return declareDao.getDeptNameById(deptId);
    }

    @Override
    public List<Declare> getProcessList(Declare declare) {
        return declareDao.getProcessList(declare);
    }

    @Override
    public List<AutoComplete> autoCompleteDept(Declare declare) {
        return declareDao.autoCompleteDept(declare);
    }

    @Override
    public List<AutoComplete> autoCompleteEmployee(Declare declare) {
        return declareDao.autoCompleteEmployee(declare);
    }

    @Override
    public List<Declare> getCompleteList(Declare declare) {
        return declareDao.getCompleteList(declare);
    }

    @Override
    public Declare getLeaveBy(String id) {
        return declareDao.getLeaveBy(id);
    }


    @Override
    public Emp getEmpByPersonId(String personId) {
        return declareDao.getEmpByPersonId(personId);
    }

    @Override
    public void insertDeclareApprove(Declare declare) {
        declareDao.insertDeclareApprove(declare);
    }
}
