package com.goisan.educational.teacher.service;

import com.goisan.educational.exam.bean.Exam;
import com.goisan.educational.exam.bean.ExamArray;
import com.goisan.educational.score.bean.ScoreExam;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.teacher.bean.TeacherCondition;
import com.goisan.educational.teacher.bean.WorkLoadCheck;

import java.util.List;

/**
 * Created by wq on 2017/10/12.
 */
public interface WorkLoadService {
    List<WorkLoadCheck> getWorkLoadCheckList(WorkLoadCheck workLoadCheck);
    WorkLoadCheck selectWorkLoadCheckById(String teacherId);
    void delWorkLoadCheckById(String teacherId);
    void updatetWorkLoad(WorkLoadCheck workLoadCheck);
    void insertWorkLoad(WorkLoadCheck workLoadCheck);
}
