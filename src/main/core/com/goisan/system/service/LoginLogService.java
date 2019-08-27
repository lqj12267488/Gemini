package com.goisan.system.service;

import com.goisan.system.bean.LoginLog;
import com.goisan.system.bean.LoginParameter;

import java.util.List;

/**
 * Created by admin on 2017/5/9.
 */
public interface LoginLogService {

    List<LoginLog> getLoginLogOrderEmp(String PersonId);

    List<LoginLog> getLoginLogOrderStudent(String PersonId);

    List<LoginLog> getLoginLogOrderParent(String PersonId);

    List<LoginLog> getLoginLog();

    List<LoginLog> getLoginLogByPersonId(String PersonId);

    List<LoginLog> delectLoginLog(LoginLog loginLogs);

    void insertLoginLog(LoginLog loginLogs);

    List<LoginLog> getLoginLogByAccountTime(LoginLog loginLogs);

    LoginParameter getLoginParameter();
}
