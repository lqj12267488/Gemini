package com.goisan.studentwork.maintenance.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created  By hanjie ON 2019/9/2
 * 维护类型
 */
public class MtType extends BaseBean {

    private String mtId;
    private String mtName;


    public String getMtId() {
        return mtId;
    }

    public void setMtId(String mtId) {
        this.mtId = mtId;
    }

    public String getMtName() {
        return mtName;
    }

    public void setMtName(String mtName) {
        this.mtName = mtName;
    }
}
