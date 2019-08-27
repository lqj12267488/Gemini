package com.goisan.educational.rewardspunish.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/7/17 0017.
 */
public class RewardsPunish extends BaseBean{

    String id;
    String rname;
    String rdept;
    String rtime;
    String leixing;
    String remark;
    String rfname;
    public String getRdept() {
        return rdept;
    }

    public void setRdept(String rdept) {
        this.rdept = rdept;
    }



    public String getRfname() {
        return rfname;
    }

    public void setRfname(String rfname) {
        this.rfname = rfname;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRname() {
        return rname;
    }

    public void setRname(String rname) {
        this.rname = rname;
    }

    public String getRtime() {
        return rtime;
    }

    public void setRtime(String rtime) {
        this.rtime = rtime;
    }

    public String getLeixing() {
        return leixing;
    }

    public void setLeixing(String leixing) {
        this.leixing = leixing;
    }
}
