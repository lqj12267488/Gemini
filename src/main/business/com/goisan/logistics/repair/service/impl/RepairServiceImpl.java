package com.goisan.logistics.repair.service.impl;

import com.goisan.logistics.repair.bean.Repair;
import com.goisan.logistics.repair.bean.RepairSupplies;
import com.goisan.logistics.repair.dao.RepairDao;
import com.goisan.logistics.repair.service.RepairService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class RepairServiceImpl implements RepairService {
    @Resource
    private RepairDao repairDao;

    public List<Repair> RepairAction(Repair repair) {
        return repairDao.RepairAction(repair);
    }

    public void insertRepair(Repair repair) {
        repairDao.insertRepair(repair);
    }

    public void updateRepair(Repair repair) {
        repairDao.updateRepair(repair);
    }

    public void deleteRepairById(String id) {
        repairDao.deleteRepairById(id);
    }

    public Repair getRepairById(String id) {
        return repairDao.getRepairById(id);
    }

    public List<Repair> distributionInfo(Repair repair) {
        return repairDao.distributionInfo(repair);
    }

    public List<Repair> searchgetDistribution(Repair repair) {
        return repairDao.searchgetDistribution(repair);
    }

    public List<Repair> RepairManAction(Repair repair) {
        return repairDao.RepairManAction(repair);
    }

    public void repairFenPei(Repair repair) {
        repairDao.repairFenPei(repair);
    }

    public void submitRepair(Repair repair) {
        repairDao.submitRepair(repair);
    }

    public void insertRepairMan(Repair repair) {
        repairDao.insertRepairMan(repair);
    }

    public void updateRepairMan(Repair repair) {
        repairDao.updateRepairMan(repair);
    }

    public Repair getRepairManById(String id) {
        return repairDao.getRepairManById(id);
    }

    public void delRepairMan(String id) {
        repairDao.delRepairMan(id);
    }

    public List<Repair> repairDefine(Repair repair) {
        return repairDao.repairDefine(repair);
    }

    public void insertContent(Repair repair) {
        repairDao.insertContent(repair);
    }

    public void YesRepair(Repair repair, String type) {
        if(type.equals("2")){
            repairDao.YesRepairExecute(repair);
        }
        else {
            repairDao.YesRepair(repair);
        }
        repairDao.updateRepairResult(repair);
    }

    public Repair searchFenPei(String repairID) {
        return repairDao.searchFenPei(repairID);
    }

    public List<Repair> repairInfo(Repair repair) {
        return repairDao.repairInfo(repair);
    }

    public List<Repair> checkInfo(Repair repair) {
        return repairDao.checkInfo(repair);
    }

    public List<AutoComplete> selectPerson() {
        return repairDao.selectPerson();
    }

    public List<Repair> searchCheckPerson(Repair repair) {
        return repairDao.searchCheckPerson(repair);
    }

    public void updateCheckerMan(Repair repair) {
        repairDao.updateCheckerMan(repair);
    }

    public List<Repair> checkDefine(Repair repair) {
        return repairDao.checkDefine(repair);
    }

    public List<Repair> selectCheck(Repair repair) {
        return repairDao.selectCheck(repair);
    }

    public void YesCheck(Repair repair) {
        repairDao.YesCheck(repair);
    }

    public void saveFeedBack(Repair repair) {
        repairDao.saveFeedBack(repair);
    }

    public List<Repair> checkPersonID(Repair repair) {
        return repairDao.checkPersonID(repair);
    }

    public List<RepairSupplies> getRepairItemList(RepairSupplies repairSupplies) {
        return repairDao.getRepairItemList(repairSupplies);
    }

    public Repair getRepairListInfo(String repairID) {
        return repairDao.getRepairListInfo(repairID);
    }

    @Override
    public List<Repair> checkRepairList(Repair repair) {
        return repairDao.checkRepairList(repair);
    }

    public List<Repair> getRepairByRepairMan(String id) {
        return repairDao.getRepairByRepairMan(id);
    }

    @Override
    public List<Repair> repairAdminList(Repair repair) {
        return repairDao.repairAdminList(repair);
    }

    @Override
    public List<Repair> checkAdminID(Repair repair) {
        return repairDao.checkAdminID(repair);
    }

    @Override
    public void insertRepairAdmin(Repair repair) {
        repairDao.insertRepairAdmin(repair);
    }

    @Override
    public Repair getRepairAdminById(String id) {
        return repairDao.getRepairAdminById(id);
    }

    @Override
    public void updateRepairAdmin(Repair repair) {
        repairDao.updateRepairAdmin(repair);
    }

    @Override
    public void delRepairAdmin(String id) {
        repairDao.delRepairAdmin(id);
    }

    @Override
    public void insertRepairLog(Repair repair) {
        repairDao.insertRepairLog(repair);
    }

    @Override
    public List<Repair> getPeopleId(String repairid) {
        return repairDao.getPeopleId(repairid);
    }

    @Override
    public void insertRepairExecute(Repair repair) {
        repairDao.insertRepairExecute(repair);
    }
    @Override
    public void deletePeople(Repair repair) {
        repairDao.deletePeople(repair);
    }

    @Override
    public List<Repair> getRepairExecute(String repairID) {
        return repairDao.getRepairExecute(repairID);
    }

    @Override
    public List<Repair> checkRequestFlag(Repair repair) {
        return repairDao.checkRequestFlag(repair);
    }

    @Override
    public void closeRepair(String repairId) {
        repairDao.closeRepair(repairId);
    }

    @Override
    public List<AutoComplete> getItemName() {
        return repairDao.getItemName();
    }
    @Override
    public Repair getRepairByRepairIdApp(Repair repair){
        return repairDao.getRepairByRepairIdApp(repair);
    }

    /**
     * 移动端通过维修任务id获取报修详细信息
     * @param repair
     * @return
     */
    @Override
    public Repair getRepairByRepairExecuteIdApp(Repair repair){
        return repairDao.getRepairByRepairExecuteIdApp(repair);
    }
    /**
     * 获取维修人员树
     * @return
     */
    @Override
    public List<Select2> getRepairPersonTree(){
        return repairDao.getRepairPersonTree();
    }
    /**
     * 获取维修任务数据根据repairID
     * @return
     */
    @Override
    public List<Repair> getRepairExecuteByRepairId(String repairID){
        return repairDao.getRepairExecuteByRepairId(repairID);
    }

    @Override
    public void repairChenXiaoFenPei(Repair repair){
        repairDao.repairChenXiaoFenPei(repair);
    }

    @Override
    public Repair selectDistributionInfo(String repairID) {
        return repairDao.selectDistributionInfo(repairID);
    }

    @Override
    public List<Repair> RepairActionInfo(String personId) {
        return repairDao.RepairActionInfo(personId);
    }

    @Override
    public List<Repair> RepairActionInfoList(String personId) {
        return repairDao.RepairActionInfoList(personId);
    }

    @Override
    public void saveFeedbackInfo(String feedbackFlag, String fback, String id) {
        Repair repair = new Repair();
        repair.setRepairID(id);
        repair.setFeedback(fback);
        repair.setFeedbackFlag(feedbackFlag);
        repairDao.saveFeedbackInfo(repair);
    }

    @Override
    public String selectName(String creator) {
        return repairDao.selectName(creator);
    }

    @Override
    public void updateConfirmTime(Date date,String repairID) {
        Repair repair = new Repair();
        repair.setRepairID(repairID);
        repair.setConfirmTime1(date);
        repairDao.updateConfirmTime(repair);
    }


}
