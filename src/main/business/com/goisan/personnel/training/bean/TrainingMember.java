package com.goisan.personnel.training.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by mcq on 2017/8/30.
 */
public class TrainingMember extends BaseBean {
    private String  memberId;
    private String trainingId;
    private String personId;
    private String deptId;
    private String trainingShow;
    private String deptShow;
    private String personShow;

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getTrainingId() {
        return trainingId;
    }

    public void setTrainingId(String trainingId) {
        this.trainingId = trainingId;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getTrainingShow() {
        return trainingShow;
    }

    public void setTrainingShow(String trainingShow) {
        this.trainingShow = trainingShow;
    }

    public String getDeptShow() {
        return deptShow;
    }

    public void setDeptShow(String deptShow) {
        this.deptShow = deptShow;
    }

    public String getPersonShow() {
        return personShow;
    }

    public void setPersonShow(String personShow) {
        this.personShow = personShow;
    }
}
