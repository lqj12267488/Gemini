package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class Qualification extends BaseBean {

    /***/
    private String id;

    /**资格证书名称*/
    private String qualificationName;

    /**资格证书等级{zgzsdj}*/
    private String qualificationLevel;

   private String qualificationLevelShow;

    /**发证机构*/
    private String qualificationAuthority;

    /**鉴定地点{jddd}*/
    private String identificationSite;

   private String identificationSiteShow;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getQualificationName() {
        return qualificationName;
    }

    public void setQualificationName(String qualificationName) {
        this.qualificationName = qualificationName;
    }

    public String getQualificationLevel() {
        return qualificationLevel;
    }

    public void setQualificationLevel(String qualificationLevel) {
        this.qualificationLevel = qualificationLevel;
    }

    public String getQualificationLevelShow() {
        return qualificationLevelShow;
    }

    public void setQualificationLevelShow(String qualificationLevelShow) {
        this.qualificationLevelShow = qualificationLevelShow;
    }

    public String getQualificationAuthority() {
        return qualificationAuthority;
    }

    public void setQualificationAuthority(String qualificationAuthority) {
        this.qualificationAuthority = qualificationAuthority;
    }

    public String getIdentificationSite() {
        return identificationSite;
    }

    public void setIdentificationSite(String identificationSite) {
        this.identificationSite = identificationSite;
    }

    public String getIdentificationSiteShow() {
        return identificationSiteShow;
    }

    public void setIdentificationSiteShow(String identificationSiteShow) {
        this.identificationSiteShow = identificationSiteShow;
    }

}
