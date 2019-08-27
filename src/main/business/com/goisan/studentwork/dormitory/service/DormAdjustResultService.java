package com.goisan.studentwork.dormitory.service;

import com.goisan.educational.place.dorm.bean.Dorm;
import com.goisan.studentwork.dormitory.bean.DormAdjustLog;
import com.goisan.studentwork.dormitory.bean.DormAdjustResult;
import com.goisan.studentwork.dormitory.bean.DormAway;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.ClassBean;
import com.goisan.system.bean.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by mcq on 2017/8/21.
 */
public interface DormAdjustResultService {
    List<Student> getDistributeList(Student student);

    List<DormAdjustResult> getAdjustmentList(DormAdjustResult dormAdjustResult);

    List<Student> getStudentByValue(String check_value);

    List<Student> getStudentByIds(@Param("ids") String ids);

    Student selectStudentByValue(String check_value);

    void insertDormAdjustResult(DormAdjustResult dormAdjustResult);

    void insertDormAdjustLog(DormAdjustLog dormAdjustLog);

    void updateStudentDormFlag(Student student);

    void updateDormNowNumber(Dorm dorm);

    String getDormOverplusNumber(String dormId);

    String getDormOriginalNowNumber(String dormId);

    void updateDormAdjustResult(DormAdjustResult dormAdjustResult);

    void updateDormAdjustLog(DormAdjustLog dormAdjustLog);

    void delDormAdjustResultById(String ids);

    List<AutoComplete> autoCompleteStudentClassDorm();

    void updateOneStudentDormFlag(Student student);

    String getDormType(String dormId);

    String getDormName(String dormId);

    List<DormAdjustResult> selectDormAdjustResultByStudentId(String ids);

    List<DormAdjustLog> getLogList(String id);

    String getClassIdByStudentId(String id);

    void updateDormAdjustResult(String dormId,String id,String qsid);

    void saveDoublePerpleAdjust(String firstStudent,String firstClass,String firstDorm,String secondStudent,String secondClass,String secondDorm);

    void saveDoubleDormAdjust(String firstDorm,String secondDorm,String firstMemberId,String secondMemberId);

    void saveBackDorm(String ids,String check_value,String backType,String backTypeText);

    void saveDormAdjustResult(String dormId,String check_value,String count);

    List<DormAway> getAwayList(DormAway DormAway);

    List<AutoComplete> autoCompleteStudentByAway(String classId);

    String getDormNumberByAway(String studentId);

    void saveAwayDorm(DormAway dormAway);



}
