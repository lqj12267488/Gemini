package com.goisan.logistics.dormmanage.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/9/25.
 */
public class StudentDorm extends BaseBean {
   private String studentDormId;
   private String studentId;
   private String startTime;
   private String endTime;
   private String tel;
    //系部Id
    private String departmentsId;
    //专业代码
    private String majorCode;
    //专业方向
   private String majorDirection;
    //培养层次
    private String trainingLevel;

    private String majorShow;

    private String sex;

    private String idcard;

    private String classId;

    private String sexShow;

    private String telShow;

    private String studentName;

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getTelShow() {
        return telShow;
    }

    public void setTelShow(String telShow) {
        this.telShow = telShow;
    }

    public String getSexShow() {
        return sexShow;
    }

    public void setSexShow(String sexShow) {
        this.sexShow = sexShow;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getStudentDormId() {
        return studentDormId;
    }

    public void setStudentDormId(String studentDormId) {
        this.studentDormId = studentDormId;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
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

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
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

    public String getMajorDirection() {
        return majorDirection;
    }

    public void setMajorDirection(String majorDirection) {
        this.majorDirection = majorDirection;
    }

    public String getTrainingLevel() {
        return trainingLevel;
    }

    public void setTrainingLevel(String trainingLevel) {
        this.trainingLevel = trainingLevel;
    }

    public String getMajorShow() {
        return majorShow;
    }

    public void setMajorShow(String majorShow) {
        this.majorShow = majorShow;
    }
}
