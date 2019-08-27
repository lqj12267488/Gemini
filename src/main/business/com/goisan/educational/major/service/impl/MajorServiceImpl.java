package com.goisan.educational.major.service.impl;

import com.goisan.educational.courseplan.bean.CoursePlan;
import com.goisan.educational.major.bean.Major;
import com.goisan.educational.major.bean.TalentTrain;
import com.goisan.educational.major.dao.MajorDao;
import com.goisan.educational.major.service.MajorService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Files;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * Created by admin on 2017/5/18.
 */
@Service
public class MajorServiceImpl implements MajorService {
    @Resource
    private MajorDao majorDao;

    //清空TalentTrain的teachFile
    public void clearTeachFile(String talentTrainId){
        this.majorDao.clearTeachFile(talentTrainId);
    }
    //清空TalentTrain的practiceFile
    public void clearPtacticeFile(String practiceTrainId){
        this.majorDao.clearPtacticeFile(practiceTrainId);
    }
    //清空TalentTrain的distributeFile
    public void clearDistributeFile(String distributeFileId){
        this.majorDao.clearDistributeFile(distributeFileId);
    }

    //添加教学活动时间安排表
    public void addTeachFileTalentTrain(TalentTrain talentTrain){

        majorDao.addTeachFileTalentTrain(talentTrain);
    }
    //添加课程设置、教学进度计划及课时分配表
    public void addDistributeFileTalentTrain(TalentTrain talentTrain){
        majorDao.addDistributeFileTalentTrain(talentTrain);
    }
    //添加实践教学活动安排表
    public void addPracticeFileTalentTrain(TalentTrain talentTrain){
        majorDao.addPracticeFileTalentTrain(talentTrain);
    }

    public Major getMajorByMajorId(String majorId){
        return majorDao.getMajorByMajorId(majorId);
    }

    @Override
    public String getStatusByTid(String tid) {
        return this.majorDao.getStatusByTid(tid);
    }

    public List<Major> getMajorList(Major major){
        return majorDao.getMajorList(major);
    }

    public void insertMajor(Major major){
        majorDao.insertMajor(major);
    }
    public void updateMajor(Major major){
        majorDao.updateMajor(major);
    }

    public void delectMajorByMajorId(String majorId){
        majorDao.delectMajorByMajorId(majorId);
    }

    public  Major checkMajorName(Major major){
        return majorDao.checkMajorName(major);
    }

    public List<Major> checkMajorCode(Major major){
        return majorDao.checkMajorCode(major);
    }

    @Override
    public List<TalentTrain> getTalentTrainList(TalentTrain tt, String uid) {
        return majorDao.getTalentTrainList(tt, uid);
    }

    @Override
    public List<TalentTrain> getTalentTrainListProcess(TalentTrain tt) {
        return majorDao.getTalentTrainListProcess(tt);
    }

    @Override
    public void insertTalentTrain(TalentTrain tt) {
        majorDao.insertTalentTrain(tt);
    }

    @Override
    public void updateTalentTrain(TalentTrain tt) {
        majorDao.updateTalentTrain(tt);
    }

    @Override
    public void saveTalentProcess(TalentTrain tt) {
        majorDao.saveTalentProcess(tt);
    }

    @Override
    public TalentTrain getTalentTrainById(String id) {
        return majorDao.getTalentTrainById(id);
    }

    @Override
    public void deleteTalenTrain(String id) {
        majorDao.deleteTalenTrain(id);
    }

    @Override
    public void submitTalent(String id, String lastStatus) {
        majorDao.submitTalent(id, lastStatus);
    }

    @Override
    public List<CoursePlan> getCoursePlan(String id) {
        return majorDao.getCoursePlan(id);
    }

    @Override
    public String sfRelation(String id,String pid) {
        return majorDao.sfRelation(id,pid);
    }

    @Override
    public void saveRelationTalent(TalentTrain tt) {
        majorDao.saveRelationTalent(tt);
    }

    @Override
    public void delRelationTalent(String pid, String tid) {
        majorDao.delRelationTalent(pid,tid);
    }

    @Override
    public String getDeptIdByDeptName(String id){ return majorDao.getDeptIdByDeptName(id);}

    /**
     * 专业代码自动完成框
     * @return
     */
    public List<AutoComplete> getMajorCodeIdList() {
        try {
            return this.majorDao.getMajorCodeIdList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<CoursePlan> getrelationMajor(String id) {
        return majorDao.getrelationMajor(id);
    }

    @Override
    public List<Major> getMajorListExport(Major major) {
        return majorDao.getMajorListExport(major);
    }

    public List<Major> getStudentNumber(){ return majorDao.getStudentNumber(); }

    public List<Major> getStudentNumberOrder(){ return majorDao.getStudentNumberOrder(); }

    public List<Major> getSourceType(){return majorDao.getSourceType(); }

    public List<Major> getMajorCodeNumber(){ return majorDao.getMajorCodeNumber(); }

    public List<Major> getAllMajor(){
        return this.majorDao.getAllMajor();
    }

    public void saveTalentAgainst(TalentTrain tt){

        this.majorDao.saveTalentAgainst(tt);
    }

    public List<Files> getFilesByFileId(String fileId){
        return majorDao.getFilesByFileId(fileId);
    }
}