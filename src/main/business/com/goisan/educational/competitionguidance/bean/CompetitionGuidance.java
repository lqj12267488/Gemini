package com.goisan.educational.competitionguidance.bean;

import com.goisan.system.bean.BaseBean;

public class CompetitionGuidance  extends BaseBean {
    private String id;
    private String teacherId;
    private String teacherName;//教师姓名
    private String departmentId;//所属系部
    private String departmentIdShow;
    private String competitionName;//竞赛项目
    private String competitionLevel;// 竞赛级别：	国家级、省级、市级、院级、其他
    private String hostUnit;//主办单位
    private String counsellingContent;//辅导内容：提示简写
    private String semester;//学    期：
    private String semesterShow;
    private String majorId;// 专    业：	字典项，从专业列表中选择专业，可多选
    private String classId;// 班    级：	可多选
    private String educationalLevel;// 学历层次
    private String competitionNumber;// 班级人数	核算多选班级的总人数
    private String trainingNumber;// 培训人数
    private String classHours;//    课 时 数
    private String place;//授课地点：
    private String competitionPerformance;//竞赛成绩：
    private String fileNumber;//竞赛成绩：
    private String fileUrl;
    private String deptId;

    public String getDepartmentIdShow() {
        return departmentIdShow;
    }

    public void setDepartmentIdShow(String departmentIdShow) {
        this.departmentIdShow = departmentIdShow;
    }

    public String getSemesterShow() {
        return semesterShow;
    }

    public void setSemesterShow(String semesterShow) {
        this.semesterShow = semesterShow;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getFileNumber() {
        return fileNumber;
    }

    public void setFileNumber(String fileNumber) {
        this.fileNumber = fileNumber;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    public String getCompetitionName() {
        return competitionName;
    }

    public void setCompetitionName(String competitionName) {
        this.competitionName = competitionName;
    }

    public String getCompetitionLevel() {
        return competitionLevel;
    }

    public void setCompetitionLevel(String competitionLevel) {
        this.competitionLevel = competitionLevel;
    }

    public String getHostUnit() {
        return hostUnit;
    }

    public void setHostUnit(String hostUnit) {
        this.hostUnit = hostUnit;
    }

    public String getCounsellingContent() {
        return counsellingContent;
    }

    public void setCounsellingContent(String counsellingContent) {
        this.counsellingContent = counsellingContent;
    }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public String getMajorId() {
        return majorId;
    }

    public void setMajorId(String majorId) {
        this.majorId = majorId;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getEducationalLevel() {
        return educationalLevel;
    }

    public void setEducationalLevel(String educationalLevel) {
        this.educationalLevel = educationalLevel;
    }

    public String getCompetitionNumber() {
        return competitionNumber;
    }

    public void setCompetitionNumber(String competitionNumber) {
        this.competitionNumber = competitionNumber;
    }

    public String getTrainingNumber() {
        return trainingNumber;
    }

    public void setTrainingNumber(String trainingNumber) {
        this.trainingNumber = trainingNumber;
    }

    public String getClassHours() {
        return classHours;
    }

    public void setClassHours(String classHours) {
        this.classHours = classHours;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public String getCompetitionPerformance() {
        return competitionPerformance;
    }

    public void setCompetitionPerformance(String competitionPerformance) {
        this.competitionPerformance = competitionPerformance;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    @Override
    public String toString() {
        return "CompetitionGuidance{" +
                "id='" + id + '\'' +
                ", teacherName='" + teacherName + '\'' +
                ", departmentId='" + departmentId + '\'' +
                ", competitionName='" + competitionName + '\'' +
                ", competitionLevel='" + competitionLevel + '\'' +
                ", hostUnit='" + hostUnit + '\'' +
                ", counsellingContent='" + counsellingContent + '\'' +
                ", semester='" + semester + '\'' +
                ", majorId='" + majorId + '\'' +
                ", classId='" + classId + '\'' +
                ", educationalLevel='" + educationalLevel + '\'' +
                ", competitionNumber='" + competitionNumber + '\'' +
                ", trainingNumber='" + trainingNumber + '\'' +
                ", classHours='" + classHours + '\'' +
                ", place='" + place + '\'' +
                ", competitionPerformance='" + competitionPerformance + '\'' +
                ", fileNumber='" + fileNumber + '\'' +
                ", fileUrl='" + fileUrl + '\'' +
                '}';
    }
}
