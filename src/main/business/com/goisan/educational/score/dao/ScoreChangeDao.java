package com.goisan.educational.score.dao;

import com.goisan.educational.score.bean.ScoreChange;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.EmpDeptRelation;
import com.goisan.system.bean.RoleEmpDeptRelation;
import com.goisan.workflow.bean.Handle;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ScoreChangeDao {
    List<ScoreChange> getScoreChangeList(ScoreChange scoreChange);
    ScoreImport getScoreImportById2(String id);
    void insertScoreChange(ScoreChange scoreChange);

    ScoreChange getScoreChangeById(String id);

    void updateScoreChangeById(ScoreChange ScoreChange);

    void deleteScoreChangeById(String id);

    List<AutoComplete> autoCompleteDept();

    List<AutoComplete> autoCompleteEmployee();

    List<ScoreChange> getProcessList(ScoreChange scoreChange);

    List<ScoreChange> getCompleteList(ScoreChange scoreChange);

    String getPersonNameById(String personId);

    String getDeptNameById(String deptId);

    List<EmpDeptRelation> getEmployeeDeptByDeptIdPersonId(String id);

    ScoreImport getScoreImportById(String id);

    void updateScoreById(ScoreChange scoreChange);

    ScoreChange getScoreChangeBy(String id);

    String getTeacherIdByCourseId(ScoreChange scoreChange);

    List<Handle> getHandleById(String id);

    List<RoleEmpDeptRelation> getRoleByPersonId(String id);

    List<String> getStudentEndTime(String studentId);
}
