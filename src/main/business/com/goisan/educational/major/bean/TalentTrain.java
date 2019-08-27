package com.goisan.educational.major.bean;

import com.goisan.system.bean.BaseBean;

import java.sql.Date;

/**
 * Created by admin on 2017/5/18.
 */
public class TalentTrain extends BaseBean {
    private String id;
    private String planId;              //计划ID
    private String departmentsId;
    private String trainingLevel;
    //系部
    private String departmentsIdShow;
    private String majorId;             //专业ID
    private String majorIdShow;
    private String yearType;            //年份
    private String trainPlan;           //培养方案
    private String planName;            //方案名称
    private String trainName;
    private String requestFlag;         //审批流程
    private String teamTeacher;         //团队负责人
    private String teamPerson;          //团队成员
    private String getDate;             //获批时间
    private String getName;             //获得荣誉或称号
    private String remark;
    // 补充字段
    private String majorCode;           // 专业代码
    private String teamLevelCode;       // 级别
    private String teamLevelShow;
    private Integer leaderNum;          // 负责人数量
    private Integer memberNum;          // 成员数量(不含负责人)
    //导出需要的字段
    private String dname,dsex,dbirthday,dworkdept,dzhiwu,dzhicheng,ptype;
    //姓名，性别，生日，工作单位，职务，职称,人员类型

    //第四次修改补充字段 培养模式
    private String trainMode;
    //第四次修改补充字段 学制
    private String schoolSystem;
    //第四次修改补充字段 适用学院
    private String suitSchool;
    //第四次修改补充字段 执行年级
    private String actionGrade;
    //第四次修改补充字段 教学活动时间安排表文件id或者名字：存数据库为文件id，查数据库为文件名字，同下
    private String teachFile11;
    //第四次修改补充字段 实践教学活动安排表
    private String practiceFile;
    //第四次修改补充字段 课程设置、教学进度计划及课时分配表
    private String distributeFile;
    //第四次修改补充字段 上传时间
    private String uploadTime;
    //第四次修改 添加字段 3个文件上传时间
    private Date teachFileTime;
    private Date practiceFileTime;
    private Date distributeFileTime;

    //第四次修改 添加字段 文件类型
    private String teachFileType;
    private String practiceFileType;
    private  String distributeFileType;

    private String creator;
    //上一次审核状态
    private String lastStatus;

    //文件名称
    private String teachFileName;
    private String practiceFileName;
    private String distributeFileName;

    public String getLastStatus() {
        return lastStatus;
    }

    public void setLastStatus(String lastStatus) {
        this.lastStatus = lastStatus;
    }

    @Override
    public String getCreator() {
        return creator;
    }

    @Override
    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getTeachFileType() {
        return teachFileType;
    }

    public void setTeachFileType(String teachFileType) {
        this.teachFileType = teachFileType;
    }

    public String getPracticeFileType() {
        return practiceFileType;
    }

    public void setPracticeFileType(String practiceFileType) {
        this.practiceFileType = practiceFileType;
    }

    public String getDistributeFileType() {
        return distributeFileType;
    }

    public void setDistributeFileType(String distributeFileType) {
        this.distributeFileType = distributeFileType;
    }


    public Date getTeachFileTime() {
        return teachFileTime;
    }

    public void setTeachFileTime(Date teachFileTime) {
        this.teachFileTime = teachFileTime;
    }

    public Date getPracticeFileTime() {
        return practiceFileTime;
    }

    public void setPracticeFileTime(Date practiceFileTime) {
        this.practiceFileTime = practiceFileTime;
    }

    public Date getDistributeFileTime() {
        return distributeFileTime;
    }

    public void setDistributeFileTime(Date distributeFileTime) {
        this.distributeFileTime = distributeFileTime;
    }

    public String getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(String uploadTime) {
        this.uploadTime = uploadTime;
    }

    public String getTeachFile11() {
        return teachFile11;
    }

    public void setTeachFile11(String teachFile11) {
        this.teachFile11 = teachFile11;
    }

    public String getPracticeFile() {
        return practiceFile;
    }

    public void setPracticeFile(String practiceFile) {
        this.practiceFile = practiceFile;
    }

    public String getDistributeFile() {
        return distributeFile;
    }

    public void setDistributeFile(String distributeFile) {
        this.distributeFile = distributeFile;
    }

    public String getActionGrade() {
        return actionGrade;
    }

    public void setActionGrade(String actionGrade) {
        this.actionGrade = actionGrade;
    }

    public String getSuitSchool() {
        return suitSchool;
    }

