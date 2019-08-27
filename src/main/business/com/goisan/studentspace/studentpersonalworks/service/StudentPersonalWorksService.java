package com.goisan.studentspace.studentpersonalworks.service;

import com.goisan.approval.bean.ResourcePrivate;
import com.goisan.educational.place.dorm.bean.Dorm;
import com.goisan.studentspace.studentpersonalworks.bean.StudentPersonalWorks;
import com.goisan.studentwork.dormitory.bean.DormAdjustLog;
import com.goisan.studentwork.dormitory.bean.DormAdjustResult;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by mcq on 2017/8/21.
 */
public interface StudentPersonalWorksService {

    List<StudentPersonalWorks> getPersonalWorksList(StudentPersonalWorks studentPersonalWorks);

    void saveStudentPersonalWorks(StudentPersonalWorks studentPersonalWorks);

    StudentPersonalWorks getStudentPersonalWorksById(String id);

    void updateStudentPersonalWorks(StudentPersonalWorks studentPersonalWorks);

    void delStudentPersonalWorks(String id);
}
