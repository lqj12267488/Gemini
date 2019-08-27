package com.goisan.educational.major.bean;

public class MajorCollect  extends Major{
    private String overall;             // 在校生数  总人数
    private String firstGrade;      //一年级
    private String secondGrade;     //二年级
    private String juniorClass;     //三年级
    private String highSchool;      // 高中
    private String vocationalCount;  //中职起点合计
    private String twoYears;        // 五年制后两年
    private String sourceTypeOther;  //生源类型 其他


    public String getOverall() {
        return overall;
    }

    public void setOverall(String overall) {
        this.overall = overall;
    }

    public String getFirstGrade() {
        return firstGrade;
    }

    public void setFirstGrade(String firstGrade) {
        this.firstGrade = firstGrade;
    }

    public String getSecondGrade() {
        return secondGrade;
    }

    public void setSecondGrade(String secondGrade) {
        this.secondGrade = secondGrade;
    }

    public String getJuniorClass() {
        return juniorClass;
    }

    public void setJuniorClass(String juniorClass) {
        this.juniorClass = juniorClass;
    }

    public String getHighSchool() {
        return highSchool;
    }

    public void setHighSchool(String highSchool) {
        this.highSchool = highSchool;
    }

    public String getVocationalCount() {
        return vocationalCount;
    }

    public void setVocationalCount(String vocationalCount) {
        this.vocationalCount = vocationalCount;
    }

    public String getTwoYears() {
        return twoYears;
    }

    public void setTwoYears(String twoYears) {
        this.twoYears = twoYears;
    }

    public String getSourceTypeOther() {
        return sourceTypeOther;
    }

    public void setSourceTypeOther(String sourceTypeOther) {
        this.sourceTypeOther = sourceTypeOther;
    }
}
