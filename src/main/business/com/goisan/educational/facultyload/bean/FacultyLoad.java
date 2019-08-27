package com.goisan.educational.facultyload.bean;

import com.goisan.system.bean.BaseBean;

/**
 * @function: 教学工作量实体类
 * @author: ZhangHao
 * @date: 2018/11/15
 */
public class FacultyLoad extends BaseBean {

    private String id;

    private String term;

    private String teacherId;

    private String deptId;

    private String courseId;

    private String classId;

    private String studentNum;

    private String weekTime;

    private String weekNum;

    private String painTime;

    private String stopTime;

    private String stopInfo;

    private String realTime;

    private String payRule;

    private String painPay;

    private String deductionsPay;

    private String realPay;

    private String termName;

    private String deptName;

    private String teacherName;

    private String courseName;

    private String className;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
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

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getStudentNum() {
        return studentNum;
    }

    public void setStudentNum(String studentNum) {
        this.studentNum = studentNum;
    }

    public String getWeekTime() {
        return weekTime;
    }

    public void setWeekTime(String weekTime) {
        this.weekTime = weekTime;
    }

    public String getWeekNum() {
        return weekNum;
    }

    public void setWeekNum(String weekNum) {
        this.weekNum = weekNum;
    }

    public String getPainTime() {
        return painTime;
    }

    public void setPainTime(String painTime) {
        this.painTime = painTime;
    }

    public String getStopTime() {
        return stopTime;
    }

    public void setStopTime(String stopTime) {
        this.stopTime = stopTime;
    }

    public String getStopInfo() {
        return stopInfo;
    }

    public void setStopInfo(String stopInfo) {
        this.stopInfo = stopInfo;
    }

    public String getRealTime() {
        return realTime;
    }

    public void setRealTime(String realTime) {
        this.realTime = realTime;
    }

    public String getPayRule() {
        return payRule;
    }

    public void setPayRule(String payRule) {
        this.payRule = payRule;
    }

    public String getPainPay() {
        return painPay;
    }

    public void setPainPay(String painPay) {
        this.painPay = painPay;
    }

    public String getDeductionsPay() {
        return deductionsPay;
    }

    public void setDeductionsPay(String deductionsPay) {
        this.deductionsPay = deductionsPay;
    }

    public String getRealPay() {
        return realPay;
    }

    public void setRealPay(String realPay) {
        this.realPay = realPay;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getTermName() {
        return termName;
    }

    public void setTermName(String termName) {
        this.termName = termName;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }
}