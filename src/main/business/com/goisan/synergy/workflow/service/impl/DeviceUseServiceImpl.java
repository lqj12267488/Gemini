package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.DeviceUse;
import com.goisan.synergy.workflow.dao.DeviceUseDao;
import com.goisan.synergy.workflow.service.DeviceUseService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/5/6/006.
 */
@Service
public class DeviceUseServiceImpl implements DeviceUseService {
    @Resource

    private DeviceUseDao deviceUseDao;

    public List<DeviceUse> deviceUseAction(DeviceUse deviceUse) {
        return deviceUseDao.deviceUseAction(deviceUse);
    }

    public void insertDeviceUse(DeviceUse deviceUse) {
        deviceUseDao.insertDeviceUse(deviceUse);
    }

    public DeviceUse getDeviceUseById(String id) {
        return deviceUseDao.getDeviceUseById(id);
    }

    public void updateDeviceUse(DeviceUse deviceUse) {
        deviceUseDao.updateDeviceUse(deviceUse);

    }

    public void deleteDeviceUseById(String id) {
        deviceUseDao.deleteDeviceUseById(id);
    }

    public void deleteDeviceUseResourceByRoleid(String id) {
        deviceUseDao.deleteDeviceUseResourceByRoleid(id);
    }

    public List<AutoComplete> selectDept() {
        return deviceUseDao.selectDept();
    }

    public List<AutoComplete> selectPerson() {
        return deviceUseDao.selectPerson();
    }

    public List<DeviceUse> getDeviceUseListProcess(DeviceUse deviceUse) {
        return deviceUseDao.getDeviceUseListProcess(deviceUse);
    }
    public List<DeviceUse> getDeviceUseListComplete(DeviceUse deviceUse) {
        return deviceUseDao.getDeviceUseListComplete(deviceUse);
    }

    public String getPersonNameById(String personId) {
        return  deviceUseDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return deviceUseDao.getDeptNameById(deptId);
    }
}
