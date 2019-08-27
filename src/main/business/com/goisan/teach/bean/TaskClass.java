package com.goisan.teach.bean;


import com.goisan.system.bean.BaseBean;

public class TaskClass extends BaseBean {

    private String id;
    private String taskId;
    private String classId;
    private String major;
    private String xz;

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getXz() {
        return xz;
    }

    public void setXz(String xz) {
        this.xz = xz;
    }

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


    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

}
