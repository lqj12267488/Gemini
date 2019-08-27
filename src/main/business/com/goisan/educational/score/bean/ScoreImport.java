package com.goisan.educational.score.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/10/14.
 */
public class ScoreImport extends BaseBean {
    private String id;//主键id
    private String scoreClassId;//考试班级录入id
    private String subjectId;//考试课程录入id
    private String departmentsId;//系部
    private String majorCode;//专业代码
    private String majorDirection;//专业方向
    private String trainingLevel;//培养层次
    private String planId;//教学计划
    private String scoreExamId;//考试id
    private String scoreExamName;//考试名称
    private String className;
    private String courseName;
    private String classId;//班级
    private String courseId;//课程
    private String courseShow;//课程
    private String personId;//录入教师
    private String studentId;//学生id
    private String studentName;//学生姓名
    private String score;//考试成绩
    private String makeupScore;//补考成绩
    private String graduateMakeupScore;//毕业补考成绩
    private String examinationStatus;//考试状态
    private String termId;//学期
    private String termShow;
    private String makeupStatus;//补考状态
    private String graduateMakeupStatus;//毕业补考状态
    private String totalScore;
    private String passScore;
    private String courseValue;
    private String birthday;
    private String sex;
    private String entranceTime;
    private String graduationTime;
    private String term;
    private String course;
    private String courseFlag;
    private String examinationStatusValue;
    private String afertGraduateMakeupScore;//毕业补考成绩
    private String afertGraduateMakeupStatus;//毕业补考状态
    private String examTime;//考试时间
    private String peacetimeScoreA;
    private String peacetimeScoreB;
    private String peacetimeScoreC;
    private String peacetimeScoreD;
    private String examMethod;
    private String scoreSum;
    private String scoreType;
    private String teachingTeacherId;
    private String classShow;
    private String openFlag = "0";

    private String examTypes;
    private String finalScore;
    private String finalMakeupScore;
    private String finalBeforeMakeupScore;

    private String finalExaminationStatus;
    private String finalMakeupExaminationStatus;
    private String finalBeforeMakeupExaminationStatus;
    private String studentNum;
    private String generalComment;//总评
    private String startTime;
    private String endTime;
    private String classType;
    private String uploadTime;
    private String submitFlag;
    private String graduationYears; //毕业年限
    private String orderExamFlag;
//    查询使用
    private String qyeryExamMethod;

//    考试成绩
    private String examScore;

    public String getExamScore() {
        return examScore;
    }

    public void setExamScore(String examScore) {
        this.examScore = examScore;
    }

    public String getQyeryExamMethod() {
        return qyeryExamMethod;
    }

    public void setQyeryExamMethod(String qyeryExamMethod) {
        this.qyeryExamMethod = qyeryExamMethod;
    }

    public String getSubmitFlag() {
        return submitFlag;
    }

    public void setSubmitFlag(String submitFlag) {
        this.submitFlag = submitFlag;
    }

    public String getClassType() {
        return classType;
    }

