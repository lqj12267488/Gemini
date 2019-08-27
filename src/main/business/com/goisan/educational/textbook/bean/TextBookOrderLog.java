package com.goisan.educational.textbook.bean;

import com.goisan.system.bean.BaseBean;

public class TextBookOrderLog extends BaseBean{
    private String id;
    private String textbookId;
    private String actualNum;
    private String discount;
    private String declareId;
    private String term;
    private String personType;

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

    public String getActualNum() {
        return actualNum;
    }

    public void setActualNum(String actualNum) {
        this.actualNum = actualNum;
    }

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    public String getDeclareId() {
        return declareId;
    }

    public void setDeclareId(String declareId) {
        this.declareId = declareId;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public String getPersonType() {
        return personType;
    }

    public void setPersonType(String personType) {
        this.personType = personType;
    }
}
