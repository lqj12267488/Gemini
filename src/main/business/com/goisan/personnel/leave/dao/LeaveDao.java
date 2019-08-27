package com.goisan.personnel.leave.dao;

import com.goisan.personnel.leave.bean.Leave;
import com.goisan.personnel.leave.bean.LeaveCancel;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by hanyu on 2017/7/20.
 */
@Repository
public interface LeaveDao {
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
