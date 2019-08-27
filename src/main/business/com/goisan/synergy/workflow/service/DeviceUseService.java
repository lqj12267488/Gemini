package com.goisan.synergy.workflow.service;


import com.goisan.synergy.workflow.bean.DeviceUse;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by Administrator on 2017/5/6/006.
 */
public interface DeviceUseService {
    List<DeviceUse> deviceUseAction(DeviceUse deviceUse);

    void insertDeviceUse(DeviceUse deviceUse);

    DeviceUse getDeviceUseById(String id);

    void updateDeviceUse(DeviceUse deviceUse);

    void deleteDeviceUseById(String id);

    void deleteDeviceUseResourceByRoleid(String id);

    List<AutoComplete> selectDept();

    List<AutoComplete> selectPerson();

    List<DeviceUse> getDeviceUseListProcess(DeviceUse deviceUse);

    List<DeviceUse> getDeviceUseListComplete(DeviceUse deviceUse);

    String getPersonNameById (String personId);

    String getDeptNameById (String deptId);
}

