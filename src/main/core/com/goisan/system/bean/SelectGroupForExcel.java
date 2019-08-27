package com.goisan.system.bean;

/**
 * @author 郭千恺
 * @version v1.0
 * @descroption Excel模板级联菜单用
 * @date 2018/9/21 14:57
 */
public class SelectGroupForExcel {
// Field ----------------------------------------
    private String id;
    private String text;
    private String[] major;
// Method ----------------------------------------
    // Getters and setters
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

    public String[] getMajor() {
        return major;
    }

    public void setMajor(String[] major) {
        this.major = major;
    }
}
