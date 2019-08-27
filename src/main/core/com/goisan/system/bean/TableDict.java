package com.goisan.system.bean;

import java.util.List;

/**
 * Created by admin on 2017/5/18.
 */
public class TableDict {
    private String id;
    private String text;
    private String tableName;
    private String where;
    private String orderby;
    private String userLevel;

    private List<Select2> select;

    public List<Select2> getSelect() {
        return select;
    }

    public void setSelect(List<Select2> select) {
        this.select = select;
    }

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

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getWhere() {
        return where;
    }

    public void setWhere(String where) {
        this.where = where;
    }

    public String getOrderby() {
        return orderby;
    }

    public void setOrderby(String orderby) {
        this.orderby = orderby;
    }

    public String getUserLevel() {
        return userLevel;
    }

    public void setUserLevel(String userLevel) {
        this.userLevel = userLevel;
    }
}
