package com.goisan.evaluation.service;

        import com.goisan.system.bean.*;
        import com.goisan.evaluation.bean.*;
        import org.apache.ibatis.annotations.Param;
        import org.springframework.transaction.annotation.Transactional;

        import java.util.List;
        import java.util.Map;

/**
 * Created by Admin on 2017/5/23.
 */
public interface EvaluationService {
    void saveGroup(Group group);

    void deleteGroup(String id);

    List getGroupList(Group group);

    List<EvaluationMembers> getMembersByGroupId(String id, String memberType);

    void saveMember(EvaluationMembers evaluationMembers);

    void deleteMemberByGroupId(String groupId, String memberType);

    void updateGroupMembersNum(String groupId);

    void savePlan(EvaluationPlan evaluationPlan);

    List getPlanList(EvaluationPlan plan);

    EvaluationPlan getPlan(String id);

    void upadtePlan(EvaluationPlan evaluationPlan);

    void deletePlan(String id);

    void deleteIndexByPlanid(String id);

    List<Tree> getIndexByPlanId(String id);

    Integer getIndexScoreTotalByParentIndexId(String parentIndexId, String indexId);

    Integer getIndexScoreByIndexId(String parentIndexId);

    Integer getPlanScoreByPlanId(String planId);

    void saveIndex(Index index);

    void deleteIndex(String id);

    Index getIndexById(String id);

    void updateIndex(Index index);

    List getTasks(EvaluationTask task);

    EvaluationTask getTask(String id);

    void saveTask(EvaluationTask task);

    void updateTask(EvaluationTask task);

    void delTask(String id);

    List<Select2> getSelectPlan(EvaluationPlan plan);

    List<Select2> getSelectGroup(EvaluationPlan plan);


    List<EvaluationEmp> getEmpsByTaskId(String id);

    List<EvaluationEmp>  getEmpsInterviewersByTaskId(String id);

    void deleteEmpsByTaskId(String taskId);

    void saveEmps(EvaluationEmp evaluationEmp);

    List<EvaluationMembers> getMembersByTaskId(String taskId);

    void savaEmpsMembers(EvaluationEmpsMenmbers members);

    void deleteEmpsMenmbersByTaskId(String taskId);

    void updateIndexLeafFlag(String parentIndexId, Integer type, Integer col);

    Integer getLeafTotal(String parentIndexId);

    List<Index> getIndexByTaskId(String taskId);

    List<EvaluationResult> getMonitorResults(String empId, String taskId, String membersId);

    List<EvaluationResult> listResultByPersonid(EvaluationResult evaluationResult);

    List<EvaluationEmpsMenmbers> getlistTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    void updateEmpsMenmbers(EvaluationEmpsMenmbers eEMenmbers);

    List<Index>getlistIndex (String id);

