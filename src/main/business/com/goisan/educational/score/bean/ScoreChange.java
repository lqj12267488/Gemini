package com.goisan.educational.score.bean;

import com.goisan.system.bean.BaseBean;

public class ScoreChange extends BaseBean{
    private String id;
    private String departmentsId;
    private String majorCode;
    private String classId;
    private String classes;
    private String studentId;
    private String studentNumber;
    private String courseId;
    private String term;
    private String originalScore;
    private String score;
    private String reason;
    private String time;
    private String requestFlag;
    private String feedback;
    private String feedbackFlag;
    private String requestDept;//申请部门
    private String requester;//申请人
    private String requestDate;//申请日期
    private String scoreId;
    private String course;
    private String scoreType;
    private String examinationStatus;
    private String makeupScore;
    private String examTypes;
    private String examinationResults;
    private String examMethod;
    public String getExamTypes() {
        return examTypes;
    }

    public void setExamTypes(String examTypes) {
        this.examTypes = examTypes;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getClasses() {
        return classes;
    }

    public void setClasses(String classes) {
        this.classes = classes;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getStudentNumber() {
        return studentNumber;
    }

    public void setStudentNumber(String studentNumber) {
        this.studentNumber = studentNumber;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public String getOriginalScore() {
        return originalScore;
    }

    public void setOriginalScore(String originalScore) {
        this.originalScore = originalScore;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getRequestFlag() {
        return requestFlag;
    }

    public void setRequestFlag(String requestFlag) {
        this.requestFlag = requestFlag;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String getFeedbackFlag() {
        return feedbackFlag;
    }

    public void setFeedbackFlag(String feedbackFlag) {
        this.feedbackFlag = feedbackFlag;
    }

    public String getRequestDept() {
        return requestDept;
    }

    public void setRequestDept(String requestDept) {
        this.requestDept = requestDept;
    }

    public String getRequester() {
        return requester;
    }

    public void setRequester(String requester) {
        this.requester = requester;
    }

    public String getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(String requestDate) {
        this.requestDate = requestDate;
    }

    public String getScoreId() {
        return scoreId;
    }

    public void setScoreId(String scoreId) {
        this.scoreId = scoreId;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getScoreType() {
        return scoreType;
    }

    public void setScoreType(String scoreType) {
        this.scoreType = scoreType;
    }

    public String getMakeupScore() {
        return makeupScore;
    }

    public void setMakeupScore(String makeupScore) {
        this.makeupScore = makeupScore;
    }

    public String getExaminationStatus() {
        return examinationStatus;
    }

    public void setExaminationStatus(String examinationStatus) {
        this.examinationStatus = examinationStatus;
    }

    public String getExaminationResults() {
        return examinationResults;
    }

    public void setExaminationResults(String examinationResults) {
        this.examinationResults = examinationResults;
    }

    public String getExamMethod() {
        return examMethod;
    }

    public void setExamMethod(String examMethod) {
        this.examMethod = examMethod;
    }
}
