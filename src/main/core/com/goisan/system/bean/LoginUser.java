package com.goisan.system.bean;

import java.io.Serializable;
import java.util.List;
import java.util.Set;

/**
 * Created by Admin on 2017/4/15.
 */
public class LoginUser extends BaseBean implements Serializable {

    private String id;
    private String name;
    private String userAccount;
    private String personId;
    private String password;
    private String userType;
    private String userFlag;
    private String question;
    private String answer;
    private String defaultDeptId;
    private List<String> deptId;
    private Set<String> roles;
    private Set<String> permissions;
    private String photoName;
    private String photoUrl;
    private String photoType;
    private String siteBackground;
    private String siteContainer;

    public String getPhotoName() {
        return photoName;
    }

    public void setPhotoName(String photoName) {
        this.photoName = photoName;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

    public String getPhotoType() {
        return photoType;
    }

    public void setPhotoType(String photoType) {
        this.photoType = photoType;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getDefaultDeptId() {
        return defaultDeptId;
    }

    public void setDefaultDeptId(String defaultDeptId) {
        this.defaultDeptId = defaultDeptId;
    }

    public List<String> getDeptId() {
        return deptId;
    }

    public void setDeptId(List<String> deptId) {
        this.deptId = deptId;
    }

    public String getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(String userAccount) {
        this.userAccount = userAccount;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getUserFlag() {
        return userFlag;
    }

    public void setUserFlag(String userFlag) {
        this.userFlag = userFlag;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public Set<String> getRoles() {
        return roles;
    }

    public void setRoles(Set<String> roles) {
        this.roles = roles;
    }

    public Set<String> getPermissions() {
        return permissions;
    }

    public void setPermissions(Set<String> permissions) {
        this.permissions = permissions;
    }

    private String idCardPhotoUrl;

    public String getIdCardPhotoUrl() {
        return idCardPhotoUrl;
    }

    public void setIdCardPhotoUrl(String idCardPhotoUrl) {
        this.idCardPhotoUrl = idCardPhotoUrl;
    }

    public String getSiteBackground() {
        return siteBackground;
    }

    public void setSiteBackground(String siteBackground) {
        this.siteBackground = siteBackground;
    }

    public String getSiteContainer() {
        return siteContainer;
    }

    public void setSiteContainer(String siteContainer) {
        this.siteContainer = siteContainer;
    }
}