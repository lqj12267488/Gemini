package com.goisan.evaluation.dao;

import com.goisan.evaluation.bean.*;
import com.goisan.system.bean.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Admin on 2017/5/23.
 */
@Repository
public interface EvaluationDao {
    void saveGroup(Group group);

    void deleteGroup(String id);

    List getGroupList(Group group);

    List<EvaluationMembers> getMembersByGroupId(@Param("id") String id, @Param("memberType") String memberType);

    void saveMember(EvaluationMembers evaluationMembers);

    void deleteMemberByGroupId(@Param("id") String id, @Param("memberType") String memberType);

    void updateGroupMembersNum(String groupId);

    void savePlan(EvaluationPlan evaluationPlan);

    List getPlanList(EvaluationPlan plan);

    EvaluationPlan getPlan(String id);

    void upadtePlan(EvaluationPlan evaluationPlan);

    void deletePlan(String id);

    void deleteIndexByPlanid(String id);

    List<Tree> getIndexByPlanId(String id);

    Integer getPlanScoreByPlanId(String planId);

    Integer getIndexScoreByIndexId(String indexId);

    Integer getIndexScoreTotalByParentIndexId(@Param("parentIndexId") String parentIndexId, @Param("indexId") String indexId);

    void saveIndex(Index index);

    void deleteIndex(String id);

    Index getIndexById(String id);

    void updateIndex(Index index);

    List<EvaluationTask> getTasks(EvaluationTask task);

    void updateTask(EvaluationTask task);

    void saveTask(EvaluationTask task);

    void delTask(String id);

    List<Select2> getSelectGroup(EvaluationPlan plan);

    List<Select2> getSelectPlan(EvaluationPlan plan);

    EvaluationTask getTask(String id);

    List<EvaluationEmp> getEmpsByTaskId(String id);

    List<EvaluationEmp>  getEmpsInterviewersByTaskId(String id);

    void deleteEmpsByTaskId(String taskId);

    void saveEmps(EvaluationEmp evaluationEmp);

    List<EvaluationMembers> getMembersByTaskId(String taskId);

    void savaEmpsMembers(EvaluationEmpsMenmbers members);

    void deleteEmpsMenmbersByTaskId(String taskId);

    void updateIndexLeafFlag(@Param("parentIndexId") String parentIndexId, @Param("type") Integer
            type, @Param("col") Integer col);

    Integer getLeafTotal(String parentIndexId);

    List<Index> getIndexByTaskId(String taskId);

    List<EvaluationResult> getMonitorResults(@Param("empId") String id, @Param("taskId")
            String taskId, @Param("membersId") String membersId);

    List<EvaluationResult> listResultByPersonid(EvaluationResult evaluationResult);

    List<EvaluationEmpsMenmbers> getlistTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    void updateEmpsMenmbers(EvaluationEmpsMenmbers eEMenmbers);

    List<Index> getlistIndex(String id);

