package com.goisan.studentwork.graduatearchivesaddress.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created  By hanjie ON 2019/8/29
 */
//档案地址
public class Arcad  extends BaseBean {

    private String arcadId;
    private String arcadProvince;
    private String arcadProvinceShow;
    private String arcadCity;
    private String arcadCityShow;
    private String arcadCounty;
    private String arcadCountyShow;
    private String arcadDetail;


    public String getArcadProvinceShow() {
        return arcadProvinceShow;
    }

    public void setArcadProvinceShow(String arcadProvinceShow) {
        this.arcadProvinceShow = arcadProvinceShow;
    }

    public String getArcadCityShow() {
        return arcadCityShow;
    }

    public void setArcadCityShow(String arcadCityShow) {
        this.arcadCityShow = arcadCityShow;
    }

    public String getArcadCountyShow() {
        return arcadCountyShow;
    }

    public void setArcadCountyShow(String arcadCountyShow) {
        this.arcadCountyShow = arcadCountyShow;
    }

    public Arcad() {
    }

    public String getArcadId() {
        return arcadId;
    }

    public void setArcadId(String arcadId) {
        this.arcadId = arcadId;
    }

    public String getArcadProvince() {
        return arcadProvince;
    }

    public void setArcadProvince(String arcadProvince) {
        this.arcadProvince = arcadProvince;
    }

    public String getArcadCity() {
        return arcadCity;
    }

    public void setArcadCity(String arcadCity) {
        this.arcadCity = arcadCity;
    }

    public String getArcadCounty() {
        return arcadCounty;
    }

    public void setArcadCounty(String arcadCounty) {
        this.arcadCounty = arcadCounty;
    }

    public String getArcadDetail() {
        return arcadDetail;
    }

    public void setArcadDetail(String arcadDetail) {
        this.arcadDetail = arcadDetail;
    }
}