    List<EvaluationResult>listResultByPersonid (EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    void insertResult (EvaluationResult evaluationResult);

    void insertResultInterviewers(EvaluationResult evaluationResult);

    @Transactional
    void insertResult (String taskId, String empPersonId, String empDeptId, String returnValue, String
            empName,String memberPersonId,String memberDeptId,String memberName);
    @Transactional
    void insertResultInterviewers (String taskId, String empPersonId, String empDeptId, String returnValue, String
            empName,String memberPersonId,String memberDeptId,String memberName,String interviewDecision,String interviewEvaluate);

    void updateEvaluationEmpMenmber(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    Integer getMaxLevel(String taskId);

    List<EvaluationTask> getMonitoerTask(EvaluationTask task);

    List<EvaluationTask> getMonitoerTaskBySelf(EvaluationTask task);

    List<EvaluationEmp> getMonitoerEmpsByTaskId(EvaluationTask etask);

    List<Index> getIndexsByParentIndexId(String parentIndexId);

    List<EvaluationEmpsMenmbers> getMembersByTaskIdAndEmpId(String id, String taskId);

    void invalid(EvaluationEmpsMenmbers menmber);

    EvaluationEmpsMenmbers getEmpsMenmbersById(String id);

    Integer getIndexWeightsTotalByParentIndexId(String parentIndexId, String indexId);

    Integer getIndexWeightsByIndexId(String parentIndexId);

    List<EvaluationResult> searchlistIndex(EvaluationEmpsMenmbers eEmpsMenmbers);

    Integer calPlanScore(String id);

    void updatePlanTestFlag(String id, int testFlag);

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

    void checkComplexTask(String id);

    Integer getDetailWeights(String id);

    void delComplexDetail(String id);

    void delComplexTask(String id);

    void delComplexResult(String id);

    List<EvaluationComplexDetail> getEvaluationComplexDetail(String complexTaskId);

    EvaluationComplexDetail getEvaluationComplexDetailByid(String id);

    void insertComplexResultBySingleTask(EvaluationComplexDetail ecDetail);

    void insertComplexResultByTaskList(EvaluationComplexDetail ecDetail);

    List<EvaluationComplexResult> getEvaluationComplexSumResult(EvaluationComplexDetail str);

    List<EvaluationComplexResult> getEvaluationComplexResult(EvaluationComplexResult ecResult);

    void deleteTaskByPlanId(String id);

    List<EvaluationTask> getMonitoerTaskByTeacherId(EvaluationTask task);

    List<EvaluationTask> getTasksByGroupId(String id);

    @Transactional
    Map<String, List<EvaluationEmp>> exportEvaluationResultList(String taskIds,String evaluationType);

    List<EvaluationEmp> getEvaluationResultList(EvaluationTask etask);

    List<Group> getEmpGroupList(Group group);

    Group getEmpGroup(String id);

    void saveEmpGroup(Group group);

    List<EvaluationTask> getTasksByEmpGroupId(String id);

    void deleteEmpGroup(String id);

    void deleteMemberByEmpGroupId(String id);

    void updateEmpGroup(Group group);

    List<EvaluationGroupEmps> getEmpsTree(String id);

    List<EvaluationGroupEmps> getEmpsTreeByTaskId(String taskId);

    @Transactional
    void saveGroupEmps(String ids, String groupId, String evaluationType);

    void deleteGroupEmps(String id);

    @Transactional
    void editCopyMemberGroup(String id);

    @Transactional
    void editCopyPlan(String id);

    @Transactional
    void editCopyEmpGroup(String id);

    @Transactional
    void editCopyTask(String id);

    Map<String, List> getMembersByTaskIDType(String id);

    void saveProportion(EvaluationTask task);

    @Transactional
    void setStartFlagByTaskId(String taskId,String startFlag);

    @Transactional
    Map getcheckEmpsList(String complexTaskId, String evaluationType);

    /**
     * 领导评教任务
     */
    List<EvaluationTask> getLeaderTasks(EvaluationTask task);

    List<EvaluationEmpsMenmbers> getLeaderListTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    List<EvaluationTask> getMonitoerLeaderTask(EvaluationTask task);

    List<EvaluationTask> getMonitoerLeaderTaskBySelf(EvaluationTask task);

    Map getLeaderTeacherEcharts(EchartsMenu echartsMenu);
    /**
     * 教师评教任务
     */
    List<EvaluationTask> getTeacherTasks(EvaluationTask task);

    List<EvaluationEmpsMenmbers> getTeacherListTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    List<EvaluationTask> getMonitoerTeacherTask(EvaluationTask task);

    List<EvaluationTask> getMonitoerTeacherTaskBySelf(EvaluationTask task);

    Map getTeacherTeacherEcharts(EchartsMenu echartsMenu);
    /**
     * 学生评教任务
     */
    List<EvaluationTask> getStudentTasks(EvaluationTask task);

    List<EvaluationEmpsMenmbers> getStudentListTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    List<EvaluationTask> getMonitoerStudentTask(EvaluationTask task);

    List<EvaluationTask> getMonitoerStudentTaskBySelf(EvaluationTask task);

    Map getStudentTeacherEcharts(EchartsMenu echartsMenu);
    /**
     * 同行评教任务
     */
    List<EvaluationTask> getPeerTasks(EvaluationTask task);

    List<EvaluationEmpsMenmbers> getPeerListTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    List<EvaluationTask> getMonitoerPeerTask(EvaluationTask task);

    List<EvaluationTask> getMonitoerPeerTaskBySelf(EvaluationTask task);

    Map getPeerTeacherEcharts(EchartsMenu echartsMenu);
    /**
     * 社会评教任务
     */
    List<EvaluationTask> getParentTasks(EvaluationTask task);

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

    List<EvaluationTask> getUserTask(String loginId);

    List<EvaluationTask> getTaskResultList();

    List getInterviewersGroupList(Group group);

    List<Tree> getInterviwerTree();

    List<EvaluationTask> getInterviewersTasks(EvaluationTask task);

    List<EvaluationEmpsMenmbers> getInterviewersListTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers);

    @Transactional
    void saveGroupInterviewersEmps(String ids, String groupId, String evaluationType);

    List<EvaluationTask> getMonitorInterviewersTask(EvaluationTask task);

    List<AutoComplete> getInterviewers();
}
