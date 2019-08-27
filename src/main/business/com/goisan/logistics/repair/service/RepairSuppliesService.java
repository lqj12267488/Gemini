package com.goisan.logistics.repair.service;

import com.goisan.logistics.repair.bean.RepairSupplies;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by hanyu on 2017/5/24.
 */
public interface RepairSuppliesService {
    List<RepairSupplies> RepairSuppliesAction(RepairSupplies repairSupplies);

    void updateSuppliesInNum(RepairSupplies repairSupplies);

    void deleteRepairSuppliesById(String id);

    void updateRepairSuppliesById(RepairSupplies repairSupplies);

    void insertRepairSupplies(RepairSupplies repairSupplies);

    RepairSupplies getRepairSuppliesById(String id);

    List<RepairSupplies> getRepairSuppliesList(RepairSupplies repairSupplies);

    List<AutoComplete> selectDept();

    List<AutoComplete> selectPerson();

    List<RepairSupplies> RepairSuppliesComplete(RepairSupplies repairSupplies);

    RepairSupplies getById(String id);

    String getSuppliesInnum(String id);

    String getName(String id);

    void saveAddSupplies(RepairSupplies repairSupplies);

    void updateSuppliesFlag(RepairSupplies repairSupplies);

    void updateSuppliesnum(RepairSupplies repairSupplies);

    void deleteSupplies(String id);

    int countByReapairId(String repairId);
}
