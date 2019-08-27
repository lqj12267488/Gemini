package com.goisan.system.bean;

public class Result {
    private Integer state;
    private String msg;

    public Result(Integer state, String msg){
        this.state=state;
        this.msg=msg;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
