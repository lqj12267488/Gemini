package com.goisan.personnel.leave.service.impl;

import com.goisan.personnel.leave.bean.Leave;
import com.goisan.personnel.leave.dao.LeaveDao;
import com.goisan.personnel.leave.service.LeaveService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/7/20.
 */
@Service
public class LeaveServiceImpl implements LeaveService {
    @Resource
    private LeaveDao leaveDao;
    public List<Leave> getLeaveList(Leave leave){return leaveDao.getLeaveList(leave);}
    public void insertLeave(Leave leave){ leaveDao.insertLeave(leave);}

    public void updateLeaveAPP(Leave leave) {
        leaveDao.updateLeaveAPP(leave);
    }

    public Leave getLeaveById(String id){return leaveDao.getLeaveById(id);}
    public void updateLeaveById(Leave leave){leaveDao.updateLeaveById(leave);}
    public void deleteLeaveById(String id){ leaveDao.deleteLeaveById(id);}
    public List<AutoComplete> autoCompleteDept(){return leaveDao.autoCompleteDept();}
    public List<AutoComplete> autoCompleteEmployee(){return leaveDao.autoCompleteEmployee();}
    public List<Leave> getProcessList(Leave leave){return leaveDao.getProcessList(leave);}
    public List<Leave> getCompleteList(Leave leave){return leaveDao.getCompleteList(leave);}
    public String getPersonNameById(String personId){return leaveDao.getPersonNameById(personId);}
    public String getDeptNameById(String deptId){return leaveDao.getDeptNameById(deptId);}
    public List<Leave> getLeaveCancelList(Leave leave){return leaveDao.getLeaveCancelList(leave);}
    public Leave getLeaveBy(String id){return leaveDao.getLeaveBy(id);}
}
