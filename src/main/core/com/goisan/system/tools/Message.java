package com.goisan.system.tools;

/**
 * Created by Admin on 2017/4/11.
 */
public class Message {
    private int status;
    private String msg;
    private Object result;

    public Message() {
    }

    public Message(int status, String msg, Object result) {
        this.status = status;
        this.msg = msg;
        this.result = result;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getResult() {
        return result;
    }

    public void setResult(Object result) {
        this.result = result;
    }
}
