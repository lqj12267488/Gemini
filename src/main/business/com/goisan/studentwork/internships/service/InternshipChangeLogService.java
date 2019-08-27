package com.goisan.studentwork.internships.service;

import com.goisan.studentwork.internships.bean.InternshipChangeLog;

import java.util.List;

/**
 * Created by hanyu on 2017/8/3.
 */
public interface InternshipChangeLogService {
    List<InternshipChangeLog> getInternshipChangeLogList(String logId);
    void insertInternshipChangeLog(InternshipChangeLog internshipChangeLog);
    List<InternshipChangeLog> InternshipChangeLogAction(InternshipChangeLog internshipChangeLog);
    List<InternshipChangeLog> InternshipChangeLogActionById(InternshipChangeLog internshipChangeLog);
    InternshipChangeLog getInternshipChangeLogById(String logId);
    InternshipChangeLog getInternshipChangeLogId(String logId);
    void updateInternshipChangeLogById(InternshipChangeLog internshipChangeLog);
    void deleteInternshipChangeLogById(String logId);
    InternshipChangeLog selectNewId(String internshipId);
    void updateInternshipManage(InternshipChangeLog internshipChangeLog);
    List<InternshipChangeLog> selectInternshipChangeLogList(String internshipId);
    void updateInternshipManageChangeLog(InternshipChangeLog internshipChangeLog);
}
