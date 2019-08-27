package com.goisan.educational.teachingplan.bean;

import com.goisan.system.bean.BaseBean;

public class TeachingplanNew extends BaseBean {

    private String id;
    private String term;
    private String userId;
    private String deptId;
    private String departmentsId;
    private String majorId;
    private String courseId;
    private String classId;
    private String period;
    private String status;
    private String opinion;
    private String url;
    private String person;

    private String requester;
    private String requestDept;

//    是否是系部主任
    private Boolean isDeptBoss;
//    是否是教务处
    private Boolean isOffice;

    public Boolean getDeptBoss() {
        return isDeptBoss;
    }

    public void setDeptBoss(Boolean deptBoss) {
        isDeptBoss = deptBoss;
    }

    public Boolean getOffice() {
        return isOffice;
    }

    public void setOffice(Boolean office) {
        isOffice = office;
    }

    public String getRequester() {
        return requester;
    }

    public void setRequester(String requester) {
        this.requester = requester;
    }

    public String getRequestDept() {
        return requestDept;
    }

    public void setRequestDept(String requestDept) {
        this.requestDept = requestDept;
    }


    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

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

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getDepartmentsId() {
        return departmentsId;
    }

    public void setDepartmentsId(String departmentsId) {
        this.departmentsId = departmentsId;
    }

    public String getMajorId() {
        return majorId;
    }

    public void setMajorId(String majorId) {
        this.majorId = majorId;
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

    public String getPeriod() {
        return period;
    }

    public void setPeriod(String period) {
        this.period = period;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOpinion() {
        return opinion;
    }

    public void setOpinion(String opinion) {
        this.opinion = opinion;
    }

    public String getPerson() {
        return person;
    }

    public void setPerson(String person) {
        this.person = person;
    }
}
