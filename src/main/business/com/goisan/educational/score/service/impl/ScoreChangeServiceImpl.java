package com.goisan.educational.score.service.impl;

import com.goisan.educational.score.bean.ScoreChange;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.score.dao.ScoreChangeDao;
import com.goisan.educational.score.service.ScoreChangeService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.EmpDeptRelation;
import com.goisan.system.bean.RoleEmpDeptRelation;
import com.goisan.system.bean.Student;
import com.goisan.workflow.bean.Handle;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ScoreChangeServiceImpl implements ScoreChangeService {
    @Resource
    private ScoreChangeDao scoreChangeDao;

    public List<ScoreChange> getScoreChangeList(ScoreChange scoreChange) {
        return scoreChangeDao.getScoreChangeList(scoreChange);
    }

    @Override
    public ScoreImport getScoreImportById2(String id) {
        return scoreChangeDao.getScoreImportById2(id);
    }

    public void insertScoreChange(ScoreChange scoreChange) {
        scoreChangeDao.insertScoreChange(scoreChange);
    }

    public ScoreChange getScoreChangeById(String id) {
        return scoreChangeDao.getScoreChangeById(id);
    }

    public void updateScoreChangeById(ScoreChange scoreChange) {
        scoreChangeDao.updateScoreChangeById(scoreChange);
    }

    public void deleteScoreChangeById(String id) {
        scoreChangeDao.deleteScoreChangeById(id);
    }

    public List<AutoComplete> autoCompleteDept() {
        return scoreChangeDao.autoCompleteDept();
    }

    public List<AutoComplete> autoCompleteEmployee() {
        return scoreChangeDao.autoCompleteEmployee();
    }

    public List<ScoreChange> getProcessList(ScoreChange scoreChange) {
        return scoreChangeDao.getProcessList(scoreChange);
    }

    public List<ScoreChange> getCompleteList(ScoreChange scoreChange) {
        return scoreChangeDao.getCompleteList(scoreChange);
    }

    public String getPersonNameById(String personId) {
        return scoreChangeDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return scoreChangeDao.getDeptNameById(deptId);
    }

    public List<EmpDeptRelation> getEmployeeDeptByDeptIdPersonId(String id) {
        return scoreChangeDao.getEmployeeDeptByDeptIdPersonId(id);
    }

    public ScoreImport getScoreImportById(String id) {
        return scoreChangeDao.getScoreImportById(id);
    }

    public void updateScoreById(ScoreChange scoreChange) {
        scoreChangeDao.updateScoreById(scoreChange);
    }

    public ScoreChange getScoreChangeBy(String id) {
        return scoreChangeDao.getScoreChangeBy(id);
    }

    public String getTeacherIdByCourseId(ScoreChange scoreChange) {
        return scoreChangeDao.getTeacherIdByCourseId(scoreChange);
    }

    public List<Handle> getHandleById(String id) {
        return scoreChangeDao.getHandleById(id);
    }

    public List<RoleEmpDeptRelation> getRoleByPersonId(String id) {
        return scoreChangeDao.getRoleByPersonId(id);
    }

    @Override
    public List<String> getStudentEndTime(String studentId) {
        return scoreChangeDao.getStudentEndTime(studentId);
    }

    @Override
    public Student getStudentByStudentId(String studentId){
        return scoreChangeDao.getStudentByStudentId(studentId);
    }
}
