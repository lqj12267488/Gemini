package com.goisan.educational.courseconstr.controller;
import com.goisan.educational.courseconstr.bean.CourseConstr;
import com.goisan.educational.courseconstr.service.CourseConstrService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/courseconstr")
public class CourseConstrController {

    @Resource
    private CourseConstrService courseConstrService;

    @RequestMapping("/toCourseConstr")
    public String toList(Model model) {
     return "business/educational/courseconstr/list";
   }

    @RequestMapping("/toCourseConstrMajor")
    public String toListMajor(Model model) {
        return "business/educational/courseconstrMajor/list";
    }



    @ResponseBody
    @RequestMapping("/getList")
    public Map getList(CourseConstr courseConstr) {
        String dept = CommonUtil.getDefaultDept();
        courseConstr.setCreateDept(dept);
        String level = CommonUtil.getLoginUser().getLevel();
        courseConstr.setLevel(level);
        return CommonUtil.tableMap(courseConstrService.selectList(courseConstr));
    }

    @RequestMapping("/toAdd")
    public String toAdd( Model model){
        model.addAttribute("head", "新增");
        return "business/educational/courseconstr/edit";
    }

    @ResponseBody
    @RequestMapping("/save")
    public Message save(CourseConstr courseConstr) {
        if ("".equals(courseConstr.getClassId())) {
            courseConstr.setClassId(CommonUtil.getUUID());
            CommonUtil.save(courseConstr);
            courseConstrService.save(courseConstr);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(courseConstr);
            courseConstrService.update(courseConstr);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/toEdit")
    public String toEdit(String id,String type, Model model) {
        CourseConstr courseConstr=courseConstrService.selectById(id);
        model.addAttribute("courseConstr", courseConstr);
        model.addAttribute("head", "修改");

      /* return "business/educational/courseconstr/coursePublicEdit";*/
        return "business/educational/courseconstr/edit";

    }

    @ResponseBody
    @RequestMapping("/del")
    public Message del(String id) {
        courseConstrService.del(id);
        return new Message(0, "删除成功！", null);
    }


    @ResponseBody
    @RequestMapping("/checkCourseConstrName")
    public Message checkCourseName(CourseConstr courseConstr) {
        courseConstr.setCreateDept(CommonUtil.getDefaultDept());
        List<CourseConstr> list = courseConstrService.checkCourseConstrName(courseConstr);
        if(list.size()>0){
            return new Message(1, "", null);
        }else{
            return new Message(0, "", null);
        }
    }


    //专业课程信息维护
    @ResponseBody
    @RequestMapping("/getListMajor")
    public Map getListMajor(CourseConstr courseConstr) {
        String dept = CommonUtil.getDefaultDept();
        courseConstr.setCreateDept(dept);
        String level = CommonUtil.getLoginUser().getLevel();
        courseConstr.setLevel(level);
        return CommonUtil.tableMap(courseConstrService.selectListMajor(courseConstr));
    }

    @RequestMapping("/toAddMajor")
    public String toAddMajor( Model model){
        model.addAttribute("head", "新增");
        return "business/educational/courseconstrMajor/edit";
    }

    @ResponseBody
    @RequestMapping("/saveMajor")
    public Message saveMajor(CourseConstr courseConstr) {
        if ("".equals(courseConstr.getClassId())) {
            courseConstr.setClassId(CommonUtil.getUUID());
            CommonUtil.save(courseConstr);
            courseConstrService.saveMajor(courseConstr);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(courseConstr);
            courseConstrService.updateMajor(courseConstr);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/toEditMajor")
    public String toEditMajor(String id,String type, Model model) {
        CourseConstr courseConstr=courseConstrService.selectMajorById(id);
        model.addAttribute("courseConstr", courseConstr);
        model.addAttribute("head", "修改");

        /* return "business/educational/courseconstr/coursePublicEdit";*/
        return "business/educational/courseconstrMajor/edit";

    }

    @ResponseBody
    @RequestMapping("/delMajor")
    public Message delMajor(String id) {
        courseConstrService.delMajor(id);
        return new Message(0, "删除成功！", null);
    }


    @ResponseBody
    @RequestMapping("/checkCourseConstrMajorName")
    public Message checkCourseNameMajor(CourseConstr courseConstr) {
        courseConstr.setCreateDept(CommonUtil.getDefaultDept());
        List<CourseConstr> list = courseConstrService.checkCourseConstrMajorName(courseConstr);
        if(list.size()>0){
            return new Message(1, "", null);
        }else{
            return new Message(0, "", null);
        }
    }


}
