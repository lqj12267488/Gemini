package com.goisan.archives.bean;

import com.goisan.system.bean.BaseBean;

public class ArchivesType extends BaseBean {
    private String typeId;
    private String typeName;
    private String parentTypeId;
    private String deptOrder;
    private String publicType;
    private String newTypeId;
    public String getTypeId() {
        return typeId;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getParentTypeId() {
        return parentTypeId;
    }

    public void setParentTypeId(String parentTypeId) {
        this.parentTypeId = parentTypeId;
    }

    public String getDeptOrder() {
        return deptOrder;
    }

    public void setDeptOrder(String deptOrder) {
        this.deptOrder = deptOrder;
    }


    public String getPublicType() {
        return publicType;
    }

    public void setPublicType(String publicType) {
        this.publicType = publicType;
    }

    public String getNewTypeId() {
        return newTypeId;
    }

    public void setNewTypeId(String newTypeId) {
        this.newTypeId = newTypeId;
    }
}
