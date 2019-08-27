package com.goisan.synergy.workflow.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by Administrator on 2017/5/17.
 */
public class DeviceUseSupplies extends BaseBean {
    private String id;
    private String diccode;
    private String dicname;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDiccode() {
        return diccode;
    }

    public void setDiccode(String diccode) {
        this.diccode = diccode;
    }

    public String getDicname() {
        return dicname;
    }

    public void setDicname(String dicname) {
        this.dicname = dicname;
    }

}
