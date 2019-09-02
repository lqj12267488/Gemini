package com.goisan.workflow.service.impl;

import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Select2;
import com.goisan.system.dao.EmpDao;
import com.goisan.system.tools.CommonUtil;
import com.goisan.task.bean.SysTask;
import com.goisan.task.dao.TaskDao;
import com.goisan.workflow.bean.*;
import com.goisan.workflow.dao.NodeDao;
import com.goisan.workflow.dao.WorkflowDao;
import com.goisan.workflow.service.WorkflowService;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Admin on 2017/5/5.
 */
@Service
public class WorkflowServiceImpl implements WorkflowService {
    @Resource
    private WorkflowDao workflowDao;
    @Resource
    private EmpDao empDao;
    @Resource
    private TaskDao taskDao;
    @Resource
    private NodeDao nodeDao;

    public void saveWorkflow(Workflow workflow) {
        workflowDao.saveWorkflow(workflow);
    }

    public void saveHandleAfter(Handle handle) { workflowDao.saveHandleAfter(handle);}

    public List<Workflow> getWorkflowList(Workflow workflow) {
        return workflowDao.getWorkflowList(workflow);
    }

    public void delWorkflow(String workflowId) {
        workflowDao.delWorkflow(workflowId);
        workflowDao.delNodeByWorkflowId(workflowId);
        workflowDao.delDefinitionByWorkflowId(workflowId);
    }

    public Workflow getWorkflowById(String workflowId) {
        return workflowDao.getWorkflowById(workflowId);
    }

    public List getNodeListByWorkflowId(String workflowId) {
        return workflowDao.getNodeListByWorkflowId(workflowId);
    }


    public void updateWorkflow(Workflow workflow) {
        workflowDao.updateWorkflow(workflow);
    }

    public void start(Start start) {
        workflowDao.start(start);
    }

    public String getWorkflowIdByTableName(String tableName) {
        return workflowDao.getWorkflowIdByTableName(tableName);
    }

    public Node getStratNodeId(String workflowId) {
        return workflowDao.getStratNodeId(workflowId);
    }

    public void saveHandle(Handle startHandle) {
        workflowDao.saveHandle(startHandle);
    }

    public Definition getNextNodeId(String workflowId, String nodeId, String term) {
        return workflowDao.getNextNodeId(workflowId, nodeId, term);
    }

    public Start getWorkflowStart(String tableName, String businessId) {
        return workflowDao.getWorkflowStart(tableName, businessId);
    }

    public Start getWorkflowStartByWorkflowCode(String tableName, String businessId, String
            workflowCode) {
        return workflowDao.getWorkflowStartByWorkflowCode(tableName, businessId, workflowCode);
    }


    public Handle getHandle(String startId, String personId) {
        return workflowDao.getHandle(startId, personId);
    }

    public void updateHandleState(String id, String remark) {
        workflowDao.updateHandleState(id, remark);
    }

    public void updateStartState(String startId) {
        workflowDao.updateStartState(startId);
    }

    public List<Node> getNextNodeList(String workflowId, String nodeId) {
        return workflowDao.getNextNodeList(workflowId, nodeId);
    }

    public List<Handle> getHandleList(String startId) {
        return workflowDao.getHandleList(startId);
    }

    public List<Select2> getAuditer(String handleRole) {
        return workflowDao.getAuditer(handleRole);
    }

    public List<Select2> getAuditerByDept(String tableName, String businessId, String handleRole) {
        return workflowDao.getAuditerByDept(tableName, businessId, handleRole);
    }

    public String getUnAudit(String tableName, String personId) {
        return "AND id in (SELECT s.business_id FROM t_sys_workflow_start s, " +
                "t_sys_workflow_handle h WHERE h.state = '1' AND s.state = '1' AND h.start_id = s" +
                ".start_id AND s.table_name = '" + tableName + "' AND h.handle_user LIKE '%" +
                personId + "%')";
    }

    public String getWorlflowLog(String tableName, String personId) {
        return "AND id in SELECT s.business_id FROM t_sys_workflow_start s, t_sys_workflow_handle" +
                " h" +
                " WHERE h.state = '2' AND h.start_id = s.start_id" +
                " AND s.table_name = '" + tableName + "' AND h.handle_user LIKE '%" + personId +
                "%'";
    }

    public List<Select2> getAuditerByRange(String tableName, String businessId) {
        return workflowDao.getAuditerByRange(tableName, businessId);
    }

    public void updateBusiness(String tableName, String businessId, String state) {
        workflowDao.updateBusiness(tableName, businessId, state);
    }

    public String getRejectState(String tableName, String businessId, String personId) {
        return workflowDao.getRejectState(tableName, businessId, personId);
    }

