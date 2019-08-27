package com.goisan.logistics.repair.service.impl;

import com.goisan.logistics.repair.dao.RepairTypeDao;
import com.goisan.logistics.repair.service.RepairTypeService;
import com.goisan.system.bean.UserDic;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**报修类型管理
 * Created by wq on 2017/5/26.
 */
@Service
public class RepairTypeServiceImpl implements RepairTypeService {
    @Resource
    private RepairTypeDao repairTypeDao;
    public List<UserDic> repairTypeAction(UserDic userDic) {
        return repairTypeDao.repairTypeAction(userDic);
    }

    public void insertRepairType(UserDic userDic) {
        repairTypeDao.insertRepairType(userDic);
    }
    public void deleteRepairTypeById(String id) {
        repairTypeDao.deleteRepairTypeById(id);
    }
    public void updateRepairType(UserDic userDic) {
        repairTypeDao.updateRepairType(userDic);
    }
    public UserDic getRepairTypeById(String id) {
        return repairTypeDao.getRepairTypeById(id);
    }
    public List<UserDic> getRepairTypeList(UserDic userDic) {
        return repairTypeDao.getRepairTypeList(userDic);
    }

    public List<UserDic> checkName(UserDic userDic) {
        return repairTypeDao.checkName(userDic);
    }
    public List<UserDic> checkCode(UserDic userDic) {
        return repairTypeDao.checkCode(userDic);
    }
    public List<UserDic> checkOrder(UserDic userDic) {
        return repairTypeDao.checkOrder(userDic);
    }

    public List<String> getRepairTypeNoOrder(){return repairTypeDao.getRepairTypeNoOrder();}
}
