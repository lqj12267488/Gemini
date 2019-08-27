package com.goisan.system.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by admin on 2017/5/20.
 */
public class ClassStudentRelation extends BaseBean {
    private String id;
    private String studentId;
    private String classId;
    private String studentOrder;

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

    public String getStudentOrder() {
        return studentOrder;
    }

    public void setStudentOrder(String studentOrder) {
        this.studentOrder = studentOrder;
    }

}
