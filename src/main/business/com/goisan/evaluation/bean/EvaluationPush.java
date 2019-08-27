package com.goisan.evaluation.bean;

import com.goisan.system.bean.BaseBean;

public class EvaluationPush extends BaseBean{
    private String id;
    private String taskId;
    private String personId;
    private String deptId;
    private String groupId;
    private String empGroupId;
    private String name;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
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

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public String getEmpGroupId() {
        return empGroupId;
    }

    public void setEmpGroupId(String empGroupId) {
        this.empGroupId = empGroupId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
