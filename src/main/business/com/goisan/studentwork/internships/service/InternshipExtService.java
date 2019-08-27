package com.goisan.studentwork.internships.service;

import com.goisan.studentwork.internships.bean.InternshipExt;
import com.goisan.studentwork.internships.bean.Internships;

import java.util.List;

/**
 * Created by hanyu on 2017/8/1.
 */
public interface InternshipExtService {
    List<InternshipExt> getInternshipExtList(String id);
    void insertInternshipExt(InternshipExt internshipExt);
    List<InternshipExt> InternshipExtAction(InternshipExt internshipExt);
    List<InternshipExt> internshipExtActionById(InternshipExt internshipExt);
    InternshipExt getInternshipExtById(String id);
    InternshipExt getInternshipExtId(String id);
    void updateInternshipExtById(InternshipExt internshipExt);
    void deleteInternshipExtById(String id);
    InternshipExt selectId(String internshipUnitId);
    Internships selectString(String internshipUnitId);
}
