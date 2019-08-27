package com.goisan.educational.exam.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by mcq on 2017/8/11.
 */
public class ExamRoomTeacher extends BaseBean {


    private String id;
    private String examRoomId;
    private String examId;
    private String roomId;
    private String departmentsId;
    private String majorCode;
    private String classId;
    private String trainingLevel;
    private String teacherPersonId;
    private String teacherDeptId;
    private String date;
    private String startTime;
    private String endTime;

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getExamRoomId() {
        return examRoomId;
    }

    public void setExamRoomId(String examRoomId) {
        this.examRoomId = examRoomId;
    }

    public String getExamId() {
        return examId;
    }

    public void setExamId(String examId) {
        this.examId = examId;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
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

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getTrainingLevel() {
        return trainingLevel;
    }

    public void setTrainingLevel(String trainingLevel) {
        this.trainingLevel = trainingLevel;
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
}
