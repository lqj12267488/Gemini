package com.goisan.educational.exam.controller;

import com.goisan.educational.exam.bean.ExamTeacherCourse;
import com.goisan.educational.exam.service.ExamTeacherCourseService;
import com.goisan.system.tools.Message;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 123456 on 2018/4/24.
 */
@Controller
public class ExamTeacherCourseController {
    @Resource
    private ExamTeacherCourseService examTeacherCourseService;

    @RequestMapping("/examTeacherCourse/list")
    public ModelAndView getExamTeacherCourse(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/exam/examteachercourse/examTeacherCourseList");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/examTeacherCourse/getExamTeacherCourseList")
    public Map<String, List<ExamTeacherCourse>> getExamTeacherCourseList(ExamTeacherCourse examTeacherCourse) {
        Map<String, List<ExamTeacherCourse>> group = new HashMap<String, List<ExamTeacherCourse>>();
        group.put("data", examTeacherCourseService.getExamTeacherCourseList(examTeacherCourse));
        return group;
    }
    @RequestMapping("/examTeacherCourse/getAddExamTeacherCourse")
    public ModelAndView getAddExamTeacherCourse() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/exam/examteachercourse/addExamTeacherCourse");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        ExamTeacherCourse examTeacherCourse=new ExamTeacherCourse();
        mv.addObject("head","新增教师课程关联");
        mv.addObject("examTeacherCourse",examTeacherCourse);
        return mv;
    }

    @RequestMapping("/examTeacherCourse/getUpdateExamTeacherCourse")
    public ModelAndView updateList(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/exam/examteachercourse/addExamTeacherCourse");
        mv.addObject("head","修改教师课程关联");
        ExamTeacherCourse examTeacherCourse = examTeacherCourseService.getExamTeacherCourseById(id);
        mv.addObject("examTeacherCourse",examTeacherCourse);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/examTeacherCourse/saveExamTeacherCourse")
    public Message saveExamTeacherCourse(ExamTeacherCourse examTeacherCourse){
        LoginUser login = CommonUtil.getLoginUser();
        if(null ==examTeacherCourse.getId() || examTeacherCourse.getId().equals("")){
            examTeacherCourse.setCreator(login.getPersonId());
            examTeacherCourse.setCreateDept(login.getDefaultDeptId());
            examTeacherCourseService.insertExamTeacherCourse(examTeacherCourse);
            return new Message(1, "新增成功！", null);
        }else{
            examTeacherCourse.setChanger(login.getPersonId());
            examTeacherCourse.setChangeDept(login.getDefaultDeptId());
            examTeacherCourseService.updateExamTeacherCourse(examTeacherCourse);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/examTeacherCourse/deleteExamTeacherCourse")
    public Message deleteExamTeacherCourse(String id){
        LoginUser login = CommonUtil.getLoginUser();
        ExamTeacherCourse examTeacherCourse = new ExamTeacherCourse();
        examTeacherCourse.setId(id);
        examTeacherCourse.setChanger(login.getPersonId());
        examTeacherCourse.setChangeDept(login.getDefaultDeptId());
        examTeacherCourseService.deleteExamTeacherCourse(examTeacherCourse);
        return new Message(1, "删除成功！", null);
    }
}
