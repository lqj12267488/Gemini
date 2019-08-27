package com.goisan.educational.score.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/10/12.
 */
public class ScoreClass extends BaseBean {
    private String scoreClassId;//主键id
    private String subjectId;//考试科目id
    private String departmentsId;//系部
    private String majorCode;//专业代码
    private String majorDirection;//专业方向
    private String trainingLevel;//培养层次
    private String planId;//教学计划
    private String scoreExamId;//考试id
    private String scoreExamName;//考试名称
    private String classId;//班级
    private String courseId;//课程
    private String courseType;
    private String personId;//录入教师
    private String scoreClassIds;
    private String studentId;
    private String studentName;
    private String score;//考试成绩
    private String makeupScore;//补考成绩
    private String graduateMakeupScore;//毕业补考成绩
    private String examinationStatus;//考试状态
    private String termId;//学期
    private String makeupStatus;//补考状态
    private String graduateMakeupStatus;//毕业补考状态
    private String teacherDeptId;
    private String teacherPersonId;
    private String courseFlag ;

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getCourseFlag() {
        return courseFlag;
    }

    public void setCourseFlag(String courseFlag) {
        this.courseFlag = courseFlag;
    }

    public String getScoreClassId() {
        return scoreClassId;
    }

    public void setScoreClassId(String scoreClassId) {
        this.scoreClassId = scoreClassId;
    }

    public String getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(String subjectId) {
        this.subjectId = subjectId;
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

    public String getMajorDirection() {
        return majorDirection;
    }

    public void setMajorDirection(String majorDirection) {
        this.majorDirection = majorDirection;
    }

    public String getTrainingLevel() {
        return trainingLevel;
    }

    public void setTrainingLevel(String trainingLevel) {
        this.trainingLevel = trainingLevel;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

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

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getCourseType() {
        return courseType;
    }

    public void setCourseType(String courseType) {
        this.courseType = courseType;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getScoreClassIds() {
        return scoreClassIds;
    }

    public void setScoreClassIds(String scoreClassIds) {
        this.scoreClassIds = scoreClassIds;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getMakeupScore() {
        return makeupScore;
    }

    public void setMakeupScore(String makeupScore) {
        this.makeupScore = makeupScore;
    }

    public String getGraduateMakeupScore() {
        return graduateMakeupScore;
    }

    public void setGraduateMakeupScore(String graduateMakeupScore) {
        this.graduateMakeupScore = graduateMakeupScore;
    }

    public String getExaminationStatus() {
        return examinationStatus;
    }

    public void setExaminationStatus(String examinationStatus) {
        this.examinationStatus = examinationStatus;
    }

    public String getTermId() {
        return termId;
    }

    public void setTermId(String termId) {
        this.termId = termId;
    }

    public String getMakeupStatus() {
        return makeupStatus;
    }

    public void setMakeupStatus(String makeupStatus) {
        this.makeupStatus = makeupStatus;
    }

    public String getGraduateMakeupStatus() {
        return graduateMakeupStatus;
    }

    public void setGraduateMakeupStatus(String graduateMakeupStatus) {
        this.graduateMakeupStatus = graduateMakeupStatus;
    }

    public String getTeacherDeptId() {
        return teacherDeptId;
    }

    public void setTeacherDeptId(String teacherDeptId) {
        this.teacherDeptId = teacherDeptId;
    }

    public String getTeacherPersonId() {
        return teacherPersonId;
    }

    public void setTeacherPersonId(String teacherPersonId) {
        this.teacherPersonId = teacherPersonId;
    }
}
