package com.goisan.logistics.repair.service.impl;

import com.goisan.logistics.repair.bean.RepairSupplies;
import com.goisan.logistics.repair.service.RepairSuppliesService;

import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/5/24.
 */
@Service
public class RepairSuppliesServiceImpl implements RepairSuppliesService {
    @Resource
    private com.goisan.logistics.repair.dao.RepairSuppliesDao RepairSuppliesDao;

    public void updateSuppliesInNum(RepairSupplies repairSupplies){
        RepairSuppliesDao.updateSuppliesInNum(repairSupplies);
    }

    public List<RepairSupplies> RepairSuppliesAction(RepairSupplies RepairSupplies) {
        return RepairSuppliesDao.RepairSuppliesAction(RepairSupplies);
    }

    public void deleteRepairSuppliesById(String id) {
        RepairSuppliesDao.deleteRepairSuppliesById(id);
    }

    public void updateRepairSuppliesById(RepairSupplies RepairSupplies) {
        RepairSuppliesDao.updateRepairSuppliesById(RepairSupplies);
    }

    public void insertRepairSupplies(RepairSupplies RepairSupplies) {
        RepairSuppliesDao.insertRepairSupplies(RepairSupplies);
    }

    public RepairSupplies getRepairSuppliesById(String id) {
        return RepairSuppliesDao.getRepairSuppliesById(id);
    }

    public List<RepairSupplies> getRepairSuppliesList(RepairSupplies RepairSupplies) {
        return RepairSuppliesDao.getRepairSuppliesList(RepairSupplies);
    }

    public List<AutoComplete> selectDept() {
        return RepairSuppliesDao.selectDept();
    }

    public List<AutoComplete> selectPerson() {
        return RepairSuppliesDao.selectPerson();
    }

    public List<RepairSupplies> RepairSuppliesComplete(RepairSupplies RepairSupplies) {
        return RepairSuppliesDao.RepairSuppliesComplete(RepairSupplies);
    }

    public RepairSupplies getById(String id) {
        return RepairSuppliesDao.getById(id);
    }

    public String getSuppliesInnum(String id) {
        return RepairSuppliesDao.getSuppliesInnum(id);
    }

    public String getName(String id) {
        return RepairSuppliesDao.getName(id);
    }

    public void saveAddSupplies(RepairSupplies repairSupplies) {
        RepairSuppliesDao.saveAddSupplies(repairSupplies);
    }

    public void updateSuppliesFlag(RepairSupplies repairSupplies) {
        RepairSuppliesDao.updateSuppliesFlag(repairSupplies);
    }

    public void updateSuppliesnum(RepairSupplies repairSupplies) {
        RepairSuppliesDao.updateSuppliesnum(repairSupplies);
    }

    public void deleteSupplies(String id) {
        RepairSuppliesDao.deleteSupplies(id);
    }

    @Override
    public int countByReapairId(String repairId) {
        return RepairSuppliesDao.countByReapairId(repairId);
    }
}
