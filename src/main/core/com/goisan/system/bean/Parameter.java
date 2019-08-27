package com.goisan.system.bean;

public class Parameter extends BaseBean {
    private String id;
    private String parametername;
    private String parametercode;
    private String parametertype;
    private String parametervalue;

    public String getParametername() {
        return parametername;
    }

    public void setParametername(String parametername) {
        this.parametername = parametername;
    }

    public String getParametercode() {
        return parametercode;
    }

    public void setParametercode(String parametercode) {
        this.parametercode = parametercode;
    }

    public String getParametervalue() {
        return parametervalue;
    }

    public void setParametervalue(String parametervalue) {
        this.parametervalue = parametervalue;
    }

    public String getParametertype() {
        return parametertype;
    }

    public void setParametertype(String parametertype) {
        this.parametertype = parametertype;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
