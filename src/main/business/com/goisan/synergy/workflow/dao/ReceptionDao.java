package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.Reception;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReceptionDao {
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
