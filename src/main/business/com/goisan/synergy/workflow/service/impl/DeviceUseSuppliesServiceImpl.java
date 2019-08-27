package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.dao.DeviceUseSuppliesDao;
import com.goisan.synergy.workflow.service.DeviceUseSuppliesService;
import com.goisan.system.bean.UserDic;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/5/17.
 */
@Service
public class DeviceUseSuppliesServiceImpl implements DeviceUseSuppliesService {
    @Resource
    private DeviceUseSuppliesDao deviceUseSuppliesDao;
    public List<UserDic> deviceUseSuppliesAction(UserDic userDic) {
        return deviceUseSuppliesDao.deviceUseSuppliesAction(userDic);
    }

    public void insertDeviceUseSupplies(UserDic userDic) {
        deviceUseSuppliesDao.insertDeviceUseSupplies(userDic);
    }

    public UserDic getDeviceUseSuppliesById(String id) {
        return deviceUseSuppliesDao.getDeviceUseSuppliesById(id);
    }

    public void updateDeviceUseSupplies(UserDic userDic) {
        deviceUseSuppliesDao.updateDeviceUseSupplies(userDic);
    }

    public void deleteDeviceUseSuppliesById(String id) {
        deviceUseSuppliesDao.deleteDeviceUseSuppliesById(id);
    }

    /*public void deletedeviceUseSuppliesResourceByRoleid(String id) {
        deviceUseSuppliesDao.deleteDeviceUseSuppliesResourceByRoleid(id);
    }*/

    public List<UserDic> getCompleteDeviceUseSuppliesList(UserDic userDic) {
        return deviceUseSuppliesDao.getCompleteDeviceUseSuppliesList(userDic);
    }

    public List<UserDic> checkName(UserDic userDic) {
        return deviceUseSuppliesDao.checkName(userDic);
    }

    public List<UserDic> checkCode(UserDic userDic) {
        return deviceUseSuppliesDao.checkCode(userDic);
    }

    public List<UserDic> checkOrder(UserDic userDic) {
        return deviceUseSuppliesDao.checkOrder(userDic);
    }


}
