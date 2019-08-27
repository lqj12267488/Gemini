package com.goisan.studentwork.employments.dao;

import com.goisan.studentwork.employments.bean.EmploymentManage;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by hanyu on 2017/8/11.
 */
@Repository
public interface EmploymentManageDao {
    List<EmploymentManage> getEmploymentManageList(String employmentId);
    void insertEmploymentManage(EmploymentManage employmentManage);
    List<EmploymentManage> EmploymentManageAction(EmploymentManage employmentManage);
    EmploymentManage getEmploymentManageById(String employmentId);
    void updateEmploymentManageById(EmploymentManage employmentManage);
    void deleteEmploymentManageById(String employmentId);
    EmploymentManage selectId(String employmentId);
    List<EmploymentManage> selectEmploymentStatistics(EmploymentManage employmentManage);
    String selectEmploymentArea(String employmentUnitId);
    String selectEmploymentType(String employmentId);
    List<EmploymentManage> employmentSelectStatistics(EmploymentManage employmentManage);
}
