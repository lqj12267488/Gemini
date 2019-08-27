package com.goisan.educational.teachingtask.bean;

import com.goisan.system.bean.BaseBean;

/**
 * @function:
 * @author: ZhangHao
 * @date: 2018/10/19
 */
public class TeachingTask extends BaseBean {

    private String id;

    private String schoolYear;

    private String semester;

    private String department;

    private String preparedBy = "";

    private String preparedTime = "";

    private String teacherId;

    private String classInfo;

    private String studentNum;

    private String courseId;

    private String weekTime;

    private String employedTitle;

    private String otherDept;

    private String remarks;

    private String departmentName = "";

    private String teacherName = "";

    private String courseName = "";

    private String className = "";

    private String preparedByName = "";

    private String semesterName = "";

    private String examMethod;

    private String staffIdBy = "";

    private String idCard;

    private String staffId;

    public String getExamMethod() {
        return examMethod;
    }

    public void setExamMethod(String examMethod) {
        this.examMethod = examMethod;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSchoolYear() {
        return schoolYear;
    }

    public void setSchoolYear(String schoolYear) {
        this.schoolYear = schoolYear;
    }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getPreparedBy() {
        return preparedBy;
    }

    public void setPreparedBy(String preparedBy) {
        this.preparedBy = preparedBy;
    }

    public String getPreparedTime() {
        return preparedTime;
    }

    public void setPreparedTime(String preparedTime) {
        this.preparedTime = preparedTime;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getClassInfo() {
        return classInfo;
    }

    public void setClassInfo(String classInfo) {
        this.classInfo = classInfo;
    }

    public String getStudentNum() {
        return studentNum;
    }

    public void setStudentNum(String studentNum) {
        this.studentNum = studentNum;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getWeekTime() {
        return weekTime;
    }

    public void setWeekTime(String weekTime) {
        this.weekTime = weekTime;
    }

    public String getEmployedTitle() {
        return employedTitle;
    }

    public void setEmployedTitle(String employedTitle) {
        this.employedTitle = employedTitle;
    }

    public String getOtherDept() {
        return otherDept;
    }

    public void setOtherDept(String otherDept) {
        this.otherDept = otherDept;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
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

    public String getPreparedByName() {
        return preparedByName;
    }

    public void setPreparedByName(String preparedByName) {
        this.preparedByName = preparedByName;
    }

    public String getSemesterName() {
        return semesterName;
    }

    public void setSemesterName(String semesterName) {
        this.semesterName = semesterName;
    }

    public String getStaffIdBy() {
        return staffIdBy;
    }

    public void setStaffIdBy(String staffIdBy) {
        this.staffIdBy = staffIdBy;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }
}
