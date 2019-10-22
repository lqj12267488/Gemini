package com.goisan.workflow.controller;

import com.goisan.educational.score.bean.ScoreChange;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.score.service.ScoreChangeService;
import com.goisan.partybuilding.reportmanagement.bean.ReportManagement;
import com.goisan.partybuilding.reportmanagement.service.ReportManagementService;
import com.goisan.synergy.message.service.MessageService;
import com.goisan.synergy.notice.service.NoticeService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.task.bean.SysTask;
import com.goisan.task.service.TaskService;
import com.goisan.workflow.bean.*;
import com.goisan.workflow.service.DefinitionService;
import com.goisan.workflow.service.NodeService;
import com.goisan.workflow.service.WorkflowService;
import com.goisan.workflow.util.UpdateBusiness;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Admin on 2017/5/5.
 */
@Controller
public class WorkflowController {

    @Resource
    private WorkflowService workflowService;
    @Resource
    private NodeService nodeService;
    @Resource
    private DefinitionService definitionService;
    @Resource
    private EmpService empService;
    @Resource
    private TaskService taskService;
    @Resource
    private UpdateBusiness updateBusiness;
    @Resource
    private ScoreChangeService scoreChangeService;
    @Resource
    private ReportManagementService reportManagementService;

    @RequestMapping("/workflow")
    public String workflow() {
        return "/core/wf/workflow";
    }

    @RequestMapping("/toAddWorkflow")
    public String toAddWorkflow() {
        return "/core/wf/addWorkflow";
    }

    @ResponseBody
    @RequestMapping("/getWorkflowList")
    public Map<String, List> getWorkflowList(Workflow workflow) {
        return CommonUtil.tableMap(workflowService.getWorkflowList(workflow));
    }

    @ResponseBody
    @RequestMapping("/saveWorkflow")
    public Message saveWorkflow(Workflow workflow) {
        workflow.setWorkflowId(CommonUtil.getUUID());
        workflow.setCreator(CommonUtil.getPersonId());
        workflow.setCreateDept(CommonUtil.getDefaultDept());
        workflow.setCreateTime(CommonUtil.getDate());
        workflowService.saveWorkflow(workflow);
        return new Message(1, "添加成功！", null);
    }

    @ResponseBody
    @RequestMapping("/delWorkflow")
    public Message delWorkflow(String workflowId) {
        workflowService.delWorkflow(workflowId);
        return new Message(1, "删除成功！", null);
    }

