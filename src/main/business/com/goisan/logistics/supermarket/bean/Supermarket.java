package com.goisan.logistics.supermarket.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/9/25.
 */
public class Supermarket extends BaseBean {

    private String id;
    private String name;
    private String address;
    private String personName;
    private String personTel;
    private String personidCard;
    private String startTime;
    private String endTime;
    //
    private String supermarketId;
    private String staffName;
    private String staffidCard;
    private String staffAddress;
    private String staffAfe;
    private String staffSex;
    private String isJob;
    private String staffTel;
    private String staffPost;

    public String getStaffPost() {
        return staffPost;
    }

    public void setStaffPost(String staffPost) {
        this.staffPost = staffPost;
    }

    public String getStaffTel() {
        return staffTel;
    }

    public void setStaffTel(String staffTel) {
        this.staffTel = staffTel;
    }

    public String getSupermarketId() {
        return supermarketId;
    }

    public void setSupermarketId(String supermarketId) {
        this.supermarketId = supermarketId;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getStaffidCard() {
        return staffidCard;
    }

    public void setStaffidCard(String staffidCard) {
        this.staffidCard = staffidCard;
    }

    public String getStaffAddress() {
        return staffAddress;
    }

    public void setStaffAddress(String staffAddress) {
        this.staffAddress = staffAddress;
    }

    public String getStaffAfe() {
        return staffAfe;
    }

    public void setStaffAfe(String staffAfe) {
        this.staffAfe = staffAfe;
    }

    public String getStaffSex() {
        return staffSex;
    }

    public void setStaffSex(String staffSex) {
        this.staffSex = staffSex;
    }

    public String getIsJob() {
        return isJob;
    }

    public void setIsJob(String isJob) {
        this.isJob = isJob;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public String getPersonTel() {
        return personTel;
    }

    public void setPersonTel(String personTel) {
        this.personTel = personTel;
    }

    public String getPersonidCard() {
        return personidCard;
    }

    public void setPersonidCard(String personidCard) {
        this.personidCard = personidCard;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
}