    public String getBusinessStatus(String tableName, String businessId, String personId) {
        return workflowDao.getBusinessStatus(tableName,businessId,personId);
    }

    public List<Select2> getAuditerByPersonId(String tableName, String businessId) {
        return workflowDao.getAuditerByPersonId(tableName, businessId);
    }

    public Handle getHandleLog(String startId) {
        return workflowDao.getHandleLog(startId);
    }

    public List<Select2> getStartAuditerBydept(String tableName, String deptId) {
        return workflowDao.getStartAuditerBydept(tableName, deptId);
    }

    public List<Select2> getStartAuditerByWorkflowCode(String tableName, String deptId, String
            workflowCode) {
        return workflowDao.getStartAuditerByWorkflowCode(tableName, deptId, workflowCode);
    }

    public Feedback getFeedback(String tableName, String businessId) {
        return workflowDao.getFeedback(tableName, businessId);
    }

    public void feedback(String businessId, String tableName, String feedbackFlag, String
            feedback) {
        workflowDao.feedback(businessId, tableName, feedbackFlag, feedback);
    }

    public List<String> getRelationList() {
        return workflowDao.getRelationList();
    }

    public Node getNextNodeIdByStartNodeId(String nodeId) {
        return workflowDao.getNextNodeIdByStartNodeId(nodeId);
    }

    public String getWorkflowIdByWorkflowCode(String workflowCode) {
        return workflowDao.getWorkflowIdByWorkflowCode(workflowCode);
    }

    public void submitTask(Start start, SysTask task) {
        //更新待办任务表
        task.setTaskId(start.getWorkflowId());
        task.setTaskFlag("1");
        taskDao.updateTaskFlag(task);
        String workflowId = workflowDao.getWorkflowIdByWorkflowCode(start.getWorkflowCode());
        String handleUser = start.getHandleUser().split(",")[0];
        String handleName = start.getHandleName().split("--")[0];
        String handleDept = start.getHandleUser().split(",")[1];
        start.setWorkflowId(workflowId);
        start.setStartId(CommonUtil.getUUID());
        start.setHandleUser(CommonUtil.getPersonId());
        CommonUtil.save(start);
        workflowDao.start(start);
        workflowDao.updateBusiness(start.getTableName(), start.getBusinessId(), "1");
        Node cuurentNodeId = workflowDao.getStratNodeId(workflowId);
        Handle startHandle = new Handle();
        startHandle.setId(CommonUtil.getUUID());
        startHandle.setStartId(start.getStartId());
        startHandle.setCuurentWorkflowId(workflowId);
        startHandle.setHandleRole(cuurentNodeId.getHandleRole());
        startHandle.setHandleUser(CommonUtil.getPersonId());
        startHandle.setHandleName(empDao.getPersonNameById(CommonUtil.getPersonId()));
        startHandle.setHandleDept(CommonUtil.getDefaultDept());
        startHandle.setCuurentNodeId(cuurentNodeId.getNodeId());
        startHandle.setCreator(empDao.getPersonNameById(CommonUtil.getPersonId()));
        startHandle.setState("2");
        workflowDao.saveHandle(startHandle);
        Definition nextNode = workflowDao.getNextNodeId(workflowId, cuurentNodeId.getNodeId(), null);
        Handle cuurentHandle = new Handle();
        cuurentHandle.setId(CommonUtil.getUUID());
        cuurentHandle.setStartId(start.getStartId());
        cuurentHandle.setCuurentWorkflowId(workflowId);
        cuurentHandle.setHandleUser(handleUser);
        cuurentHandle.setHandleRole(nodeDao.getNodeById(nextNode.getNextNodeId()).getHandleRole());
        cuurentHandle.setHandleName(handleName);
        cuurentHandle.setHandleDept(handleDept);
        cuurentHandle.setCuurentNodeId(nextNode.getNextNodeId());
        cuurentHandle.setCreator(empDao.getPersonNameById(CommonUtil.getPersonId()));
        cuurentHandle.setState("1");
        workflowDao.saveHandle(cuurentHandle);


    }

    public List<Handle> getUnAuditHandleList(String startId) {
        return workflowDao.getUnAuditHandleList(startId);
    }

    public void updateHandleStateByNodeIdAndStartId(String startId, String personId, String
            remark) {
        workflowDao.updateHandleStateByNodeIdAndStartId(startId,personId,remark);
    }

    public String getAppUrlByWorkFlowId(String workFlowId) {
        return workflowDao.getAppUrlByWorkFlowId(workFlowId);
    }

    @Override
    public String getEditAppUrlByWorkFlowId(String workFlowId) {
        return workflowDao.getEditAppUrlByWorkFlowId(workFlowId);
    }

