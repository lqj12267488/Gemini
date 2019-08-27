package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.DeviceBorrow;
import com.goisan.synergy.workflow.dao.DeviceBorrowDao;
import com.goisan.synergy.workflow.service.DeviceBorrowService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/7/20.
 */
@Service
public class DeviceBorrowServiceImpl implements DeviceBorrowService{
    @Resource
    private DeviceBorrowDao deviceBorrowDao;
    public List<DeviceBorrow> getDeviceBorrowList(DeviceBorrow deviceBorrow){return deviceBorrowDao.getDeviceBorrowList(deviceBorrow);}
    public void insertDeviceBorrow(DeviceBorrow deviceBorrow){ deviceBorrowDao.insertDeviceBorrow(deviceBorrow);}
    public DeviceBorrow getDeviceBorrowById(String id){return deviceBorrowDao.getDeviceBorrowById(id);}
    public void updateDeviceBorrowById(DeviceBorrow deviceBorrow){ deviceBorrowDao.updateDeviceBorrowById(deviceBorrow);}
    public void deleteDeviceBorrowById(String id){ deviceBorrowDao.deleteDeviceBorrowById(id);}
    public List<AutoComplete> autoCompleteDept(){ return deviceBorrowDao.autoCompleteDept(); }
    public List<AutoComplete> autoCompleteEmployee(){ return deviceBorrowDao.autoCompleteEmployee(); }
    public List<DeviceBorrow> getProcessList(DeviceBorrow deviceBorrow){return deviceBorrowDao.getProcessList(deviceBorrow);}
    public List<DeviceBorrow> getCompleteList(DeviceBorrow deviceBorrow){return deviceBorrowDao.getCompleteList(deviceBorrow);}
    public String getPersonNameById(String personId){return deviceBorrowDao.getPersonNameById(personId);}
    public String getDeptNameById(String deptId){return deviceBorrowDao.getDeptNameById(deptId);}
}
