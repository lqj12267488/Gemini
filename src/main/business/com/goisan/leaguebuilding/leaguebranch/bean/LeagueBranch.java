package com.goisan.leaguebuilding.leaguebranch.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/7/26/026.
 */
public class LeagueBranch extends BaseBean {
    private String id;
    private String pId;
    private String branchName;
    private String remark;
    private String parentBranchId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getpId() {
        return pId;
    }

    public void setpId(String pId) {
        this.pId = pId;
    }
    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getParentBranchId() {
        return parentBranchId;
    }

    public void setParentBranchId(String parentBranchId) {
        this.parentBranchId = parentBranchId;
    }
}
