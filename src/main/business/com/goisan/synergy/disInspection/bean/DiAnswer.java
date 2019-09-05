package com.goisan.synergy.disInspection.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created  By hanjie ON 2019/9/5
 */
public class DiAnswer extends BaseBean {

    private String answerId;
    private String remarkId;
    private String reMsg;
    private String ansMsg;
    private String remarkPerson;
    private String answerPerson;
    private String reTime;


    public String getAnswerId() {
        return answerId;
    }

    public void setAnswerId(String answerId) {
        this.answerId = answerId;
    }

    public String getRemarkId() {
        return remarkId;
    }

    public void setRemarkId(String remarkId) {
        this.remarkId = remarkId;
    }

    public String getReMsg() {
        return reMsg;
    }

    public void setReMsg(String reMsg) {
        this.reMsg = reMsg;
    }

    public String getAnsMsg() {
        return ansMsg;
    }

    public void setAnsMsg(String ansMsg) {
        this.ansMsg = ansMsg;
    }

    public String getRemarkPerson() {
        return remarkPerson;
    }

    public void setRemarkPerson(String remarkPerson) {
        this.remarkPerson = remarkPerson;
    }

    public String getAnswerPerson() {
        return answerPerson;
    }

    public void setAnswerPerson(String answerPerson) {
        this.answerPerson = answerPerson;
    }

    public String getReTime() {
        return reTime;
    }

    public void setReTime(String reTime) {
        this.reTime = reTime;
    }
}
