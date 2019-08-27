package com.goisan.educational.teacher.service.impl;

import com.goisan.educational.exam.bean.ExamArray;
import com.goisan.educational.exam.bean.ExamRoomTeacher;
import com.goisan.educational.score.bean.ScoreExam;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.score.dao.ScoreExamDao;
import com.goisan.educational.score.service.ScoreExamService;
import com.goisan.educational.teacher.bean.WorkLoadCheck;
import com.goisan.educational.teacher.dao.WorkLoadDao;
import com.goisan.educational.teacher.service.WorkLoadService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wq on 2017/10/12.
 */
@Service
public class WorkLoadServiceImpl implements WorkLoadService {
    @Resource
    private WorkLoadDao workLoadDao;

    public List<WorkLoadCheck> getWorkLoadCheckList(WorkLoadCheck workLoadCheck){
        return workLoadDao.getWorkLoadCheckList(workLoadCheck);
    }
    public WorkLoadCheck selectWorkLoadCheckById(String teacherId) {
        return workLoadDao.selectWorkLoadCheckById(teacherId);
    }
    public void delWorkLoadCheckById(String teacherId) {
        workLoadDao.delWorkLoadCheckById(teacherId);
    }

    public void updatetWorkLoad(WorkLoadCheck workLoadCheck) {
        workLoadDao.updatetWorkLoad(workLoadCheck);
    }
    public void insertWorkLoad(WorkLoadCheck workLoadCheck) {
        workLoadDao.insertWorkLoad(workLoadCheck);
    }
}
