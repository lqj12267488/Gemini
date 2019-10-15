package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class TeachContact extends BaseBean {

    /***/
    private String id;

    /**教职工id*/
    private String personId;

    /**分管工作*/
    private String responsibilities;

    /**听课（节）*/
    private String attendLectures;

    /**走访学生寝室（次）*/
    private String studentDorm;

    /**走访校外实习点（次）*/
    private String outsidePractice;

    /**参与学生社团文体活动（次）*/
    private String studentClubActivities;

    private String personIdShow;
    private String staffId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getResponsibilities() {
        return responsibilities;
    }

    public void setResponsibilities(String responsibilities) {
        this.responsibilities = responsibilities;
    }

    public String getAttendLectures() {
        return attendLectures;
    }

    public void setAttendLectures(String attendLectures) {
        this.attendLectures = attendLectures;
    }

    public String getStudentDorm() {
        return studentDorm;
    }

    public void setStudentDorm(String studentDorm) {
        this.studentDorm = studentDorm;
    }

    public String getOutsidePractice() {
        return outsidePractice;
    }

    public void setOutsidePractice(String outsidePractice) {
        this.outsidePractice = outsidePractice;
    }

    public String getStudentClubActivities() {
        return studentClubActivities;
    }

    public void setStudentClubActivities(String studentClubActivities) {
        this.studentClubActivities = studentClubActivities;
    }

    public String getPersonIdShow() {
        return personIdShow;
    }

    public void setPersonIdShow(String personIdShow) {
        this.personIdShow = personIdShow;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }
}
