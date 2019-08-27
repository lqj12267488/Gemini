package com.goisan.data.bean;

import com.goisan.system.bean.BaseBean;

public class DataLocation extends BaseBean {
    private String locationId;
    private String locationName;
    private String parentLocationId;
    public String getLocationId() {
        return locationId;
    }

    public void setLocationId(String locationId) {
        this.locationId = locationId;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public String getParentLocationId() {
        return parentLocationId;
    }

    public void setParentLocationId(String parentLocationId) {
        this.parentLocationId = parentLocationId;
    }

    public void setParentlocationId(String parentLocationId) {
        this.parentLocationId = parentLocationId;
    }

}
