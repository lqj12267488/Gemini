package com.goisan.studentwork.dormitory.dao;

import com.goisan.educational.exam.bean.Exam;
import com.goisan.educational.place.dorm.bean.Dorm;
import com.goisan.studentwork.dormitory.bean.DormAdjustLog;
import com.goisan.studentwork.dormitory.bean.DormAdjustResult;
import com.goisan.studentwork.dormitory.bean.DormAway;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.ClassBean;
import com.goisan.system.bean.Student;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by mcq on 2017/8/21.
 */
@Repository
public interface DormAdjustResultDao {
    List<Student> getDistributeList(Student student);

    List<DormAdjustResult> getAdjustmentList(DormAdjustResult dormAdjustResult);

    List<Student> getStudentByValue(@Param("check_value") String check_value);

    Student selectStudentByValue(@Param("check_value") String check_value);

    List<Student> getStudentByIds(@Param("ids") String ids);

    void insertDormAdjustResult(DormAdjustResult dormAdjustResult);

    void insertDormAdjustLog(DormAdjustLog dormAdjustLog);

    void updateStudentDormFlag(Student student);

    void updateDormNowNumber(Dorm dorm);

    String getDormOverplusNumber(String dormId);

    String getDormOriginalNowNumber(String dormId);

    void updateDormAdjustResult(DormAdjustResult dormAdjustResult);

    void updateDormAdjustLog(DormAdjustLog dormAdjustLog);

    void delDormAdjustResultById(@Param("ids") String ids);

    List<AutoComplete> autoCompleteStudentClassDorm();

    void updateOneStudentDormFlag(Student student);


    String getDormType(String dormId);

    String getDormName(String dormId);

    List<DormAdjustResult> selectDormAdjustResultByStudentId(@Param("ids") String ids);

    List<DormAdjustLog> getLogList(@Param("id") String id);

    String getClassIdByStudentId(String studentId);

    List<DormAway> getAwayList(DormAway dormAway);

    List<AutoComplete> autoCompleteStudentByAway(@Param("classId") String classId);

    String getDormNumberByAway(String studentId);

    void saveAwayDorm(DormAway dormAway);

}
