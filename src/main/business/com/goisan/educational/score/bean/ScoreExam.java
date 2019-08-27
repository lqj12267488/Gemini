package com.goisan.educational.score.bean;

import com.goisan.system.bean.BaseBean;

import java.util.List;

/**
 * Created by wq on 2017/10/12.
 */
public class ScoreExam extends BaseBean {
    private String scoreExamId;
    private String scoreExamName;
    private String startTime;
    private String endTime;
    private String term;
    private String scoreFlag;
    private String col;
    private String classId;
    private List<ScoreCourse> courses;

    public String getCol() {
        return col;
    }

    public void setCol(String col) {
        this.col = col;
    }

    public List<ScoreCourse> getCourses() {
        return courses;
    }

    public void setCourses(List<ScoreCourse> courses) {
        this.courses = courses;
    }

    public String getTermShow() {
        return termShow;
    }

    public void setTermShow(String termShow) {
        this.termShow = termShow;
    }

    private String termShow;

    public String getScoreExamId() {
        return scoreExamId;
    }

    public void setScoreExamId(String scoreExamId) {
        this.scoreExamId = scoreExamId;
    }

    public String getScoreExamName() {
        return scoreExamName;
    }

    public void setScoreExamName(String scoreExamName) {
        this.scoreExamName = scoreExamName;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getScoreFlag() {
        return scoreFlag;
    }

    public void setScoreFlag(String scoreFlag) {
        this.scoreFlag = scoreFlag;
    }
}
