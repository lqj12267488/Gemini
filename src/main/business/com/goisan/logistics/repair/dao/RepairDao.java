package com.goisan.logistics.repair.dao;

import com.goisan.logistics.repair.bean.Repair;
import com.goisan.logistics.repair.bean.RepairSupplies;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Files;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import com.sun.org.apache.regexp.internal.RE;

import java.util.Date;
import java.util.List;

public interface RepairDao {
    List<Repair> RepairAction(Repair repair);
    void insertRepair(Repair repair);
    void updateRepair(Repair repair);
    void deleteRepairById(String id);
    Repair getRepairById(String id);
    List<Repair> distributionInfo(Repair repair);
    List<Repair> searchgetDistribution(Repair repair);
    List<Repair> RepairManAction(Repair repair);
    void repairFenPei(Repair repair);
    void submitRepair(Repair repair);
    void insertRepairMan(Repair repair);
    void updateRepairMan(Repair repair);
    Repair getRepairManById(String id);
    void delRepairMan(String id);
    List<Repair> repairDefine(Repair repair);
    void YesRepair(Repair repair);
    void insertContent(Repair repair);
    Repair searchFenPei(String repairID);
    List<Repair> repairInfo(Repair repair);
    List<Repair> checkInfo(Repair repair);
    List<AutoComplete> selectPerson();
    List<Repair> searchCheckPerson(Repair repair);
    void updateCheckerMan(Repair repair);
    List<Repair> checkDefine(Repair repair);
    List<Repair> selectCheck(Repair repair);
    void YesCheck(Repair repair);
    void saveFeedBack(Repair repair);
    List<Repair> checkPersonID(Repair repair);
    List<RepairSupplies> getRepairItemList(RepairSupplies repairSupplies);
    Repair getRepairListInfo(String repairID);
    List<Repair> checkRepairList(Repair repair);
    List<Repair> getRepairByRepairMan(String id);
    List<Repair> repairAdminList(Repair repair);
    List<Repair> checkAdminID(Repair repair);
    void insertRepairAdmin(Repair repair);
    Repair getRepairAdminById(String id);
    void updateRepairAdmin(Repair repair);
    void delRepairAdmin(String id);
    void insertRepairLog(Repair repair);
    List<Repair> getPeopleId(String repairid);
    void insertRepairExecute(Repair repair);
    void deletePeople(Repair repair);
    List<Repair> getRepairExecute(String repairID);
    void YesRepairExecute(Repair repair);
    List<Repair> checkRequestFlag(Repair repair);
    void closeRepair(String repairId);
    List<AutoComplete> getItemName();
    void updateRepairResult(Repair repair);
    Repair selectDistributionInfo(String repairID);
    /**
     * 移动端通过报修id获取报修详细信息
     * @param repair
     * @return
     */
    Repair getRepairByRepairIdApp(Repair repair);

    /**
     * 移动端通过维修任务id获取报修详细信息
     * @param repair
     * @return
     */
    Repair getRepairByRepairExecuteIdApp(Repair repair);
    /**
     * 获取维修人员树
     * @return
     */
    List<Select2> getRepairPersonTree();

    /**
     * 获取维修任务数据根据repairID
     * @return
     */
    List<Repair> getRepairExecuteByRepairId(String repairID);

    /**
     * 修改维修信息请求状态
     * @param repair
     */
    void repairChenXiaoFenPei(Repair repair);

    List<Repair> RepairActionInfo(String personId);

    List<Repair> RepairActionInfoList(String personId);

    void saveFeedbackInfo(Repair repair);

    String selectName(String creator);

    void updateConfirmTime(Repair repair);

    String getNameByPersonId(String creator);

    void repairDisMan(Repair repair);

    Files selectUploadFiles(String id);

    Repair getRepairById1(String id);
}
