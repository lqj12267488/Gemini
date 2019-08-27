package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.ITDeviceRepai;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by Administrator on 2017/5/6 0006.
 */
public interface ITDeviceRepaiService {
     List<ITDeviceRepai> ITDeviceAction(ITDeviceRepai itDeviceRepai);
    List<ITDeviceRepai> iTDeviceProcess(ITDeviceRepai itDeviceRepai);
    List<ITDeviceRepai> iTDeviceComplete(ITDeviceRepai itDeviceRepai);
    void deleteITDeviceById(String id);
    ITDeviceRepai getITDeviceById(String id);
    void updateITDeviceById(ITDeviceRepai itDeviceRepai);
    void insertITDevice(ITDeviceRepai itDeviceRepai);
    void updateITDeviceAPP(ITDeviceRepai itDeviceRepai);
    List<ITDeviceRepai>  getITDeviceList(ITDeviceRepai itDeviceRepai);
    List<AutoComplete> selectDept();
    List<AutoComplete> selectPerson();
}
