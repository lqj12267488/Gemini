package com.goisan.type.bean;

import com.goisan.system.bean.BaseBean;

public class ResourceTypeCourse extends BaseBean {
    private String resourceCourseId;
    private String resourceCourseName;
    private String resourceCourseOrder;
    private String resourceMajorId;
    private String resourceSubjectId;
    private String resourceMajorIdShow;
    private String resourceSubjectIdShow;
    private String remark;
    private String id;
    private String jpkTypeName;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getJpkTypeName() {
        return jpkTypeName;
    }

    public void setJpkTypeName(String jpkTypeName) {
        this.jpkTypeName = jpkTypeName;
    }

    public String getResourceCourseId() {
        return resourceCourseId;
    }

    public void setResourceCourseId(String resourceCourseId) {
        this.resourceCourseId = resourceCourseId;
    }

    public String getResourceCourseName() {
        return resourceCourseName;
    }

    public void setResourceCourseName(String resourceCourseName) {
        this.resourceCourseName = resourceCourseName;
    }

    public String getResourceCourseOrder() {
        return resourceCourseOrder;
    }

    public void setResourceCourseOrder(String resourceCourseOrder) {
        this.resourceCourseOrder = resourceCourseOrder;
    }

    public String getResourceMajorId() {
        return resourceMajorId;
    }

    public void setResourceMajorId(String resourceMajorId) {
        this.resourceMajorId = resourceMajorId;
    }

    public String getResourceSubjectId() {
        return resourceSubjectId;
    }

    public void setResourceSubjectId(String resourceSubjectId) {
        this.resourceSubjectId = resourceSubjectId;
    }

    public String getResourceMajorIdShow() {
        return resourceMajorIdShow;
    }

    public void setResourceMajorIdShow(String resourceMajorIdShow) {
        this.resourceMajorIdShow = resourceMajorIdShow;
    }

    public String getResourceSubjectIdShow() {
        return resourceSubjectIdShow;
    }

    public void setResourceSubjectIdShow(String resourceSubjectIdShow) {
        this.resourceSubjectIdShow = resourceSubjectIdShow;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
