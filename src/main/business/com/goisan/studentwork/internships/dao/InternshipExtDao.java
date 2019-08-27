package com.goisan.studentwork.internships.dao;

import com.goisan.studentwork.internships.bean.InternshipExt;
import com.goisan.studentwork.internships.bean.InternshipManage;
import com.goisan.studentwork.internships.bean.Internships;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by hanyu on 2017/8/1.
 */

@Repository
public interface InternshipExtDao {
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
