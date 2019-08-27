package com.goisan.educational.major.util;

public class DataSort {
    public static Date1[] date1Sort(Date1[] dates) {
        int len = dates.length;
        for(int i = len - 1; i >= 1; i--) {
            for(int j = 0; j <= i - 1; j++) {
                if((dates[j].compare(dates[j+1])) > 0) {
                    Date1 temp = dates[j];
                    dates[j] = dates[j+1];
                    dates[j+1] = temp;
                }
            }
        }
        return dates;
    }
}
