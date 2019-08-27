package com.goisan.system.dao;

import com.goisan.system.bean.EmpChangeLog;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by admin on 2017/6/28.
 */
@Repository
public interface EmpChangeLogDao {
    List<EmpChangeLog> getEmpChangeLogList(EmpChangeLog empChangeLog);

    Select2 getDeptNameByPersonId(String personId);

    Select2 getStatusByPersonId(String personId);

    void saveLog(EmpChangeLog empChangeLog);
}
