package com.goisan.synergy.disInspection.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created  By hanjie ON 2019/9/4
 */
public class DiRemark extends BaseBean {
    private String remarkId;
    private String reMsg;
    private String reTime;

    public String getReTime() {
        return reTime;
    }

    public void setReTime(String reTime) {
        this.reTime = reTime;
    }

    public String getRemarkId() {
        return remarkId;
    }

    public void setRemarkId(String remarkId) {
        this.remarkId = remarkId;
    }

    public String getReMsg() {
        return reMsg;
    }

    public void setReMsg(String reMsg) {
        this.reMsg = reMsg;
    }
}
