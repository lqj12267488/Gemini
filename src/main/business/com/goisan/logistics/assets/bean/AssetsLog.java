package com.goisan.logistics.assets.bean;


import com.goisan.system.bean.BaseBean;

public class AssetsLog extends BaseBean {

    private String id;
    private String assetsId;
    private String parentAssetsId;
    private String status;
    private String timeShow;
    private String track;
    private String scrapReson;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAssetsId() {
        return assetsId;
    }

    public void setAssetsId(String assetsId) {
        this.assetsId = assetsId;
    }

    public String getParentAssetsId() {
        return parentAssetsId;
    }

    public void setParentAssetsId(String parentAssetsId) {
        this.parentAssetsId = parentAssetsId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTrack() {
        return track;
    }

    public void setTrack(String track) {
        this.track = track;
    }

    public String getTimeShow() {
        return timeShow;
    }

    public void setTimeShow(String timeShow) {
        this.timeShow = timeShow;
    }

    public String getScrapReson() {
        return scrapReson;
    }

    public void setScrapReson(String scrapReson) {
        this.scrapReson = scrapReson;
    }
}
