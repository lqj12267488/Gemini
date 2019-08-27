package com.goisan.educational.major.bean;

import com.goisan.system.bean.BaseBean;

/**
 * @author 郭千恺
 * @version v1.0
 * @descroption 专业建设指导委员会
 * @date 2018/9/30 9:48
 */
public class MajorBuildingCmte extends BaseBean {
// Field ----------------------------------------
    private String id;              // 主键
    private String majorId;         // 专业代码
    private String majorShow;       // 专业名称显示
    private String cmtePost;        // 专业建设指导委员会职务
    private String personId;        // 人员id
    private String teacherName;     // 姓名显示
    private String workUnit;        // 工作单位
    private String teacherPost;     // 职务
    private String teacherTitle;    // 职称
    private String telephone;       // 电话
    private String departmentsId;   //系部
// Method ----------------------------------------
    // Getters and setters

    public String getDepartmentsId() {
        return departmentsId;
    }

    public void setDepartmentsId(String departmentsId) {
        this.departmentsId = departmentsId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMajorId() {
        return majorId;
    }

    public void setMajorId(String majorId) {
        this.majorId = majorId;
    }

    public String getMajorShow() {
        return majorShow;
    }

    public void setMajorShow(String majorShow) {
        this.majorShow = majorShow;
    }

    public String getCmtePost() {
        return cmtePost;
    }

    public void setCmtePost(String cmtePost) {
        this.cmtePost = cmtePost;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getWorkUnit() {
        return workUnit;
    }

    public void setWorkUnit(String workUnit) {
        this.workUnit = workUnit;
    }

    public String getTeacherPost() {
        return teacherPost;
    }

    public void setTeacherPost(String teacherPost) {
        this.teacherPost = teacherPost;
    }

    public String getTeacherTitle() {
        return teacherTitle;
    }

    public void setTeacherTitle(String teacherTitle) {
        this.teacherTitle = teacherTitle;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }
}
