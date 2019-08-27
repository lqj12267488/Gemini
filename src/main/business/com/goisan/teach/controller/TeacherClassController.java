package com.goisan.teach.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Student;
import com.goisan.system.bean.TableDict;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.StudentService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.JsonUtils;
import com.goisan.system.tools.Message;
import com.goisan.system.tools.WeiXinUtils;
import com.goisan.teach.bean.CourseTime;
import com.goisan.teach.bean.Task;
import com.goisan.teach.bean.TaskLog;
import com.goisan.teach.service.TeachClassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class TeacherClassController {


    @Autowired
    private TeachClassService teachClassService;
    @Autowired
    private StudentService studentService;

    @RequestMapping("teach/toCourseTimeList")
    public ModelAndView toCourseTimeList() {
        return new ModelAndView("business/teach/courseTimeList");
    }

    @RequestMapping("teach/getCourseTime")
    public Map<String, List> getCourseTime(CourseTime courseTime) {
        return CommonUtil.tableMap(teachClassService.getCourseTime(courseTime));
    }

    @RequestMapping("teach/toEditCourseTime")
    public ModelAndView toEditCourseTime(String id) {
        ModelAndView mv = new ModelAndView("business/teach/courseTime");
        if (id != null && !"".equals(id)) {
            CourseTime courseTime = teachClassService.getCourseTimeById(id);
            mv.addObject("data", courseTime);
        }
        return mv;
    }

    @RequestMapping("teach/saveCourseTime")
    public Message saveCourseTime(CourseTime courseTime) {
        String id = courseTime.getId();
        if (id != null && !"".equals(id)) {
            teachClassService.updateCourseTime(courseTime);
        } else {
            if (teachClassService.getCourseTime(courseTime).size() == 0) {
                teachClassService.saveCourseTime(courseTime);
            } else {
                return new Message(1, "无需重复添加！", null);
            }

        }
        return new Message(1, "操作成功！", null);
    }

    @RequestMapping("teach/deleteCourseTime")
    public Message deleteCourseTime(String id) {
        teachClassService.deleteCourseTime(id);
        return new Message(1, "删除成功！", null);
    }

    @RequestMapping("/studentAttendance/index")
    public ModelAndView studentAttendance() {
        return new ModelAndView("business/teach/studentAttendance");
    }

    /**
     * 根据当前登录教师id，当前学期，教学任务中获取课程
     * @return
     */
    @RequestMapping("/teach/getCourseByPerson")
    public List<Select2> getCourseByPerson() {
        return teachClassService.getCourseByPerson(CommonUtil.getPersonId());
    }

    /**
     * 根据当前登录教师id，课程，当前学期，从教学任务中获取班级
     */
    @RequestMapping("/teach/getClassByPerson")
    public List<Tree> getClassByPerson(String courseId) {
        return teachClassService.getClassByPerson(CommonUtil.getPersonId(),courseId);
    }

    @RequestMapping("/teach/saveTask")
    public Message saveTask(Task task) {
        String uuid;
        Task task2 = teachClassService.getTaskByCourseIdAndCourseTime(task);
        if (task2 != null) {
            uuid = task2.getId();
            return new Message(0, uuid, null);
        } else {
            List<Task> task1;
//            if (task.getMajor() != null) {
                task1 = teachClassService.getTaskByClassIdAndCourseTime(task);
                if (task1.size() > 0) {
                    return new Message(2, null, null);
                }
//            }
//            else {
//                task1 = teachClassService.getTaskByMajorAndCourseTime(task);
//                if (task1.size() > 0) {
//                    return new Message(2, null, null);
//                }
//            }
            uuid = CommonUtil.getUUID();
            task.setId(uuid);
            teachClassService.saveTask(task);
            return new Message(1, uuid, null);
        }
    }


    @RequestMapping("/teach/toTaskLog")
    public ModelAndView toTaskLog() {
        ModelAndView mv = new ModelAndView("business/teach/taskLog");
        mv.addObject("now", CommonUtil.now("yyyy-MM-dd"));
        return mv;
    }

    @RequestMapping("/teach/getTaskLog")
    public Map<String, Object> getTaskLog(String name, String className, String courseName, String data, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> result = new HashMap<>();
        List<Map> taskLogs = teachClassService.getTaskLog(name, className, courseName, data);
//        for (Map map : taskLogs) {
//            String o = (String) map.get("major");
//            if (o != null) {
//                Map<String, Object> count = teachClassService.getConutAndSum((String) map.get("classId"), (String) map.get("MAJOR"), (String) map.get("XZ"), (String) map.get("id"));
//                map.put("count", count.get("count"));
//                map.put("sum", count.get("sum"));
//            }
//        }
        PageInfo<Map> info = new PageInfo<>(taskLogs);
        result.put("draw", draw);
        result.put("recordsTotal", info.getTotal());
        result.put("recordsFiltered", info.getTotal());
        result.put("data", taskLogs);
        return result;
    }

    @RequestMapping("/teach/toTaskLogDetails")
    public ModelAndView toTaskLogDetails(String taskId, String classId, String major, String xz) {
        ModelAndView mv = new ModelAndView("business/teach/taskLogDetails");
        mv.addObject("taskId", taskId);
        mv.addObject("classId", classId);
        mv.addObject("major", major);
        mv.addObject("xz", xz);
        return mv;
    }


    @RequestMapping("teach/getTaskLogDetails")
    public Map<String, List> getTaskLogDetails(@RequestParam Map<String, Object> param) {
        return CommonUtil.tableMap(teachClassService.getTaskLogDetails(param));
    }


    @RequestMapping("/teach/getConfig")
    public Map<String, Object> getConfig(HttpServletRequest request) {
        String url = request.getRequestURL().toString();
        if (url.contains("http://")) {
            url = url.replace("http://", "");
            url = "http://" + url.substring(0, url.indexOf("/")) + "/loginApp/index";
        }
        if (url.contains("https://")) {
            url = url.replace("https://", "");
            url = "http://" + url.substring(0, url.indexOf("/")) + "/loginApp/index";
        }
        return WeiXinUtils.generateConfig(new String[]{"scanQRCode", "getNetworkType"}, url);
    }


    /**
     * 微信
     */
    @RequestMapping("app/studentAttendance/index")
    public ModelAndView appStudentAttendance() {
        ModelAndView mv = new ModelAndView("business/teach/appStudentAttendance");
        mv.addObject("courses", teachClassService.getCourseByPerson(CommonUtil.getPersonId()));
//        mv.addObject("classes", teachClassService.getClassByPerson(CommonUtil.getPersonId()));
        TableDict tableDict = new TableDict();
        tableDict.setTableName("T_KQ_COURSE_TIME");
        tableDict.setId(" ID ");
        tableDict.setText(" NAME ");
//        mv.addObject("courseTimes", commonService.getTableDict(tableDict));
        return mv;
    }

    /**
     * 签到
     * @return
     */
    @RequestMapping("/teach/saveTaskLog")
    public Message saveTaskLog(String resultStr, HttpServletRequest request, HttpSession session) {
        Map param = JsonUtils.toBean2(resultStr, Map.class);
        Message message = new Message(1, "签到成功！", null);
        if ((System.currentTimeMillis() - (long) param.get("now")) / 1000 > 30) {
            message.setMsg("二维码已过期，请重新扫码！");
        } else {
            String taskId = (String) param.get("id");
//            String major = (String) param.get("major");
            String classId = (String) param.get("classId");
//            if (major == null || "".equals(major)) {
            if (classId == null || "".equals(classId)) {
                if (((String) param.get("classId")).contains(CommonUtil.getDefaultDept())) {
                    signIn(taskId, message, request, session);
                } else {
                    message.setMsg("您不是当前班级的学生，不能签到");
                }
            } else {
                Student student = studentService.getStudentById(CommonUtil.getPersonId());
//                if (major.contains(student.getClassId() + ":" + student.getMajorCode() + ":" + student.getEducationalSystem())) {
                if (classId.contains(student.getClassId())){
                    signIn(taskId, message, request, session);
                } else {
                    message.setMsg("您不是当前班级的学生，不能签到");
                }
            }
        }
        return message;
    }

    private void signIn(String taskId, Message message, HttpServletRequest request, HttpSession session) {
        List<TaskLog> taskLogs = teachClassService.getTaskLogsByTaskIdAndUserId(CommonUtil.getPersonId(), taskId);
        if (taskLogs.size() > 0) {
            message.setMsg("您已经签到过了，无需多次签到！");
        } else {
            TaskLog taskLog = new TaskLog();
            taskLog.setId(CommonUtil.getUUID());
            taskLog.setStudentId(CommonUtil.getPersonId());
            taskLog.setTaskId(taskId);
            String ip = CommonUtil.getRemoteAddr(request);
            taskLog.setIpAddr(ip);
            taskLog.setMac((String) session.getAttribute("mac"));
            teachClassService.saveTaskLog(taskLog);
        }
    }
}
