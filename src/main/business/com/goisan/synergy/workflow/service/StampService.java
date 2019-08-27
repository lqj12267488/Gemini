package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.Stamp;
import com.goisan.system.bean.AutoComplete;
import com.goisan.workflow.bean.Handle;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by mcq on 2017/5/6.
 */
public interface StampService {
    List<Stamp> getStampList(Stamp stamp);
    void insertStamp(Stamp stamp);
    void updateStampAPP(Stamp stamp);
    Stamp getStampById(String id);
    void updateStampById(Stamp Stamp);
    void deleteStampById(String id);
    List<AutoComplete> autoCompleteDept();
    List<AutoComplete> autoCompleteEmployee();
    List<Stamp> getProcessList(Stamp stamp);
    List<Stamp> getCompleteList(Stamp stamp);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
    String getStateById(String id);
    List<Handle> getHandlebyId(String id);
}
