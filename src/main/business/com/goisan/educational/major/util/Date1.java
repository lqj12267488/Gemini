package com.goisan.educational.major.util;

public class Date1 {

    int year, month, day;

    public Date1(int y, int m, int d) {
        year = y;
        month = m;
        day = d;
    }

    //比较日期大小,先看年份，年份大就返回1，否则返回-1，如果年份相等,再比较月份,以此类推
    public int compare(Date1 date) {
        return year > date.year ? 1
                : year < date.year ? -1
                : month > date.month ? 1
                : month < date.month ? -1
                : day > date.day ? 1
                : day < date.day ? -1 : 0;
    }

    //重写toString方法
    public String toString() {
        return year +""+ month+"" + day;
    }
}
