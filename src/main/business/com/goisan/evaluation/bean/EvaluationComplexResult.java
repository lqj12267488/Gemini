package com.goisan.evaluation.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by admin on 2017/7/18.
 */
public class EvaluationComplexResult extends BaseBean {
    private String complexTaskId;
    private String taskId;
    private String empsId;
    private String empPersonId;
    private String empDeptId;
    private String empName;
    private String score;
    private String deptShow;
    private String fullMarks;
    private String complexDetailId;
    private String evaluationType;

    public String getComplexTaskId() {
        return complexTaskId;
    }

    public void setComplexTaskId(String complexTaskId) {
        this.complexTaskId = complexTaskId;
    }

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public String getEmpsId() {
        return empsId;
    }

    public void setEmpsId(String empsId) {
        this.empsId = empsId;
    }

    public String getEmpPersonId() {
        return empPersonId;
    }

    public void setEmpPersonId(String empPersonId) {
        this.empPersonId = empPersonId;
    }

    public String getEmpDeptId() {
        return empDeptId;
    }

    public void setEmpDeptId(String empDeptId) {
        this.empDeptId = empDeptId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getDeptShow() {
        return deptShow;
    }

    public void setDeptShow(String deptShow) {
        this.deptShow = deptShow;
    }

    public String getFullMarks() {
        return fullMarks;
    }

    public void setFullMarks(String fullMarks) {
        this.fullMarks = fullMarks;
    }

    public String getComplexDetailId() {
        return complexDetailId;
    }

    public void setComplexDetailId(String complexDetailId) {
        this.complexDetailId = complexDetailId;
    }

    public String getEvaluationType() {
        return evaluationType;
    }

    public void setEvaluationType(String evaluationType) {
        this.evaluationType = evaluationType;
    }
}
