package com.goisan.educational.teacher.controller;

import com.goisan.educational.exam.bean.Exam;
import com.goisan.educational.exam.bean.ExamTeacherCourse;
import com.goisan.educational.score.bean.ScoreExam;
import com.goisan.educational.teacher.bean.TeacherCondition;
import com.goisan.educational.teacher.bean.WorkLoadCheck;
import com.goisan.educational.teacher.service.TeacherInfoService;
import com.goisan.educational.teacher.service.WorkLoadService;
import com.goisan.educational.teachingevent.service.TeachingEventService;
import com.goisan.synergy.workflow.bean.Stamp;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
 * Created by wym on 2018/6/22.
 */
@Controller
public class WorkLoadCheckController {
    @Resource
    private WorkLoadService workLoadService;
    /**
     * 工作量核定页面跳转
     *
     */
    @RequestMapping("/workLoad/check")
    public ModelAndView teachingEventList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teacher/workLoadCheck");
        return mv;
    }
    //工作量核定信息列表
    @ResponseBody
    @RequestMapping("/workLoad/checkList")
    public Map getWorkLoadCheckList(String teacherId) {
        WorkLoadCheck workLoadCheck = new WorkLoadCheck();
        workLoadCheck.setTeacherId(teacherId);
        workLoadCheck.setCreator(CommonUtil.getPersonId());
        return CommonUtil.tableMap(workLoadService.getWorkLoadCheckList(workLoadCheck));
    }
    @ResponseBody
    @RequestMapping("/workLoad/checkOne")
    public Map getWorkLoadCheckOne(WorkLoadCheck workLoadCheck) {
        workLoadCheck.setCreator(CommonUtil.getPersonId());
        return CommonUtil.tableMap(workLoadService.getWorkLoadCheckList(workLoadCheck));
    }
    //教师工作量核定信息列表页
    @RequestMapping("/workLoad/checkContent")
    public ModelAndView searchTeacherExamArrayResult(String teacherId) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("teacherId",teacherId);
        mv.setViewName("/business/educational/teacher/workLoadCheckContent");
        return mv;
    }
    @RequestMapping("/workLoad/checkContentEdit")
    public String toEditTeacherArray(String teacherId, Model model) {
        model.addAttribute("array", workLoadService.selectWorkLoadCheckById(teacherId));
        WorkLoadCheck workLoadCheck=workLoadService.selectWorkLoadCheckById(teacherId);
        String id=workLoadCheck.getTeacherId();
        model.addAttribute("head", "修改教师工作量核定信息");
        return "/business/educational/teacher/workLoadCheckEdit";
    }
    @ResponseBody
    @RequestMapping("/workLoad/delContentById")
    public Message delExamArray(String teacherId) {
        workLoadService.delWorkLoadCheckById(teacherId);
        return new Message(0, "删除成功！", null);
    }
    @ResponseBody
    @RequestMapping("/workLoadCheck/save")
    public Message saveExam(WorkLoadCheck workLoadCheck) {
        if (null == workLoadCheck.getTeacherId() || workLoadCheck.getTeacherId() == "") {
            workLoadCheck.setTeacherId(CommonUtil.getUUID());
            workLoadCheck.setCreateDept(CommonUtil.getDefaultDept());
            CommonUtil.save(workLoadCheck);
            workLoadService.insertWorkLoad(workLoadCheck);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(workLoadCheck);
            workLoadService.updatetWorkLoad(workLoadCheck);
            return new Message(0, "修改成功！", null);
        }

    }
    @RequestMapping("/workLoad/toAdd")
    public String toAddExam(Model model) {
        String now=CommonUtil.now("yyyy-MM-dd");
        model.addAttribute("head", "添加");
        model.addAttribute("now", now);
        return "/business/educational/teacher/workLoadCheckEdit";
    }

}
