package com.goisan.studentwork.payment.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by mcq on 2017/10/25.
 */
public class PaymentResult extends BaseBean {

    private String id;
    private String itemId;
    private String planId;
    private String studentId;
    private String paymentStandard;
    private String paymentAmount;
    private String refundAmount;
    private String classId;
    private String studentName;
    private String planName;
    private String planItemShow;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getPaymentStandard() {
        return paymentStandard;
    }

    public void setPaymentStandard(String paymentStandard) {
        this.paymentStandard = paymentStandard;
    }

    public String getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(String paymentAmount) {
        this.paymentAmount = paymentAmount;
    }

    public String getRefundAmount() {
        return refundAmount;
    }

    public void setRefundAmount(String refundAmount) {
        this.refundAmount = refundAmount;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public String getPlanItemShow() {
        return planItemShow;
    }

    public void setPlanItemShow(String planItemShow) {
        this.planItemShow = planItemShow;
    }
}
