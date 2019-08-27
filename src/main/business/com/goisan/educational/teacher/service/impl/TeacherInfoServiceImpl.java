package com.goisan.educational.teacher.service.impl;

import com.goisan.educational.score.bean.ScoreExam;
import com.goisan.educational.teacher.bean.*;
import com.goisan.educational.teacher.dao.TeacherInfoDao;
import com.goisan.educational.score.dao.ScoreExamDao;
import com.goisan.educational.teacher.service.TeacherInfoService;
import com.goisan.educational.teacher.bean.TeacherCondition;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wq on 2017/10/12.
 */
@Service
public class TeacherInfoServiceImpl implements TeacherInfoService {
    @Resource
    private TeacherInfoDao teacherInfoDao;

    public TeacherCondition getTeacherInfoByTeacherName(String teacherName){
        return teacherInfoDao.getTeacherInfoByTeacherName(teacherName);
    }
    public List<TeacherCondition> getTeacherInfoList(TeacherCondition teacherCondition) {
        return teacherInfoDao.getTeacherInfoList(teacherCondition);
    }

    public void insertTeacherInfo(TeacherCondition teacherCondition) {
        teacherInfoDao.insertTeacherInfo(teacherCondition);
    }

    public TeacherCondition getTeacherInfoById(String teacherId) {
        return teacherInfoDao.getTeacherInfoById(teacherId);
    }

    public void updateTeacherInfoById(TeacherCondition teacherCondition) {
        teacherInfoDao.updateTeacherInfoById(teacherCondition);
    }

    public void deleteTeacherInfoById(String teacherId) {
        teacherInfoDao.deleteTeacherInfoById(teacherId);
    }

    public List<TeacherCondition> selectTeacherName() {
        return teacherInfoDao.selectTeacherName();
    }

    public List<DoubleDivisionTeacher> getDoubleDivisionList(DoubleDivisionTeacher doubleDivisionTeacher) {
        return teacherInfoDao.getDoubleDivisionList(doubleDivisionTeacher);
    }

    public void insertDoubleDivision(DoubleDivisionTeacher doubleDivisionTeacher) {
        teacherInfoDao.insertDoubleDivision(doubleDivisionTeacher);
    }

    public DoubleDivisionTeacher getDoubleDivisionById(String teacherId) {
        return teacherInfoDao.getDoubleDivisionById(teacherId);
    }

    public void updateDoubleDivisionById(DoubleDivisionTeacher doubleDivisionTeacher) {
        teacherInfoDao.updateDoubleDivisionById(doubleDivisionTeacher);
    }

    public void deleteDoubleDivisionById(String teacherId) {
        teacherInfoDao.deleteDoubleDivisionById(teacherId);
    }

    public List<TeacherTraining> getTeacherTrainingList(TeacherTraining teacherTraining) {
        return teacherInfoDao.getTeacherTrainingList(teacherTraining);
    }

    public void insertTeacherTraining(TeacherTraining teacherTraining) {
        teacherInfoDao.insertTeacherTraining(teacherTraining);
    }

    public TeacherTraining getTeacherTrainingById(String teacherId) {
        return teacherInfoDao.getTeacherTrainingById(teacherId);
    }

    public void updateTeacherTrainingById(TeacherTraining teacherTraining) {
        teacherInfoDao.updateTeacherTrainingById(teacherTraining);
    }

    public void deleteTeacherTrainingById(String teacherId) {
        teacherInfoDao.deleteTeacherTrainingById(teacherId);
    }

    public List<GetHonor> getHonorList(GetHonor getHonor) {
        return teacherInfoDao.getHonorList(getHonor);
    }

    public void insertHonor(GetHonor getHonor) {
        teacherInfoDao.insertHonor(getHonor);
    }

    public GetHonor getHonorById(String teacherId) {
        return teacherInfoDao.getHonorById(teacherId);
    }

    public void updateHonorById(GetHonor getHonor) {
        teacherInfoDao.updateHonorById(getHonor);
    }

    public void deleteHonorById(String teacherId) {
        teacherInfoDao.deleteHonorById(teacherId);
    }

    public List<EducationImprove> getEducationImproveList(EducationImprove educationImprove) {
        return teacherInfoDao.getEducationImproveList(educationImprove);
    }

    public void insertEducationImprove(EducationImprove educationImprove) {
        teacherInfoDao.insertEducationImprove(educationImprove);
    }

    public EducationImprove getEducationById(String teacherId) {
        return teacherInfoDao.getEducationById(teacherId);
    }

    public void updateEdcuationById(EducationImprove educationImprove) {
        teacherInfoDao.updateEdcuationById(educationImprove);
    }

    public void delEducationImprove(String teacherId) {
        teacherInfoDao.delEducationImprove(teacherId);
    }

    public List<BusinessAssessment> getAssessmentList(BusinessAssessment businessAssessment) {
        return teacherInfoDao.getAssessmentList(businessAssessment);
    }

    public void insertBusinessAssessment(BusinessAssessment businessAssessment) {
        teacherInfoDao.insertBusinessAssessment(businessAssessment);
    }

    public BusinessAssessment getAssessmentById(String teacherId) {
        return teacherInfoDao.getAssessmentById(teacherId);
    }

    public void updateAssessmentById(BusinessAssessment businessAssessment) {
        teacherInfoDao.updateAssessmentById(businessAssessment);
    }

    public void delAssessmentById(String teacherId) {
        teacherInfoDao.delAssessmentById(teacherId);
    }

    @Override
    public List<Competition> getCompetitionList(Competition competition) {
        return teacherInfoDao.getCompetitionList(competition);
    }

    @Override
    public Competition getCompetitionIdById(String competitionId) {
        return teacherInfoDao.getCompetitionIdById(competitionId);
    }

    @Override
    public void deleteCompetitionIdById(String competitionId) {
        teacherInfoDao.deleteCompetitionIdById(competitionId);
    }

    @Override
    public void insertCompetition(Competition competition) {
        teacherInfoDao.insertCompetition(competition);
    }

    @Override
    public void updateCompetitionById(Competition competition) {
        teacherInfoDao.updateCompetitionById(competition);
    }

    @Override
    public RewardAndPunishment getRewardById(String rewardId) {
        return teacherInfoDao.getRewardById(rewardId);
    }

    @Override
    public void deleteRewardById(String rewardId) {
        teacherInfoDao.deleteRewardById(rewardId);
    }

    @Override
    public void insertReward(RewardAndPunishment rewardAndPunishment) {
        teacherInfoDao.insertReward(rewardAndPunishment);
    }

    @Override
    public void updateReward(RewardAndPunishment rewardAndPunishment) {
        teacherInfoDao.updateReward(rewardAndPunishment);
    }

    @Override
    public List<RewardAndPunishment> getRewardList(RewardAndPunishment rewardAndPunishment) {
        return teacherInfoDao.getRewardList(rewardAndPunishment);
    }

    @Override
    public List<TeacherCondition> getTeacherType(String teacherType) {
        return teacherInfoDao.getTeacherType(teacherType);
    }

    @Override
    public List<TeacherCondition> getTeacherTypeToExp(String teacherType) {
        return teacherInfoDao.getTeacherTypeToExp(teacherType);
    }
}
