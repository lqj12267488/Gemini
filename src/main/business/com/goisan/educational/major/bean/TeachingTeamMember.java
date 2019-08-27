package com.goisan.educational.major.bean;

import com.goisan.system.bean.BaseBean;

/**
 * @author 郭千恺
 * @version v1.0
 * @descroption
 * @date 2018/10/11 8:45
 */
public class TeachingTeamMember extends BaseBean {
// Field ----------------------------------------
    private String id;          // 主键
    private String teamId;      // 团队id
    private String personId;    // 人员id
    private String deptId;     // 部门id
    private String memberType;  // 人员类型:1:负责人;2:成员
    // 仅回显用
    private String name;        // 姓名
    private String sex;         // 性别
    private String birth;       // 生日
    private String workUnit;    // 工作单位
    private String post;        // 职务
    private String title;       // 职称
// Method ----------------------------------------
    // Getters and setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTeamId() {
        return teamId;
    }

    public void setTeamId(String teamId) {
        this.teamId = teamId;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getMemberType() {
        return memberType;
    }

    public void setMemberType(String memberType) {
        this.memberType = memberType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth;
    }

    public String getWorkUnit() {
        return workUnit;
    }

    public void setWorkUnit(String workUnit) {
        this.workUnit = workUnit;
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
