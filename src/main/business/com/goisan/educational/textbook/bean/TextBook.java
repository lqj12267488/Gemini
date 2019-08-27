package com.goisan.educational.textbook.bean;


import com.goisan.system.bean.BaseBean;

public class TextBook extends BaseBean {
    private String id;
    private String textbookId;
    private String textbookName;
    private String textbookNumber;
    private String textbookType;
    private String textbookNature;
    private String textbookNatureName;
    private String departmentsId;
    private String majorId;
    private String majorCode;
    private String trainingLevel;
    private String publishingHouse;
    private String editor;
    private String edition;
    private String price;
    private String textbookNumAll;
    private String textbookNumIn;
    private String remark;
    private String releaseNum;
    private String firstEditorCompany;//第一主编单位
    private String textbookCategory;//教材类别 使用JCLB字典  1 高职高专  2 其他
    private String subscribeCode;
    private String versionDate;
    private String gradeId;
    private String discount;
    private String operationNum;

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTextbookId() {
        return textbookId;
    }

    public void setTextbookId(String textbookId) {
        this.textbookId = textbookId;
    }


    public String getTextbookName() {
        return textbookName;
    }

    public void setTextbookName(String textbookName) {
        this.textbookName = textbookName;
    }


    public String getTextbookNumber() {
        return textbookNumber;
    }

    public void setTextbookNumber(String textbookNumber) {
        this.textbookNumber = textbookNumber;
    }


    public String getTextbookType() {
        return textbookType;
    }

    public void setTextbookType(String textbookType) {
        this.textbookType = textbookType;
    }


    public String getTextbookNature() {
        return textbookNature;
    }

    public void setTextbookNature(String textbookNature) {
        this.textbookNature = textbookNature;
    }


    public String getDepartmentsId() {
        return departmentsId;
    }

    public void setDepartmentsId(String departmentsId) {
        this.departmentsId = departmentsId;
    }


    public String getMajorId() {
        return majorId;
    }

    public void setMajorId(String majorId) {
        this.majorId = majorId;
    }


    public String getPublishingHouse() {
        return publishingHouse;
    }

    public void setPublishingHouse(String publishingHouse) {
        this.publishingHouse = publishingHouse;
    }

    public String getTextbookNatureName() {
        return textbookNatureName;
    }

    public void setTextbookNatureName(String textbookNatureName) {
        this.textbookNatureName = textbookNatureName;
    }

    public String getEditor() {
        return editor;
    }

    public void setEditor(String editor) {
        this.editor = editor;
    }


    public String getEdition() {
        return edition;
    }

    public void setEdition(String edition) {
        this.edition = edition;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getTextbookNumAll() {
        return textbookNumAll;
    }

    public void setTextbookNumAll(String textbookNumAll) {
        this.textbookNumAll = textbookNumAll;
    }


    public String getTextbookNumIn() {
        return textbookNumIn;
    }

    public void setTextbookNumIn(String textbookNumIn) {
        this.textbookNumIn = textbookNumIn;
    }


    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getMajorCode() {
        return majorCode;
    }

    public void setMajorCode(String majorCode) {
        this.majorCode = majorCode;
    }

    public String getTrainingLevel() {
        return trainingLevel;
    }

    public void setTrainingLevel(String trainingLevel) {
        this.trainingLevel = trainingLevel;
    }

    public String getReleaseNum() {
        return releaseNum;
    }

    public void setReleaseNum(String releaseNum) {
        this.releaseNum = releaseNum;
    }

    public String getFirstEditorCompany() {
        return firstEditorCompany;
    }

    public void setFirstEditorCompany(String firstEditorCompany) {
        this.firstEditorCompany = firstEditorCompany;
    }

    public String getTextbookCategory() {
        return textbookCategory;
    }

    public void setTextbookCategory(String textbookCategory) {
        this.textbookCategory = textbookCategory;
    }

    public String getSubscribeCode() {
        return subscribeCode;
    }

    public void setSubscribeCode(String subscribeCode) {
        this.subscribeCode = subscribeCode;
    }

    public String getVersionDate() {
        return versionDate;
    }

    public void setVersionDate(String versionDate) {
        this.versionDate = versionDate;
    }

    public String getGradeId() {
        return gradeId;
    }

    public void setGradeId(String gradeId) {
        this.gradeId = gradeId;
    }

    public String getOperationNum() {
        return operationNum;
    }

    public void setOperationNum(String operationNum) {
        this.operationNum = operationNum;
    }
}
