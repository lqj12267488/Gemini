package com.goisan.studentwork.payment.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by mcq on 2017/10/25.
 */
public class PaymentPlanItem extends BaseBean{

    private  String id;
    private  String planId;
    private  String itemId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }
}
