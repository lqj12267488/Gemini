package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.Computer;
import com.goisan.synergy.workflow.bean.SoftInstall;
import com.goisan.synergy.workflow.dao.ComputerDao;
import com.goisan.synergy.workflow.service.ComputerService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Role;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/5/4.
 */
@Service
public class ComputerServiceImpl implements ComputerService {
    @Resource
    private ComputerDao computerDao;
    public List<Computer> computerAction(Computer computer) {
        return computerDao.computerAction(computer);
    }
    public Computer getComputerById(String id) {
        return computerDao.getComputerById(id);
    }
    public Computer getComputerId(String id){return computerDao.getComputerId(id);}
    public void insertComputer(Computer computer) {
        computerDao.insertComputer(computer);
    }
    public void updateComputer(Computer computer) {
        computerDao.updateComputer(computer);
    }
    public void deleteComputerById(String id) {
        computerDao.deleteComputerById(id);
    }
    public List<Computer> getComputerList(Computer computer) {
        return computerDao.getComputerList(computer);
    }

    public List<AutoComplete> selectDept()  {
        return computerDao.selectDept();
    }

    public List<AutoComplete> selectPerson() {
        return computerDao.selectPerson();
    }

    public List<Computer> getProcessComputerList(Computer computer) {
        return computerDao.getProcessComputerList(computer);
    }

    public List<Computer> getCompleteComputerList(Computer computer) {
        return computerDao.getCompleteComputerList(computer);
    }

}
