package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class CourtyardName extends BaseBean {

    /**主键id*/
    private String id;

    /**学校标识码*/
    private String schoolIdcode;

    /**学校名称(全称)*/
    private String schoolName;

    /**所在地区（省、自治区、直辖市）*/
    private String province;

    /**所在城市*/
    private String city;

    /**当前校名启用日期（年月）*/
    private String enableTime;

    /**建校日期（年月）*/
    private String establishTime;

    /**建校基础*/
    private String establishBasics;

    /**{xxjbzxz}学校举办者性质*/
    private String nature;

   private String natureShow;

    /**{xxjbzjb}学校举办者级别*/
    private String holdLevel;

   private String holdLevelShow;

    /**{xxxzlb}学校性质类别*/
    private String schoolType;

   private String schoolTypeShow;

    /**校训*/
    private String schoolMotto;

    /**{sfxgdzyyxxz}示范性高等职业院校性质*/
    private String exemplaryNature;

   private String exemplaryNatureShow;

    /**{sfxgdzyyxjb}示范性高等职业院校级别*/
    private String exemplaryLevel;

   private String exemplaryLevelShow;

    /**示范性高等职业院校立项部门*/
    private String establishmentDept;

    /**立项日期（年）*/
    private String establishmentTime;

    /**评估状态 第一轮 评估日期
（年月）*/
    private String assessmentOneTime;

    /**评估状态 第一轮 评估结论*/
    private String evaluationConclusionOne;

    /**评估状态 第二轮 评估日期
（年月）*/
    private String assessmentTwoTime;

    /**评估状态 第二轮 评估结论*/
    private String evaluationConclusionTwo;

    /**{sf}未接受评估是/否*/
    private String unassessed;

   private String unassessedShow;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSchoolIdcode() {
        return schoolIdcode;
    }

    public void setSchoolIdcode(String schoolIdcode) {
        this.schoolIdcode = schoolIdcode;
    }

    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getEnableTime() {
        return enableTime;
    }

    public void setEnableTime(String enableTime) {
        this.enableTime = enableTime;
    }

    public String getEstablishTime() {
        return establishTime;
    }

    public void setEstablishTime(String establishTime) {
        this.establishTime = establishTime;
    }

    public String getEstablishBasics() {
        return establishBasics;
    }

    public void setEstablishBasics(String establishBasics) {
        this.establishBasics = establishBasics;
    }

    public String getNature() {
        return nature;
    }

    public void setNature(String nature) {
        this.nature = nature;
    }

    public String getNatureShow() {
        return natureShow;
    }

    public void setNatureShow(String natureShow) {
        this.natureShow = natureShow;
    }

    public String getHoldLevel() {
        return holdLevel;
    }

    public void setHoldLevel(String holdLevel) {
        this.holdLevel = holdLevel;
    }

    public String getHoldLevelShow() {
        return holdLevelShow;
    }

    public void setHoldLevelShow(String holdLevelShow) {
        this.holdLevelShow = holdLevelShow;
    }

    public String getSchoolType() {
        return schoolType;
    }

    public void setSchoolType(String schoolType) {
        this.schoolType = schoolType;
    }

    public String getSchoolTypeShow() {
        return schoolTypeShow;
    }

    public void setSchoolTypeShow(String schoolTypeShow) {
        this.schoolTypeShow = schoolTypeShow;
    }

    public String getSchoolMotto() {
        return schoolMotto;
    }

    public void setSchoolMotto(String schoolMotto) {
        this.schoolMotto = schoolMotto;
    }

    public String getExemplaryNature() {
        return exemplaryNature;
    }

    public void setExemplaryNature(String exemplaryNature) {
        this.exemplaryNature = exemplaryNature;
    }

    public String getExemplaryNatureShow() {
        return exemplaryNatureShow;
    }

    public void setExemplaryNatureShow(String exemplaryNatureShow) {
        this.exemplaryNatureShow = exemplaryNatureShow;
    }

    public String getExemplaryLevel() {
        return exemplaryLevel;
    }

    public void setExemplaryLevel(String exemplaryLevel) {
        this.exemplaryLevel = exemplaryLevel;
    }

    public String getExemplaryLevelShow() {
        return exemplaryLevelShow;
    }

    public void setExemplaryLevelShow(String exemplaryLevelShow) {
        this.exemplaryLevelShow = exemplaryLevelShow;
    }

    public String getEstablishmentDept() {
        return establishmentDept;
    }

    public void setEstablishmentDept(String establishmentDept) {
        this.establishmentDept = establishmentDept;
    }

    public String getEstablishmentTime() {
        return establishmentTime;
    }

    public void setEstablishmentTime(String establishmentTime) {
        this.establishmentTime = establishmentTime;
    }

    public String getAssessmentOneTime() {
        return assessmentOneTime;
    }

    public void setAssessmentOneTime(String assessmentOneTime) {
        this.assessmentOneTime = assessmentOneTime;
    }

    public String getEvaluationConclusionOne() {
        return evaluationConclusionOne;
    }

    public void setEvaluationConclusionOne(String evaluationConclusionOne) {
        this.evaluationConclusionOne = evaluationConclusionOne;
    }

    public String getAssessmentTwoTime() {
        return assessmentTwoTime;
    }

    public void setAssessmentTwoTime(String assessmentTwoTime) {
        this.assessmentTwoTime = assessmentTwoTime;
    }

    public String getEvaluationConclusionTwo() {
        return evaluationConclusionTwo;
    }

    public void setEvaluationConclusionTwo(String evaluationConclusionTwo) {
        this.evaluationConclusionTwo = evaluationConclusionTwo;
    }

    public String getUnassessed() {
        return unassessed;
    }

    public void setUnassessed(String unassessed) {
        this.unassessed = unassessed;
    }

    public String getUnassessedShow() {
        return unassessedShow;
    }

    public void setUnassessedShow(String unassessedShow) {
        this.unassessedShow = unassessedShow;
    }

}
