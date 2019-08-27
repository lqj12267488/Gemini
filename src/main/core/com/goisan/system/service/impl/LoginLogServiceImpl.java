package com.goisan.system.service.impl;

import com.goisan.system.bean.LoginLog;
import com.goisan.system.bean.LoginParameter;
import com.goisan.system.dao.LoginLogDao;
import com.goisan.system.service.LoginLogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by admin on 2017/5/9.
 */
@Service
public class LoginLogServiceImpl implements LoginLogService {
    @Resource
    private LoginLogDao loginLogDao;

    public List<LoginLog> getLoginLogOrderEmp(String PersonId){
        return loginLogDao.getLoginLogOrderEmp(PersonId);
    }
    public List<LoginLog> getLoginLogOrderStudent(String PersonId){
        return loginLogDao.getLoginLogOrderStudent(PersonId);
    }
    public List<LoginLog> getLoginLogOrderParent(String PersonId){
        return loginLogDao.getLoginLogOrderParent(PersonId);
    }
    public List<LoginLog> getLoginLog() {
        return loginLogDao.getLoginLog();
    }

    public List<LoginLog> getLoginLogByPersonId(String PersonId) {
        return loginLogDao.getLoginLogByPersonId(PersonId);
    }

    public List<LoginLog> delectLoginLog(LoginLog loginLogs) {
        return loginLogDao.delectLoginLog(loginLogs);
    }

    public void insertLoginLog(LoginLog loginLogs) {
        loginLogDao.insertLoginLog(loginLogs);
    }

    public List<LoginLog> getLoginLogByAccountTime(LoginLog loginLogs){
        return loginLogDao.getLoginLogByAccountTime(loginLogs);
    }

    public LoginParameter getLoginParameter() {
        return loginLogDao.getLoginParameter();
    }
}
