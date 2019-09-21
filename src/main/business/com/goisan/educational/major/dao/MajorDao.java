package com.goisan.educational.major.dao;

import com.goisan.educational.courseplan.bean.CoursePlan;
import com.goisan.educational.major.bean.Major;
import com.goisan.educational.major.bean.TalentTrain;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Files;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by admin on 2017/5/18.
 */
@Repository
public interface MajorDao {


    //清空TalentTrain的teachFile
    void clearTeachFile(String talentTrainId);
    //清空TalentTrain的practiceFile
    void clearPtacticeFile(String practiceTrainId);
    //清空TalentTrain的distributeFile
    void clearDistributeFile(String distributeFile);
    Major getMajorByMajorId(String majorId);
    void addTeachFileTalentTrain(TalentTrain talentTrain);
    void addDistributeFileTalentTrain(TalentTrain talentTrain);
    void addPracticeFileTalentTrain(TalentTrain talentTrain);
    String getStatusByTid(String tid);
    List<Major> getMajorList(Major major);

    void insertMajor(Major major);

    void updateMajor(Major major);

    void delectMajorByMajorId(String majorId);

    Major checkMajorName(Major major);

    List<Major> checkMajorCode(Major major);

    List<TalentTrain> getTalentTrainList(@Param("tt") TalentTrain tt, @Param("uid") String uid);
    List<TalentTrain> getTalentTrainListProcess(TalentTrain tt);
    void insertTalentTrain(TalentTrain tt);

    void updateTalentTrain(TalentTrain tt);
    void saveTalentProcess(TalentTrain tt);

    void deleteTalenTrain(String id);
    void submitTalent(@Param("id") String id, @Param("lastStatus")String lastStatus);
    TalentTrain getTalentTrainById(String id);

    List<CoursePlan> getCoursePlan(String id);
    String sfRelation(@Param("id") String id,@Param("pid") String pid);
    void saveRelationTalent(TalentTrain tt);
    void delRelationTalent(@Param("pid") String pid,@Param("tid") String tid);

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
     * 获得所有的专业
     */
    List<Major> getAllMajor();

    /**
     * 保存人才培养驳回
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
}
