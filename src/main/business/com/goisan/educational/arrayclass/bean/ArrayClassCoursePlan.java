package com.goisan.educational.arrayclass.bean;

import com.goisan.system.bean.BaseBean;

public class ArrayClassCoursePlan extends BaseBean {
    private String arrayClassId;
    private String id;
    private String term;
    private String planId;

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    private String planName;
    private String schoolYear;

    public String getArrayClassId() {
        return arrayClassId;
    }

    public void setArrayClassId(String arrayClassId) {
        this.arrayClassId = arrayClassId;
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

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getSchoolYear() {
        return schoolYear;
    }

    public void setSchoolYear(String schoolYear) {
        this.schoolYear = schoolYear;
    }
}
