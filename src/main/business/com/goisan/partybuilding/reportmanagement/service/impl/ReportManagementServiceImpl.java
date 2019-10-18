package com.goisan.partybuilding.reportmanagement.service.impl;

import com.goisan.partybuilding.reportmanagement.bean.ReportManagement;
import com.goisan.partybuilding.reportmanagement.dao.ReportManagementDao;
import com.goisan.partybuilding.reportmanagement.service.ReportManagementService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ReportManagementServiceImpl implements ReportManagementService {
    @Resource
    private ReportManagementDao reportManagementDao;

    @Override
    public List<ReportManagement> getReportManagementList(ReportManagement reportManagement) {
        return reportManagementDao.getReportManagementList(reportManagement);
    }

    @Override
    public List<ReportManagement> reportManagementProcessList(ReportManagement reportManagement) {
        return reportManagementDao.reportManagementProcessList(reportManagement);
    }

    @Override
    public List<ReportManagement> reportManagementCompleteList(ReportManagement reportManagement) {
        return reportManagementDao.reportManagementCompleteList(reportManagement);
    }

    @Override
    public ReportManagement getReportManagementById(String id) {
        return reportManagementDao.getReportManagementById(id);
    }

    @Override
    public void deleteById(String id) {
        reportManagementDao.deleteById(id);
    }

    @Override
    public void insertReportManagement(ReportManagement reportManagement) {
        reportManagementDao.insertReportManagement(reportManagement);
    }

    @Override
    public void updateReportManagement(ReportManagement reportManagement) {
        reportManagementDao.updateReportManagement(reportManagement);
    }

    @Override
    public List<ReportManagement> getReportManagementDetailList(String id) {
        return reportManagementDao.getReportManagementDetailList(id);
    }

    @Override
    public String getWorkFlowbyBusinessId(String id) {
        return reportManagementDao.getWorkFlowbyBusinessId(id);
    }

    @Override
    public void updateLoanPrintNum(String id) {
        reportManagementDao.updateLoanPrintNum(id);
    }
}
