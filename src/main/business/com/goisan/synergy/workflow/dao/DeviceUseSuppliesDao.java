package com.goisan.synergy.workflow.dao;

import com.goisan.system.bean.UserDic;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/5/17.
 */
@Repository
public interface DeviceUseSuppliesDao {
    List<UserDic> deviceUseSuppliesAction(UserDic userDic);
    void insertDeviceUseSupplies(UserDic userDic);
    UserDic getDeviceUseSuppliesById(String id);
    void updateDeviceUseSupplies(UserDic userDic);
    void deleteDeviceUseSuppliesById(String id);
    void deleteDeviceUseSuppliesResourceByRoleid(String id);
    List<UserDic> getCompleteDeviceUseSuppliesList(UserDic userDic);
    List<UserDic> checkName(UserDic userDic);
    List<UserDic> checkCode(UserDic userDic);
    List<UserDic> checkOrder(UserDic userDic);
}
