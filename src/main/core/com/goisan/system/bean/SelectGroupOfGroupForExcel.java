package com.goisan.system.bean;

/**
 * Excel模板级联菜单用
 */
public class SelectGroupOfGroupForExcel {
    private String id;
    private String text;
    private Classes[] classeses;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Classes[] getClasseses() {
        return classeses;
    }

    public void setClasseses(Classes[] classeses) {
        this.classeses = classeses;
    }
}
