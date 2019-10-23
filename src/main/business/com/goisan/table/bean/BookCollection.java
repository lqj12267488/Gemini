package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class BookCollection extends BaseBean {

    /**主键id*/
    private String id;

    /**总册数*/
    private String totalNumber;

    /**本学年新增数*/
    private String schoolYearAdd;

    /**中文纸质专业期刊*/
    private String chinesePaperJournal;

    /**外文纸质专业期刊*/
    private String foreignPaperJournals;

    /**电子专业期刊*/
    private String electronicJournal;

    /**年份*/
    private String year;

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTotalNumber() {
        return totalNumber;
    }

    public void setTotalNumber(String totalNumber) {
        this.totalNumber = totalNumber;
    }

    public String getSchoolYearAdd() {
        return schoolYearAdd;
    }

    public void setSchoolYearAdd(String schoolYearAdd) {
        this.schoolYearAdd = schoolYearAdd;
    }

    public String getChinesePaperJournal() {
        return chinesePaperJournal;
    }

    public void setChinesePaperJournal(String chinesePaperJournal) {
        this.chinesePaperJournal = chinesePaperJournal;
    }

    public String getForeignPaperJournals() {
        return foreignPaperJournals;
    }

    public void setForeignPaperJournals(String foreignPaperJournals) {
        this.foreignPaperJournals = foreignPaperJournals;
    }

    public String getElectronicJournal() {
        return electronicJournal;
    }

    public void setElectronicJournal(String electronicJournal) {
        this.electronicJournal = electronicJournal;
    }

}
