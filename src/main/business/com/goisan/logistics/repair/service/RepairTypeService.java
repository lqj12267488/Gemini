package com.goisan.logistics.repair.service;

import com.goisan.system.bean.UserDic;

import java.util.List;

/**报修类型管理
 * Created by wq on 2017/5/26.
 */
public interface RepairTypeService {
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
