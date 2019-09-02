package com.goisan.workflow.dao;

import com.goisan.system.bean.BaseBean;
import com.goisan.task.bean.SysTask;
import com.goisan.workflow.bean.IndexUnAudti;
import com.goisan.workflow.bean.Feedback;
import com.goisan.system.bean.Select2;
import com.goisan.workflow.bean.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Admin on 2017/5/5.
 */
@Repository
public interface WorkflowDao {

    void saveWorkflow(Workflow workflow);

    void saveHandleAfter(Handle handle);

    List<Workflow> getWorkflowList(Workflow workflow);

    void delWorkflow(String workflowId);

    Workflow getWorkflowById(String workflowId);

    void updateWorkflow(Workflow workflow);

    List getNodeListByWorkflowId(String workflowId);

    void updateBusinessState(String tableName, String businessId);

    void start(Start audit);

    String getWorkflowIdByTableName(String tableName);

    void saveHandle(Handle handle);

    Node getStratNodeId(String workflowId);

    Definition getNextNodeId(@Param("workflowId") String workflowId, @Param("nodeId") String
            nodeId, @Param("term") String term);

    Start getWorkflowStart(@Param("tableName") String tableName, @Param("businessId") String
            businessId);

    Start getWorkflowStartByWorkflowCode(@Param("tableName") String tableName, @Param
            ("businessId") String businessId, @Param("workflowCode") String workflowCode);

    Handle getHandle(@Param("startId") String startId, @Param("personId") String personId);

    Handle getHandle(String startId);

    void updateHandleState(@Param("id") String id, @Param("remark") String remark);

    void updateHandleStateForStop(@Param("id") String id, @Param("remark") String remark);

    void updateStartState(String startId);

    void updateStartStateForStop(String startId);

    List<Node> getNextNodeList(@Param("workflowId") String workflowId, @Param("nodeId") String
            nodeId);

    List<Handle> getHandleList(String startId);

    List<Select2> getAuditer(String handleRole);

    List<Select2> getAuditerByDept(@Param("tableName") String tableName, @Param("businessId")
            String businessId, @Param("handleRole") String handleRole);

    List<Select2> getAuditerByRange(@Param("tableName") String tableName, @Param("businessId")
            String businessId);

    void updateBusiness(@Param("tableName") String tableName, @Param("businessId") String
            businessId, @Param("state") String state);

    String getRejectState(@Param("tableName") String tableName, @Param("businessId") String
            businessId, @Param("personId") String personId);

    String getBusinessStatus(@Param("tableName") String tableName, @Param("businessId") String
            businessId, @Param("personId") String personId);

    List<Select2> getAuditerByPersonId(@Param("tableName") String tableName, @Param("businessId")
            String businessId);

    Handle getHandleLog(String startId);

    List<Select2> getStartAuditerBydept(@Param("tableName") String tableName, @Param("deptId")
            String deptId);

    List<Select2> getStartAuditerByWorkflowCode(@Param("tableName") String tableName, @Param
            ("deptId") String deptId, @Param("workflowCode") String workflowCode);

    Feedback getFeedback(@Param("tableName") String tableName, @Param("businessId") String
            businessId);

    void feedback(@Param("businessId") String businessId, @Param("tableName") String tableName,
                  @Param("feedbackFlag") String feedbackFlag, @Param("feedback") String feedback);

    List<String> getRelationList();

    Node getNextNodeIdByStartNodeId(String nodeId);

    String getWorkflowIdByWorkflowCode(String workflowCode);

    void submitTask(Start start, SysTask task);

    List<Handle> getUnAuditHandleList(String startId);

    void updateHandleStateByNodeIdAndStartId(@Param("startId") String startId, @Param
            ("personId") String personId, @Param("remark") String remark);

    List<Workflow> getlistWorkFlowNameApp(String personId);

    List<Start> getlistWorkFlowNameAppByType(@Param(value = "creator") String creator, @Param
            (value = "workFlowName") String workFlowName);

    List<Start> getlistUnDoWorkFlowNameAppByType(String personId);

    Start getStartByIdApp(String startId);

    String getlistWorkFlowCountApp(String personId);

    String getRelationUrlByWorkFlowId(String workFlowId);

    Handle getHandleListByCreator(Handle handle);

    String getlistWorkFlowDoneCountApp(String personId);

    String getAppUrlByWorkFlowId(String workFlowId);

    String getEditAppUrlByWorkFlowId(String workFlowId);

    List<Select2> getOpinion(String personId);

    List<Select2> getAuditerByCreator(@Param("tableName") String tableName, @Param("businessId")
            String businessId);

    List<IndexUnAudti> getIndexUnAudtiList(@Param("id") String id);

    List<IndexUnAudti> getIndexUnAudtiMoreList(@Param("id") String id);

    List<IndexUnAudti> getIndexAudtiMoreList(@Param("id") String id);

    List<IndexUnAudti> getUnRelationList(@Param("workflowId") String workflowId,@Param("personId") String personId,@Param("id") String id);

    List<IndexUnAudti> getRelationListById(@Param("personId") String personId,@Param("id") String id);

    List<Workflow> getAppStartList();


    BaseBean getBusinessById(@Param("businessId")String businessId, @Param("tableName")String tableName);


    Relation getRelation(@Param("workflowId")String workflowId,@Param("tableName") String tableName);

    void updateTask(String id);

    List<Workflow> getAppRequestList(@Param("tableName") String tableName);

    Workflow editAppInfoList(@Param("tableName") String tableName,@Param("workflowId") String workflowId);

    void insertBusiness(@Param("tableName")String tableName,@Param("businessId")String businessId,@Param("deptId")String deptId);
    

    void delNodeByWorkflowId(String workflowId);

    void delDefinitionByWorkflowId(String workflowId);

    void delNullWorkflow(@Param("businessId")String businessId, @Param("tableName")String tableName);

    String getWorkflowNameByWorkflowCode(String workflowCode);

    List<Select2> getStudentAuditer(@Param("tableName") String tableName, @Param("businessId")
            String businessId);

    /**
     * 获取当前节点 角色是（校级/副校级领导审核）
     * @param startId
     * @param personId
     * @return
     */
    String getCuurentNodeIdByStartIdAndHandleUserHandleRole(@Param("startId") String startId, @Param
            ("personId") String personId);
    /**
     * 多人办理驳回修改多个状态
     * @param startId
     * @param cuurentNodeId
     * @param remark
     */
    void updateHandleStateByCuurentNodeId(@Param("startId") String startId,@Param
            ("cuurentNodeId") String cuurentNodeId, @Param("remark") String remark);

    void updateHandleStateByNodeIdAndStartIdRole(@Param("startId") String startId, @Param
            ("personId") String personId, @Param("remark") String remark,@Param("handleRole") String handleRole);

    List<Select2> getHeadTeacherByStudentId(@Param
            ("studentId") String studentId);
}
