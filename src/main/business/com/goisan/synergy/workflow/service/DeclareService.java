package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.Declare;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Emp;

import java.util.List;

public interface DeclareService {
    List<Declare> getDeclareList(Declare declare);

    void insertDeclare(Declare declare);

    Declare getDeclareById(String id);

    void updateDeclareById(Declare declare);

    void deleteDeclareById(String id);

    String getPersonNameById(String personId);

    String getDeptNameById(String deptId);

    List<Declare> getProcessList(Declare declare);

    List<AutoComplete> autoCompleteDept(Declare declare);

    List<AutoComplete> autoCompleteEmployee(Declare declare);

    List<Declare> getCompleteList(Declare declare);

    Declare getLeaveBy(String id);

    Emp getEmpByPersonId(String personId);

    void insertDeclareApprove(Declare declare);

}
