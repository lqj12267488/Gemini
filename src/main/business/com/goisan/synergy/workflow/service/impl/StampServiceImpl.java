package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.Stamp;
import com.goisan.synergy.workflow.dao.StampDao;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.Handle;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by znw on 2017/5/6.
 */
@Service
public class StampServiceImpl implements StampService{
    @Resource
    private StampDao stampDao;

    public List<Stamp> getStampList(Stamp stamp) {
        return stampDao.getStampList(stamp);
    }

    public void insertStamp(Stamp stamp) {
        stampDao.insertStamp(stamp);
    }

    public void updateStampAPP(Stamp stamp) {
        stampDao.updateStampAPP(stamp);
    }

    public Stamp getStampById(String id) {

        return stampDao.getStampById(id);
    }

    public void updateStampById(Stamp Stamp) {
        stampDao.updateStampById(Stamp);
    }

    public void deleteStampById(String id) {
        stampDao.deleteStampById(id);
    }

    public List<AutoComplete> autoCompleteDept() {
        return stampDao.autoCompleteDept();
    }

    public List<AutoComplete> autoCompleteEmployee() {
        return stampDao.autoCompleteEmployee();
    }

    public List<Stamp> getProcessList(Stamp stamp) {
        return stampDao.getProcessList(stamp);
    }

    public List<Stamp> getCompleteList(Stamp stamp) {
        return stampDao.getCompleteList(stamp);
    }

    public String getPersonNameById(String personId) {
        return stampDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return stampDao.getDeptNameById(deptId);
    }

    public String getStateById(String id) { return stampDao.getStateById(id);}

    public List<Handle> getHandlebyId(String id) { return stampDao.getHandlebyId(id);}
}
