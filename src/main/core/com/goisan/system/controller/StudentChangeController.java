package com.goisan.system.controller;

import com.goisan.system.bean.*;
import com.goisan.system.service.StudentChangeLogService;
import com.goisan.system.service.StudentService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/6/29.
 */
@Controller
public class StudentChangeController {
    @Resource
    private StudentService studentService;
    @Resource
    private StudentChangeLogService studentChangeLogService;

    @RequestMapping("/studentChangeLog/studentChange")
    public ModelAndView studentList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/studentChange/studentTree");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentChangeLog/getStudentList")
    public Map<String, List<Student>> getStudentList(String deptId,String level){
        String tablename = studentService.getTreeTable(deptId);
        Map<String, List<Student>> studentList = new HashMap<String, List<Student>>();
        if("T_XG_MAJOR".equals(tablename)){
            studentList.put("data",studentService.getStudentListByMajor(deptId , "", "",level));
        }else if("T_SYS_DEPT".equals(tablename)){
            studentList.put("data",studentService.getStudentListByDept(deptId ,deptId+"%", "", "",level));
        }else if("T_XG_CLASS".equals(tablename)){
            Student student = new Student();
            student.setClassId(deptId);
            studentList.put("data",studentService.getStudentList(student));
        }
        return studentList;
    }

    @RequestMapping("/studentChangeLog/studentChangeClassTree")
    public ModelAndView studentClassRelation(String studentId) {
        ModelAndView mv = new ModelAndView();
        String relation = "";
        boolean b = true;

        List<ClassStudentRelation> list = studentService.getClassStudentRelation(studentId);
        for (int i = 0; i < list.size(); i++) {
            ClassStudentRelation r = list.get(i);
            if (b) {
                relation += r.getClassId();
                b = false;
            } else
                relation += "," +  r.getClassId();
        }

        mv.addObject("relation",relation);
        mv.addObject("studentId",studentId);
        mv.addObject("head", "学生班级关联");
        mv.setViewName("/core/xg/studentChange/changeClassRelation");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentChangeLog/saveClassRelation")
    public Message saveRelation(String studentId, String relationids) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        Select2 selectOld = studentChangeLogService.getClassByStudentId(studentId);
        studentService.saveClassStudentRelation(studentId, relationids);
        Select2 selectNew = studentChangeLogService.getClassByStudentId(studentId);
        StudentChangeLog studentChangeLog = new StudentChangeLog();
        studentChangeLog.setChangeType("1");
        studentChangeLog.setStudentId(studentId);
        studentChangeLog.setNewCode(selectNew.getId());
        studentChangeLog.setNewContent(selectNew.getText());
        studentChangeLog.setOldCode(selectOld.getId());
        studentChangeLog.setOldContent(selectOld.getText());
        studentChangeLog.setCreateDept(loginUser.getDefaultDeptId());
        studentChangeLog.setCreator(loginUser.getPersonId());
        studentChangeLogService.saveLog(studentChangeLog);

        return new Message(1, "保存成功！", null);
    }

    @RequestMapping("/studentChangeLog/studentStatus")
    public ModelAndView studentStatus(String studentId ,String name) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/studentChange/changeStatus");
        Student student=studentService.getStudentByIdNoClassId(studentId);
        mv.addObject("studentId",studentId);
        mv.addObject("student",student);
        return mv;
    }


    @ResponseBody
    @RequestMapping("/studentChangeLog/updateStatus")
    public Message updateStatus(String studentId, String studentStatus) {
        LoginUser loginUser = CommonUtil.getLoginUser();

        Select2 selectOld = studentChangeLogService.getStatusByStudentId(studentId);

        Student student = new Student();
        student.setStudentId(studentId);
        student.setStudentStatus(studentStatus);
        studentChangeLogService.updateStudentStatus(student);

        Select2 selectNew = studentChangeLogService.getStatusByStudentId(studentId);

        StudentChangeLog studentChangeLog = new StudentChangeLog();
        studentChangeLog.setChangeType("2");
        studentChangeLog.setStudentId(studentId);
        studentChangeLog.setNewCode(selectNew.getId());
        studentChangeLog.setNewContent(selectNew.getText());
        studentChangeLog.setOldCode(selectOld.getId());
        studentChangeLog.setOldContent(selectOld.getText());
        studentChangeLog.setCreateDept(loginUser.getDefaultDeptId());
        studentChangeLog.setCreator(loginUser.getPersonId());
        studentChangeLogService.saveLog(studentChangeLog);
        return new Message(1, "保存成功！", null);
    }

    @RequestMapping("/studentChangeLog/logByStudent")
    public ModelAndView logByStudent(String studentId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/studentChange/studentLogGrid");
        mv.addObject("studentId",studentId);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentChangeLog/searchGrid")
    public Map<String, List<StudentChangeLog>> searchGrid(StudentChangeLog studentChangeLog) {
        Map<String, List<StudentChangeLog>> logList = new HashMap();
        List<StudentChangeLog> r = studentChangeLogService.getStudentChangeLogList(studentChangeLog);
        logList.put("data", r);
        return logList;
    }

    @RequestMapping("/studentChangeLog/searchLog")
    public ModelAndView searchLog() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/studentChange/logGrid");
        return mv;
    }
    @RequestMapping("/studentChangeLog/searchLogECharts")
    public ModelAndView searchLogECharts() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/studentChange/logGridSearchLogECharts");
        return mv;
    }


    @RequestMapping("/studentChangeLog/studentChangeStatistics")
    public ModelAndView studentChangeStatistics() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/studentChange/studentChangeStatisticsList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentChangeLog/getStudentChangeStatisticsList")
    public Map<String, List<StudentChangeLog>> getStudentChangeStatisticsList(StudentChangeLog studentChangeLog){
        Map<String, List<StudentChangeLog>> logList = new HashMap();
        List<StudentChangeLog> r = studentChangeLogService.getStudentChangeStatisticsList(studentChangeLog);
        logList.put("data", r);
        return logList;
    }

}
