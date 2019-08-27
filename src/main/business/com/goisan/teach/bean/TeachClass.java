package com.goisan.teach.bean;


import com.goisan.system.bean.BaseBean;

public class TeachClass extends BaseBean {

    private String id;
    private String teacherId;
    private String classId;
    private String nameShow;
    private String classShow;

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


    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getNameShow() {
        return nameShow;
    }

    public void setNameShow(String nameShow) {
        this.nameShow = nameShow;
    }

    public String getClassShow() {
        return classShow;
    }

    public void setClassShow(String classShow) {
        this.classShow = classShow;
    }
}
