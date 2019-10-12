package com.goisan.personnel.teachManageinfo.bean;

import com.goisan.system.bean.BaseBean;

public class TeachMgeInfo extends BaseBean {

    /**主键，使用uuid*/
    private String id;

    /**教职工id，使用uuid*/
    private String personId;

    /**银行卡号id*/
    private String bankId;

    /**一寸照有无{	yw}*/
    private String phone;

   private String phoneShow;

    /**身份证复印件有无{	yw}*/
    private String idcardCopy;

   private String idcardCopyShow;

    /**身份证期限*/
    private String idcardEndtime;

    /**户口有无{	yw}*/
    private String account;

   private String accountShow;

    /**毕业证有无{	yw}*/
    private String diploma;

   private String diplomaShow;

    /**学位证有无{	yw}*/
    private String degreeCert;

   private String degreeCertShow;

    /**解除劳动合同有无{yw}*/
    private String disContract;

   private String disContractShow;

    /**计算机{yw}*/
    private String computer;

   private String computerShow;

    /**英语{yw}*/
    private String english;

   private String englishShow;

    /**普通话{yw}*/
    private String putonghua;

   private String putonghuaShow;

    /**国语水平{yw}*/
    private String pthLevel;

   private String pthLevelShow;

    /**教师资格证{yw}*/
    private String teachCert;

   private String teachCertShow;

    /**其他资格证{yw}*/
    private String otherCert;

   private String otherCertShow;

    /**驾驶证{yw}*/
    private String driverCert;

   private String driverCertShow;

    /**电工证{yw}*/
    private String eleCert;

   private String eleCertShow;

    /**退休证{yw}*/
    private String retireCert;

   private String retireCertShow;

    /**退休证名{yw}*/
    private String retireProve;

   private String retireProveShow;

    /**外单位交社保证明{yw}*/
    private String extSsCert;

   private String extSsCertShow;

    /**人事档案{yw}*/
    private String personFile;

   private String personFileShow;

    /**其他资料{yw}*/
    private String otherInfo;

   private String otherInfoShow;



    private String deptId;

    private String deptShow;

    private String idcard;

    private String name;

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getDeptShow() {
        return deptShow;
    }

