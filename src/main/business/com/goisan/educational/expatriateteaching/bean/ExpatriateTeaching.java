package com.goisan.educational.expatriateteaching.bean;

import com.goisan.system.bean.BaseBean;

public class ExpatriateTeaching extends BaseBean {
    private String id;
    private String teacherId;
    private String teacherDeptId;
    private String startTime;
    private String endTime;
    private String content;
    private String place;
    private String crowd;
    private String sum;
    private String timeSum;
    private String nameShow;
    private String count;
    private String fileUrl;

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }

    public String getNameShow() {
        return nameShow;
    }

    public void setNameShow(String nameShow) {
        this.nameShow = nameShow;
    }

    public String getTimeSum() {
        return timeSum;
    }

    public void setTimeSum(String timeSum) {
        this.timeSum = timeSum;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherDeptId() {
        return teacherDeptId;
    }

    public void setTeacherDeptId(String teacherDeptId) {
        this.teacherDeptId = teacherDeptId;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public String getCrowd() {
        return crowd;
    }

    public void setCrowd(String crowd) {
        this.crowd = crowd;
    }

    public String getSum() {
        return sum;
    }

    public void setSum(String sum) {
        this.sum = sum;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }
}
