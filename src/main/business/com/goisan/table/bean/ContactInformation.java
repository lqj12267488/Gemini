package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class ContactInformation extends BaseBean {

    /**主键id*/
    private String id;

    /**通信地址*/
    private String mailingAddress;

    /**邮政编码*/
    private String postalCode;

    /**学校网址*/
    private String schoolWebsite;

    /**法人区号－电话号码*/
    private String areaNumber;

    /**法人区号－传真号*/
    private String areaFax;

    /**法人电子邮箱*/
    private String mailBox;

    /**联系人区号－电话号码*/
    private String contactsAreaNumber;

    /**联系人区号－传真号*/
    private String contactsAreaFax;

    /**联系人电子邮箱*/
    private String contactsMailBox;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMailingAddress() {
        return mailingAddress;
    }

    public void setMailingAddress(String mailingAddress) {
        this.mailingAddress = mailingAddress;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getSchoolWebsite() {
        return schoolWebsite;
    }

    public void setSchoolWebsite(String schoolWebsite) {
        this.schoolWebsite = schoolWebsite;
    }

    public String getAreaNumber() {
        return areaNumber;
    }

    public void setAreaNumber(String areaNumber) {
        this.areaNumber = areaNumber;
    }

    public String getAreaFax() {
        return areaFax;
    }

    public void setAreaFax(String areaFax) {
        this.areaFax = areaFax;
    }

    public String getMailBox() {
        return mailBox;
    }

    public void setMailBox(String mailBox) {
        this.mailBox = mailBox;
    }

    public String getContactsAreaNumber() {
        return contactsAreaNumber;
    }

    public void setContactsAreaNumber(String contactsAreaNumber) {
        this.contactsAreaNumber = contactsAreaNumber;
    }

    public String getContactsAreaFax() {
        return contactsAreaFax;
    }

    public void setContactsAreaFax(String contactsAreaFax) {
        this.contactsAreaFax = contactsAreaFax;
    }

    public String getContactsMailBox() {
        return contactsMailBox;
    }

    public void setContactsMailBox(String contactsMailBox) {
        this.contactsMailBox = contactsMailBox;
    }

}
