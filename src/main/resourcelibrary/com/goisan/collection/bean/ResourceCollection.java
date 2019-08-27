package com.goisan.collection.bean;

import com.goisan.system.bean.BaseBean;

public class ResourceCollection extends BaseBean {
    private String id;
    private String resourceId;
    private String resourceName;
    private String personId;
    private String personShow;
    private String deptId;
    private String resourceType;
    private String resourceTypeShow;

    public String getResourceId() {
        return resourceId;
    }

    public void setResourceId(String resourceId) {
        this.resourceId = resourceId;
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

    public String getPersonShow() {
        return personShow;
    }

    public void setPersonShow(String personShow) {
        this.personShow = personShow;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }
    public String getResourceType() {
        return resourceType;
    }

    public void setResourceType(String resourceType) {
        this.resourceType = resourceType;
    }

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

    public String getResourceTypeShow() {
        return resourceTypeShow;
    }

    public void setResourceTypeShow(String resourceTypeShow) {
        this.resourceTypeShow = resourceTypeShow;
    }
}
