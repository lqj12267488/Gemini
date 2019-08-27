package com.goisan.attendance.attendance.service.impl;

import com.goisan.attendance.attendance.bean.AttendanceImplog;
import com.goisan.attendance.attendance.bean.AttendanceInfo;
import com.goisan.attendance.attendance.dao.AttendanceDao;
import com.goisan.attendance.attendance.service.AttendanceService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by admin on 2017/7/7.
 */
@Service
public class AttendanceServiceImpl implements AttendanceService {
    @Resource
    private AttendanceDao attendanceDao;

    public List<AttendanceInfo> getInfoList(AttendanceInfo attendanceInfo){
        return attendanceDao.getInfoList(attendanceInfo);
    }

    public AttendanceInfo getInfoById(String id){
        return attendanceDao.getInfoById(id);
    }

    public void insertInfo(AttendanceInfo attendanceInfo){
        attendanceDao.insertInfo(attendanceInfo);
    }

    public void deleteInfoByCoding(String Coding){
        attendanceDao.deleteInfoByCoding(Coding);
    }

    public List<AttendanceImplog> getImplogList(AttendanceImplog attendanceImplog){
      return  attendanceDao.getImplogList(attendanceImplog);
    }

    public  List<AttendanceImplog> getImplogById(String id){
        return  attendanceDao.getImplogById(id);
    }

    public void insertImplog(AttendanceImplog attendanceImplog){
        attendanceDao.insertImplog(attendanceImplog);
    }

    public void deleteImplogByCoding(String Coding){
        attendanceDao.deleteImplogByCoding(Coding);
    }

    public List<AttendanceInfo> getListUnDoAttendanceAppByType(String idCard) {
        return attendanceDao.getListUnDoAttendanceAppByType(idCard);
    }

}
