package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.ITSuppliesRepair;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by Administrator on 2017/5/4 0004.
 */
public interface ITSuppliesRepairService {
    List<ITSuppliesRepair> ITSuppliesRepairAction(ITSuppliesRepair itSuppliesRepair);
    void deleteITSuppliesRepairById(String id);
    ITSuppliesRepair getITSuppliesRepairById(String id);
    void updateITSuppliesRepairById(ITSuppliesRepair itSuppliesRepair);
    void insertITSuppliesRepair(ITSuppliesRepair itSuppliesRepair);
    void updateITSuppliesRepairAPP(ITSuppliesRepair itSuppliesRepair);
    List<ITSuppliesRepair>  getITSuppliesRepairList(ITSuppliesRepair itSuppliesRepair);
    List<AutoComplete> selectDept();
    List<AutoComplete> selectPerson();
    List<ITSuppliesRepair> getProcessList(ITSuppliesRepair iTSuppliesRepair);
    List<ITSuppliesRepair> getCompleteList(ITSuppliesRepair iTSuppliesRepair);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
}