    public List<Workflow> getlistWorkFlowNameApp(String personId) {
        return workflowDao.getlistWorkFlowNameApp(personId);
    }

    public List<Start> getlistWorkFlowNameAppByType(String creator,String workFlowName) {
        return workflowDao.getlistWorkFlowNameAppByType(creator,workFlowName);
    }

    public List<Start> getlistUnDoWorkFlowNameAppByType(String personId) {
        return workflowDao.getlistUnDoWorkFlowNameAppByType(personId);
    }

    public String getlistWorkFlowCountApp(String personId) {
        return workflowDao.getlistWorkFlowCountApp(personId);
    }

    public String getlistWorkFlowDoneCountApp(String personId) {
        return workflowDao.getlistWorkFlowDoneCountApp(personId);
    }

    public Start getStartByIdApp(String startId) {
        return workflowDao.getStartByIdApp(startId);
    }

    public String getRelationUrlByWorkFlowId(String workFlowId) {
        return workflowDao.getRelationUrlByWorkFlowId(workFlowId);
    }

    public Handle getHandleListByCreator(Handle handle) {
        return workflowDao.getHandleListByCreator(handle);
    }

    public List<Select2> getOpinion(String personId) {
        return workflowDao.getOpinion(personId);
    }

    public List<Select2> getAuditerByCreator(String tableName, String businessId) {
        return workflowDao.getAuditerByCreator(tableName,businessId);
    }

    public List<IndexUnAudti> getIndexUnAudtiList(String id) {
        return workflowDao.getIndexUnAudtiList(id);
    }

    public List<IndexUnAudti> getUnRelationList(String workflowId,String personId,String id) {
        return workflowDao.getUnRelationList(workflowId,personId,id);
    }

    public List<IndexUnAudti> getRelationListById(String personId, String id) {
        return workflowDao.getRelationListById(personId,id);
    }

    public List<Workflow> getAppStartList() {
        return workflowDao.getAppStartList();
    }

    public BaseBean getBusinessById(String businessId, String tableName) {
        return workflowDao.getBusinessById(businessId,tableName);
    }

    public Relation getRelation(String workflowId, String tableName) {
        return workflowDao.getRelation(workflowId,tableName);
    }

    public void updateTask(String id) {
        workflowDao.updateTask(id);
    }

    public List<Workflow> getAppRequestList(String tableName) {
        return workflowDao.getAppRequestList(tableName);
    }

    public Workflow editAppInfoList(String tableName,String workflowId) {
        return workflowDao.editAppInfoList(tableName,workflowId);
    }

    public void insertBusiness(String tableName, String businessId,String deptId) {
        workflowDao.delNullWorkflow(businessId,tableName);
        workflowDao.insertBusiness(tableName,businessId,deptId);
    }
    public void stopUpdateBusiness(Handle handle, String tableName, String businessId) {
        workflowDao.updateStartStateForStop(handle.getStartId());
        workflowDao.updateBusiness(tableName, businessId, "4");
    }

    @Override
    public String getWorkflowNameByWorkflowCode(String workflowCode) {
        return workflowDao.getWorkflowNameByWorkflowCode(workflowCode);
    }

    @Override
    public List<IndexUnAudti> getIndexUnAudtiMoreList(String id) {
        return workflowDao.getIndexUnAudtiMoreList(id);
    }

    @Override
    public List<IndexUnAudti> getIndexAudtiMoreList(String id) {
        return workflowDao.getIndexAudtiMoreList(id);
    }

    public List<Select2> getStudentAuditer(String tableName,String businessId) {
        return workflowDao.getStudentAuditer(tableName,businessId);
    }

    public String getCuurentNodeIdByStartIdAndHandleUserHandleRole(@Param("startId") String startId, @Param
            ("personId") String personId){
        return workflowDao.getCuurentNodeIdByStartIdAndHandleUserHandleRole(startId,personId);
    }

    public void updateHandleStateByCuurentNodeId(@Param("startId") String startId,@Param
            ("cuurentNodeId") String cuurentNodeId, @Param("remark") String remark){
        workflowDao.updateHandleStateByCuurentNodeId(startId,cuurentNodeId,remark);
    }

    public void updateHandleStateByNodeIdAndStartIdRole(@Param("startId") String startId, @Param
            ("personId") String personId, @Param("remark") String remark,@Param("handleRole") String handleRole){
        workflowDao.updateHandleStateByNodeIdAndStartIdRole(startId,personId,remark,handleRole);
    }

    public List<Select2> getHeadTeacherByStudentId(@Param
            ("studentId") String studentId){
        return workflowDao.getHeadTeacherByStudentId(studentId);
    }
}
