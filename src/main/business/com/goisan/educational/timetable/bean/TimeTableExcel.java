package com.goisan.educational.timetable.bean;

import com.goisan.system.bean.BaseBean;

public class TimeTableExcel extends BaseBean {

    private String id;
    private String timeTableName;//课程表名称
    private String executionDate;//执行日期
    private String timeTableDepartmentId; //课程表id
    private String weeks;//周几
    private String courseNum;//第几节课
    private String courseName;//课程名称
    private String courseTeacher;//授课老师
    private String specialPlace;//特殊 地点
    private String timeTableId; //所属课程表id
    private String departmentId; //所属系部Id
    private String majorId; //所属 专业 Id
    private String classId; //所属班级 Id
    private String peopleNumber; //班级人数
    private String classRom; //上课教室
    private String specialFlag; //画线标识
    private String specialPlaceName; //特殊地点名称

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTimeTableName() {
        return timeTableName;
    }

    public void setTimeTableName(String timeTableName) {
        this.timeTableName = timeTableName;
    }

    public String getExecutionDate() {
        return executionDate;
    }

    public void setExecutionDate(String executionDate) {
        this.executionDate = executionDate;
    }

    public String getTimeTableDepartmentId() {
        return timeTableDepartmentId;
    }

    public void setTimeTableDepartmentId(String timeTableDepartmentId) {
        this.timeTableDepartmentId = timeTableDepartmentId;
    }

    public String getWeeks() {
        return weeks;
    }

    public void setWeeks(String weeks) {
        this.weeks = weeks;
    }

    public String getCourseNum() {
        return courseNum;
    }

    public void setCourseNum(String courseNum) {
        this.courseNum = courseNum;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getCourseTeacher() {
        return courseTeacher;
    }

    public void setCourseTeacher(String courseTeacher) {
        this.courseTeacher = courseTeacher;
    }

    public String getSpecialPlace() {
        return specialPlace;
    }

    public void setSpecialPlace(String specialPlace) {
        this.specialPlace = specialPlace;
    }

    public String getTimeTableId() {
        return timeTableId;
    }

    public void setTimeTableId(String timeTableId) {
        this.timeTableId = timeTableId;
    }

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    public String getMajorId() {
        return majorId;
    }

    public void setMajorId(String majorId) {
        this.majorId = majorId;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getPeopleNumber() {
        return peopleNumber;
    }

    public void setPeopleNumber(String peopleNumber) {
        this.peopleNumber = peopleNumber;
    }

    public String getClassRom() {
        return classRom;
    }

    public void setClassRom(String classRom) {
        this.classRom = classRom;
    }

    public String getSpecialFlag() {
        return specialFlag;
    }

    public void setSpecialFlag(String specialFlag) {
        this.specialFlag = specialFlag;
    }

    public String getSpecialPlaceName() {
        return specialPlaceName;
    }

    public void setSpecialPlaceName(String specialPlaceName) {
        this.specialPlaceName = specialPlaceName;
    }
}
