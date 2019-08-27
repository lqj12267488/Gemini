package com.goisan.studentwork.internships.service;

import com.goisan.studentwork.internships.bean.InternshipManage;
import com.goisan.system.bean.Student;

import java.util.List;

/**
 * Created by hanyu on 2017/8/1.
 */
public interface InternshipManageService {
    List<InternshipManage> getInternshipManageList(String internshipId);
    void insertInternshipManage(InternshipManage internshipManage);
    List<InternshipManage> InternshipManageAction(InternshipManage internshipManage);
    InternshipManage getInternshipManageById(String internshipId);
    void updateInternshipManageById(InternshipManage internshipManage);
    void deleteInternshipManageById(String internshipId);
    InternshipManage select(String internshipId);
    InternshipManage selectId(String internshipId);
    InternshipManage selectNewId(String internshipId);
    void updateInternshipManage(InternshipManage internshipManage);
    String selectNewInternshipUnitId(String internshipId);
    InternshipManage getInternshipManage(String internshipId);
    List<InternshipManage> selectInternshipManage(String internshipId);
    Student selectStudent(String studentNumber);
    String selectArea(String internshipId);
    String selectInternshipType(String internshipId);
}
