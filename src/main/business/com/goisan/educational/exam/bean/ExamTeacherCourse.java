package com.goisan.educational.exam.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by 123456 on 2018/4/24.
 */
public class ExamTeacherCourse extends BaseBean {
    private String id;
    private String courseId;
    private String courseName;
    private String courseType;
    private String departmentsId;
    private String majorCode;
    private String teacherPersonId;
    private String teacherDeptId;
    private String departmentsIdShow;
    private String majorCodeShow;
    private String teacherPersonIdShow;
    private String teacherDeptIdShow;
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getCourseType() {
        return courseType;
    }

    public void setCourseType(String courseType) {
        this.courseType = courseType;
    }

    public String getDepartmentsId() {
        return departmentsId;
    }

    public void setDepartmentsId(String departmentsId) {
        this.departmentsId = departmentsId;
    }

    public String getMajorCode() {
        return majorCode;
    }

    public void setMajorCode(String majorCode) {
        this.majorCode = majorCode;
    }

    public String getTeacherPersonId() {
        return teacherPersonId;
    }

    public void setTeacherPersonId(String teacherPersonId) {
        this.teacherPersonId = teacherPersonId;
    }

    public String getTeacherDeptId() {
        return teacherDeptId;
    }

    public void setTeacherDeptId(String teacherDeptId) {
        this.teacherDeptId = teacherDeptId;
    }

    public String getDepartmentsIdShow() {
        return departmentsIdShow;
    }

    public void setDepartmentsIdShow(String departmentsIdShow) {
        this.departmentsIdShow = departmentsIdShow;
    }

    public String getMajorCodeShow() {
        return majorCodeShow;
    }

    public void setMajorCodeShow(String majorCodeShow) {
        this.majorCodeShow = majorCodeShow;
    }

    public String getTeacherPersonIdShow() {
        return teacherPersonIdShow;
    }

    public void setTeacherPersonIdShow(String teacherPersonIdShow) {
        this.teacherPersonIdShow = teacherPersonIdShow;
    }

    public String getTeacherDeptIdShow() {
        return teacherDeptIdShow;
    }

    public void setTeacherDeptIdShow(String teacherDeptIdShow) {
        this.teacherDeptIdShow = teacherDeptIdShow;
    }
}
