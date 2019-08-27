package com.goisan.studentwork.internships.service.impl;

import com.goisan.studentwork.internships.bean.InternshipChangeLog;
import com.goisan.studentwork.internships.dao.InternshipChangeLogDao;
import com.goisan.studentwork.internships.service.InternshipChangeLogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/8/3.
 */
@Service
public class InternshipChangeLogServiceImpl implements InternshipChangeLogService{
    @Resource
    private InternshipChangeLogDao internshipChangeLogDao;
    public List<InternshipChangeLog> getInternshipChangeLogList(String logId){
        return internshipChangeLogDao.getInternshipChangeLogList(logId);
    }
    public void insertInternshipChangeLog(InternshipChangeLog internshipChangeLog){
        internshipChangeLogDao.insertInternshipChangeLog(internshipChangeLog);
    }
    public List<InternshipChangeLog> InternshipChangeLogAction(InternshipChangeLog internshipChangeLog){
        return internshipChangeLogDao.InternshipChangeLogAction(internshipChangeLog);
    }
    public InternshipChangeLog getInternshipChangeLogById(String logId){
        return internshipChangeLogDao.getInternshipChangeLogById(logId);
    }
    public InternshipChangeLog getInternshipChangeLogId(String logId){
        return internshipChangeLogDao.getInternshipChangeLogId(logId);
    }
    public void updateInternshipChangeLogById(InternshipChangeLog internshipChangeLog){
        internshipChangeLogDao.updateInternshipChangeLogById(internshipChangeLog);
    }
    public void deleteInternshipChangeLogById(String logId){
        internshipChangeLogDao.deleteInternshipChangeLogById(logId);
    }
    public List<InternshipChangeLog> InternshipChangeLogActionById(InternshipChangeLog internshipChangeLog){
        return internshipChangeLogDao.InternshipChangeLogActionById(internshipChangeLog);
    }
    public InternshipChangeLog selectNewId(String internshipId){return internshipChangeLogDao.selectNewId(internshipId);}
    public void updateInternshipManage(InternshipChangeLog internshipChangeLog){internshipChangeLogDao.updateInternshipManage(internshipChangeLog);}
    public List<InternshipChangeLog> selectInternshipChangeLogList(String internshipId){
        return internshipChangeLogDao.selectInternshipChangeLogList(internshipId);
    }
    public void updateInternshipManageChangeLog(InternshipChangeLog internshipChangeLog){
        internshipChangeLogDao.updateInternshipManageChangeLog(internshipChangeLog);
    }
}