    List<EvaluationResult> listResultByPersonid(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    void insertResult(EvaluationResult evaluationResult);

    void insertResultInterviewers(EvaluationResult evaluationResult);

    void updateEvaluationEmpMenmber(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    Integer getMaxLevel(String taskId);

    List<EvaluationTask> getMonitoerTask(EvaluationTask task);

    List<EvaluationTask> getMonitoerTaskBySelf(EvaluationTask task);

    List<EvaluationEmp> getMonitoerEmpsByTaskId(EvaluationTask etask);

    List<Index> getIndexsByParentIndexId(String parentIndexId);

    List<EvaluationEmpsMenmbers> getMembersByTaskIdAndEmpId(@Param("id") String id, @Param("taskId") String
            taskId);

    void invalid(EvaluationEmpsMenmbers menmber);

    EvaluationEmpsMenmbers getEmpsMenmbersById(String id);

    Integer getIndexWeightsTotalByParentIndexId(@Param("parentIndexId") String parentIndexId, @Param("indexId") String indexId);

    Integer getIndexWeightsByIndexId(String indexId);

    List<EvaluationResult> searchlistIndex(EvaluationEmpsMenmbers eEmpsMenmbers);

    Integer calPlanScore(String id);

    void updatePlanTestFlag(@Param("id") String id, @Param("testFlag") int testFlag);

    List<EvaluationTask> getTasksByPlanId(String id);

    List<EvaluationEmp> getMonitoerEmpsOrder(EvaluationTask etask);

    Integer calPlanWights(String id);

    void upadteGroup(Group group);

    Group getGroup(String id);

    void delectResult(EvaluationResult eResult);

    void delectResultInterviewers(EvaluationResult eResult);

    void updateEvaluationEmpMenmberInterviewers(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    List<Tree> getEmpsCheckByTask(String id);

    List<Tree> getEmpsInterviewersCheckByTask(String id);

    List<Tree> getClassStudentCheckByTask(String id);

    void insertEmpsMembers(EvaluationTask task);

    void delectEmpsMembers(String id);

    List<EvaluationTask> getlistTaskNameApp(EvaluationEmpsMenmbers eEmpsMenmbers);

    List<EvaluationComplexTask> getEvaluationComplexTask(EvaluationComplexTask ecTask);

    EvaluationComplexTask getEvaluationComplexTaskByid(String id);

    void saveComplexTask(EvaluationComplexTask ecTask);

    void updateComplexTask(EvaluationComplexTask ecTask);

    void seveComplexDetail(EvaluationComplexDetail ecDetail);

    void delComplexDetail(String id);

    void delComplexTask(String id);

    void delComplexResult(String id);

    void checkComplexTask(String id);

    Integer getDetailWeights(String id);

    List<EvaluationComplexDetail> getEvaluationComplexDetail(String complexTaskId);

    EvaluationComplexDetail getEvaluationComplexDetailByid(String id);

    void insertComplexResultBySingleTask(EvaluationComplexDetail ecDetail);

    void insertComplexResultByTaskList(EvaluationComplexDetail ecDetail);

    List<EvaluationComplexResult> getEvaluationComplexResult(EvaluationComplexResult ecResult);

    List<EvaluationComplexResult> getEvaluationComplexSumResult(EvaluationComplexDetail str);

    void deleteTaskByPlanId(@Param("id") String id);

    List<EvaluationTask> getMonitoerTaskByTeacherId(EvaluationTask task);

    List<EvaluationTask> getTasksByGroupId(String id);

    List<EvaluationEmp> getEvaluationResultList(EvaluationTask etask);

    List<Group> getEmpGroupList(Group group);

    Group getEmpGroup(String id);

    void saveEmpGroup(Group group);

    List<EvaluationTask> getTasksByEmpGroupId(String id);

    void deleteEmpGroup(String id);

    void deleteMemberByEmpGroupId(String id);

    void updateEmpGroup(Group group);

    List<EvaluationGroupEmps> getEmpsTree(@Param("groupId") String groupId);

    List<Interviewers> getInterviwerTree(@Param("groupId") String groupId);

    List<EvaluationGroupEmps> getEmpsTreeByTaskId(@Param("taskId") String taskId);

    void insertGroupEmps(EvaluationGroupEmps eGroupEmps);

    void updateGroupEmpsNum(String groupId);

    void deleteGroupEmps(String id);

    void copyMemberGroup(@Param("groupId") String groupId, @Param("creator") String creator,
                         @Param("createDept") String createDept, @Param("id") String id);

    void copyMembers(@Param("groupId") String groupId, @Param("creator") String creator,
                     @Param("createDept") String createDept, @Param("id") String id);

    void copyPlan(@Param("planId") String planId, @Param("creator") String creator,
                  @Param("createDept") String createDept, @Param("id") String id);

    void copyIndexById(@Param("planId") String planId, @Param("indexId") String indexId,
                       @Param("parentIndexId") String parentIndexId, @Param("IndexIdOld") String IndexIdOld,
                       @Param("creator") String creator, @Param("createDept") String createDept);

    void copyIndexList(@Param("planId") String planId, @Param("parentIndexId") String parentIndexId,
                       @Param("parentIndexIdOld") String parentIndexIdOld,
                       @Param("creator") String creator, @Param("createDept") String createDept);

    void copyEmpGroup(@Param("groupId") String groupId, @Param("creator") String creator,
                      @Param("createDept") String createDept, @Param("id") String id);

    void copyEmps(@Param("groupId") String groupId, @Param("creator") String creator,
                  @Param("createDept") String createDept, @Param("id") String id);

    void copyTask(@Param("taskId") String taskId, @Param("creator") String creator,
                  @Param("createDept") String createDept, @Param("id") String id);

    List<Tree> getMembersByTaskIDEmp(String taskId);

    List<Tree> getMembersByTaskIDStu(String taskId);

    void saveProportion(EvaluationTask task);

    void setStartFlagByTaskId(@Param("taskId") String taskId, @Param("startFlag") String startFlag);

    void updateEvaluationType(@Param("taskId") String taskId, @Param("startFlag") String startFlag);

    /**
     * 领导评教任务
     */
    List<EvaluationTask> getLeaderTasks(EvaluationTask task);

    List<Tree> getMembersByTaskIDLeader(String taskId);

    List<EvaluationEmpsMenmbers> getLeaderListTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    List<EvaluationTask> getMonitoerLeaderTask(EvaluationTask task);

    List<EvaluationTask> getMonitoerLeaderTaskBySelf(EvaluationTask task);

    EchartsMenu getLeaderTeacherNameEcharts(EchartsMenu echartsMenu);

    EchartsMenu getLeaderTeacherSorceEcharts(EchartsMenu echartsMenu);

    Map getLeaderTeacherEcharts(EchartsMenu echartsMenu);
    /**
     * 教师评教任务
     */
    List<EvaluationTask> getTeacherTasks(EvaluationTask task);

    List<Tree> getMembersByTaskIDTeacher(String taskId);

    List<EvaluationEmpsMenmbers> getTeacherListTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    List<EvaluationTask> getMonitoerTeacherTask(EvaluationTask task);

    List<EvaluationTask> getMonitoerTeacherTaskBySelf(EvaluationTask task);

    Map getTeacherTeacherEcharts(EchartsMenu echartsMenu);
    /**
     * 学生评教任务
     */
    List<EvaluationTask> getStudentTasks(EvaluationTask task);

    List<Tree> getMembersByTaskIDStudent(String taskId);

    List<EvaluationEmpsMenmbers> getStudentListTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    List<EvaluationTask> getMonitoerStudentTask(EvaluationTask task);

    List<EvaluationTask> getMonitoerStudentTaskBySelf(EvaluationTask task);

    Map getStudentTeacherEcharts(EchartsMenu echartsMenu);
    /**
     * 同行评教任务
     */
    List<EvaluationTask> getPeerTasks(EvaluationTask task);

    List<Tree> getMembersByTaskIDPeer(String taskId);

    List<EvaluationEmpsMenmbers> getPeerListTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    List<EvaluationTask> getMonitoerPeerTask(EvaluationTask task);

    List<EvaluationTask> getMonitoerPeerTaskBySelf(EvaluationTask task);

    Map getPeerTeacherEcharts(EchartsMenu echartsMenu);
    /**
     * 社会评教任务
     */
    List<EvaluationTask> getParentTasks(EvaluationTask task);

    List<Tree> getMembersByTaskIDParent(String taskId);

    List<EvaluationEmpsMenmbers> getParentListTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    List<EvaluationTask> getMonitoerParentTask(EvaluationTask task);

    List<EvaluationTask> getMonitoerParentTaskBySelf(EvaluationTask task);

    Map getParentTeacherEcharts(EchartsMenu echartsMenu);
    /**
     * 评教结果汇总
     */
    List<EvaluationTask> getEvaluationSummaryTask(EvaluationTask task);

    List<EvaluationEmp> getMonitoerSummaryByTaskId(EvaluationTask task);

    void deleteEvaluationPushMember(@Param("id") String id);

    void saveEvaluationPushMember(EvaluationPush evaluationPush);

    List<EvaluationPush> getEvaluationPushMembersByGroupId(@Param("id") String id);

    void updateEvaluationTaskPushFlag(String id);

    List<EvaluationTask> getEvaluationSummaryPushTask(EvaluationTask task);

    List<EvaluationTask> getEvaluationTaskByTaskIds(@Param("taskIds") String taskIds);

    Map getAllEvaluationEcharts(EchartsMenu echartsMenu);

    EchartsMenu getStudentEvaluationEcharts(EchartsMenu echartsMenu);

    EchartsMenu getLeaderEvaluationEcharts(EchartsMenu echartsMenu);

    EchartsMenu getTeacherEvaluationEcharts(EchartsMenu echartsMenu);

    EchartsMenu getPeerEvaluationEcharts(EchartsMenu echartsMenu);

    List<EvaluationTask> getUserTask(String loginId);

    List<EvaluationTask> getTaskResultList();

    List getInterviewersGroupList(Group group);

    List<Tree> getInterviwerTree();

    List<EvaluationTask> getInterviewersTasks(EvaluationTask task);

    List<EvaluationEmpsMenmbers> getInterviewersListTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    List<EvaluationTask> getMonitorInterviewersTask(EvaluationTask task);

    List<AutoComplete> getInterviewers();
}
