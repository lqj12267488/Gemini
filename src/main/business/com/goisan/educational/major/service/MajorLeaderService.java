package com.goisan.educational.major.service;

import com.goisan.educational.major.bean.*;
import com.goisan.educational.teacher.bean.TeacherCondition;
import com.goisan.studentwork.employments.bean.Employments;
import com.goisan.system.bean.EmpDeptTree;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/5/18.
 */
public interface MajorLeaderService {

    List<TalentTrain> getTalentTrainByPlanName(TalentTrain talentTrain);
    void majorLeaderExpertExcel(HttpServletResponse response, MajorLeader m);
    void deleteResearchResultByMajorLeaderId(String majorLeaderId);
    List<ResearchResult> getResearchResultsByMajorLeaderId(String majorLeaderId);
    void insertResearchResult(ResearchResult researchResult);
    void expertExcel(HttpServletResponse response, TalentTrain talentTrain);
    void deleteAllMembersByTeamId(String teamId);
    TeachingTeamMember getTeamTeachByTeamId(String teamId);
    List<TeachingTeamMember> findTeachingTeamMemberByTeamId(String teamId);
    Integer getTableMembersColumn(String planName);
    Map<String, String> getTeacherById(String tid);
    MajorLeader getMajorLeaderById(String id);

    MajorResponsible getMajorResponsibleById(String id);

    void insertLeaderEmpDept(TeachingTeamMember teachingTeamMember);

    List<MajorLeader> getMajorLeaderList(MajorLeader m);

    void insertMajorLeader(MajorLeader m);

    void updateMajorLeader(MajorLeader m);

    void deleteMajorLeader(String id);
    /**
     * 团队建设*/
    TalentTrain getTeachingTeamById(String id);

    //通过团队id查询团队成员，不包括负责人,bean为Map主要为页面列表显示的查询方法
    List<Map<String, String>> getTeachingTeamMemberByTeamId(String memberId);

    //通过团队id查询团队成员，不包括负责人,bean为Map主要为导出xls的查询方法
    List<TeachingTeamMember> getTeachingTeamMemberById(String teamId);

    List<TalentTrain> getTeachingTeamList(TalentTrain tt);

    List<Map<String, String>> getTeachingTeamMap(TalentTrain tt);

    void insertTeachingTeam(TalentTrain tt);

    //插入已有id的数据
    void insertTeachTeam(TalentTrain tt);

    void updateTeachingTeam(TalentTrain tt);

    void deleteTeachingTeam(String id);

    List<EmpDeptTree> getDeptAndPersonTree(TeachingTeamMember tt);

    void delRoleEmpDeptByArchivesIdAndInsertRoleEmpDept(String teamId, String memberType,String checkList);



    void insertMajorResponsible(MajorResponsible m);

    void updateMajorResponsible(MajorResponsible m);

    List<MajorResponsible> getMajorResponsibleList(MajorResponsible m);


    void deleteMajorResponsible(String id);
    List<TalentTrain> getDaoChu(TalentTrain tt);


}
