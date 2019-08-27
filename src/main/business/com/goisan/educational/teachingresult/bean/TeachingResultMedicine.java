package com.goisan.educational.teachingresult.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/7/27.
 */
public class TeachingResultMedicine extends BaseBean{
    private String id;
    private String personId;
    private String deptId;
    private String typicalFlag;
    private String role;
    private String medicineNum;
    private String medicineName;
    private String publishDate;
    private String validityTerm;
    private String remark;
    private String resultType;

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

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getTypicalFlag() {
        return typicalFlag;
    }

    public void setTypicalFlag(String typicalFlag) {
        this.typicalFlag = typicalFlag;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getMedicineNum() {
        return medicineNum;
    }

    public void setMedicineNum(String medicineNum) {
        this.medicineNum = medicineNum;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }

    public String getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(String publishDate) {
        this.publishDate = publishDate;
    }

    public String getValidityTerm() {
        return validityTerm;
    }

    public void setValidityTerm(String validityTerm) {
        this.validityTerm = validityTerm;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
