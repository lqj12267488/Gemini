package com.goisan.system.bean;

import java.util.Map;

public class CommonBean {

    public static Map<String,String> globalParamMap;

    /**
     * 全局参数
     */
    public static  String getParamValue (String param_name) {
        return globalParamMap.get(param_name);
    }
}
