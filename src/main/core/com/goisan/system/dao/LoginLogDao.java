package com.goisan.system.dao;

import com.goisan.system.bean.LoginLog;
import com.goisan.system.bean.LoginParameter;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by admin on 2017/5/9.
 */
@Repository
public interface LoginLogDao {

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