    public void setSuitSchool(String suitSchool) {
        this.suitSchool = suitSchool;
    }

    public String getSchoolSystem() {
        return schoolSystem;
    }

    public void setSchoolSystem(String schoolSystem) {
        this.schoolSystem = schoolSystem;
    }

    public String getTrainMode() {
        return trainMode;
    }

    public void setTrainMode(String trainMode) {
        this.trainMode = trainMode;
    }

    public String getTrainingLevel() {
        return trainingLevel;
    }

    public void setTrainingLevel(String trainingLevel) {
        this.trainingLevel = trainingLevel;
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

    public String getDepartmentsIdShow() {
        return departmentsIdShow;
    }

    public void setDepartmentsIdShow(String departmentsIdShow) {
        this.departmentsIdShow = departmentsIdShow;
    }

    public String getMajorId() {
        return majorId;
    }

    public void setMajorId(String majorId) {
        this.majorId = majorId;
    }

    public String getYearType() {
        return yearType;
    }

    public void setYearType(String yearType) {
        this.yearType = yearType;
    }

    public String getTrainPlan() {
        return trainPlan;
    }

    public void setTrainPlan(String trainPlan) {
        this.trainPlan = trainPlan;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public String getRequestFlag() {
        return requestFlag;
    }

    public void setRequestFlag(String requestFlag) {
        this.requestFlag = requestFlag;
    }

    public String getMajorIdShow() {
        return majorIdShow;
    }

    public void setMajorIdShow(String majorIdShow) {
        this.majorIdShow = majorIdShow;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getTrainName() {
        return trainName;
    }

    public void setTrainName(String trainName) {
        this.trainName = trainName;
    }

    public String getTeamTeacher() {
        return teamTeacher;
    }

    public void setTeamTeacher(String teamTeacher) {
        this.teamTeacher = teamTeacher;
    }

    public String getTeamPerson() {
        return teamPerson;
    }

    public void setTeamPerson(String teamPerson) {
        this.teamPerson = teamPerson;
    }

    public String getGetDate() {
        return getDate;
    }

    public void setGetDate(String getDate) {
        this.getDate = getDate;
    }

    public String getGetName() {
        return getName;
    }

    public void setGetName(String getName) {
        this.getName = getName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getMajorCode() {
        return majorCode;
    }

    public void setMajorCode(String majorCode) {
        this.majorCode = majorCode;
    }

    public String getTeamLevelCode() {
        return teamLevelCode;
    }

    public void setTeamLevelCode(String teamLevelCode) {
        this.teamLevelCode = teamLevelCode;
    }

    public String getTeamLevelShow() {
        return teamLevelShow;
    }

    public void setTeamLevelShow(String teamLevelShow) {
        this.teamLevelShow = teamLevelShow;
    }

    public Integer getLeaderNum() {
        return leaderNum;
    }

    public void setLeaderNum(Integer leaderNum) {
        this.leaderNum = leaderNum;
    }

    public Integer getMemberNum() {
        return memberNum;
    }

    public void setMemberNum(Integer memberNum) {
        this.memberNum = memberNum;
    }

    public String getDname() {
        return dname;
    }

    public void setDname(String dname) {
        this.dname = dname;
    }

    public String getDsex() {
        return dsex;
    }

    public void setDsex(String dsex) {
        this.dsex = dsex;
    }

    public String getDbirthday() {
        return dbirthday;
    }

    public void setDbirthday(String dbirthday) {
        this.dbirthday = dbirthday;
    }

    public String getDworkdept() {
        return dworkdept;
    }

    public void setDworkdept(String dworkdept) {
        this.dworkdept = dworkdept;
    }

    public String getDzhiwu() {
        return dzhiwu;
    }

    public void setDzhiwu(String dzhiwu) {
        this.dzhiwu = dzhiwu;
    }

    public String getDzhicheng() {
        return dzhicheng;
    }

    public void setDzhicheng(String dzhicheng) {
        this.dzhicheng = dzhicheng;
    }

    public String getPtype() {
        return ptype;
    }

    public void setPtype(String ptype) {
        this.ptype = ptype;
    }

    public String getTeachFileName() {
        return teachFileName;
    }

    public void setTeachFileName(String teachFileName) {
        this.teachFileName = teachFileName;
    }

    public String getPracticeFileName() {
        return practiceFileName;
    }

    public void setPracticeFileName(String practiceFileName) {
        this.practiceFileName = practiceFileName;
    }

    public String getDistributeFileName() {
        return distributeFileName;
    }

    public void setDistributeFileName(String distributeFileName) {
        this.distributeFileName = distributeFileName;
    }
}
