package com.goisan.personnel.leave.service.impl;

import com.goisan.personnel.leave.bean.Leave;
import com.goisan.personnel.leave.bean.LeaveCancel;
import com.goisan.personnel.leave.dao.LeaveCancelDao;
import com.goisan.personnel.leave.service.LeaveCancelService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/7/21.
 */
@Service
public class LeaveCancelServiceImpl implements LeaveCancelService {
    @Resource
    private LeaveCancelDao leaveCancelDao;

    public List<LeaveCancel> getLeaveCancelList(LeaveCancel leaveCancel) {
        return leaveCancelDao.getLeaveCancelList(leaveCancel);
    }

    public void insertLeaveCancel(LeaveCancel leaveCancel) {
        leaveCancelDao.insertLeaveCancel(leaveCancel);
    }

    public LeaveCancel getLeaveCancelById(String id) {
        return leaveCancelDao.getLeaveCancelById(id);
    }

    public void updateLeaveCancelById(LeaveCancel leaveCancel) {
        leaveCancelDao.updateLeaveCancelById(leaveCancel);
    }

    public void deleteLeaveCancelById(String id) {
        leaveCancelDao.deleteLeaveCancelById(id);
    }

    public List<AutoComplete> autoCompleteDept() {
        return leaveCancelDao.autoCompleteDept();
    }

    public List<AutoComplete> autoCompleteEmployee() {
        return leaveCancelDao.autoCompleteEmployee();
    }

    public List<LeaveCancel> getProcessList(LeaveCancel leaveCancel) {
        return leaveCancelDao.getProcessList(leaveCancel);
    }

    public List<LeaveCancel> getCompleteList(LeaveCancel leaveCancel) {
        return leaveCancelDao.getCompleteList(leaveCancel);
    }
    public  LeaveCancel selectLeaveCancelId(String id){
        return leaveCancelDao.selectLeaveCancelId(id);
    }

    public String getPersonNameById(String personId) {
        return leaveCancelDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return leaveCancelDao.getDeptNameById(deptId);
    }
    public Leave getLeaveById(String id){return leaveCancelDao.getLeaveById(id);}
    public  List<LeaveCancel> selectLeaveCancelById(String id){
        return leaveCancelDao.selectLeaveCancelById(id);
    }
    public String selectId(String id){return leaveCancelDao.selectId(id);}
    public LeaveCancel getCancelById(String id){return leaveCancelDao.getCancelById(id);}
    public String selectFlag(String id){return leaveCancelDao.selectFlag(id);}
    public LeaveCancel getEditProcessById(String id){return leaveCancelDao.getEditProcessById(id);}
    public List<LeaveCancel> selectLeaveCancel(String id){return leaveCancelDao.selectLeaveCancel(id);}
    public LeaveCancel getById(String id){return leaveCancelDao.getById(id);}
    public List<LeaveCancel> getAllList(LeaveCancel leaveCancel){return leaveCancelDao.getAllList(leaveCancel);}
    public LeaveCancel selectOne(String id){return leaveCancelDao.selectOne(id);}
}