package com.goisan.system.service;

import com.goisan.system.bean.EmpChangeLog;
import com.goisan.system.bean.Select2;

import java.util.List;

/**
 * Created by admin on 2017/6/28.
 */
public interface EmpChangeLogService {

    List<EmpChangeLog> getEmpChangeLogList(EmpChangeLog empChangeLog);

    Select2 getDeptNameByPersonId(String personId);

    Select2 getStatusByPersonId(String personId);

    void saveLog(EmpChangeLog empChangeLog);


}
