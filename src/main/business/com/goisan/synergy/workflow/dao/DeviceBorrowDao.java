package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.DeviceBorrow;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by hanyu on 2017/7/20.
 */
@Repository
public interface DeviceBorrowDao {
    List<DeviceBorrow> getDeviceBorrowList(DeviceBorrow deviceBorrow);
    void insertDeviceBorrow(DeviceBorrow deviceBorrow);
    DeviceBorrow getDeviceBorrowById(String id);
    void updateDeviceBorrowById(DeviceBorrow DeviceBorrow);
    void deleteDeviceBorrowById(String id);
    List<AutoComplete> autoCompleteDept();
    List<AutoComplete> autoCompleteEmployee();
    List<DeviceBorrow> getProcessList(DeviceBorrow deviceBorrow);
    List<DeviceBorrow> getCompleteList(DeviceBorrow deviceBorrow);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
}
