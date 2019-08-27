package com.goisan.attendance.attendance.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by admin on 2017/7/7.
 */
public class AttendanceInfo extends BaseBean {
    private String id;
    private int basicFrequency;
    private int noSignInFrequency;
    private int latestOutOfSignIn;
    private int leaveNoSign;
    private int publicHolidays;
    private int compassionateLeave;
    private int sickLeave;
    private int wrongSignOnBusiness;
    private int year;
    private int month;
    private String name;
    private String idcard;
    private String coding;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getBasicFrequency() {
        return basicFrequency;
    }

    public void setBasicFrequency(int basicFrequency) {
        this.basicFrequency = basicFrequency;
    }

    public int getNoSignInFrequency() {
        return noSignInFrequency;
    }

    public void setNoSignInFrequency(int noSignInFrequency) {
        this.noSignInFrequency = noSignInFrequency;
    }

    public int getLatestOutOfSignIn() {
        return latestOutOfSignIn;
    }

    public void setLatestOutOfSignIn(int latestOutOfSignIn) {
        this.latestOutOfSignIn = latestOutOfSignIn;
    }

    public int getLeaveNoSign() {
        return leaveNoSign;
    }

    public void setLeaveNoSign(int leaveNoSign) {
        this.leaveNoSign = leaveNoSign;
    }

    public int getPublicHolidays() {
        return publicHolidays;
    }

    public void setPublicHolidays(int publicHolidays) {
        this.publicHolidays = publicHolidays;
    }

    public int getCompassionateLeave() {
        return compassionateLeave;
    }

    public void setCompassionateLeave(int compassionateLeave) {
        this.compassionateLeave = compassionateLeave;
    }

    public int getSickLeave() {
        return sickLeave;
    }

    public void setSickLeave(int sickLeave) {
        this.sickLeave = sickLeave;
    }

    public int getWrongSignOnBusiness() {
        return wrongSignOnBusiness;
    }

    public void setWrongSignOnBusiness(int wrongSignOnBusiness) {
        this.wrongSignOnBusiness = wrongSignOnBusiness;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getCoding() {
        return coding;
    }

    public void setCoding(String coding) {
        this.coding = coding;
    }
}
