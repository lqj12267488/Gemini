package com.goisan.personnel.leave.service;

import com.goisan.personnel.leave.bean.Leave;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by hanyu on 2017/7/20.
 */
public interface LeaveService {
    List<Leave> getLeaveList(Leave leave);
    void insertLeave(Leave leave);
    void updateLeaveAPP(Leave leave);
    Leave getLeaveById(String id);
    void updateLeaveById(Leave leave);
    void deleteLeaveById(String id);
    List<AutoComplete> autoCompleteDept();
    List<AutoComplete> autoCompleteEmployee();
    List<Leave> getProcessList(Leave leave);
    List<Leave> getCompleteList(Leave leave);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
    List<Leave> getLeaveCancelList(Leave leave);
    Leave getLeaveBy(String id);
}
