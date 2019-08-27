package com.goisan.system.bean;

import com.goisan.system.bean.BaseBean;

public class StudentParentRelation extends BaseBean {
    private String id;
    private String parentId;
    private String studentId;
    private String relation;
    private String parentName;
    private String studentName;
    private String relationShow;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getRelation() {
        return relation;
    }

    public void setRelation(String relation) {
        this.relation = relation;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getRelationShow() {
        return relationShow;
    }

    public void setRelationShow(String relationShow) {
        this.relationShow = relationShow;
    }
}
