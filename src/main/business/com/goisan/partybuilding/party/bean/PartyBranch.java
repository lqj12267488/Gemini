package com.goisan.partybuilding.party.bean;

import com.goisan.system.bean.BaseBean;

import java.util.Date;

/**
 * Created by Administrator on 2017/7/26/026.
 */
public class PartyBranch extends BaseBean{
    private String id;
    private String branchName;
    private String remark;
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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
}
