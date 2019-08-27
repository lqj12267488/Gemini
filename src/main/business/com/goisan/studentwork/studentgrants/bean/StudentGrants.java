package com.goisan.studentwork.studentgrants.bean;

import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Select2;

import java.util.List;

/**
 * Created by Administrator on 2017/7/28.
 */
public class StudentGrants extends BaseBean {
    private String id;
    private String studentId;
    private String classId;
    //系部Id
    private String departmentsId;
    //专业代码
    private String majorCode;
    //专业方向
//    private String majorDirection;
    //培养层次
    private String trainingLevel;
    //助学金类别
    private String grantType;
    //金额
    private String money;
    //获得学期
    private String term;
    private String grantTypeShow;
//    List<Select2> getMajorByDeptId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getDepartmentsId() {
        return departmentsId;
    }

    public void setDepartmentsId(String departmentsId) {
        this.departmentsId = departmentsId;
    }

    public String getMajorCode() {
        return majorCode;
    }

    public void setMajorCode(String majorCode) {
        this.majorCode = majorCode;
    }

//    public String getMajorDirection() {
//        return majorDirection;
//    }

//    public void setMajorDirection(String majorDirection) {
//        this.majorDirection = majorDirection;
//    }

    public String getTrainingLevel() {
        return trainingLevel;
    }

    public void setTrainingLevel(String trainingLevel) {
        this.trainingLevel = trainingLevel;
    }

    public String getGrantType() {
        return grantType;
    }

    public void setGrantType(String grantType) {
        this.grantType = grantType;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public String getGrantTypeShow() {
        return grantTypeShow;
    }

    public void setGrantTypeShow(String grantTypeShow) {
        this.grantTypeShow = grantTypeShow;
    }
}
