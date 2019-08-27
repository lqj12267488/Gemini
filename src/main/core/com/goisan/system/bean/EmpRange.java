package com.goisan.system.bean;

/**
 * Created by mcq on 2017/5/9.
 */
public class EmpRange extends  BaseBean{
    private String id;
    private String personId;
    private String deptId;
    private String deptIdShow;
    private String personIdShow;

    public String getDeptIdShow() {
        return deptIdShow;
    }

    public void setDeptIdShow(String deptIdShow) {
        this.deptIdShow = deptIdShow;
    }

    public String getPersonIdShow() {
        return personIdShow;
    }

    public void setPersonIdShow(String personIdShow) {
        this.personIdShow = personIdShow;
    }

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
}
