package com.goisan.educational.skillappraisal.service;

import com.goisan.educational.skillappraisal.bean.SkillAppraisal;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface SkillAppraisalService {

    List<SkillAppraisal> skillAppraisal(SkillAppraisal skill);
    void deleteSkillAppraisalById(String id);
    SkillAppraisal getSkillAppraisalById(String id);
    void updateSkillApprraisalById(SkillAppraisal skill);
    void insertSkillAppraisal(SkillAppraisal skill);
    List<SkillAppraisal> skillAppraisalCount(SkillAppraisal skill);
    List<SkillAppraisal> scoreSituation (SkillAppraisal skill);
    void updateScoreSituationById(SkillAppraisal skill);
    void getStudentExcelTemplate(HttpServletResponse response);
    String checkIsImport();
}
