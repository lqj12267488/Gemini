package com.goisan.synergy.workflow.service;
import java.util.List;

import com.goisan.synergy.workflow.bean.Computer;
import com.goisan.synergy.workflow.bean.SoftInstall;
import com.goisan.system.bean.AutoComplete;

/**
 * Created by Administrator on 2017/5/4.
 */
public interface ComputerService {
    List<Computer> computerAction(Computer computer);
    void insertComputer(Computer computer);
    Computer getComputerById(String id);
    Computer getComputerId(String id);
    void updateComputer(Computer computer);
    void deleteComputerById(String id);
    List<Computer>  getComputerList(Computer computer);
    List<AutoComplete> selectDept();
    List<AutoComplete> selectPerson();
    List<Computer> getProcessComputerList(Computer computer);
    List<Computer> getCompleteComputerList(Computer computer);

}
