package com.goisan.educational.timetable.bean;

import com.goisan.educational.timetable.util.TimeTableSpecialPlaceConstants;
import com.goisan.system.bean.BaseBean;

public class TimeTable extends BaseBean {

    private String id;
    private String timeTableName;//课程表名称
    private String executionDate;//执行日期
    private String sum;
    private String total;

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getSum() {
        return sum;
    }

    public void setSum(String sum) {
        this.sum = sum;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTimeTableName() {
        return timeTableName;
    }

    public void setTimeTableName(String timeTableName) {
        this.timeTableName = timeTableName;
    }

    public String getExecutionDate() {
        return executionDate;
    }

    public void setExecutionDate(String executionDate) {
        this.executionDate = executionDate;
    }
}
