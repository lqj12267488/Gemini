package com.goisan.educational.skillappraisal.dao;

import com.goisan.educational.skillappraisal.bean.SkillAppraisal;
import com.goisan.system.bean.SelectGroupForExcel;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SkillAppraisalDao {

    List<SkillAppraisal> skillAppraisal(SkillAppraisal skill);
    void deleteSkillAppraisalById(String id);
    SkillAppraisal getSkillAppraisalById(String id);
    void updateSkillApprraisalById(SkillAppraisal skill);
    void insertSkillAppraisal(SkillAppraisal skill);
    List<SkillAppraisal> skillAppraisalCount(SkillAppraisal skill);
    List<SkillAppraisal> scoreSituation (SkillAppraisal skill);
    void updateScoreSituationById(SkillAppraisal skill);
    List<SelectGroupForExcel> getMajorClassesName();
    List<String> getSchoolSystem();
    List<String> getStudentsNameList();
    String checkIsImport();
}
