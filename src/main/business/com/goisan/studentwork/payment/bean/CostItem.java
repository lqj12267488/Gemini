package com.goisan.studentwork.payment.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by mcq on 2017/10/23.
 */
public class CostItem extends BaseBean {
    private  String costId;
    private  String costType;
    private  String costName;

    public String getCostId() {
        return costId;
    }

    public void setCostId(String costId) {
        this.costId = costId;
    }

    public String getCostType() {
        return costType;
    }

    public void setCostType(String costType) {
        this.costType = costType;
    }

    public String getCostName() {
        return costName;
    }

    public void setCostName(String costName) {
        this.costName = costName;
    }
}
