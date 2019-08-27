package com.goisan.educational.courseconstr.bean;


import com.goisan.system.bean.BaseBean;

public class CourseConstr extends BaseBean {

    private String classId;             //课程Id                                    //公告基础课程维护
    private String className;           //课程名称
    private String classTypes;          //课程类型
    private String courseProperties;    //课程属性
    private String prescribedPeriods;   //规定课时
    private String practiceClass;       //实践课时
    private String coreCurriculum;      //核心课程
    private String schoolEnterpriseCooperation;  //校企合作
    private String excellentCourse;              // 精品课程
    private String venue;                        //授课地点
    private String teachingMethod;               //授课方式
    private String testMethod;                   //考试方法
    private String classCertifiate;              //课证融通
    private String courseCode;                   //公共 or 专业信息查询  为1的为专业



    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getTeachingMethod() {
        return teachingMethod;
    }

    public void setTeachingMethod(String teachingMethod) {
        this.teachingMethod = teachingMethod;
    }

    public String getTestMethod() {
        return testMethod;
    }

    public void setTestMethod(String testMethod) {
        this.testMethod = testMethod;
    }

    public String getClassCertifiate() {
        return classCertifiate;
    }

    public void setClassCertifiate(String classCertifiate) {
        this.classCertifiate = classCertifiate;
    }

    public String getClassTypes() {
        return classTypes;
    }

    public void setClassTypes(String classTypes) {
        this.classTypes = classTypes;
    }

    public String getCourseProperties() {
        return courseProperties;
    }

    public void setCourseProperties(String courseProperties) {
        this.courseProperties = courseProperties;
    }

    public String getPrescribedPeriods() {
        return prescribedPeriods;
    }

    public void setPrescribedPeriods(String prescribedPeriods) {
        this.prescribedPeriods = prescribedPeriods;
    }

    public String getPracticeClass() {
        return practiceClass;
    }

    public void setPracticeClass(String practiceClass) {
        this.practiceClass = practiceClass;
    }

    public String getCoreCurriculum() {
        return coreCurriculum;
    }

    public void setCoreCurriculum(String coreCurriculum) {
        this.coreCurriculum = coreCurriculum;
    }

    public String getSchoolEnterpriseCooperation() {
        return schoolEnterpriseCooperation;
    }

    public void setSchoolEnterpriseCooperation(String schoolEnterpriseCooperation) {
        this.schoolEnterpriseCooperation = schoolEnterpriseCooperation;
    }

    public String getExcellentCourse() {
        return excellentCourse;
    }

    public void setExcellentCourse(String excellentCourse) {
        this.excellentCourse = excellentCourse;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }
}
