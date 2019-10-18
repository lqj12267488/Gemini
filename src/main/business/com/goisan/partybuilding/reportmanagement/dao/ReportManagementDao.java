package com.goisan.partybuilding.reportmanagement.dao;

import com.goisan.partybuilding.reportmanagement.bean.ReportManagement;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReportManagementDao {
    List<ReportManagement> getReportManagementList(ReportManagement reportManagement);

    List<ReportManagement> reportManagementProcessList(ReportManagement reportManagement);

    List<ReportManagement> reportManagementCompleteList(ReportManagement reportManagement);

    ReportManagement getReportManagementById(String id);

    void deleteById(String id);

    void insertReportManagement(ReportManagement reportManagement);

    void updateReportManagement(ReportManagement reportManagement);
    //查询关联事物是否有数据
    List<ReportManagement> getReportManagementDetailList(String id);
    //通过id查关联业务名称
    String getWorkFlowbyBusinessId(String id);

    void updateLoanPrintNum(String id);
}
