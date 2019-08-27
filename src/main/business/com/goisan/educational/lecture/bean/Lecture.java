package com.goisan.educational.lecture.bean;

import com.goisan.system.bean.BaseBean;

public class Lecture extends BaseBean {
    private String id;
    private String teacherId;
    private String deptId;
    private String lectureName;
    private String majorCode;
    private String trainingLevel;
    private String classId;
    private String studentNumber;
    private String classHours;
    private String place;
    private String placeShow;
    private String count;
    private String fileUrl;
    private String fieldType;
    private String abuildingId;

    public String getPlaceShow() {
        return placeShow;
    }

    public void setPlaceShow(String placeShow) {
        this.placeShow = placeShow;
    }

    public String getFieldType() {
        return fieldType;
    }

    public void setFieldType(String fieldType) {
        this.fieldType = fieldType;
    }

    public String getAbuildingId() {
        return abuildingId;
    }

    public void setAbuildingId(String abuildingId) {
        this.abuildingId = abuildingId;
    }

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

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getLectureName() {
        return lectureName;
    }

    public void setLectureName(String lectureName) {
        this.lectureName = lectureName;
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

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getStudentNumber() {
        return studentNumber;
    }

    public void setStudentNumber(String studentNumber) {
        this.studentNumber = studentNumber;
    }

    public String getClassHours() {
        return classHours;
    }

    public void setClassHours(String classHours) {
        this.classHours = classHours;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }
}
