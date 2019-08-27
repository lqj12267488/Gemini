package com.goisan.studentwork.employments.dao;

import com.goisan.studentwork.employments.bean.EmploymentManage;
import com.goisan.studentwork.employments.bean.Employments;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by hanyu on 2017/8/11.
 */
@Repository
public interface EmploymentsDao {
    List<Employments> getEmploymentsList(String employmentUnitId);
    void insertEmployments(Employments employments);
    void insertEmployments1(Employments employments);
    List<Employments> EmploymentsAction(Employments employments);
    Employments getEmploymentsById(String employmentUnitId);
    void updateEmploymentsById(Employments employments);
    void deleteEmploymentsById(String employmentUnitId);
    Employments selectId(String employmentUnitId);
    Employments employmentList(String employmentUnitId);
    List<Bean> bean();
    List<EmploymentManage> getEmploymentsByInternshipUnitName(String internshipUnitName);
}
