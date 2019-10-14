package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class ProEvaAgency extends BaseBean {

    /**主键id，使用uuid*/
    private String id;

    /**职业技能鉴定站（所）*/
    private String evaName;

    /**工种证书名称*/
    private String certName;

    /**等级{	zydj}*/
    private String evaLevel;

   private String evaLevelShow;

    /**建立单位级别{	dwbmdj}*/
    private String buildDepLev;

   private String buildDepLevShow;

    /**部门*/
    private String depart;

    /**社会鉴定数（人天）*/
    private String ssEvaNum;

    /**在校生鉴定数(人天)*/
    private String schEvaNum;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEvaName() {
        return evaName;
    }

    public void setEvaName(String evaName) {
        this.evaName = evaName;
    }

    public String getCertName() {
        return certName;
    }

    public void setCertName(String certName) {
        this.certName = certName;
    }

    public String getEvaLevel() {
        return evaLevel;
    }

    public void setEvaLevel(String evaLevel) {
        this.evaLevel = evaLevel;
    }

    public String getEvaLevelShow() {
        return evaLevelShow;
    }

    public void setEvaLevelShow(String evaLevelShow) {
        this.evaLevelShow = evaLevelShow;
    }

    public String getBuildDepLev() {
        return buildDepLev;
    }

    public void setBuildDepLev(String buildDepLev) {
        this.buildDepLev = buildDepLev;
    }

    public String getBuildDepLevShow() {
        return buildDepLevShow;
    }

    public void setBuildDepLevShow(String buildDepLevShow) {
        this.buildDepLevShow = buildDepLevShow;
    }

    public String getDepart() {
        return depart;
    }

    public void setDepart(String depart) {
        this.depart = depart;
    }

    public String getSsEvaNum() {
        return ssEvaNum;
    }

    public void setSsEvaNum(String ssEvaNum) {
        this.ssEvaNum = ssEvaNum;
    }

    public String getSchEvaNum() {
        return schEvaNum;
    }

    public void setSchEvaNum(String schEvaNum) {
        this.schEvaNum = schEvaNum;
    }

}
