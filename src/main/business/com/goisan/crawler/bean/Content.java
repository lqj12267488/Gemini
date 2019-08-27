package com.goisan.crawler.bean;

import com.goisan.system.bean.BaseBean;

public class Content extends BaseBean {
    private String id;
    private String url;
    private String title;
    private String grabDate;
    private String webId;
    private String sensiWords;
    private String sensiLevel;
    private String pid;
    private String channelName;

    public String getChannelName() {
        return channelName;
    }

    public void setChannelName(String channelName) {
        this.channelName = channelName;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getGrabDate() {
        return grabDate;
    }

    public void setGrabDate(String grabDate) {
        this.grabDate = grabDate;
    }

    public String getWebId() {
        return webId;
    }

    public void setWebId(String webId) {
        this.webId = webId;
    }

    public String getSensiWords() {
        return sensiWords;
    }

    public void setSensiWords(String sensiWords) {
        this.sensiWords = sensiWords;
    }

    public String getSensiLevel() {
        return sensiLevel;
    }

    public void setSensiLevel(String sensiLevel) {
        this.sensiLevel = sensiLevel;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }
}
