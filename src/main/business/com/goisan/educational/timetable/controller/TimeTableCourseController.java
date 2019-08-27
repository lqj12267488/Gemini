package com.goisan.educational.timetable.controller;

import com.goisan.educational.timetable.bean.TimeTable;
import com.goisan.educational.timetable.bean.TimeTableCourse;
import com.goisan.educational.timetable.service.TimeTableCourseService;
import com.goisan.educational.timetable.service.TimeTableService;
import com.goisan.system.bean.Select2;
import com.goisan.system.service.DeptService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/timeTableCourse")
public class TimeTableCourseController {

    @Autowired
    private TimeTableCourseService timeTableCourseService;
    @Autowired
    private DeptService deptService;

    @RequestMapping("/toTimeTableCourse")
    public ModelAndView toTimeTableCourse(String departmentName, String timeTableDepartmentId,String timeTableId) {
        ModelAndView mv = new ModelAndView();
        String deptName =deptService.getDeptById(CommonUtil.getDefaultDept()).getDeptName();
        if(deptName.equals("教务处")){
            mv.addObject("isDean", 1);
        } else{
            mv.addObject("isDean", 0);
        }


        mv.addObject("timeTableDepartmentName", departmentName);
        mv.addObject("timeTableDepartmentId", timeTableDepartmentId);
        mv.addObject("timeTableId", timeTableId);
        mv.setViewName("business/educational/timetable/timeTableCourseList");
        return mv;

    }


    @RequestMapping("getTimeTableCourseList")
    public Map<String, List> getTimeTableCourseList(TimeTableCourse timeTableCourse) {
        timeTableCourse.setCreateDept(CommonUtil.getDefaultDept());
        return CommonUtil.tableMap(timeTableCourseService.getTimeTableCourseList(timeTableCourse));
    }

    @RequestMapping("/toTimeTableCourseAdd")
    public ModelAndView toTimeTableCourseAdd(String id,String timeTableDepartmentId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/educational/timetable/timeTableCourseEdit");
        if (id != null && !"".equals(id)) {
            TimeTableCourse timeTableCourse = timeTableCourseService.getTimeTableCourseById(id);
            mv.addObject("data", timeTableCourse);
            mv.addObject("head", "修改课程表");
        } else {
            TimeTableCourse timeTableCourse=new TimeTableCourse();
            timeTableCourse.setTimeTableDepartmentId(timeTableDepartmentId);
            mv.addObject("data", timeTableCourse);
            mv.addObject("head", "新增课程表");
        }
        return mv;
    }


    @RequestMapping("deleteTimeTableCourse")
    public Message deleteTimeTableCourse(String id) {
        timeTableCourseService.deleteTimeTableCourse(id);
        return new Message(1, "删除成功！", null);
    }


    @RequestMapping("saveTimeTableCourse")
    public Message saveTimeTableCourse(TimeTableCourse timeTableCourse) {

        List<TimeTableCourse> timeTableCourseList = timeTableCourseService.getTimeTableCourseList(timeTableCourse);
        if (timeTableCourse.getId() != null && !"".equals(timeTableCourse.getId())) {
            TimeTableCourse ttc = timeTableCourseService.getTimeTableCourseById(timeTableCourse.getId());
            if (!ttc.getWeeks().equals(timeTableCourse.getWeeks())||!ttc.getCourseNum().equals(timeTableCourse.getCourseNum())){
                for (TimeTableCourse tc: timeTableCourseList) {
                    if (tc.getWeeks().equals(timeTableCourse.getWeeks())&&tc.getCourseNum().equals(timeTableCourse.getCourseNum())){
                        return new Message(2, "修改失败！请注意时间", null);
                    }
                }
            }
            timeTableCourseService.updateTimeTableCourse(timeTableCourse);
            return new Message(0, "修改成功！", null);
        } else {
            for (TimeTableCourse tc: timeTableCourseList) {
                if (tc.getWeeks().equals(timeTableCourse.getWeeks())&&tc.getCourseNum().equals(timeTableCourse.getCourseNum())){
                     return new Message(2, "新增失败！请注意时间", null);
                }
            }
            timeTableCourse.setId(CommonUtil.getUUID());
            timeTableCourse.setCreateDept(CommonUtil.getDefaultDept());
            timeTableCourseService.saveTimeTableCourse(timeTableCourse);
            return new Message(0, "新增成功！", null);
        }
    }


}





