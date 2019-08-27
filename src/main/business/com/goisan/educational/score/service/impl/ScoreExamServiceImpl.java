package com.goisan.educational.score.service.impl;

import com.goisan.educational.score.bean.ScoreExam;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.score.dao.ScoreExamDao;
import com.goisan.educational.score.service.ScoreExamService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wq on 2017/10/12.
 */
@Service
public class ScoreExamServiceImpl implements ScoreExamService{
    @Resource
    private ScoreExamDao scoreExamDao;

    public List<ScoreExam> getScoreExamList(ScoreExam scoreExam){
        return scoreExamDao.getScoreExamList(scoreExam);
    }
    public ScoreExam getScoreExamById(String id){
        return scoreExamDao.getScoreExamById(id);
    }
    public void insertScoreExam(ScoreExam scoreExam){
        scoreExamDao.insertScoreExam(scoreExam);
    }
    public void updateScoreExamById(ScoreExam scoreExam){
        scoreExamDao.updateScoreExamById(scoreExam);
    }
    public void deleteScoreExamById(String id){
        scoreExamDao.deleteScoreExamById(id);
        scoreExamDao.deleteSubjectByExamId(id);
        scoreExamDao.deleteClassByExamId(id);
        scoreExamDao.deleteScoreByExamId(id);
    }
    public void openScoreExam(String scoreExamId){
        scoreExamDao.openScoreExam(scoreExamId);
    }
    public List<ScoreExam> getOpenScoreExamList(ScoreExam scoreExam){
        return scoreExamDao.getOpenScoreExamList(scoreExam);
    }
    public List<ScoreImport> getOpenScoreList(ScoreImport scoreImport){
        return scoreExamDao.getOpenScoreList(scoreImport);
    }

    public List<ScoreExam> getScoreMakeupListByMakeup(ScoreExam scoreExam){return scoreExamDao.getScoreMakeupListByMakeup(scoreExam);}

    @Override
    public List<ScoreImport> getStuOpenScoreExamList(ScoreImport scoreImport) {
        return scoreExamDao.getStuOpenScoreExamList(scoreImport);
    }

    @Override
    public List<ScoreImport> getStuOpenScoreList(ScoreImport scoreImport) {
        return scoreExamDao.getStuOpenScoreList(scoreImport);
    }

    @Override
    public List<ScoreImport> getTeaOpenScoreExamList(ScoreImport scoreImport) {
        return scoreExamDao.getTeaOpenScoreExamList(scoreImport);
    }

    @Override
    public List<ScoreImport> getTeaOpenScoreList(ScoreImport scoreImport) {
        return scoreExamDao.getTeaOpenScoreList(scoreImport);
    }

    @Override
    public List<ScoreImport> getTeaOpenScoreList2(ScoreImport scoreImport) {
        return scoreExamDao.getTeaOpenScoreList2(scoreImport);
    }

    @Override
    public List<ScoreImport> getScoreRoleByPersonId(String roleId, String id) {
        return scoreExamDao.getScoreRoleByPersonId(roleId,id);
    }
}
