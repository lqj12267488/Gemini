package com.goisan.synergy.workflow.dao;


import com.goisan.synergy.workflow.bean.DeviceUse;
import com.goisan.synergy.workflow.bean.SoftInstall;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/5/6/006.
 */
@Repository
public interface DeviceUseDao {
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
