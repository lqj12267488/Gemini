package com.goisan.educational.otherexamination.service;

import com.goisan.educational.otherexamination.bean.OtherExamination;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.synergy.message.bean.Message;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public interface OtherExaminationService {


    List getOtherExaminationList(OtherExamination otherExamination);

    List getScoreImport(OtherExamination otherExamination);

    OtherExamination getOtherExaminationById(String id);

    OtherExamination getScoreImportById(String id);

    void deleteOtherExamination(String id);

    void deleteById(String id);

    com.goisan.system.tools.Message openScore(String id);

    com.goisan.system.tools.Message saveScoreCon(HttpServletRequest request);

    void updateOtherExamination(OtherExamination otherExamination);

    void updateOtherExaminationImport(OtherExamination otherExamination);

    void saveOtherExamination(OtherExamination otherExamination);

    void insertScoreImportByOtherExamination(ScoreImport scoreImport);

    List<ScoreImport> getScoreExamListByOtherExam(ScoreImport scoreImport);
}
