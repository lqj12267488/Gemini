package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.Reception;
import com.goisan.synergy.workflow.dao.ReceptionDao;
import com.goisan.synergy.workflow.service.ReceptionService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ReceptionServiceImpl implements ReceptionService {
    @Resource
    private ReceptionDao receptionDao;

    public List<Reception> getReceptionList(Reception reception){
        return receptionDao.getReceptionList(reception);
    }
    public void insertReception(Reception reception){
        receptionDao.insertReception(reception);
    }
    public Reception getReceptionById(String id){
        return receptionDao.getReceptionById(id);
    }
    public void updateReceptionById(Reception reception){
        receptionDao.updateReceptionById(reception);
    }
    public void deleteReceptionById(String id){
        receptionDao.deleteReceptionById(id);
    }
    public List<AutoComplete> autoCompleteDept(){
        return receptionDao.autoCompleteDept();
    }
    public List<AutoComplete> autoCompleteEmployee(){
        return receptionDao.autoCompleteEmployee();
    }
    public List<Reception> getProcessList(Reception reception){
        return receptionDao.getProcessList(reception);
    }
    public List<Reception> getCompleteList(Reception reception){
        return receptionDao.getCompleteList(reception);
    }
    public String getPersonNameById(String personId){
        return receptionDao.getPersonNameById(personId);
    }
    public String getDeptNameById(String deptId){
        return receptionDao.getDeptNameById(deptId);
    }
}
