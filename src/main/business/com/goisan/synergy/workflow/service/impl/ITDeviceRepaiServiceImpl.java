package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.ITDeviceRepai;
import com.goisan.synergy.workflow.dao.ITDeviceRepaiDao;
import com.goisan.synergy.workflow.service.ITDeviceRepaiService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/5/6 0006.
 */
@Service
public class ITDeviceRepaiServiceImpl implements ITDeviceRepaiService {
    @Resource
    private ITDeviceRepaiDao itDeviceRepaiDao;
    public List<ITDeviceRepai> ITDeviceAction(ITDeviceRepai itDeviceRepai) {
        return itDeviceRepaiDao.ITDeviceAction(itDeviceRepai);
    }

    public List<ITDeviceRepai> iTDeviceComplete(ITDeviceRepai itDeviceRepai) {
        return itDeviceRepaiDao.iTDeviceComplete(itDeviceRepai);
    }

    public List<ITDeviceRepai> iTDeviceProcess(ITDeviceRepai itDeviceRepai) {
        return itDeviceRepaiDao.iTDeviceProcess(itDeviceRepai);
    }

    public void deleteITDeviceById(String id) {
       itDeviceRepaiDao.deleteITDeviceById(id);
    }

    public ITDeviceRepai getITDeviceById(String id) {
        return itDeviceRepaiDao.getITDeviceById(id);
    }

    public void updateITDeviceById(ITDeviceRepai itDeviceRepai) {
        itDeviceRepaiDao.updateITDeviceById(itDeviceRepai);
    }

    public void insertITDevice(ITDeviceRepai itDeviceRepai) {
        itDeviceRepaiDao.insertITDevice(itDeviceRepai);
    }

    public void updateITDeviceAPP(ITDeviceRepai itDeviceRepai) {
        itDeviceRepaiDao.updateITDeviceAPP(itDeviceRepai);
    }

    public List<ITDeviceRepai> getITDeviceList(ITDeviceRepai itDeviceRepai) {
        return itDeviceRepaiDao.getITDeviceList(itDeviceRepai);
    }

    public List<AutoComplete> selectDept() {
        return itDeviceRepaiDao.selectDept();
    }

    public List<AutoComplete> selectPerson() {
        return itDeviceRepaiDao.selectPerson();
    }
}
