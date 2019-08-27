package com.goisan.educational.teachingresult.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/7/13 0013.
 */
public class TeachingResult extends BaseBean {
    private String id;
    private String resultObject;
    private String resultPersonId;
    private String resultPersonDeptId;
    private String resultType;
    private String resultLevel;
    private String resultTime;
    private String remark;
    private String files;

    public String getFiles() {
        return files;
    }

    public void setFiles(String files) {
        this.files = files;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getResultObject() {
        return resultObject;
    }

    public void setResultObject(String resultObject) {
        this.resultObject = resultObject;
    }

    public String getResultPersonId() {
        return resultPersonId;
    }

    public void setResultPersonId(String resultPersonId) {
        this.resultPersonId = resultPersonId;
    }

    public String getResultPersonDeptId() {
        return resultPersonDeptId;
    }

    public void setResultPersonDeptId(String resultPersonDeptId) {
        this.resultPersonDeptId = resultPersonDeptId;
    }

    public String getResultType() {
        return resultType;
    }

    public void setResultType(String resultType) {
        this.resultType = resultType;
    }

    public String getResultLevel() {
        return resultLevel;
    }

    public void setResultLevel(String resultLevel) {
        this.resultLevel = resultLevel;
    }

    public String getResultTime() {
        return resultTime;
    }

    public void setResultTime(String resultTime) {
        this.resultTime = resultTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }


}
