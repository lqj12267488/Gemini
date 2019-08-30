package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.Reception;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

public interface ReceptionService {
    List<Reception> getReceptionList(Reception reception);
    void insertReception(Reception reception);
    Reception getReceptionById(String id);
    void updateReceptionById(Reception reception);
    void deleteReceptionById(String id);
    List<AutoComplete> autoCompleteDept();
    List<AutoComplete> autoCompleteEmployee();
    List<Reception> getProcessList(Reception reception);
    List<Reception> getCompleteList(Reception reception);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
}
