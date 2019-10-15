package com.goisan.table.bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.goisan.system.bean.BaseBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class StudentDocuments extends BaseBean {

    /**主键使用uuid*/
    private String id;

    /**序号*/
    private String ordernumber;

    /**文件名称及文号*/
    private String filename;

    /**发布日期*/
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
    private Date releasedate;

    /**发布部门*/
    private String releasedept;

    /**变更情况*/
    private String alteration;

    /**变更日期*/
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
    private Date alterationdate;

    /**负责部门*/
    private String responsibledept;

    private String releasedateStr;

    private String alterationdateStr;

    private String groupNameSel;

    public String getGroupNameSel() {
        return groupNameSel;
    }

    public void setGroupNameSel(String groupNameSel) {
        this.groupNameSel = groupNameSel;
    }

    public String getReleasedateStr() {
        return releasedateStr;
    }

    public void setReleasedateStr(String releasedateStr) {
        this.releasedateStr = releasedateStr;
    }

    public String getAlterationdateStr() {
        return alterationdateStr;
    }

    public void setAlterationdateStr(String alterationdateStr) {
        this.alterationdateStr = alterationdateStr;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOrdernumber() {
        return ordernumber;
    }

    public void setOrdernumber(String ordernumber) {
        this.ordernumber = ordernumber;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }



    public String getReleasedept() {
        return releasedept;
    }

    public void setReleasedept(String releasedept) {
        this.releasedept = releasedept;
    }

    public String getAlteration() {
        return alteration;
    }

    public void setAlteration(String alteration) {
        this.alteration = alteration;
    }

    public Date getReleasedate() {
        return releasedate;
    }

    public void setReleasedate(Date releasedate) {
        this.releasedate = releasedate;
    }

    public Date getAlterationdate() {
        return alterationdate;
    }

    public void setAlterationdate(Date alterationdate) {
        this.alterationdate = alterationdate;
    }

    public String getResponsibledept() {
        return responsibledept;
    }

    public void setResponsibledept(String responsibledept) {
        this.responsibledept = responsibledept;
    }

}
