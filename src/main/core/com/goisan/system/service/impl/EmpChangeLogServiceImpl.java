package com.goisan.system.service.impl;

import com.goisan.system.bean.EmpChangeLog;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import com.goisan.system.dao.DeptDao;
import com.goisan.system.dao.EmpChangeLogDao;
import com.goisan.system.service.EmpChangeLogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by admin on 2017/6/28.
 */
@Service
public class EmpChangeLogServiceImpl implements EmpChangeLogService {
    @Resource
    private EmpChangeLogDao empChangeLogDao;

   public List<EmpChangeLog> getEmpChangeLogList(EmpChangeLog empChangeLog){
        return empChangeLogDao.getEmpChangeLogList(empChangeLog);
   }

   public Select2 getDeptNameByPersonId(String personId){
        return empChangeLogDao.getDeptNameByPersonId(personId);
   }

   public Select2 getStatusByPersonId(String personId){
        return empChangeLogDao.getStatusByPersonId(personId);
   }

    public void saveLog(EmpChangeLog empChangeLog){
        empChangeLogDao.saveLog(empChangeLog);
    }

}
