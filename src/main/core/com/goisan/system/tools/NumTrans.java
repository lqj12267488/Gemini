package com.goisan.system.tools;

import java.util.Scanner;

public class NumTrans {

    private static Scanner sc ;

    private static String input;

    private static String[] units = {"", "十", "百", "千", "万", "十", "百", "千", "亿"};

    private static String[] nums = {"零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十"};

    private static String[] result;

    public static String get(String input) {
        String out = "";
        result = new String[input.length()];
        for(int i=0;i<result.length;i++) {
            result[i] = String.valueOf(input.charAt(i));
        }
        int back = 0;
        for(int i=0;i<result.length;i++) {
            if(!"0".equals(result[i])) {
                back = result.length-i-1;
                out += nums[Integer.parseInt(result[i])];
                out += units[back];
            }else {
                if(i==result.length-1) {

                }else {
                    if(!"0".equals(result[i + 1])) {
                        out += nums[0];
                    }
                }
            }
        }
        if ("1".equals(result[0]) && input.length()==2) {
            out = out.substring(1,out.length());
        }
        return out;
    }

}
