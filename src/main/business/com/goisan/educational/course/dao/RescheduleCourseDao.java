package com.goisan.educational.course.dao;

import com.goisan.educational.course.bean.RescheduleCourse;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RescheduleCourseDao {

    List<RescheduleCourse> getRescheduleCourseList(RescheduleCourse rescheduleCourse);
    void insertRescheduleCourse(RescheduleCourse rescheduleCourse);

    RescheduleCourse getRescheduleCourseById(RescheduleCourse rescheduleCourse);
    void updRescheduleCourseById(RescheduleCourse rescheduleCourse);
    void delRescheduleCourseById(RescheduleCourse rescheduleCourse);
    void updRCWithSubmit(RescheduleCourse rescheduleCourse);
    RescheduleCourse getApproveRCById(RescheduleCourse rescheduleCourse);
    void updRCWithDeptApprove(RescheduleCourse rescheduleCourse);
    void updRCWithDeptOverrule(RescheduleCourse rescheduleCourse);
    RescheduleCourse getMajorSchoolByDeptId(RescheduleCourse rescheduleCourse);
    void updRCWithOfficeApprove(RescheduleCourse rescheduleCourse);
    void updRCWithOfficeOverrule(RescheduleCourse rescheduleCourse);
    void updRCWithOffOverNoDept(RescheduleCourse rescheduleCourse);
    void updRCWithOfficeAndDeptOverrule(RescheduleCourse rescheduleCourse);
    List<RescheduleCourse> getRCQueryList(RescheduleCourse rescheduleCourse);
    RescheduleCourse toExcelRCById (RescheduleCourse rescheduleCourse);
    String getTTKSPId(String tTKcode);

    void updRCWithOfficeSubmit(RescheduleCourse rescheduleCourse);


}
