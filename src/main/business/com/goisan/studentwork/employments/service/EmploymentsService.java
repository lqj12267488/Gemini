package com.goisan.studentwork.employments.service;

import com.goisan.studentwork.employments.bean.EmploymentManage;
import com.goisan.studentwork.employments.bean.Employments;

import java.util.List;

/**
 * Created by hanyu on 2017/8/11.
 */
public interface EmploymentsService {
    List<Employments> getEmploymentsList(String employmentUnitId);
    void insertEmployments(Employments employments);
    void insertEmployments1(Employments employments);
    List<Employments> EmploymentsAction(Employments employments);
    Employments getEmploymentsById(String employmentUnitId);
    void updateEmploymentsById(Employments employments);
    void deleteEmploymentsById(String employmentUnitId);
    Employments selectId(String employmentUnitId);
    Employments employmentList(String employmentUnitId);
    List<EmploymentManage> getEmploymentsByInternshipUnitName(String internshipUnitName);
}
