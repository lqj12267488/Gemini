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

    /**
     * @param flag 毕业标识
     * @return
     */
    @RequestMapping("/studentChangeLog/studentChange")
    public ModelAndView studentList(String flag) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/studentChange/studentTree");
        mv.addObject("flag",flag);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentChangeLog/getStudentList")
    public Map<String, List<Student>> getStudentList(String deptId,String level){
        String tablename = studentService.getTreeTable(deptId);
        Map<String, List<Student>> studentList = new HashMap<String, List<Student>>();
        if("T_XG_MAJOR".equals(tablename)){
            studentList.put("data",studentService.getStudentListByMajor2(deptId));
        }else if("T_SYS_DEPT".equals(tablename)){
            studentList.put("data",studentService.getStudentListByDept2(deptId));
        }else if("T_XG_CLASS".equals(tablename)){
            Student student = new Student();
            student.setClassId(deptId);
            studentList.put("data",studentService.getStudentList(student));
        }
        return studentList;
    }


    /**
     * @param type 1 系部，2 专业，3 班级
     * @return
     */
    @ResponseBody
    @RequestMapping("/studentChangeLog/getGraduateStudentList")
    public Map<String, List<Student>> getGraduateStudentList(String deptId,String type){
        Map<String, List<Student>> studentList = new HashMap<>();
        if("1".equals(type)){
            studentList.put("data",studentService.getGradStudentListByDept(deptId));
        }else if("2".equals(type)){
            studentList.put("data",studentService.getGradStudentListByMajor(deptId));
        }else if("3".equals(type)){
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
        /**
         * 如果先休退学后辍学都要显示出来
         * 页面渲染根据flag标识
         */
        mv.addObject("flag","0");
        if ("2".equals(student.getStudentStatus()) ||"5".equals(student.getStudentStatus())){
            mv.addObject("flag","1");
        }
        if ("12".equals(student.getStudentStatus())){
            mv.addObject("flag","2");
            StudentChangeLog log = new StudentChangeLog();
            log.setStudentId(student.getStudentId());
            List<StudentChangeLog> r = studentChangeLogService.getStudentChangeLogList(log);
            /**
             * 查询修改先是否是休学
             */
            if (r.size()>0){
                StudentChangeLog scl = r.get(0);
                if ("5".equals(scl.getOldCode())||"2".equals(scl.getOldCode())){
                    mv.addObject("flag","3");
                }
            }
        }
        if ("6".equals(student.getStudentStatus())){
            mv.addObject("flag","4");
        }
        return mv;
    }


    @ResponseBody
    @RequestMapping("/studentChangeLog/updateStatus")
    public Message updateStatus(String studentId, String studentStatus,String retireReason,String dropOutReason,String graduaDestina,String statusDate) {
        LoginUser loginUser = CommonUtil.getLoginUser();

        Select2 selectOld = studentChangeLogService.getStatusByStudentId(studentId);

        Student student = new Student();
        student.setStudentId(studentId);
        student.setStudentStatus(studentStatus);
        student.setGraduaDestina(graduaDestina);
        student.setRetireReason(retireReason);
        student.setDropOutReason(dropOutReason);
        student.setStatusDate(statusDate);
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

    @RequestMapping("/studentChangeLog/updateReason")
    @ResponseBody
    public Message updateReason(String studentId,String retireReason,String dropOutReason,String statusDate,String graduaDestina){
        Student student = new Student();
        student.setStudentId(studentId);
        student.setRetireReason(retireReason);
        student.setDropOutReason(dropOutReason);
        student.setStatusDate(statusDate);
        student.setGraduaDestina(graduaDestina);
        studentChangeLogService.updateReason(student);
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
