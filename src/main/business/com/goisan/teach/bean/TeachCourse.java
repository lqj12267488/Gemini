package com.goisan.teach.bean;


import com.goisan.system.bean.BaseBean;

public class TeachCourse extends BaseBean {

    private String id;
    private String teacherId;
    private String courseId;
    private String nameShow;
    private String courseShow;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }


    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getNameShow() {
        return nameShow;
    }

    public void setNameShow(String nameShow) {
        this.nameShow = nameShow;
    }

    public String getCourseShow() {
        return courseShow;
    }

    public void setCourseShow(String courseShow) {
        this.courseShow = courseShow;
    }
}
