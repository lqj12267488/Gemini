package com.goisan.system.bean;

/**
 * Created by admin on 2017/5/2.
 */
public class EmpDeptTree {
    private String id;
    private String name;
    private String pId;
    private String url;
    private String isPanrent;
    private String isper;
    private boolean isOpen;
    private String checked;

    public String getIsper() {
        return isper;
    }

    public void setIsper(String isper) {
        this.isper = isper;
    }

    public String getIsPanrent() {
        return isPanrent;
    }

    public void setIsPanrent(String isPanrent) {
        this.isPanrent = isPanrent;
    }

    public String getChecked() {
        return checked;
    }

    public void setChecked(String checked) {
        this.checked = checked;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getpId() {
        return pId;
    }

    public void setpId(String pId) {
        this.pId = pId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public boolean isOpen() {
        return isOpen;
    }

    public void setOpen(boolean open) {
        isOpen = open;
    }

}

