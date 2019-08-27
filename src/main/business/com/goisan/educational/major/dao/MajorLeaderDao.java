package com.goisan.educational.major.dao;

import com.goisan.educational.major.bean.*;
import com.goisan.studentwork.employments.bean.Employments;
import com.goisan.system.bean.EmpDeptTree;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/5/18.
 */
@Repository
public interface MajorLeaderDao {
    List<TalentTrain> getTalentTrainByPlanName(TalentTrain talentTrain);
    void deleteResearchResultByMajorLeaderId(String majorLeaderId);
    List<ResearchResult> getResearchResultsByMajorLeaderId(String majorLeaderId);
    void insertResearchResult(ResearchResult researchResult);
    void deleteAllMembersByTeamId(String teamId);
    TeachingTeamMember getTeamTeachByTeamId(String teamId);
    List<TeachingTeamMember> findTeachingTeamMemberByTeamId(String teamId);
    Map<String, String> getTeacherById(String tid);
    Integer getTableMembersColumn(@Param("planName") String planName);

    MajorLeader getMajorLeaderById(String id);

    MajorResponsible getMajorResponsibleById(String id);

    List<MajorLeader> getMajorLeaderList(MajorLeader m);

    void insertMajorLeader(MajorLeader m);

    void updateMajorLeader(MajorLeader m);

    void deleteMajorLeader(String id);

    TalentTrain getTeachingTeamById(String id);
    List<Map<String, String>> getTeachingTeamMemberByTeamId(String teamId);

    List<TeachingTeamMember> getTeachingTeamMemberById(String teamId);

    List<TalentTrain> getTeachingTeamList(TalentTrain tt);

    List<Map<String, String>> getTeachingTeamMap(TalentTrain tt);

    void insertTeachingTeam(TalentTrain tt);

    //插入已有id的数据
    void insertTeachTeam(TalentTrain tt);

    void updateTeachingTeam(TalentTrain tt);

    void deleteTeachingTeam(String id);

    List<EmpDeptTree> getDeptAndPersonTree(TeachingTeamMember tt);

    void delLeaderEmpDeptByArchivesId(TeachingTeamMember tt);

    void insertLeaderEmpDept(TeachingTeamMember ar);


    void insertMajorResponsible(MajorResponsible m);

    void updateMajorResponsible(MajorResponsible m);

    List<MajorResponsible> getMajorResponsibleList(MajorResponsible m);

    void deleteMajorResponsible(String id);

    List<TalentTrain> getDaoChu(TalentTrain tt);


}
