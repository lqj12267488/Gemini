package com.goisan.workflow.service;

import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Select2;
import com.goisan.task.bean.SysTask;
import com.goisan.workflow.bean.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Admin on 2017/5/5.
 */
public interface WorkflowService {

    void saveWorkflow(Workflow workflow);

    void saveHandleAfter(Handle handle);

    List<Workflow> getWorkflowList(Workflow workflow);

    void delWorkflow(String workflowId);

    Workflow getWorkflowById(String workflowId);

    void updateWorkflow(Workflow workflow);

    List getNodeListByWorkflowId(String workflowId);

    void start(Start audit);

    String getWorkflowIdByTableName(String tableName);

    Node getStratNodeId(String workflowId);

    void saveHandle(Handle startHandle);

    Definition getNextNodeId(String workflowId, String nodeId, String term);

    Start getWorkflowStart(String tableName, String businessId);

    Start getWorkflowStartByWorkflowCode(String tableName, String businessId, String workflowCode);

    Handle getHandle(String startId,String personId);

    void updateHandleState(String id, String remark);

    void updateStartState(String startId);

    List<Node> getNextNodeList(String workflowId, String nodeId);

    List<Handle> getHandleList(String startId);

    List<Select2> getAuditer(String handleRole);

    List<Select2> getAuditerByDept(String tableName, String businessId, String handleRole);

    String getUnAudit(String tableName, String personId);

    List<Select2> getAuditerByRange(String tableName, String businessId);

    void updateBusiness(String tableName, String businessId, String state);

    String getRejectState(String tableName, String businessId, String personId);

    String getBusinessStatus(String tableName, String businessId, String personId);

    List<Select2> getAuditerByPersonId(String tableName, String businessId);

    Handle getHandleLog(String startId);

    List<Select2> getStartAuditerBydept(String tableName, String deptId);

    List<Select2> getStartAuditerByWorkflowCode(String tableName, String deptId, String workflowCode);

    Feedback getFeedback(String tableName, String businessId);

    void feedback(String businessId, String tableName, String feedbackFlag, String feedback);

    List<String> getRelationList();

    Node getNextNodeIdByStartNodeId(String nodeId);

    String getWorkflowIdByWorkflowCode(String workflowCode);

    void submitTask(Start start, SysTask task);

    List<Workflow> getlistWorkFlowNameApp(String personId);

    List<Start> getlistWorkFlowNameAppByType(@Param(value="personId") String personId, @Param(value="workFlowName")String workFlowName);

    List<Start> getlistUnDoWorkFlowNameAppByType( String personId);

    String getlistWorkFlowCountApp(String personId);

    String getlistWorkFlowDoneCountApp(String personId);

    Start getStartByIdApp( String startId);

    String getRelationUrlByWorkFlowId(String workFlowId);

    Handle getHandleListByCreator(Handle handle);

    List<Handle> getUnAuditHandleList(String startId);

    void updateHandleStateByNodeIdAndStartId(String startId, String personId, String remark);

    String getAppUrlByWorkFlowId(String workFlowId);

    String getEditAppUrlByWorkFlowId(String workFlowId);

    List<Select2> getOpinion(String personId);

    List<Select2> getAuditerByCreator(String tableName, String businessId);

    List<IndexUnAudti> getIndexUnAudtiList(String id);

    List<IndexUnAudti> getUnRelationList(String workflowId,String personId,String id);

    List<IndexUnAudti> getRelationListById(String personId,String id);

    List<Workflow> getAppStartList();

    BaseBean getBusinessById(String businessId, String tableName);

    Relation getRelation(String workflowId, String tableName);

    void updateTask(String id);

    List<Workflow> getAppRequestList(String tableName);

    Workflow editAppInfoList(String tableName,String workflowId);

    void insertBusiness(String tableName,String businessId,String deptId);

    void stopUpdateBusiness(Handle handle, String tableName, String businessId);

    String getWorkflowNameByWorkflowCode(String workflowCode);

    List<IndexUnAudti> getIndexUnAudtiMoreList(String id);

    List<IndexUnAudti> getIndexAudtiMoreList(String id);

    List<Select2> getStudentAuditer(String tableName,String businessId);

    List<Select2> getStudentAuditerGrantManagement(@Param("tableName") String tableName, @Param("businessId")
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

    List<Handle> getHandleListByDocumentProcess(String startId);
}
