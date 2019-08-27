package com.goisan.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Admin on 2017/5/6.
 */
public class Node extends BaseBean {
    private String nodeId;
    private String nodeName;
    private String workflowId;
    private String handleRole;
    private String startFlag;
    private String nodeOrder;
    private String roleRange;
    private String nodeType;

    public String getRoleRange() {
        return roleRange;
    }

    public void setRoleRange(String roleRange) {
        this.roleRange = roleRange;
    }

    public String getNodeOrder() {
        return nodeOrder;
    }

    public void setNodeOrder(String nodeOrder) {
        this.nodeOrder = nodeOrder;
    }

    public String getNodeId() {
        return nodeId;
    }

    public void setNodeId(String nodeId) {
        this.nodeId = nodeId;
    }

    public String getNodeName() {
        return nodeName;
    }

    public void setNodeName(String nodeName) {
        this.nodeName = nodeName;
    }

    public String getWorkflowId() {
        return workflowId;
    }

    public void setWorkflowId(String workflowId) {
        this.workflowId = workflowId;
    }

    public String getHandleRole() {
        return handleRole;
    }

    public void setHandleRole(String handleRole) {
        this.handleRole = handleRole;
    }

    public String getStartFlag() {
        return startFlag;
    }

    public void setStartFlag(String startFlag) {
        this.startFlag = startFlag;
    }

    public String getNodeType() {
        return nodeType;
    }

    public void setNodeType(String nodeType) {
        this.nodeType = nodeType;
    }
}
