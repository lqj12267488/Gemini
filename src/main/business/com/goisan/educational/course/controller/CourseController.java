package com.goisan.educational.course.controller;

import com.goisan.educational.course.bean.Course;
import com.goisan.educational.course.service.CourseService;
import com.goisan.system.bean.Select2;
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
@RequestMapping("/course")
public class CourseController {

    @Resource
    private CourseService courseService;

    @RequestMapping("/toCourse")
    public String toList(String type, Model model) {
            model.addAttribute("type", type);
            if ("1".equals(type)) {
                return "business/educational/course/coursePublicList";
            } else {
                return "business/educational/course/list";
            }

    }

    @ResponseBody
    @RequestMapping("/getList")
    public Map getList(Course course) {
        String dept = CommonUtil.getDefaultDept();
        course.setCreateDept(dept);
        String level = CommonUtil.getLoginUser().getLevel();
        course.setLevel(level);
        return CommonUtil.tableMap(courseService.selectList(course));
    }

    @RequestMapping("/toAdd")
    public String toAdd(String type, Model model) {
        model.addAttribute("head", "新增");
        model.addAttribute("type", type);
        if ("1".equals(type)) {
            return "business/educational/course/coursePublicEdit";
        } else {
            return "business/educational/course/edit";
        }
    }

    @ResponseBody
    @RequestMapping("/save")
    public Message save(Course course) {
        //判断是否重复课程名
        if(this.courseService.getCourseByName(course).size()>0)
            return new Message(0, "已有该课程名数据！","warning");

        if ("".equals(course.getCourseId())) {
            course.setCourseId(CommonUtil.getUUID());
            CommonUtil.save(course);
            courseService.save(course);
            return new Message(1, "添加成功！", null);
        } else {
            CommonUtil.update(course);
            courseService.update(course);
            return new Message(1, "修改成功！", null);
        }

    }

    @RequestMapping("/toEdit")
    public String toEdit(String id,String type, Model model) {
        Course course=courseService.selectById(id);
        model.addAttribute("course", course);
        model.addAttribute("head", "修改");
        if ("1".equals(type)) {
            return "business/educational/course/coursePublicEdit";
        } else {
            return "business/educational/course/edit";
        }
    }

    @ResponseBody
    @RequestMapping("/del")
    public Message del(String id) {
        courseService.del(id);
        return new Message(0, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/selectById")
    public Course selectById(String courseId) {
/*
        Map<String, Course> resultMap = new HashMap<String,Course>();
        resultMap.put("data", courseService.selectById(courseId));
*/
        return courseService.selectById(courseId);
    }

    @ResponseBody
    @RequestMapping("/getMajorByDeptId")
    public List<Select2> getMajorByDeptId(String deptId) {
        List<Select2> list=courseService.getMajorByDeptId(deptId);
        return list;
    }
    //返回的Select2的id属性值为专业id
    @ResponseBody
    @RequestMapping("/getMajorByDepId")
    public List<Select2> getMajorByDepId(String deptId) {
        List<Select2> list=courseService.getMajorByDepId(deptId);
        return list;
    }
    @ResponseBody
    @RequestMapping("/checkCourseName")
    public Message checkCourseName(Course course) {
        course.setCreateDept(CommonUtil.getDefaultDept());
        List<Course> list = courseService.checkCourseName(course);
        if(list.size()>0){
            return new Message(1, "", null);
        }else{
            return new Message(0, "", null);
        }
    }
    @ResponseBody
    @RequestMapping("/checkCoding")
    public String checkCoding(Course course) {
        String maxCoding = courseService.getMaxCourseCoding(course);
        String coding = "";
        int finalCoding=0;
        if(maxCoding!=null){
            finalCoding= Integer.parseInt(maxCoding)+1;
            if(1==maxCoding.length()){
                return "000"+String.valueOf(finalCoding);
            }
            if(2==maxCoding.length()){
                return "00"+String.valueOf(finalCoding);
            }
            if(3==maxCoding.length()){
                return "0"+String.valueOf(finalCoding);
            }
            if(4==maxCoding.length()){
                return String.valueOf(finalCoding);
            }

        }else{
            coding="0001";
            return coding;
        }
        return coding;
    }

}
