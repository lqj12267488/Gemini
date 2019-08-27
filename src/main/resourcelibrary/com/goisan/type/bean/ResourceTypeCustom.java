package com.goisan.type.bean;

import com.goisan.system.bean.BaseBean;

public class ResourceTypeCustom extends BaseBean {
    private String typeId;
    private String typeName;

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
}