    public void setDeptShow(String deptShow) {
        this.deptShow = deptShow;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getBankId() {
        return bankId;
    }

    public void setBankId(String bankId) {
        this.bankId = bankId;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPhoneShow() {
        return phoneShow;
    }

    public void setPhoneShow(String phoneShow) {
        this.phoneShow = phoneShow;
    }

    public String getIdcardCopy() {
        return idcardCopy;
    }

    public void setIdcardCopy(String idcardCopy) {
        this.idcardCopy = idcardCopy;
    }

    public String getIdcardCopyShow() {
        return idcardCopyShow;
    }

    public void setIdcardCopyShow(String idcardCopyShow) {
        this.idcardCopyShow = idcardCopyShow;
    }

    public String getIdcardEndtime() {
        return idcardEndtime;
    }

    public void setIdcardEndtime(String idcardEndtime) {
        this.idcardEndtime = idcardEndtime;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getAccountShow() {
        return accountShow;
    }

    public void setAccountShow(String accountShow) {
        this.accountShow = accountShow;
    }

    public String getDiploma() {
        return diploma;
    }

    public void setDiploma(String diploma) {
        this.diploma = diploma;
    }

    public String getDiplomaShow() {
        return diplomaShow;
    }

    public void setDiplomaShow(String diplomaShow) {
        this.diplomaShow = diplomaShow;
    }

    public String getDegreeCert() {
        return degreeCert;
    }

    public void setDegreeCert(String degreeCert) {
        this.degreeCert = degreeCert;
    }

    public String getDegreeCertShow() {
        return degreeCertShow;
    }

    public void setDegreeCertShow(String degreeCertShow) {
        this.degreeCertShow = degreeCertShow;
    }

    public String getDisContract() {
        return disContract;
    }

    public void setDisContract(String disContract) {
        this.disContract = disContract;
    }

    public String getDisContractShow() {
        return disContractShow;
    }

    public void setDisContractShow(String disContractShow) {
        this.disContractShow = disContractShow;
    }

    public String getComputer() {
        return computer;
    }

    public void setComputer(String computer) {
        this.computer = computer;
    }

    public String getComputerShow() {
        return computerShow;
    }

    public void setComputerShow(String computerShow) {
        this.computerShow = computerShow;
    }

    public String getEnglish() {
        return english;
    }

    public void setEnglish(String english) {
        this.english = english;
    }

    public String getEnglishShow() {
        return englishShow;
    }

    public void setEnglishShow(String englishShow) {
        this.englishShow = englishShow;
    }

    public String getPutonghua() {
        return putonghua;
    }

    public void setPutonghua(String putonghua) {
        this.putonghua = putonghua;
    }

    public String getPutonghuaShow() {
        return putonghuaShow;
    }

    public void setPutonghuaShow(String putonghuaShow) {
        this.putonghuaShow = putonghuaShow;
    }

    public String getPthLevel() {
        return pthLevel;
    }

    public void setPthLevel(String pthLevel) {
        this.pthLevel = pthLevel;
    }

    public String getPthLevelShow() {
        return pthLevelShow;
    }

    public void setPthLevelShow(String pthLevelShow) {
        this.pthLevelShow = pthLevelShow;
    }

    public String getTeachCert() {
        return teachCert;
    }

    public void setTeachCert(String teachCert) {
        this.teachCert = teachCert;
    }

    public String getTeachCertShow() {
        return teachCertShow;
    }

    public void setTeachCertShow(String teachCertShow) {
        this.teachCertShow = teachCertShow;
    }

    public String getOtherCert() {
        return otherCert;
    }

    public void setOtherCert(String otherCert) {
        this.otherCert = otherCert;
    }

    public String getOtherCertShow() {
        return otherCertShow;
    }

    public void setOtherCertShow(String otherCertShow) {
        this.otherCertShow = otherCertShow;
    }

    public String getDriverCert() {
        return driverCert;
    }

    public void setDriverCert(String driverCert) {
        this.driverCert = driverCert;
    }

    public String getDriverCertShow() {
        return driverCertShow;
    }

    public void setDriverCertShow(String driverCertShow) {
        this.driverCertShow = driverCertShow;
    }

    public String getEleCert() {
        return eleCert;
    }

    public void setEleCert(String eleCert) {
        this.eleCert = eleCert;
    }

    public String getEleCertShow() {
        return eleCertShow;
    }

    public void setEleCertShow(String eleCertShow) {
        this.eleCertShow = eleCertShow;
    }

    public String getRetireCert() {
        return retireCert;
    }

    public void setRetireCert(String retireCert) {
        this.retireCert = retireCert;
    }

    public String getRetireCertShow() {
        return retireCertShow;
    }

    public void setRetireCertShow(String retireCertShow) {
        this.retireCertShow = retireCertShow;
    }

    public String getRetireProve() {
        return retireProve;
    }

    public void setRetireProve(String retireProve) {
        this.retireProve = retireProve;
    }

    public String getRetireProveShow() {
        return retireProveShow;
    }

    public void setRetireProveShow(String retireProveShow) {
        this.retireProveShow = retireProveShow;
    }

    public String getExtSsCert() {
        return extSsCert;
    }

    public void setExtSsCert(String extSsCert) {
        this.extSsCert = extSsCert;
    }

    public String getExtSsCertShow() {
        return extSsCertShow;
    }

    public void setExtSsCertShow(String extSsCertShow) {
        this.extSsCertShow = extSsCertShow;
    }

    public String getPersonFile() {
        return personFile;
    }

    public void setPersonFile(String personFile) {
        this.personFile = personFile;
    }

    public String getPersonFileShow() {
        return personFileShow;
    }

    public void setPersonFileShow(String personFileShow) {
        this.personFileShow = personFileShow;
    }

    public String getOtherInfo() {
        return otherInfo;
    }

    public void setOtherInfo(String otherInfo) {
        this.otherInfo = otherInfo;
    }

    public String getOtherInfoShow() {
        return otherInfoShow;
    }

    public void setOtherInfoShow(String otherInfoShow) {
        this.otherInfoShow = otherInfoShow;
    }

}
