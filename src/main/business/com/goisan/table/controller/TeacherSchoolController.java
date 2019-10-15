package com.goisan.table.controller;

import com.goisan.staff.service.StaffService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.table.bean.TeacherSchool;
import com.goisan.table.service.TeacherSchoolService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.system.bean.BaseBean;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class TeacherSchoolController {

    @Resource
    private TeacherSchoolService teacherSchoolService;

    @Resource
    private StaffService staffService;

    @RequestMapping("/TeacherSchool/toTeacherSchoolList")
    public String toTeacherSchoolList() {
        return "/business/table/teacherSchool/teacherSchoolList";
    }

    @RequestMapping("/TeacherSchool/toConcurrentSchoolList")
    public String toConcurrentSchoolList() {
        return "/business/table/teacherSchool/concurrentSchoolList";
    }

    @ResponseBody
    @RequestMapping("/TeacherSchool/getTeacherSchoolList")
    public Map<String,Object> getTeacherSchoolList(TeacherSchool teacherSchool,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<TeacherSchool> list =  teacherSchoolService.getTeacherSchoolList(teacherSchool);
        for (TeacherSchool teacherSchool1 : list) {
            teacherSchool1.setWhetherhost("0".equals(teacherSchool1.getWhetherhost())?"否":"是");
            teacherSchool1.setHorizontaltopic("0".equals(teacherSchool1.getHorizontaltopic())?"否":"是");
        }
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/TeacherSchool/toTeacherSchoolAdd")
    public String toAddTeacherSchool(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/teacherSchool/teacherSchoolEdit";
    }

    @RequestMapping("/TeacherSchool/toConcurrentSchoolAdd")
    public String toConcurrentSchoolAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/teacherSchool/concurrentSchoolEdit";
    }

    @ResponseBody
    @RequestMapping("/TeacherSchool/saveTeacherSchool")
    public Message saveTeacherSchool(TeacherSchool teacherSchool) {
        if (null != teacherSchool.getId() && !"".equals(teacherSchool.getId())) {
           CommonUtil.update(teacherSchool);
            teacherSchoolService.updateTeacherSchool(teacherSchool);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(teacherSchool);
            teacherSchool.setPersonid(teacherSchool.getPersonidvalue());
            teacherSchoolService.saveTeacherSchool(teacherSchool);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/TeacherSchool/toTeacherSchoolEdit")
    public String toEditTeacherSchool(String id, Model model) {
        TeacherSchool teacherSchool =  teacherSchoolService.selectTeacherById(id);
        AutoComplete autoComplete =  staffService.getPersonDept(teacherSchool.getPersonid());
        teacherSchool.setPerson(autoComplete.getLabel());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        teacherSchool.setProjectdateStr(simpleDateFormat.format(teacherSchool.getProjectdate()));
        model.addAttribute("data", teacherSchool);
        model.addAttribute("head", "修改");
        return "/business/table/teacherSchool/teacherSchoolEdit";
    }


    @RequestMapping("/TeacherSchool/toConcurrentSchoolEdit")
    public String toConcurrentSchoolEdit(String id, Model model) {
        TeacherSchool teacherSchool =  teacherSchoolService.selectTeacherById(id);
        AutoComplete autoComplete =  staffService.getPersonDept(teacherSchool.getPersonid());
        teacherSchool.setPerson(autoComplete.getLabel());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        teacherSchool.setProjectdateStr(simpleDateFormat.format(teacherSchool.getProjectdate()));
        model.addAttribute("data", teacherSchool);
        model.addAttribute("head", "修改");
        return "/business/table/teacherSchool/concurrentSchoolEdit";
    }

    @ResponseBody
    @RequestMapping("/TeacherSchool/delTeacherSchool")
    public Message delTeacherSchool(String id) {
        teacherSchoolService.delTeacherSchool(id);
        return new Message(0, "删除成功！", null);
    }

}
