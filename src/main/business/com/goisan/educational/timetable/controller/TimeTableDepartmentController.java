package com.goisan.educational.timetable.controller;

import com.goisan.educational.place.classroom.bean.Classroom;
import com.goisan.educational.place.classroom.service.ClassroomService;
import com.goisan.educational.timetable.bean.TimeTable;
import com.goisan.educational.timetable.bean.TimeTableDepartment;
import com.goisan.educational.timetable.service.TimeTableDepartmentService;
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
@RequestMapping("/timeTableDepartment")
public class TimeTableDepartmentController {

    @Autowired
    private TimeTableDepartmentService timeTableDepartmentService;

    @Autowired
    private ClassroomService classroomService;

    @Autowired
    DeptService deptService;

    @RequestMapping("/toTimeTableDepartment")
    public ModelAndView toTimeTableDepartment(String timeTableName, String id) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("timeTableName", timeTableName);
        mv.addObject("timeTableId", id);
        String deptName =deptService.getDeptById(CommonUtil.getDefaultDept()).getDeptName();
        if(deptName.equals("教务处")){
            mv.addObject("isDean", 1);
        } else{
            mv.addObject("isDean", 0);
        }
        mv.setViewName("business/educational/timetable/timeTableDepartmentList");
        return mv;

    }


    @RequestMapping("getTimeTableDepartmentList")
    public Map<String, List> getTimeTableDepartmentList(TimeTableDepartment timeTableDepartment) {
        timeTableDepartment.setCreateDept(CommonUtil.getDefaultDept());
        return CommonUtil.tableMap(timeTableDepartmentService.getTimeTableDepartmentList(timeTableDepartment));

    }

    @RequestMapping("/toTimeTableDepartmentAdd")
    public ModelAndView toTimeTableDepartmentAdd(String id, String timeTableId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/educational/timetable/timeTableDepartmentEdit");
        if (id != null && !"".equals(id)) {
            TimeTableDepartment timeTableDepartment = timeTableDepartmentService.getTimeTableDepartmentById(id);
            mv.addObject("data", timeTableDepartment);
            mv.addObject("head", "修改课程表");
        } else {
            TimeTableDepartment timeTableDepartment = new TimeTableDepartment();
            timeTableDepartment.setTimeTableId(timeTableId);
            mv.addObject("data", timeTableDepartment);
            mv.addObject("head", "新增课程表");
        }
        return mv;
    }


    @RequestMapping("deleteTimeTableDepartment")
    public Message deleteTimeTableDepartment(String id) {
        timeTableDepartmentService.deleteTimeTableDepartment(id);
        return new Message(1, "删除成功！", null);
    }


    @RequestMapping("saveTimeTableDepartment")
    public Message saveTimeTableDepartment(TimeTableDepartment timeTableDepartment) {
        TimeTableDepartment query = new TimeTableDepartment();
        timeTableDepartment.setMajorId(timeTableDepartment.getMajorId().split(",")[0]);
        query.setTimeTableId(timeTableDepartment.getTimeTableId());
        List<TimeTableDepartment> timeTableDepartmentList = timeTableDepartmentService.getTimeTableDepartmentList(query);
        Classroom classroom = classroomService.getClassroomById(timeTableDepartment.getClassRom());
        if (timeTableDepartment.getId() != null && !"".equals(timeTableDepartment.getId())) {
            TimeTableDepartment td = timeTableDepartmentService.getTimeTableDepartmentById(timeTableDepartment.getId());
            if (!td.getClassRom().equals(timeTableDepartment.getClassRom())){
                for (TimeTableDepartment department:timeTableDepartmentList){
                    if (department.getClassRom().equals(classroom.getClassroomName())){
                        return new Message(2,"修改失败，该教室已被占用", null);
                    }
                }
            }
            timeTableDepartmentService.updateTimeTableDepartment(timeTableDepartment);
            return new Message(0, "修改成功！", null);
        } else {
            for (TimeTableDepartment td : timeTableDepartmentList){
                 if (td.getClassRom().equals(classroom.getClassroomName())){
                     return new Message(2,"新增失败，该教室已被占用",null);
                 }
            }
            timeTableDepartment.setId(CommonUtil.getUUID());
            timeTableDepartment.setCreateDept(CommonUtil.getDefaultDept());
            timeTableDepartmentService.saveTimeTableDepartment(timeTableDepartment);
            return new Message(0, "新增成功！", null);
        }
    }

    @RequestMapping("/getMajorCodeByDeptId")
    public List<Select2> getMajorCodeByDeptId(String id) {
        return timeTableDepartmentService.getMajorCodeByDeptId(id);

    }

    @RequestMapping("/getClassIdByMajorCode")
    public List<Select2> getClassIdByMajorCode(String id) {
        return timeTableDepartmentService.getClassIdByMajorCode(id.split(",")[0]);

    }

}





