package com.goisan.evaluation.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by admin on 2017/7/18.
 */
public class EvaluationComplexDetail extends BaseBean {
    private String id;
    private String complexTaskId;
    private String taskShowName;
    private String taskId;
    private String taskName;
    private int weights;
    private String score;
    private String evaluationType;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getComplexTaskId() {
        return complexTaskId;
    }

    public void setComplexTaskId(String complexTaskId) {
        this.complexTaskId = complexTaskId;
    }

    public String getTaskShowName() {
        return taskShowName;
    }

    public void setTaskShowName(String taskShowName) {
        this.taskShowName = taskShowName;
    }

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public int getWeights() {
        return weights;
    }

    public void setWeights(int weights) {
        this.weights = weights;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getEvaluationType() {
        return evaluationType;
    }

    public void setEvaluationType(String evaluationType) {
        this.evaluationType = evaluationType;
    }
}
