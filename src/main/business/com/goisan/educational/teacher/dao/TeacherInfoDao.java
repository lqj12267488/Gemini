package com.goisan.educational.teacher.dao;

import com.goisan.educational.score.bean.ScoreExam;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.teacher.bean.*;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wq on 2018/06/20.
 */
@Repository
public interface TeacherInfoDao {

    TeacherCondition getTeacherInfoByTeacherName(String teacherName);

    List<TeacherCondition> getTeacherInfoList(TeacherCondition teacherCondition);

    void insertTeacherInfo(TeacherCondition teacherCondition);

    TeacherCondition getTeacherInfoById(String teacherId);

    void updateTeacherInfoById(TeacherCondition teacherCondition);

    void deleteTeacherInfoById(String teacherId);

    List<TeacherCondition> selectTeacherName();

    List<DoubleDivisionTeacher> getDoubleDivisionList(DoubleDivisionTeacher doubleDivisionTeacher);

    void insertDoubleDivision(DoubleDivisionTeacher doubleDivisionTeacher);

    DoubleDivisionTeacher getDoubleDivisionById(String teacherId);

    void updateDoubleDivisionById(DoubleDivisionTeacher doubleDivisionTeacher);

    void deleteDoubleDivisionById(String teacherId);

    List<TeacherTraining> getTeacherTrainingList(TeacherTraining teacherTraining);

    void insertTeacherTraining(TeacherTraining teacherTraining);

    TeacherTraining getTeacherTrainingById(String teacherId);

    void updateTeacherTrainingById(TeacherTraining teacherTraining);

    void deleteTeacherTrainingById(String teacherId);

    List<GetHonor> getHonorList(GetHonor getHonor);

    void insertHonor(GetHonor getHonor);

    GetHonor getHonorById(String teacherId);

    void updateHonorById(GetHonor getHonor);

    void deleteHonorById(String teacherId);

    List<EducationImprove> getEducationImproveList(EducationImprove educationImprove);

    void insertEducationImprove(EducationImprove educationImprove);

    EducationImprove getEducationById(String teacherId);

    void updateEdcuationById(EducationImprove educationImprove);

    void delEducationImprove(String teacherId);

    List<BusinessAssessment> getAssessmentList(BusinessAssessment businessAssessment);

    void insertBusinessAssessment(BusinessAssessment businessAssessment);

    BusinessAssessment getAssessmentById(String teacherId);

    void updateAssessmentById(BusinessAssessment businessAssessment);

    void delAssessmentById(String teacherId);

    List<Competition> getCompetitionList(Competition competition);

    Competition getCompetitionIdById(String competitionId);

    void deleteCompetitionIdById(String competitionId);

    void insertCompetition(Competition competition);

    void updateCompetitionById(Competition competition);

    RewardAndPunishment getRewardById(String rewardId);

    void deleteRewardById(String rewardId);

    void insertReward(RewardAndPunishment rewardAndPunishment);

    void updateReward(RewardAndPunishment rewardAndPunishment);

    List<RewardAndPunishment> getRewardList(RewardAndPunishment rewardAndPunishment);
    List<TeacherCondition> getTeacherType(String teacherType);

    List<TeacherCondition>  getTeacherTypeToExp(String teacherType);
}
