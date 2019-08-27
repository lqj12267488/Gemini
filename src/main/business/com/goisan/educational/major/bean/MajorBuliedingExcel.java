package com.goisan.educational.major.bean;

import java.util.List;

/**
 * @author 郭千恺
 * @version v1.0
 * @descroption 每个专业导出一个excel用
 * @date 2018/10/10 8:52
 */
public class MajorBuliedingExcel {
// Field ----------------------------------------
    private String majorId;                     // 专业id
    private String majorName;                   // 专业名称
    private List<MajorBuildingCmte> cmteList;   // 成员名单
// Method ----------------------------------------
    // Getters and setters
    public String getMajorId() {
        return majorId;
    }

    public void setMajorId(String majorId) {
        this.majorId = majorId;
    }

    public String getMajorName() {
        return majorName;
    }

    public void setMajorName(String majorName) {
        this.majorName = majorName;
    }

    public List<MajorBuildingCmte> getCmteList() {
        return cmteList;
    }

    public void setCmteList(List<MajorBuildingCmte> cmteList) {
        this.cmteList = cmteList;
    }
}
