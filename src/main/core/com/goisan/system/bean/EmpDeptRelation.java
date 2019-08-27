package com.goisan.system.bean;

/**
 * Created by Admin on 2017/4/26.
 */
public class EmpDeptRelation extends BaseBean {
    private String id;
    private String deptId;
    private String personId;
    private Integer personOrder;
    private String defaultFlag;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDefaultFlag() {
        return defaultFlag;
    }

    public void setDefaultFlag(String defaultFlag) {
        this.defaultFlag = defaultFlag;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public Integer getPersonOrder() {
        return personOrder;
    }

    public void setPersonOrder(Integer personOrder) {
        this.personOrder = personOrder;
    }
}
