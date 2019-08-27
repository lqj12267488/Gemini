package com.goisan.personnel.leave.dao;

import com.goisan.personnel.leave.bean.Leave;
import com.goisan.personnel.leave.bean.LeaveCancel;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by hanyu on 2017/7/21.
 */
@Repository
public interface LeaveCancelDao {
    List<LeaveCancel> getLeaveCancelList(LeaveCancel leaveCancel);
    void insertLeaveCancel(LeaveCancel leaveCancel);
    LeaveCancel getLeaveCancelById(String id);
    LeaveCancel getById(String id);
    Leave getLeaveById(String id);
    void updateLeaveCancelById(LeaveCancel leaveCancel);
    void deleteLeaveCancelById(String id);
    List<AutoComplete> autoCompleteDept();
    List<AutoComplete> autoCompleteEmployee();
    List<LeaveCancel> getProcessList(LeaveCancel leaveCancel);
    List<LeaveCancel> getCompleteList(LeaveCancel leaveCancel);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
    List<LeaveCancel> selectLeaveCancelById(String id);
    LeaveCancel selectLeaveCancelId(String id);
    List<LeaveCancel> selectLeaveCancel(String id);
    String selectId(String id);
    String selectFlag(String id);
    LeaveCancel getCancelById(String id);
    LeaveCancel getEditProcessById(String id);
    List<LeaveCancel> getAllList(LeaveCancel leaveCancel);
    LeaveCancel selectOne(String id);
}
