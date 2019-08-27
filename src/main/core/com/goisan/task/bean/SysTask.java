package com.goisan.task.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by mcq on 2017/8/30.
 */
public class SysTask extends BaseBean {
    //T_BG_FUNDS_WF
    private String id;

    //T_SYS_TASK
    private String taskId;
    private String taskTitle;
    private String taskTime;
    private String personId;
    private String deptId;
    private String taskBusinessId;
    private String taskUrl;
    private String taskAppUrl;
    private String taskFlag;
    private String taskTable;
    private String deptShow;
    private String personShow;
    private String taskType;

    public String getTaskType() {
        return taskType;
    }

    public void setTaskType(String taskType) {
        this.taskType = taskType;
    }

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public String getTaskTitle() {
        return taskTitle;
    }

    public void setTaskTitle(String taskTitle) {
        this.taskTitle = taskTitle;
    }

    public String getTaskTime() {
        return taskTime;
    }

    public void setTaskTime(String taskTime) {
        this.taskTime = taskTime;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getTaskBusinessId() {
        return taskBusinessId;
    }

    public void setTaskBusinessId(String taskBusinessId) {
        this.taskBusinessId = taskBusinessId;
    }

    public String getTaskUrl() {
        return taskUrl;
    }

    public void setTaskUrl(String taskUrl) {
        this.taskUrl = taskUrl;
    }

    public String getTaskFlag() {
        return taskFlag;
    }

    public void setTaskFlag(String taskFlag) {
        this.taskFlag = taskFlag;
    }

    public String getDeptShow() {
        return deptShow;
    }

    public void setDeptShow(String deptShow) {
        this.deptShow = deptShow;
    }

    public String getPersonShow() {
        return personShow;
    }

    public void setPersonShow(String personShow) {
        this.personShow = personShow;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTaskTable() {
        return taskTable;
    }

    public void setTaskTable(String taskTable) {
        this.taskTable = taskTable;
    }

    public void setTaskAppUrl(String taskAppUrl) {
        this.taskAppUrl = taskAppUrl;
    }

    public String getTaskAppUrl() {

        return taskAppUrl;
    }
}
