package com.goisan.educational.major.service;

import com.goisan.educational.courseplan.bean.CoursePlan;
import com.goisan.educational.major.bean.Major;
import com.goisan.educational.major.bean.TalentTrain;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Files;
import org.apache.ibatis.annotations.Param;
import org.apache.poi.ss.formula.functions.T;

import java.util.List;

/**
 * Created by admin on 2017/5/18.
 */
public interface MajorService {
    //清空TalentTrain的teachFile
    void clearTeachFile(String talentTrainId);
    //清空TalentTrain的practiceFile
    void clearPtacticeFile(String practiceTrainId);
    //清空TalentTrain的distributeFile
    void clearDistributeFile(String distributeFile);
    //添加教学活动时间安排表
    void addTeachFileTalentTrain(TalentTrain talentTrain);
    //添加课程设置、教学进度计划及课时分配表
    void addDistributeFileTalentTrain(TalentTrain talentTrain);
    //添加实践教学活动安排表
    void addPracticeFileTalentTrain(TalentTrain talentTrain);
    String getStatusByTid(String tid);
    Major getMajorByMajorId(String majorId);

    List<Major> getMajorList(Major major);

    void insertMajor(Major major);

    void updateMajor(Major major);

    void delectMajorByMajorId(String majorId);

    Major checkMajorName(Major major);

    List<Major> checkMajorCode(Major major);

    /**人才培养方案系列*/
    List<TalentTrain> getTalentTrainList(TalentTrain tt, String uid);
    List<TalentTrain> getTalentTrainListProcess(TalentTrain tt);
    void insertTalentTrain(TalentTrain tt);

    void updateTalentTrain(TalentTrain tt);
    void saveTalentProcess(TalentTrain tt);

    TalentTrain getTalentTrainById(String id);

    void deleteTalenTrain(String id);
    void submitTalent(String id, String lastStatus);

    List<CoursePlan> getCoursePlan(String id);
    String sfRelation(String id,String pid);
    void saveRelationTalent(TalentTrain tt);
    void delRelationTalent(String pid,String tid);

    String getDeptIdByDeptName(String id);

    /**
     * 专业代码自动完成框
     * @return
     */
    List<AutoComplete> getMajorCodeIdList();

    List<CoursePlan> getrelationMajor(String id);

    List<Major> getMajorListExport(Major major);

    /**
     * 当前月份小于于8月获取学校在校学生人数
     */
    List<Major> getStudentNumber();
    /**
     * 当前月份大于8月获取学校在校学生人数
     */
    List<Major> getStudentNumberOrder();
    /**
     * 获取各类生源类型人数
     */
    List<Major> getSourceType();
    /**
     * 获取各专业总人数
     */
    List<Major> getMajorCodeNumber();

    /**
     * 获取所有的专业
     */
    List<Major> getAllMajor();

    /**
     * 保存人才方案的驳回
     */
    void saveTalentAgainst(TalentTrain tt);
    /**
     * 查找附件
     * @param fileId
     * @return
     */
    List<Files> getFilesByFileId(String fileId);

    Major getStudentNumberList(Major major);

    Major getSourceTypeList(Major major);
    List<Major> getMajorNumList();
    Major getMajorByName(String majorName);
}
