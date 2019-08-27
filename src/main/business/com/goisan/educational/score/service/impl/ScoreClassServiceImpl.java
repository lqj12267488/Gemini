package com.goisan.educational.score.service.impl;

import com.goisan.educational.score.bean.ScoreClass;
import com.goisan.educational.score.bean.ScoreCourse;
import com.goisan.educational.score.dao.ScoreClassDao;
import com.goisan.educational.score.service.ScoreClassService;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.TableDict;
import com.goisan.system.bean.Tree;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/10/12.
 */
@Service
public class ScoreClassServiceImpl implements ScoreClassService {
    @Resource
    private ScoreClassDao scoreClassDao;

    public List<ScoreClass> getScoreClassList(ScoreClass scoreClass){
        return scoreClassDao.getScoreClassList(scoreClass);
    }

    public ScoreClass getScoreClassById(String scoreClassId){
        return scoreClassDao.getScoreClassById(scoreClassId);
    }

    public void insertScoreClass (ScoreClass scoreClass){
         scoreClassDao.insertScoreClass(scoreClass);
    }

    public void updateScoreClassById(ScoreClass scoreClass){
        scoreClassDao.updateScoreClassById(scoreClass);
    }

    public void deleteScoreClassById(String scoreClassId){
        scoreClassDao.deleteScoreClassById(scoreClassId);
    }

    public ScoreCourse selectScoreCourse(String subjectId){
        return scoreClassDao.selectScoreCourse(subjectId);
    }

    public List<Tree> getClassTreeByScoreClass(){
        return scoreClassDao.getClassTreeByScoreClass();
    }

    public List<ScoreClass> getClassByScoreClassId(String scoreClassId){
        return scoreClassDao.getClassByScoreClassId(scoreClassId);
    }

    public List<ScoreClass> getClassByScoreId(String scoreClassId){
        return scoreClassDao.getClassByScoreId(scoreClassId);
    }

    public void delScoreClass(String scoreClassId){
        scoreClassDao.delScoreClass(scoreClassId);
        scoreClassDao.delScoreByClassId(scoreClassId);
    }

    public void updateScoreClassListByScoreClassId(String scoreClassId){

    }

    public void saveClass(String[] tmp, String scoreClassId){
        ScoreClass scoreClass = scoreClassDao.getClassByScoreId(scoreClassId).get(0);
        System.out.println(scoreClass.getDepartmentsId());
        scoreClassDao.delScoreClass(scoreClassId);
        for (int i = 0 ; i < tmp.length ; i ++){
            scoreClass.setClassId(tmp[i]);
            scoreClass.setScoreClassId(CommonUtil.getUUID());
            scoreClassDao.saveScoreClassAll(scoreClass);
        }
        scoreClassDao.updateScoreClassListByScoreClassId(scoreClassId);
    }
    public void insertScoreClassSubject (ScoreCourse scoreCourse){
        scoreClassDao.insertScoreClassSubject(scoreCourse);
    }
    public List<Object> selectScoreClassSubjectId(String subjectId){
        return scoreClassDao.selectScoreClassSubjectId(subjectId);
    }
    public void deleteScoreClassByClass(ScoreClass scoreClass){
        scoreClassDao.deleteScoreClassByClass(scoreClass);
    }

    public List<ScoreClass> getScoreClassByIds(String scoreClassIds){
        return scoreClassDao.getScoreClassByIds(scoreClassIds);
    }

    public void updatePersonIdByScore(String scoreClassId){
        scoreClassDao.updatePersonIdByScore(scoreClassId);
    }

    public List<Select2> getScoreClassTableDict(TableDict tableDict){
        return scoreClassDao.getScoreClassTableDict(tableDict);
    }
}
