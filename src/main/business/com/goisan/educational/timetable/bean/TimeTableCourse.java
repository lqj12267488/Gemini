package com.goisan.educational.timetable.bean;

import com.goisan.system.bean.BaseBean;

public class TimeTableCourse extends BaseBean {

    private String id;
    private String timeTableDepartmentId; //课程表id
    private String weeks;//周几
    private String courseNum;//第几节课
    private String courseName;//课程名称
    private String courseTeacher;//授课老师
    private String specialPlace;//特殊 地点
    private String startWeek;
    private String endWeek;
    private String courseTeacherId;

    public String getStartWeek() {
        return startWeek;
    }

    public void setStartWeek(String startWeek) {
        this.startWeek = startWeek;
    }

    public String getEndWeek() {
        return endWeek;
    }

    public void setEndWeek(String endWeek) {
        this.endWeek = endWeek;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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


    public String getTimeTableDepartmentId() {
        return timeTableDepartmentId;
    }

    public void setTimeTableDepartmentId(String timeTableDepartmentId) {
        this.timeTableDepartmentId = timeTableDepartmentId;
    }

    public String getCourseTeacherId() {
        return courseTeacherId;
    }

    public void setCourseTeacherId(String courseTeacherId) {
        this.courseTeacherId = courseTeacherId;
    }
}
