package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.ITSuppliesRepair;
import com.goisan.synergy.workflow.service.ITSuppliesRepairService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/5/3 0003.
 */
@Service
public class ITSuppliesRepairServiceImpl implements ITSuppliesRepairService {

    @Resource
    private com.goisan.synergy.workflow.dao.ITSuppliesRepairDao ITSuppliesRepairDao;
    public List<ITSuppliesRepair> ITSuppliesRepairAction(ITSuppliesRepair ITSuppliesRepair) {
        return ITSuppliesRepairDao.ITSuppliesRepairAction(ITSuppliesRepair);
    }

    public void deleteITSuppliesRepairById(String id) {
        ITSuppliesRepairDao.deleteITSuppliesRepairById(id);
    }

    public ITSuppliesRepair getITSuppliesRepairById(String id) {
        return ITSuppliesRepairDao.getITSuppliesRepairById(id);
    }

    public void updateITSuppliesRepairById(ITSuppliesRepair ITSuppliesRepair) {
        ITSuppliesRepairDao.updateITSuppliesRepairById(ITSuppliesRepair);
    }

    public void insertITSuppliesRepair(ITSuppliesRepair ITSuppliesRepair) { ITSuppliesRepairDao.insertITSuppliesRepair(ITSuppliesRepair);}

    public void updateITSuppliesRepairAPP(ITSuppliesRepair itSuppliesRepair) {
        ITSuppliesRepairDao.updateITSuppliesRepairAPP(itSuppliesRepair);
    }

    public List<ITSuppliesRepair> getITSuppliesRepairList(ITSuppliesRepair ITSuppliesRepair) {
        return ITSuppliesRepairDao.getITSuppliesRepairList(ITSuppliesRepair);
    }

    public List<AutoComplete> selectDept()  {
        return ITSuppliesRepairDao.selectDept();
    }

    public List<AutoComplete> selectPerson() {
        return ITSuppliesRepairDao.selectPerson();
    }

    public List<ITSuppliesRepair> getProcessList(ITSuppliesRepair iTSuppliesRepair) {
        return ITSuppliesRepairDao.getProcessList(iTSuppliesRepair);
    }

    public List<ITSuppliesRepair> getCompleteList(ITSuppliesRepair iTSuppliesRepair) {
        return ITSuppliesRepairDao.getCompleteList(iTSuppliesRepair);
    }

    public String getPersonNameById(String personId) {
        return ITSuppliesRepairDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return ITSuppliesRepairDao.getDeptNameById(deptId);
    }

}
