package com.goisan.educational.otherexamination.dao;

import com.goisan.educational.otherexamination.bean.OtherExamination;
import com.goisan.educational.score.bean.ScoreImport;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface OtherExaminationDao {

    List getOtherExaminationList(OtherExamination otherExamination);

    List getScoreImport(OtherExamination otherExamination);

    OtherExamination getOtherExaminationById(String id);

    OtherExamination getScoreImportById(String id);

    void deleteOtherExamination(String id);

    void deleteById(String id);

    void updateOpenFlag(@Param("openFlag") String openFlag, @Param("teachingTeacherId") String teachingTeacherId, @Param("id") String id);

    void updateOtherExamination(OtherExamination otherExamination);

    void saveOtherExamination(OtherExamination otherExamination);

    void updateOtherExaminationImport(OtherExamination otherExamination);

    void insertScoreImportByOtherExamination(ScoreImport scoreImport);

    List<ScoreImport> getScoreExamListByOtherExam(ScoreImport scoreImport);
}