    @RequestMapping("/toUpdateWorkflow")
    public ModelAndView toUpdateWorkflow(String workflowId) {
        ModelAndView mv = new ModelAndView("/core/wf/editWorkflow");
        Workflow workflow = workflowService.getWorkflowById(workflowId);
        String loginId = CommonUtil.getPersonId();
        mv.addObject("workflow", workflow);
        mv.addObject("loginId", loginId);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/updateWorkflow")
    public Message updateWorkflow(Workflow workflow) {
        workflow.setChanger(CommonUtil.getPersonId());
        workflow.setChangeDept(CommonUtil.getDefaultDept());
        workflow.setChangeTime(CommonUtil.getDate());
        workflowService.updateWorkflow(workflow);
        return new Message(1, "修改成功！", null);
    }

    @ResponseBody
    @RequestMapping("/getNodeListByWorkflowId")
    public Map<String, List> getNodeListByWorkflowId(String workflowId) {
        return CommonUtil.tableMap(workflowService.getNodeListByWorkflowId(workflowId));
    }

    @RequestMapping("/node")
    public ModelAndView node(String workflowId) {
        Workflow workflow = workflowService.getWorkflowById(workflowId);
        String workflowName = workflow.getWorkflowName();
        ModelAndView mv = new ModelAndView("/core/wf/node");
        mv.addObject("workflowId", workflowId);
        mv.addObject("workflowName", workflowName);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/submit")
    public Message submit(Start start) {
        String workflowId = workflowService.getWorkflowIdByWorkflowCode(start.getWorkflowCode());
        String[] users = start.getHandleUser().split(",");
        String[] names = start.getHandleName().split(",");
        //String workflowId = workflowService.getWorkflowIdByTableName(start.getTableName());
        start.setWorkflowId(workflowId);
        start.setStartId(CommonUtil.getUUID());
        start.setHandleUser(CommonUtil.getPersonId());
        start.setHandleName(empService.getPersonNameById(CommonUtil.getPersonId()));
        CommonUtil.save(start);
        workflowService.start(start);
        workflowService.updateBusiness(start.getTableName(), start.getBusinessId(), "1");
        Node cuurentNodeId = workflowService.getStratNodeId(workflowId);
        Handle startHandle = new Handle();
        startHandle.setId(CommonUtil.getUUID());
        startHandle.setStartId(start.getStartId());
        startHandle.setCuurentWorkflowId(workflowId);
        startHandle.setHandleRole(cuurentNodeId.getHandleRole());
        startHandle.setHandleUser(CommonUtil.getPersonId());
        startHandle.setHandleName(empService.getPersonNameById(CommonUtil.getPersonId()));
        startHandle.setHandleDept(CommonUtil.getDefaultDept());
        startHandle.setCuurentNodeId(cuurentNodeId.getNodeId());
        startHandle.setCreator(empService.getPersonNameById(CommonUtil.getPersonId()));
        startHandle.setState("2");
        workflowService.saveHandle(startHandle);
        Definition nextNode = workflowService.getNextNodeId(workflowId, cuurentNodeId.getNodeId(), null);
        for (int i = 0; i < users.length; i++) {
            String handleUser = null;
            String handleDept = null;
            String handleName = null;
            if (start.getHandleUser() != null) {
                handleUser = users[i].split(":")[0];
                handleDept = users[i].split(":")[1];
                handleName = names[i].split("--")[0];
            }
            Handle handle = new Handle();
            handle.setId(CommonUtil.getUUID());
            handle.setStartId(start.getStartId());
            handle.setCuurentWorkflowId(start.getWorkflowId());
            handle.setHandleUser(handleUser);
            handle.setHandleDept(handleDept);
            handle.setHandleRole(nodeService.getNodeById(nextNode.getNextNodeId()).getHandleRole());
            handle.setCuurentNodeId(nextNode.getNextNodeId());
            handle.setHandleName(handleName);
            handle.setCreator(empService.getPersonNameById(CommonUtil.getPersonId()));
            handle.setState("1");
            workflowService.saveHandleAfter(handle);
        }
        return new Message(1, "提交成功！", null);
    }

    @ResponseBody
    @RequestMapping("/submitTask")
    public Message submitTask(Start start, SysTask task) {
        workflowService.submitTask(start, task);
        return new Message(1, "提交成功！", null);
    }

    @ResponseBody
    @RequestMapping("/checkUnAudit")
    public Message check(String tableName, String businessId) {
        Message msg = new Message();
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        List<Handle> cuurent = workflowService.getUnAuditHandleList(start.getStartId());
        Node cuurentNode = nodeService.getNodeById(cuurent.get(0).getCuurentNodeId());
        if ("0".equals(cuurentNode.getNodeType())) {
            msg.setStatus(0);
        } else if ("1".equals(cuurentNode.getNodeType())) {
            msg.setStatus(0);
        } else if ("2".equals(cuurentNode.getNodeType()) && cuurent.size() == 1) {
            msg.setStatus(0);
        } else {
            msg.setStatus(1);
        }
        return msg;
    }

    @Resource
    private NoticeService noticeService;
    @Resource
    private MessageService messageService;

    @ResponseBody
    @RequestMapping("/audit")
    public Message audit(Handle handle, String term, String tableName, String businessId) {
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        Handle cuurent = workflowService.getHandle(start.getStartId(), CommonUtil.getPersonId());
        Node node = nodeService.getNodeById(cuurent.getCuurentNodeId());
        Definition nextNode = workflowService.getNextNodeId(start.getWorkflowId(), cuurent
                .getCuurentNodeId(), term);
        //多选单人和单选单人
        if (!"2".equals(node.getNodeType())) {
            workflowService.updateHandleState(cuurent.getId(), handle.getRemark());
            List<Handle> handles = workflowService.getUnAuditHandleList(start.getStartId());
            for (Handle h : handles) {
                if (!h.getId().equals(cuurent.getId())) {
                    workflowService.updateHandleState(h.getId(), null);
                }
            }
            if ("-1".equals(term)) {
                //办结
                handle.setId(CommonUtil.getUUID());
                handle.setStartId(start.getStartId());
                handle.setCuurentWorkflowId(start.getWorkflowId());
                handle.setHandleRole(nodeService.getNodeById(nextNode.getNextNodeId()).getHandleRole());
                handle.setCuurentNodeId(nextNode.getNextNodeId());
                handle.setHandleName(empService.getPersonNameById(CommonUtil.getPersonId()));
                handle.setState("2");
                handle.setCreator(empService.getPersonNameById(CommonUtil.getPersonId()));
                BaseBean bean = workflowService.getBusinessById(businessId, tableName);
                Relation relation = workflowService.getRelation(start.getWorkflowId(), tableName);
                Workflow workflow = workflowService.getWorkflowById(start.getWorkflowId());
                SysTask task = new SysTask();
                if ("T_JW_SCORE_CHANGE_WF".equals(tableName)) {
                    ScoreChange scoreChange = scoreChangeService.getScoreChangeById(businessId);
                    ScoreImport scoreImport = scoreChangeService.getScoreImportById2(scoreChange.getScoreId());
                    scoreChange.setChanger(CommonUtil.getPersonId());
                    if ("1".equals(scoreImport.getExamTypes())) {
                        if ("1".equals(scoreChange.getExaminationStatus())) {
                            if ("".equals(scoreChange.getExaminationResults()) || null == scoreChange.getExaminationResults()) {
                                if (Integer.parseInt(scoreChange.getScore()) >= 60) {
                                    scoreChange.setScoreType("0");
                                } else {
                                    scoreChange.setScoreType("1");
                                }
                            } else {
                                if ("04".equals(scoreChange.getExaminationResults())) {
                                    scoreChange.setScoreType("1");
                                } else {
                                    scoreChange.setScoreType("0");
                                }
                            }
                        }
                    } else {
                        if ("1".equals(scoreChange.getMakeupScore())) {
                            scoreChange.setScoreType("0");
                        } else {
                            scoreChange.setScoreType("1");
                        }
                    }
                    scoreChangeService.updateScoreById(scoreChange);
                }
                task.setTaskId(CommonUtil.getUUID());
                task.setTaskTitle(workflow.getWorkflowName());
                task.setDeptId(bean.getCreateDept());
                task.setPersonId(bean.getCreator());
                task.setTaskBusinessId(businessId);
                task.setTaskTime(CommonUtil.now("yyyy-MM-dd"));
                task.setTaskFlag("1");
                task.setTaskTable(tableName);
                task.setTaskUrl(relation.getUrl());
                task.setTaskAppUrl(relation.getAppUrl());
                task.setTaskType("3");
                CommonUtil.save(task);
                workflowService.updateStartState(start.getStartId());
                workflowService.updateBusiness(tableName, businessId, "2");
                taskService.saveSysTask(task);
                updateBusiness.updateBusiness(tableName, businessId);
                if ("T_SYS_NOTICE".equals(tableName)) {
                    noticeService.noticePublish(businessId);
                }
                if ("T_SYS_MESSAGE".equals(tableName)) {
                    messageService.messagePublish(businessId);
                }
            } else {
                //正常流转
                String[] users = handle.getHandleUser().split(",");
                String[] names = handle.getHandleName().split(",");
                for (int i = 0; i < users.length; i++) {
                    String handleUser = null;
                    String handleDept = null;
                    String handleName = null;
                    if (handle.getHandleUser() != null) {
                        handleUser = users[i].split(":")[0];
                        handleDept = users[i].split(":")[1];
                        handleName = names[i].split("--")[0];
                    }
                    handle.setId(CommonUtil.getUUID());
                    handle.setStartId(start.getStartId());
                    handle.setCuurentWorkflowId(start.getWorkflowId());
                    handle.setHandleUser(handleUser);
                    handle.setHandleDept(handleDept);
                    handle.setHandleRole(nodeService.getNodeById(nextNode.getNextNodeId()).getHandleRole());
                    handle.setCuurentNodeId(nextNode.getNextNodeId());
                    handle.setHandleName(handleName);
                    handle.setCreator(empService.getPersonNameById(CommonUtil.getPersonId()));
                    if ("2".equals(term)) {
                        handle.setState("3");
                    } else {
                        handle.setState("1");
                    }
                    workflowService.saveHandleAfter(handle);
                }
            }
        } else {
            //多选多人
            List<Handle> handles = workflowService.getUnAuditHandleList(start.getStartId());
            if (handles.size() == 1) {
                String[] users = handle.getHandleUser().split(",");
                String[] names = handle.getHandleName().split(",");
                for (int i = 0; i < users.length; i++) {
                    String handleUser = null;
                    String handleDept = null;
                    String handleName = null;
                    if (handle.getHandleUser() != null) {
                        handleUser = users[i].split(":")[0];
                        handleDept = users[i].split(":")[1];
                        handleName = names[i].split("--")[0];
                    }
                    handle.setId(CommonUtil.getUUID());
                    handle.setStartId(start.getStartId());
                    handle.setCuurentWorkflowId(start.getWorkflowId());
                    handle.setHandleUser(handleUser);
                    handle.setHandleDept(handleDept);
                    handle.setHandleRole(nodeService.getNodeById(nextNode.getNextNodeId()).getHandleRole());
                    handle.setCuurentNodeId(nextNode.getNextNodeId());
                    handle.setHandleName(handleName);
                    handle.setCreator(empService.getPersonNameById(CommonUtil.getPersonId()));
                    if ("2".equals(term)) {
                        handle.setState("3");
                    } else {
                        handle.setState("1");
                    }
                    workflowService.saveHandleAfter(handle);
                }
            }
            workflowService.updateHandleStateByNodeIdAndStartId(start.getStartId(), CommonUtil.getPersonId(), handle.getRemark());
        }

        return new Message(1, "提交成功！", null);
    }


    @ResponseBody
    @RequestMapping("/stop")
    public Message stop(String handleId, String remark, String startId, String tableName, String businessId) {
        Handle handle = new Handle();
        Start start = workflowService.getWorkflowStart(tableName, businessId);

        handle.setId(CommonUtil.getUUID());
        handle.setStartId(start.getStartId());
        handle.setRemark(remark);
        handle.setCuurentWorkflowId(start.getWorkflowId());
        handle.setHandleUser(CommonUtil.getPersonId());
        handle.setHandleDept(CommonUtil.getDefaultDept());
        //handle.setHandleRole(nodeService.getNodeById(nextNode.getNextNodeId()).getHandleRole());
        handle.setCuurentNodeId("-1");
        handle.setHandleName(CommonUtil.getPersonName());
        handle.setCreator(empService.getPersonNameById(CommonUtil.getPersonId()));
        handle.setState("4");
        workflowService.saveHandle(handle);
        workflowService.stopUpdateBusiness(handle, tableName, businessId);
        workflowService.updateHandleState(handleId, remark);
        updateBusiness.stopBusiness(tableName, businessId);
        return new Message();
    }

    @RequestMapping("/toAudit")
    public ModelAndView toAudit(String tableName, String businessId, String url, String backUrl, String flag) {
        if (!"T_SYS_TASK".equals(tableName)) {
            Start start = workflowService.getWorkflowStart(tableName, businessId);
            Handle cuurent = workflowService.getHandle(start.getStartId(), CommonUtil.getPersonId());
            List<Definition> definitions = definitionService.getDefinitionListByNodeIdAndWorkflowId(
                    cuurent.getCuurentNodeId(), cuurent.getCuurentWorkflowId());
            List<Handle> workflowLog = workflowService.getHandleList(start.getStartId());
            List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
            ModelAndView mv = new ModelAndView("/core/wf/audit");
            mv.addObject("definitions", definitions);
            mv.addObject("tableName", tableName);
            mv.addObject("businessId", businessId);
            mv.addObject("workflowLog", workflowLog);
            mv.addObject("cuurentNodeId", cuurent.getCuurentNodeId());
            mv.addObject("nodes", nodes);
            mv.addObject("size", nodes.size());
            mv.addObject("url", url);
            mv.addObject("backUrl", backUrl);
            mv.addObject("flag", flag);
            return mv;
        } else {
            ModelAndView mv = new ModelAndView("/core/task/auditTaskEdit");
            String time = taskService.getTaskTimeById(businessId);
            String personId = CommonUtil.getPersonId();
            SysTask sysTask = taskService.selectSysTaskById(personId, time);
            mv.addObject("head", "修改");
            mv.addObject("sysTask", sysTask);
            return mv;
        }

    }

    @ResponseBody
    @RequestMapping("/getAuditer")
    public Map<String, Object> getAuditer(String tableName, String businessId, String term, String workflowCode) {
        Start start = null;
        String roleRange = null;
        Node nextNode = null;
        Definition definition = null;
        if (term != null) {
            start = workflowService.getWorkflowStart(tableName, businessId);
            //start = workflowService.getWorkflowStartByWorkflowCode(tableName,businessId,
            // workflowCode);
            Handle cuurent = workflowService.getHandle(start.getStartId(),
                    CommonUtil.getPersonId());
            definition = workflowService.getNextNodeId(start.getWorkflowId(), cuurent
                    .getCuurentNodeId(), term);
            nextNode = nodeService.getNodeById(definition.getNextNodeId());
            roleRange = nextNode.getRoleRange();
        } else {
            //String workflowId = workflowService.getWorkflowIdByTableName(tableName);
            String workflowId = workflowService.getWorkflowIdByWorkflowCode(workflowCode);
            Node startNode = workflowService.getStratNodeId(workflowId);
            definition = workflowService.getNextNodeId(workflowId, startNode.getNodeId(), term);
            nextNode = nodeService.getNodeById(definition.getNextNodeId());
            roleRange = nextNode.getRoleRange();
        }

        List<Select2> emps = null;
        if ("1".equals(nextNode.getStartFlag())) {
            if ("T_JW_SLOW_EXAMINATION".equals(tableName) || "T_XG_STUDENT_PROVE_WF".equals(tableName) || "T_XG_STUDENT_REISSUE_WF".equals(tableName)) {
                emps = workflowService.getStudentAuditer(tableName, businessId);
            } else if ("T_XG_GRANT_MANAGEMENT_WF".equals(tableName)) {
                emps = workflowService.getStudentAuditerGrantManagement(tableName, businessId);
            } else if ("T_DT_REPORT_MANAGEMENT".equals(tableName)) {
                ReportManagement reportManagement = reportManagementService.getReportManagementById(businessId);
                if ("1".equals(reportManagement.getStudentTeacherType())){
                    emps = workflowService.getAuditerByCreator(tableName, businessId);
                }else {
                    emps = workflowService.getStudentAuditer(tableName, businessId);
                }
            } else{
                emps = workflowService.getAuditerByCreator(tableName, businessId);
            }
        } else {
            if ("2".equals(nextNode.getNodeOrder())) {
                if ("T_XG_STUDENT_PROVE_WF".equals(tableName) || "T_XG_STUDENT_REISSUE_WF".equals(tableName)) {
                    emps = workflowService.getHeadTeacherByStudentId(CommonUtil.getPersonId());
                } else if ("T_XG_GRANT_MANAGEMENT_WF".equals(tableName)) {
                    emps = workflowService.getStudentAuditerGrantManagement(tableName, businessId);
                }  else if ("T_DT_REPORT_MANAGEMENT".equals(tableName)) {
                    ReportManagement reportManagement = reportManagementService.getReportManagementById(businessId);
                        if ("1".equals(reportManagement.getStudentTeacherType())){
                            if ("1".equals(roleRange)) {
                                emps = workflowService.getAuditer(nextNode.getHandleRole());
                            }
                            if ("2".equals(roleRange)) {
                                emps = workflowService.getAuditerByDept(tableName, businessId, nextNode
                                        .getHandleRole());
                            }
                            if ("3".equals(roleRange)) {
                                emps = workflowService.getAuditerByRange(tableName, businessId);
                            }
                        }else{
                            emps = workflowService.getHeadTeacherByStudentId(CommonUtil.getPersonId());
                        }
                    /*emps = workflowService.getHeadTeacherByStudentId(CommonUtil.getPersonId());*/
                }else {
                    if ("1".equals(roleRange)) {
                        emps = workflowService.getAuditer(nextNode.getHandleRole());
                    }
                    if ("2".equals(roleRange)) {
                        emps = workflowService.getAuditerByDept(tableName, businessId, nextNode
                                .getHandleRole());
                    }
                    if ("3".equals(roleRange)) {
                        emps = workflowService.getAuditerByRange(tableName, businessId);
                    }
                }
            } else {
                if ("1".equals(roleRange)) {
                    emps = workflowService.getAuditer(nextNode.getHandleRole());
                }
                if ("2".equals(roleRange)) {
                    emps = workflowService.getAuditerByDept(tableName, businessId, nextNode
                            .getHandleRole());
                }
                if ("3".equals(roleRange)) {
                    emps = workflowService.getAuditerByRange(tableName, businessId);
                }
            }
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("nodeType", nextNode.getNodeType());
        if (!"0".equals(nextNode.getNodeType())) {
            List<Tree> empTree = new ArrayList<Tree>();
            for (Select2 emp : emps) {
                Tree tree = new Tree();
                tree.setId(emp.getId());
                tree.setName(emp.getText());
                tree.setpId("9999");
                empTree.add(tree);
            }
            Tree tree = new Tree();
            tree.setpId("0");
            tree.setName("全选");
            tree.setId("9999");
            empTree.add(tree);
            map.put("emps", empTree);
        } else {
            map.put("emps", emps);
        }
        return map;
    }

    @RequestMapping("/toSelectAuditer")
    public String toSelectAuditer() {
        return "/core/wf/selectAuditer";
    }

    @RequestMapping("/getWotkflowLog")
    public ModelAndView getWotkflowLog(String tableName, String businessId, String url, String
            backUrl) {
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        Handle cuurent = workflowService.getHandle(start.getStartId(), CommonUtil.getPersonId());
        String cuurentNodeId = "-1";
        if (cuurent != null) {
            cuurentNodeId = cuurent.getCuurentNodeId();
        }
        List<Handle> workflowLog;
        if ("T_BG_DOCUMENT_WF".equals(tableName)) {
            workflowLog = workflowService.getHandleListByDocumentProcess(start.getStartId());
        } else {
            workflowLog = workflowService.getHandleList(start.getStartId());
        }
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        ModelAndView mv = new ModelAndView("/core/wf/log");
        mv.addObject("tableName", tableName);
        mv.addObject("businessId", businessId);
        mv.addObject("workflowLog", workflowLog);
        mv.addObject("cuurentNodeId", cuurentNodeId);
        mv.addObject("nodes", nodes);
        //mv.addObject("size", nodes.size());
        mv.addObject("url", url);
        mv.addObject("backUrl", backUrl);
        return mv;
    }

    @RequestMapping("/getIndexWorkflowLog")
    public ModelAndView getIndexWorkflowLog(String tableName, String businessId, String url, String taskId) {
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        Handle cuurent = workflowService.getHandle(start.getStartId(), CommonUtil.getPersonId());
        String cuurentNodeId = "-1";
        if (cuurent != null) {
            cuurentNodeId = cuurent.getCuurentNodeId();
        }
        List<Handle> workflowLog;
        if ("T_BG_DOCUMENT_WF".equals(tableName)) {
            workflowLog = workflowService.getHandleListByDocumentProcess(start.getStartId());
        } else {
            workflowLog = workflowService.getHandleList(start.getStartId());
        }
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        ModelAndView mv = new ModelAndView("/core/wf/indexLog");
        mv.addObject("tableName", tableName);
        mv.addObject("businessId", businessId);
        mv.addObject("workflowLog", workflowLog);
        mv.addObject("cuurentNodeId", cuurentNodeId);
        mv.addObject("nodes", nodes);
        mv.addObject("taskId", taskId);
        //mv.addObject("size", nodes.size());
        mv.addObject("url", url + "?id=" + businessId);
        return mv;
    }

    @RequestMapping("/toEditBusiness")
    public ModelAndView toEditBusiness(String tableName, String businessId, String url, String
            backUrl) {
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        Handle cuurent = workflowService.getHandle(start.getStartId(), CommonUtil.getPersonId());
        List<Definition> definitions = definitionService.getDefinitionListByNodeIdAndWorkflowId
                (cuurent.getCuurentNodeId(), cuurent.getCuurentWorkflowId());
        List<Handle> workflowLog = workflowService.getHandleList(start.getStartId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        ModelAndView mv = new ModelAndView("/core/wf/editBusiness");
        mv.addObject("definitions", definitions);
        mv.addObject("startId", start.getStartId());
        mv.addObject("handleId", cuurent.getId());
        mv.addObject("tableName", tableName);
        mv.addObject("businessId", businessId);
        mv.addObject("workflowLog", workflowLog);
        mv.addObject("cuurentNodeId", cuurent.getCuurentNodeId());
        mv.addObject("nodes", nodes);
        mv.addObject("url", url);
        //mv.addObject("size", nodes.size());
        mv.addObject("backUrl", backUrl);
        return mv;
    }

    //判断当前登录人是否是申请人
    @ResponseBody
    @RequestMapping("/getStartState")
    public Message getStartState(String tableName, String businessId) {
        String status = workflowService.getRejectState(tableName, businessId, CommonUtil.getPersonId());
        if ("1".equals(status)) {
            return new Message(1, "审核过程中，审核人不能修改申请信息！", null);
        } else {
            return new Message(0, "", null);
        }
    }

    //根据当前记录是否是驳回状态，判断申请人能否进行审核操作
    @ResponseBody
    @RequestMapping("/getRejectState")
    public Message getRejectState(String tableName, String businessId) {
        String status = workflowService.getRejectState(tableName, businessId, CommonUtil.getPersonId());
        if ("3".equals(status)) {
            return new Message(1, "您不是审核人，不能审核办理！", null);
        } else {
            return new Message(0, "", null);
        }
    }

    //判断当前业务是否能否反馈
    @ResponseBody
    @RequestMapping("/getBusinessStatus")
    public Message getBusinessStatus(String tableName, String businessId) {
        String status = workflowService.getBusinessStatus(tableName, businessId, CommonUtil.getPersonId());
        if (status == null) {
            return new Message(1, "您不是申请人，不能进行反馈！", null);
        } else if (!"2".equals(status) && !"4".equals(status)) {
            return new Message(1, "流程尚未结束，暂时不能进行反馈！", null);
        } else {
            return new Message(0, "", null);
        }
    }

    @ResponseBody
    @RequestMapping("/getFeedback")
    public ModelAndView getFeedBack(String tableName, String businessId, String backUrl) {
        Feedback feedback = workflowService.getFeedback(tableName, businessId);
        ModelAndView mv = new ModelAndView("/core/wf/feedback");
        mv.addObject("head", "反馈意见");
        mv.addObject("tableName", tableName);
        mv.addObject("businessId", businessId);
        mv.addObject("feedback", feedback);
        mv.addObject("backUrl", backUrl);
        return mv;
    }

    //判断当前业务操作人是否能确认
    @ResponseBody
    @RequestMapping("/getConfirmStatus")
    public Message getConfirmStatus(String tableName, String businessId) {
        String status = workflowService.getBusinessStatus(tableName, businessId, CommonUtil.getPersonId());
        if (status == null) {
            return new Message(1, "您不是申请人，不能进行确认！", null);
        } else {
            return new Message(0, "", null);
        }
    }

    @ResponseBody
    @RequestMapping("/feedback")
    public Message feedback(String businessId, String tableName, String feedbackFlag, String feedback) {
        workflowService.feedback(businessId, tableName, feedbackFlag, feedback);
        return new Message(1, "反馈成功！", null);
    }

    @RequestMapping("/loadIndexUnAudit")
    public ModelAndView loadIndexUnAudit() {
        String personId = CommonUtil.getPersonId();
        ModelAndView mv = new ModelAndView("/core/wf/indexUnAudit");
        //mv.addObject("task",   taskService.findTaskList(personId));
        mv.addObject("data", workflowService.getIndexUnAudtiList(personId));
        return mv;
    }


    @RequestMapping("/toIndexAudit")
    public ModelAndView toIndexAudit(String tableName, String businessId, String url, String flag) {
        ModelAndView mv = new ModelAndView("/core/wf/indexAudit");
        mv.addObject("url", url);
        mv.addObject("tableName", tableName);
        mv.addObject("businessId", businessId);
        mv.addObject("flag", flag);
        return mv;
    }

    @RequestMapping("/nodeWorkflow")
    public String nodeWorkflow(String workflowId) {
        Workflow workflow = workflowService.getWorkflowById(workflowId);
        return workflow.getWorkflowName();
    }

    @ResponseBody
    @RequestMapping("/getOpinion")
    public List<Select2> getOpinion() {
        return workflowService.getOpinion(CommonUtil.getPersonId());
    }

    @RequestMapping("/funds/toAudit")
    public ModelAndView fundsToAudit(String tableName, String businessId, String url, String backUrl, String flag) {
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        Handle cuurent = workflowService.getHandle(start.getStartId(), CommonUtil.getPersonId());
        if (null == cuurent) {
            ModelAndView mv = new ModelAndView("/business/synergy/workflow/document/documentProcess");
            return mv;
        }
        List<Definition> definitions = definitionService.getDefinitionListByNodeIdAndWorkflowId(
                cuurent.getCuurentNodeId(), cuurent.getCuurentWorkflowId());
        List<Handle> workflowLog;
        if ("T_BG_DOCUMENT_WF".equals(tableName)) {
            workflowLog = workflowService.getHandleListByDocumentProcess(start.getStartId());
        } else {
            workflowLog = workflowService.getHandleList(start.getStartId());
        }
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        ModelAndView mv = new ModelAndView("/core/wf/audit");
        mv.addObject("definitions", definitions);
        mv.addObject("tableName", tableName);
        mv.addObject("businessId", businessId);
        mv.addObject("workflowLog", workflowLog);
        mv.addObject("cuurentNodeId", cuurent.getCuurentNodeId());
        mv.addObject("nodes", nodes);
        mv.addObject("size", nodes.size());
        mv.addObject("url", url);
        mv.addObject("backUrl", backUrl);
        return mv;

    }

    @ResponseBody
    @RequestMapping("/updateTask")
    public Message updateTask(String id) {
        workflowService.updateTask(id);
        return new Message(1, "操作成功！", null);
    }

    @RequestMapping("/loadMoreAudit")
    public ModelAndView loadMoreNotices() {
        ModelAndView mv = new ModelAndView("core/wf/moreAudit");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/getMoreUnAuditList")
    public Map<String, List> getMoreUnAuditList() {
        return CommonUtil.tableMap(workflowService.getIndexUnAudtiMoreList(CommonUtil.getPersonId()));
    }

    @ResponseBody
    @RequestMapping("/getMoreAuditList")
    public Map<String, List> getMoreAuditList() {
        return CommonUtil.tableMap(workflowService.getIndexAudtiMoreList(CommonUtil.getPersonId()));
    }

    //首页更多待办页
    @RequestMapping("/toIndexMoreAudit")
    public ModelAndView toIndexMoreAudit(String tableName, String businessId, String url, String flag) {
        ModelAndView mv = new ModelAndView("/core/wf/indexMoreAudit");
        mv.addObject("url", url);
        mv.addObject("tableName", tableName);
        mv.addObject("businessId", businessId);
        mv.addObject("flag", flag);
        return mv;
    }

    //首页待办办理【更多】
    @RequestMapping("/toMoreAudit")
    public ModelAndView toMoreAudit(String tableName, String businessId, String url, String backUrl, String flag) {
        if (!"T_SYS_TASK".equals(tableName)) {
            Start start = workflowService.getWorkflowStart(tableName, businessId);
            List<Definition> definitions = null;
            ModelAndView mv = new ModelAndView("/core/wf/auditForMore");
            Handle cuurent = workflowService.getHandle(start.getStartId(), CommonUtil.getPersonId());
            if (cuurent != null && !"2".equals(flag)) {
                definitions = definitionService.getDefinitionListByNodeIdAndWorkflowId(
                        cuurent.getCuurentNodeId(), cuurent.getCuurentWorkflowId());
                mv.addObject("cuurentNodeId", cuurent.getCuurentNodeId());
            } else {
                mv.addObject("cuurentNodeId", "");
            }
            List<Handle> workflowLog = workflowService.getHandleList(start.getStartId());
            List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());

            mv.addObject("definitions", definitions);
            mv.addObject("tableName", tableName);
            mv.addObject("businessId", businessId);
            mv.addObject("workflowLog", workflowLog);
            mv.addObject("nodes", nodes);
            mv.addObject("size", nodes.size());
            mv.addObject("url", url);
            mv.addObject("backUrl", backUrl);
            return mv;
        } else {
            ModelAndView mv = new ModelAndView("/core/task/auditTaskEdit");
            String time = taskService.getTaskTimeById(businessId);
            String personId = CommonUtil.getPersonId();
            SysTask sysTask = taskService.selectSysTaskById(personId, time);
            mv.addObject("head", "修改");
            mv.addObject("sysTask", sysTask);
            return mv;
        }

    }

    @RequestMapping("/toEditBusinessForMore")
    public ModelAndView toEditBusinessForMore(String tableName, String businessId, String url, String
            backUrl) {
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        Handle cuurent = workflowService.getHandle(start.getStartId(), CommonUtil.getPersonId());
        List<Definition> definitions = definitionService.getDefinitionListByNodeIdAndWorkflowId
                (cuurent.getCuurentNodeId(), cuurent.getCuurentWorkflowId());
        List<Handle> workflowLog = workflowService.getHandleList(start.getStartId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        ModelAndView mv = new ModelAndView("/core/wf/editBusinessForMore");
        mv.addObject("definitions", definitions);
        mv.addObject("tableName", tableName);
        mv.addObject("businessId", businessId);
        mv.addObject("workflowLog", workflowLog);
        mv.addObject("cuurentNodeId", cuurent.getCuurentNodeId());
        mv.addObject("nodes", nodes);
        mv.addObject("url", url);
        //mv.addObject("size", nodes.size());
        mv.addObject("backUrl", backUrl);
        return mv;
    }
}
