package com.goisan.attendance.attendance.service;

import com.goisan.attendance.attendance.bean.AttendanceImplog;
import com.goisan.attendance.attendance.bean.AttendanceInfo;

import java.util.List;

/**
 * Created by admin on 2017/7/7.
 */
public interface AttendanceService {

    List<AttendanceInfo> getInfoList(AttendanceInfo attendanceInfo);

    AttendanceInfo getInfoById(String id);

    void insertInfo(AttendanceInfo attendanceInfo);

    void deleteInfoByCoding(String Coding);

    List<AttendanceImplog> getImplogList(AttendanceImplog attendanceImplog);

    List<AttendanceImplog> getImplogById(String id);

    void insertImplog(AttendanceImplog attendanceImplog);

    void deleteImplogByCoding(String Coding);

    List<AttendanceInfo> getListUnDoAttendanceAppByType(String idCard);
}
