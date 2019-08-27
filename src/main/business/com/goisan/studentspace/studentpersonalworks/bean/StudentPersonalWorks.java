package com.goisan.studentspace.studentpersonalworks.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by fn on 2017/11/16.
 */
public class StudentPersonalWorks extends BaseBean {
    //资源ID，使用UUID
    private String id;
    //资源名称
    private String resourceName;
    //上传人学生ID
    private String uploadPersonId;
    //上传班级ID
    private String uploadDeptId;
    //上传时间
    private String uploadTime;
    //描述
    private String remark;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }

    public String getUploadPersonId() {
        return uploadPersonId;
    }

    public void setUploadPersonId(String uploadPersonId) {
        this.uploadPersonId = uploadPersonId;
    }

    public String getUploadDeptId() {
        return uploadDeptId;
    }

    public void setUploadDeptId(String uploadDeptId) {
        this.uploadDeptId = uploadDeptId;
    }

    public String getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(String uploadTime) {
        this.uploadTime = uploadTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
