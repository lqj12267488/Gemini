package com.goisan.synergy.workflow.service;

import com.goisan.system.bean.UserDic;

import java.util.List;

/**
 * Created by Administrator on 2017/5/17.
 */
public interface DeviceUseSuppliesService {
    List<UserDic> deviceUseSuppliesAction(UserDic userDic);
    void insertDeviceUseSupplies(UserDic userDic);
    UserDic getDeviceUseSuppliesById(String id);
    void updateDeviceUseSupplies(UserDic userDic);
    void deleteDeviceUseSuppliesById(String id);
    List<UserDic> getCompleteDeviceUseSuppliesList(UserDic userDic);
    List<UserDic> checkName(UserDic userDic);
    List<UserDic> checkCode(UserDic userDic);
    List<UserDic> checkOrder(UserDic userDic);
}
