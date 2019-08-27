package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.Computer;
import com.goisan.synergy.workflow.bean.SoftInstall;
import com.goisan.system.bean.AutoComplete;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/5/4.
 */
@Repository
public interface ComputerDao {
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