    public void setClassType(String classType) {
        this.classType = classType;
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

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getGraduationYears() {
        return graduationYears;
    }

    public String getExamMethod() {
        return examMethod;
    }

    public void setExamMethod(String examMethod) {
        this.examMethod = examMethod;
    }

    public String getScoreSum() {
        return scoreSum;
    }

    public void setScoreSum(String scoreSum) {
        this.scoreSum = scoreSum;
    }

    public String getCourseShow() {
        return courseShow;
    }

    public void setCourseShow(String courseShow) {
        this.courseShow = courseShow;
    }

    public String getPeacetimeScoreA() {
        return peacetimeScoreA;
    }

    public void setPeacetimeScoreA(String peacetimeScoreA) {
        this.peacetimeScoreA = peacetimeScoreA;
    }

    public String getPeacetimeScoreB() {
        return peacetimeScoreB;
    }

    public void setPeacetimeScoreB(String peacetimeScoreB) {
        this.peacetimeScoreB = peacetimeScoreB;
    }

    public String getPeacetimeScoreC() {
        return peacetimeScoreC;
    }

    public void setPeacetimeScoreC(String peacetimeScoreC) {
        this.peacetimeScoreC = peacetimeScoreC;
    }

    public String getPeacetimeScoreD() {
        return peacetimeScoreD;
    }

    public void setPeacetimeScoreD(String peacetimeScoreD) {
        this.peacetimeScoreD = peacetimeScoreD;
    }

    public String getExamTime() {
        return examTime;
    }

    public void setExamTime(String examTime) {
        this.examTime = examTime;
    }

    public String getAfertGraduateMakeupScore() {
        return afertGraduateMakeupScore;
    }

    public void setAfertGraduateMakeupScore(String afertGraduateMakeupScore) {
        this.afertGraduateMakeupScore = afertGraduateMakeupScore;
    }

    public String getAfertGraduateMakeupStatus() {
        return afertGraduateMakeupStatus;
    }

    public void setAfertGraduateMakeupStatus(String afertGraduateMakeupStatus) {
        this.afertGraduateMakeupStatus = afertGraduateMakeupStatus;
    }

    public String getExaminationStatusValue() {
        return examinationStatusValue;
    }

    public void setExaminationStatusValue(String examinationStatusValue) {
        this.examinationStatusValue = examinationStatusValue;
    }

    public String getCourseFlag() {
        return courseFlag;
    }

    public void setCourseFlag(String courseFlag) {
        this.courseFlag = courseFlag;
    }

    public String getCourseValue() {
        return courseValue;
    }

    public void setCourseValue(String courseValue) {
        this.courseValue = courseValue;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
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

    public String getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(String totalScore) {
        this.totalScore = totalScore;
    }

    public String getPassScore() {
        return passScore;
    }

    public void setPassScore(String passScore) {
        this.passScore = passScore;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getEntranceTime() {
        return entranceTime;
    }

    public void setEntranceTime(String entranceTime) {
        this.entranceTime = entranceTime;
    }

    public String getGraduationTime() {
        return graduationTime;
    }

    public void setGraduationTime(String graduationTime) {
        this.graduationTime = graduationTime;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getTermShow() {
        return termShow;
    }

    public void setTermShow(String termShow) {
        this.termShow = termShow;
    }

    public String getScoreType() {
        return scoreType;
    }

    public void setScoreType(String scoreType) {
        this.scoreType = scoreType;
    }

    public String getTeachingTeacherId() {
        return teachingTeacherId;
    }

    public void setTeachingTeacherId(String teachingTeacherId) {
        this.teachingTeacherId = teachingTeacherId;
    }

    public String getFinalScore() {
        return finalScore;
    }

    public void setFinalScore(String finalScore) {
        this.finalScore = finalScore;
    }

    public String getFinalMakeupScore() {
        return finalMakeupScore;
    }

    public void setFinalMakeupScore(String finalMakeupScore) {
        this.finalMakeupScore = finalMakeupScore;
    }

    public String getFinalBeforeMakeupScore() {
        return finalBeforeMakeupScore;
    }

    public void setFinalBeforeMakeupScore(String finalBeforeMakeupScore) {
        this.finalBeforeMakeupScore = finalBeforeMakeupScore;
    }

    public String getExamTypes() {
        return examTypes;
    }

    public void setExamTypes(String examTypes) {
        this.examTypes = examTypes;
    }

    public String getFinalExaminationStatus() {
        return finalExaminationStatus;
    }

    public void setFinalExaminationStatus(String finalExaminationStatus) {
        this.finalExaminationStatus = finalExaminationStatus;
    }

    public String getFinalMakeupExaminationStatus() {
        return finalMakeupExaminationStatus;
    }

    public void setFinalMakeupExaminationStatus(String finalMakeupExaminationStatus) {
        this.finalMakeupExaminationStatus = finalMakeupExaminationStatus;
    }

    public String getFinalBeforeMakeupExaminationStatus() {
        return finalBeforeMakeupExaminationStatus;
    }

    public void setFinalBeforeMakeupExaminationStatus(String finalBeforeMakeupExaminationStatus) {
        this.finalBeforeMakeupExaminationStatus = finalBeforeMakeupExaminationStatus;
    }

    public String getClassShow() {
        return classShow;
    }

    public void setClassShow(String classShow) {
        this.classShow = classShow;
    }

    public String getOpenFlag() {
        return openFlag;
    }

    public void setOpenFlag(String openFlag) {
        this.openFlag = openFlag;
    }

    public String getStudentNum() {
        return studentNum;
    }

    public void setStudentNum(String studentNum) {
        this.studentNum = studentNum;
    }

    public String getGeneralComment() {
        return generalComment;
    }

    public String getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(String uploadTime) {
        this.uploadTime = uploadTime;
    }

    public void setGeneralComment(String generalComment) {
        this.generalComment = generalComment;
    }

    public void setGraduationYears(String graduationYears) {
        this.graduationYears = graduationYears;
    }

    public String getOrderExamFlag() {
        return orderExamFlag;
    }

    public void setOrderExamFlag(String orderExamFlag) {
        this.orderExamFlag = orderExamFlag;
    }
}
