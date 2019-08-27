package com.goisan.educational.arrayclass.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by hanyu on 2017/8/28.
 */
public class StudentArrayClassLook extends BaseBean {
    private String id;//主键id
    private String arrayclassId;//排课ID
    private String arrayId;//排课安排ID
    private String studentId;//学生ID
    private String departmentsId;//系部ID
    private String majorCode;//专业代码
    private String majorDirection;//专业方向
    private String trainingLevel;//培养层次
    private String classId;//班级ID
    private String courseType;//课程类型，使用KCLX字典
    private String courseId;//课程ID
    private String roomId;//教室ID
    private String teacherPersonId;//授课教师人员ID
    private String teacherDeptId;//授课教师组织机构ID
    private String weekType;//学周，使用XZLX字典，0每周 1单周  2双周
    private String startWeek;//开始学周（包含）
    private String endWeek;//结束学周（包含）
    private String hours;//学时数
    private String connectHours;//相连课时数，不得大于每周课时数
    private String mergeFlag;//合班分组标识，使用HBFZ字典
    private String week;//星期，使用XZQ字典
    private String hoursType;//学时类型，使用PKXSLX字典
    private String hoursCode;//学时编码
    private String arrayclassFlag;//排课状态，使用PKZT字典，0未排，1已排
    private String weekTypeShow;
    private String margeFlagShow;
    private String weekShow;
    private String hoursTypeShow;
    private String arrayclassFlagShow;
    private String studentIdShow;
    private String departmentsIdShow;
    private String majorCodeShow;
    private String majorDriectionShow;
    private String trainingLevelShow;
    private String classIdShow;
    private String courseTypeShow;
    private String courseIdShow;
    private String roomIdShow;
    private String teacherPersonIdShow;
    private String term;

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

    public String getArrayId() {
        return arrayId;
    }

    public void setArrayId(String arrayId) {
        this.arrayId = arrayId;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
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

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getCourseType() {
        return courseType;
    }

    public void setCourseType(String courseType) {
        this.courseType = courseType;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getTeacherPersonId() {
        return teacherPersonId;
    }

    public void setTeacherPersonId(String teacherPersonId) {
        this.teacherPersonId = teacherPersonId;
    }

    public String getTeacherDeptId() {
        return teacherDeptId;
    }

    public void setTeacherDeptId(String teacherDeptId) {
        this.teacherDeptId = teacherDeptId;
    }

    public String getWeekType() {
        return weekType;
    }

    public void setWeekType(String weekType) {
        this.weekType = weekType;
    }

    public String getStartWeek() {
        return startWeek;
    }

    public void setStartWeek(String startWeek) {
        this.startWeek = startWeek;
    }

    public String getEndWeek() {
        return endWeek;
    }

    public void setEndWeek(String endWeek) {
        this.endWeek = endWeek;
    }

    public String getHours() {
        return hours;
    }

    public void setHours(String hours) {
        this.hours = hours;
    }

    public String getConnectHours() {
        return connectHours;
    }

    public void setConnectHours(String connectHours) {
        this.connectHours = connectHours;
    }

    public String getMergeFlag() {
        return mergeFlag;
    }

    public void setMergeFlag(String mergeFlag) {
        this.mergeFlag = mergeFlag;
    }

    public String getWeek() {
        return week;
    }

    public void setWeek(String week) {
        this.week = week;
    }

    public String getHoursType() {
        return hoursType;
    }

    public void setHoursType(String hoursType) {
        this.hoursType = hoursType;
    }

    public String getHoursCode() {
        return hoursCode;
    }

    public void setHoursCode(String hoursCode) {
        this.hoursCode = hoursCode;
    }

    public String getArrayclassFlag() {
        return arrayclassFlag;
    }

    public void setArrayclassFlag(String arrayclassFlag) {
        this.arrayclassFlag = arrayclassFlag;
    }

    public String getWeekTypeShow() {
        return weekTypeShow;
    }

    public void setWeekTypeShow(String weekTypeShow) {
        this.weekTypeShow = weekTypeShow;
    }

    public String getMargeFlagShow() {
        return margeFlagShow;
    }

    public void setMargeFlagShow(String margeFlagShow) {
        this.margeFlagShow = margeFlagShow;
    }

    public String getWeekShow() {
        return weekShow;
    }

    public void setWeekShow(String weekShow) {
        this.weekShow = weekShow;
    }

    public String getHoursTypeShow() {
        return hoursTypeShow;
    }

    public void setHoursTypeShow(String hoursTypeShow) {
        this.hoursTypeShow = hoursTypeShow;
    }

    public String getArrayclassFlagShow() {
        return arrayclassFlagShow;
    }

    public void setArrayclassFlagShow(String arrayclassFlagShow) {
        this.arrayclassFlagShow = arrayclassFlagShow;
    }

    public String getStudentIdShow() {
        return studentIdShow;
    }

    public void setStudentIdShow(String studentIdShow) {
        this.studentIdShow = studentIdShow;
    }

    public String getDepartmentsIdShow() {
        return departmentsIdShow;
    }

    public void setDepartmentsIdShow(String departmentsIdShow) {
        this.departmentsIdShow = departmentsIdShow;
    }

    public String getMajorCodeShow() {
        return majorCodeShow;
    }

    public void setMajorCodeShow(String majorCodeShow) {
        this.majorCodeShow = majorCodeShow;
    }

    public String getMajorDriectionShow() {
        return majorDriectionShow;
    }

    public void setMajorDriectionShow(String majorDriectionShow) {
        this.majorDriectionShow = majorDriectionShow;
    }

    public String getTrainingLevelShow() {
        return trainingLevelShow;
    }

    public void setTrainingLevelShow(String trainingLevelShow) {
        this.trainingLevelShow = trainingLevelShow;
    }

    public String getClassIdShow() {
        return classIdShow;
    }

    public void setClassIdShow(String classIdShow) {
        this.classIdShow = classIdShow;
    }

    public String getCourseTypeShow() {
        return courseTypeShow;
    }

    public void setCourseTypeShow(String courseTypeShow) {
        this.courseTypeShow = courseTypeShow;
    }

    public String getCourseIdShow() {
        return courseIdShow;
    }

    public void setCourseIdShow(String courseIdShow) {
        this.courseIdShow = courseIdShow;
    }

    public String getRoomIdShow() {
        return roomIdShow;
    }

    public void setRoomIdShow(String roomIdShow) {
        this.roomIdShow = roomIdShow;
    }

    public String getTeacherPersonIdShow() {
        return teacherPersonIdShow;
    }

    public void setTeacherPersonIdShow(String teacherPersonIdShow) {
        this.teacherPersonIdShow = teacherPersonIdShow;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }
}
