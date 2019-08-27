package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/5/6 0006.
 */
public class FundsRelation extends BaseBean {
    private String id;
    private String businessId;
    private String fundsId;
    private String url;
    private String appUrl;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBusinessId() {
        return businessId;
    }

    public void setBusinessId(String businessId) {
        this.businessId = businessId;
    }

    public String getFundsId() {
        return fundsId;
    }

    public void setFundsId(String fundsId) {
        this.fundsId = fundsId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getAppUrl() {
        return appUrl;
    }

    public void setAppUrl(String appUrl) {
        this.appUrl = appUrl;
    }
}
