package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class GeneralConstruction extends BaseBean {

    /**主键id*/
    private String id;

    /**接入互联网出口带宽(mbps)*/
    private String internetBandwidth;

    /**校园网主干最大带宽（mbps）*/
    private String networkBandwidth;

    /**{sf}一卡通使用*/
    private String oneCardUse;

   private String oneCardUseShow;

    /**{wxfgqk}无线覆盖情况*/
    private String wirelessCoverage;

   private String wirelessCoverageShow;

    /**网络信息点数（个）*/
    private String networkInformation;

    /**管理信息系统数据总量*/
    private String managementInformation;

    /**电子邮件系统用户数（个）*/
    private String systemMailNumber;

    /**上网课程数（门）*/
    private String onlineCourses;

    /**数字资源量*/
    private String digitalResources;

    /**电子图书（册）*/
    private String electronicsBook;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getInternetBandwidth() {
        return internetBandwidth;
    }

    public void setInternetBandwidth(String internetBandwidth) {
        this.internetBandwidth = internetBandwidth;
    }

    public String getNetworkBandwidth() {
        return networkBandwidth;
    }

    public void setNetworkBandwidth(String networkBandwidth) {
        this.networkBandwidth = networkBandwidth;
    }

    public String getOneCardUse() {
        return oneCardUse;
    }

    public void setOneCardUse(String oneCardUse) {
        this.oneCardUse = oneCardUse;
    }

    public String getOneCardUseShow() {
        return oneCardUseShow;
    }

    public void setOneCardUseShow(String oneCardUseShow) {
        this.oneCardUseShow = oneCardUseShow;
    }

    public String getWirelessCoverage() {
        return wirelessCoverage;
    }

    public void setWirelessCoverage(String wirelessCoverage) {
        this.wirelessCoverage = wirelessCoverage;
    }

    public String getWirelessCoverageShow() {
        return wirelessCoverageShow;
    }

    public void setWirelessCoverageShow(String wirelessCoverageShow) {
        this.wirelessCoverageShow = wirelessCoverageShow;
    }

    public String getNetworkInformation() {
        return networkInformation;
    }

    public void setNetworkInformation(String networkInformation) {
        this.networkInformation = networkInformation;
    }

    public String getManagementInformation() {
        return managementInformation;
    }

    public void setManagementInformation(String managementInformation) {
        this.managementInformation = managementInformation;
    }

    public String getSystemMailNumber() {
        return systemMailNumber;
    }

    public void setSystemMailNumber(String systemMailNumber) {
        this.systemMailNumber = systemMailNumber;
    }

    public String getOnlineCourses() {
        return onlineCourses;
    }

    public void setOnlineCourses(String onlineCourses) {
        this.onlineCourses = onlineCourses;
    }

    public String getDigitalResources() {
        return digitalResources;
    }

    public void setDigitalResources(String digitalResources) {
        this.digitalResources = digitalResources;
    }

    public String getElectronicsBook() {
        return electronicsBook;
    }

    public void setElectronicsBook(String electronicsBook) {
        this.electronicsBook = electronicsBook;
    }

}
