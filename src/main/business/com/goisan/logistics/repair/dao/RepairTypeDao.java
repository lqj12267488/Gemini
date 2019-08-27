package com.goisan.logistics.repair.dao;

import com.goisan.system.bean.UserDic;
import org.springframework.stereotype.Repository;

import java.util.List;

/**报修类型管理
 * Created by wq on 2017/5/26.
 */
@Repository
public interface RepairTypeDao {
    List<UserDic> repairTypeAction(UserDic userDic);
    void insertRepairType(UserDic userDic);
    void deleteRepairTypeById(String id);
    void updateRepairType(UserDic userDic);
    UserDic getRepairTypeById(String id);
    List<UserDic> getRepairTypeList(UserDic userDic);
    List<UserDic> checkName(UserDic userDic);
    List<UserDic> checkCode(UserDic userDic);
    List<UserDic> checkOrder(UserDic userDic);
    List<String> getRepairTypeNoOrder();
}
