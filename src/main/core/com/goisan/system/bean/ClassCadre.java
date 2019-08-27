package com.goisan.system.bean;

import com.goisan.system.bean.BaseBean;

public class ClassCadre extends BaseBean {
    private String id;
    private String classId;
    private String className;
    private String studentId;
    private String studentName;
    private String cadrecoad;
    private String cadrecoadShow;
    private String courseId;
    private String courseName;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getCadrecoad() {
        return cadrecoad;
    }

    public void setCadrecoad(String cadrecoad) {
        this.cadrecoad = cadrecoad;
    }

    public String getCadrecoadShow() {
        return cadrecoadShow;
    }

    public void setCadrecoadShow(String cadrecoadShow) {
        this.cadrecoadShow = cadrecoadShow;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }
}
