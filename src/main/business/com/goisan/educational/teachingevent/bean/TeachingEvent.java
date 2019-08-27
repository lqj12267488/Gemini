package com.goisan.educational.teachingevent.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by znw on 2017/7/13.
 */
public class TeachingEvent extends BaseBean {
    private String id;
    private String eventName;
    private String departmentsId;
    private String hostId;
    private String hostDept;
    private String startTime;
    private String endTime;
    private String eventContent;
    private String eventEffect;
    private String departmentsIdShow;
    private String hostIdShow;
    private String hostDeptShow;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getDepartmentsId() {
        return departmentsId;
    }

    public void setDepartmentsId(String departmentsId) {
        this.departmentsId = departmentsId;
    }

    public String getHostId() {
        return hostId;
    }

    public void setHostId(String hostId) {
        this.hostId = hostId;
    }

    public String getHostDept() {
        return hostDept;
    }

    public void setHostDept(String hostDept) {
        this.hostDept = hostDept;
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

    public String getEventContent() {
        return eventContent;
    }

    public void setEventContent(String eventContent) {
        this.eventContent = eventContent;
    }

    public String getEventEffect() {
        return eventEffect;
    }

    public void setEventEffect(String eventEffect) {
        this.eventEffect = eventEffect;
    }


    public String getDepartmentsIdShow() {
        return departmentsIdShow;
    }

    public void setDepartmentsIdShow(String departmentsIdShow) {
        this.departmentsIdShow = departmentsIdShow;
    }

    public String getHostIdShow() {
        return hostIdShow;
    }

    public void setHostIdShow(String hostIdShow) {
        this.hostIdShow = hostIdShow;
    }

    public String getHostDeptShow() {
        return hostDeptShow;
    }

    public void setHostDeptShow(String hostDeptShow) {
        this.hostDeptShow = hostDeptShow;
    }
}
