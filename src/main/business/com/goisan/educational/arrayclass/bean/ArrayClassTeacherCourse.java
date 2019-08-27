package com.goisan.educational.arrayclass.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by wq on 2017/8/23.
 */
public class ArrayClassTeacherCourse extends BaseBean {
    private String id;
    private String arrayclassId;
    private String teacherPersonId;
    private String teacherDeptId;
    private String courseType;
    private String courseId;
    private String departmentsId;
    private String majorCode;
    private String trainingLevel;
    private String courseName;
    private String arrayclassTeacherId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getArrayclassId() {
        return arrayclassId;
    }

    public void setArrayclassId(String arrayclassId) {
        this.arrayclassId = arrayclassId;
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

    public String getCourseType() {
        return courseType;
    }

    public void setCourseType(String courseType) {
        this.courseType = courseType;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
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

    public String getTrainingLevel() {
        return trainingLevel;
    }

    public void setTrainingLevel(String trainingLevel) {
        this.trainingLevel = trainingLevel;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getArrayclassTeacherId() {
        return arrayclassTeacherId;
    }

    public void setArrayclassTeacherId(String arrayclassTeacherId) {
        this.arrayclassTeacherId = arrayclassTeacherId;
    }
}
