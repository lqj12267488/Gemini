package com.goisan.educational.score.service.impl;

import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.score.dao.StudentExamScoreDao;
import com.goisan.educational.score.service.StudentExamScoreService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wq on 2017/10/18.
 */
@Service
public class StudentExamScoreServiceImpl implements StudentExamScoreService{
    @Resource
    StudentExamScoreDao studentExamScoreDao;
    public List<ScoreImport> getStudentExamList(ScoreImport scoreImport){
        return studentExamScoreDao.getStudentExamList(scoreImport);
    }
    public List<ScoreImport> getStudentExamClassList(ScoreImport scoreImport){
        return studentExamScoreDao.getStudentExamClassList(scoreImport);
    }
    public List<ScoreImport> getStudentExamScoreList(ScoreImport scoreImport){
        return studentExamScoreDao.getStudentExamScoreList(scoreImport);
    }

    @Override
    public List<ScoreImport> getExamRole(String loginid) {
        return studentExamScoreDao.getExamRole(loginid);
    }
}
