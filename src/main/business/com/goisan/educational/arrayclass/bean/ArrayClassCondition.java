package com.goisan.educational.arrayclass.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by hanyu on 2017/8/22.
 */
public class ArrayClassCondition extends BaseBean {
    private String id;//主键id
    private String arrayclassId;//排课id
    private String elementsId;//元素ID，教师存person_id，课程存course_id，班级存class_id，场地存room_id
    private String elementsType;//元素类型，使用PKYSLX字典，1班级、2教师、3课程、4场地
    private String conditionType;//约束条件类型，使用PKYSTJLX字典，1禁排 ，2待定
    private String limitWeek;//禁排星期，使用XZQ字典
    private String limitHoursType;//禁排学时类型，使用PKXSLX字典，1晨读、2上午、3中午、4下午、5晚自习
    private String limitHoursCode;//禁排学时编码，使用T_JW_ARRAYCLASS_TIME表选
    private String elementsTypeShow;
    private String conditionTypeShow;
    private String limitWeekShow;
    private String limitHoursTypeShow;
    private String limitHoursCodeShow;
    private String elementsIdShow;

    public String getElementsIdShow() {
        return elementsIdShow;
    }

    public void setElementsIdShow(String elementsIdShow) {
        this.elementsIdShow = elementsIdShow;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getArrayclassId() {
        return arrayclassId;
    }

    public void setArrayclassId(String arrayclassId) {
        this.arrayclassId = arrayclassId;
    }

    public String getElementsId() {
        return elementsId;
    }

    public void setElementsId(String elementsId) {
        this.elementsId = elementsId;
    }

    public String getElementsType() {
        return elementsType;
    }

    public void setElementsType(String elementsType) {
        this.elementsType = elementsType;
    }

    public String getConditionType() {
        return conditionType;
    }

    public void setConditionType(String conditionType) {
        this.conditionType = conditionType;
    }

    public String getLimitWeek() {
        return limitWeek;
    }

    public void setLimitWeek(String limitWeek) {
        this.limitWeek = limitWeek;
    }

    public String getLimitHoursType() {
        return limitHoursType;
    }

    public void setLimitHoursType(String limitHoursType) {
        this.limitHoursType = limitHoursType;
    }

    public String getLimitHoursCode() {
        return limitHoursCode;
    }

    public void setLimitHoursCode(String limitHoursCode) {
        this.limitHoursCode = limitHoursCode;
    }

    public String getElementsTypeShow() {
        return elementsTypeShow;
    }

    public void setElementsTypeShow(String elementsTypeShow) {
        this.elementsTypeShow = elementsTypeShow;
    }

    public String getConditionTypeShow() {
        return conditionTypeShow;
    }

    public void setConditionTypeShow(String conditionTypeShow) {
        this.conditionTypeShow = conditionTypeShow;
    }

    public String getLimitWeekShow() {
        return limitWeekShow;
    }

    public void setLimitWeekShow(String limitWeekShow) {
        this.limitWeekShow = limitWeekShow;
    }

    public String getLimitHoursTypeShow() {
        return limitHoursTypeShow;
    }

    public void setLimitHoursTypeShow(String limitHoursTypeShow) {
        this.limitHoursTypeShow = limitHoursTypeShow;
    }

    public String getLimitHoursCodeShow() {
        return limitHoursCodeShow;
    }

    public void setLimitHoursCodeShow(String limitHoursCodeShow) {
        this.limitHoursCodeShow = limitHoursCodeShow;
    }
}
