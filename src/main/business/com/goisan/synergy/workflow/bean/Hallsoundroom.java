package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/5/6.
 */
public class Hallsoundroom extends BaseBean {
    private String id;
    private String requestdept;
    private String meetingcontent;
    private String starttime;
    private String endtime;
    private String usedevice;
    private String requester;
    private String requestdate;
    private String feedback;
    private String feedbackflag;
    private String requestflag;
    private String usedeviceShow;



    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRequestdept() {
        return requestdept;
    }

    public void setRequestdept(String requestdept) {
        this.requestdept = requestdept;
    }

    public String getMeetingcontent() {
        return meetingcontent;
    }

    public void setMeetingcontent(String meetingcontent) {
        this.meetingcontent = meetingcontent;
    }

    public String getStarttime() {
        return starttime;
    }

    public void setStarttime(String starttime) {
        this.starttime = starttime;
    }

    public String getEndtime() {
        return endtime;
    }

    public void setEndtime(String endtime) {
        this.endtime = endtime;
    }

    public String getUsedevice() {
        return usedevice;
    }

    public void setUsedevice(String usedevice) {
        this.usedevice = usedevice;
    }

    public String getRequester() {
        return requester;
    }

    public void setRequester(String requester) {
        this.requester = requester;
    }

    public String getRequestdate() {
        return requestdate;
    }

    public void setRequestdate(String requestdate) {
        this.requestdate = requestdate;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String getFeedbackflag() {
        return feedbackflag;
    }

    public void setFeedbackflag(String feedbackflag) {
        this.feedbackflag = feedbackflag;
    }

    public String getRequestflag() {
        return requestflag;
    }

    public void setRequestflag(String requestflag) {
        this.requestflag = requestflag;
    }

    public String getUsedeviceShow() {
        return usedeviceShow;
    }

    public void setUsedeviceShow(String usedeviceShow) {
        this.usedeviceShow = usedeviceShow;
    }
}
