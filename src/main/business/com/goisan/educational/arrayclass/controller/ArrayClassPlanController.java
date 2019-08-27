package com.goisan.educational.arrayclass.controller;

import com.goisan.educational.arrayclass.bean.*;
import com.goisan.educational.arrayclass.service.ArrayClassPlanService;
import com.goisan.educational.arrayclass.service.ArrayClassService;
import com.goisan.educational.course.service.CourseService;
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
public class ArrayClassPlanController {

    @Resource
    private ArrayClassPlanService arrayClassPlanService;
    @Resource
    private ArrayClassService arrayClassService;
    @Resource
    private CourseService courseService;

    @RequestMapping("/arrayclassplan/toArrayClass")
    public String toArrayClass() {
        /*ApplicationContext ac = new ClassPathXmlApplicationContext("");*/
        return "business/educational/arrayclass/arraycalssplan/classList";
    }

    @RequestMapping("/arrayclassplan/toArrayClassClassList")
    public String toArrayClassClassList(String id, Model model, String arrayClassName, String
            className) {
        model.addAttribute("arrayClassId", id);
        model.addAttribute("arrayClassName", arrayClassName);
        model.addAttribute("className", className);
        model.addAttribute("arrayClassName", arrayClassName);
        return "business/educational/arrayclass/arraycalssplan/arrayClassClassList";
    }

    @RequestMapping("/arrayclassplan/toArrayclassArrayList")
    public String toList(String id, String classId, String arrayclassClassId, Model model, String
            className, String arrayClassName) {
        model.addAttribute("id", id);
        model.addAttribute("classId", classId);
        model.addAttribute("arrayclassClassId", arrayclassClassId);
        model.addAttribute("className", className);
        model.addAttribute("arrayClassName", arrayClassName);
        return "business/educational/arrayclass/arraycalssplan/arrayclassArrayList";
    }

    @ResponseBody
    @RequestMapping("/arrayclassplan/getArrayclassArrayList")
    public Map getList(ArrayclassArray arrayclassArray) {
        return CommonUtil.tableMap(arrayClassPlanService.getArrayclassArrayList(arrayclassArray));
    }

    @RequestMapping("/arrayclassplan/toArrayclassArrayAdd")
    public String toAdd(String arrayclassClassId, Model model) {
        ArrayClassClass arrayClassClass = (ArrayClassClass) arrayClassService
                .getArrayClassClassById(arrayclassClassId);
        ArrayclassArray arrayclassArray = new ArrayclassArray();
        arrayclassArray.setClassId(arrayClassClass.getClassId());
        arrayclassArray.setDepartmentsId(arrayClassClass.getDepartmentsId());
        arrayclassArray.setMajorCode(arrayClassClass.getMajorCode());
        arrayclassArray.setTrainingLevel(arrayClassClass.getTrainingLevel());
        arrayclassArray.setMajorDirection(arrayClassClass.getMajorDirection());
        arrayclassArray.setArrayclassId(arrayClassClass.getArrayclassId());
        arrayclassArray.setRoomId(arrayClassClass.getRoomId());
        model.addAttribute("head", "新增");
        model.addAttribute("data", arrayclassArray);
        return "business/educational/arrayclass/arraycalssplan/arrayclassArrayClassEdit";
    }

    @ResponseBody
    @RequestMapping("/arrayclassplan/saveArrayclassArray")
    public Message save(ArrayclassArray arrayclassArray) {
        if ("".equals(arrayclassArray.getArrayId())) {
            arrayclassArray.setArrayId(CommonUtil.getUUID());
            CommonUtil.save(arrayclassArray);
            arrayClassPlanService.saveArrayclassArray(arrayclassArray);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(arrayclassArray);
            arrayClassPlanService.updateArrayclassArray(arrayclassArray);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/arrayclassplan/toArrayclassArrayEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", arrayClassPlanService.getArrayclassArrayById(id));
        model.addAttribute("head", "修改");
        return "business/educational/arrayclass/arraycalssplan/arrayclassArrayClassEdit";
    }

    @ResponseBody
    @RequestMapping("/arrayclassplan/delArrayclassArray")
    public Message del(String id) {
        arrayClassPlanService.delArrayclassArray(id);
        return new Message(0, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/arrayclassplan/getCourseById")
    public ArrayClassCourse getCourseById(ArrayClassCourse arrayClassCourse) {
        return arrayClassService.getCourseById(arrayClassCourse);
    }

    @RequestMapping("/arrayclassplan/toTeacherList")
    public String toTeacherList() {
        return "business/educational/arrayclass/arraycalssplan/teacherList";
    }

    @RequestMapping("/arrayclassplan/toArrayClassTecaherList")
    public String toArrayClassTecaherList(String id, Model model, String arrayClassName) {
        model.addAttribute("arrayclassId", id);
        model.addAttribute("arrayClassName", arrayClassName);
        return "business/educational/arrayclass/arraycalssplan/arrayClassTecaherList";
    }

    @RequestMapping("/arrayclassplan/toArrayclassArrayTeacherList")
    public String toArrayclassArrayTeacherList(String id, Model model, String teacherPersonShow,
                                               String arrayClassName) {
        ArrayClassTeacher arrayClassTeacherById = arrayClassService.getArrayClassTeacherById(id);
        model.addAttribute("arrayclassId", arrayClassTeacherById.getArrayclassId());
        model.addAttribute("teacherPersonId", arrayClassTeacherById.getTeacherPersonId());
        model.addAttribute("teacherDeptId", arrayClassTeacherById.getTeacherDeptId());
        model.addAttribute("arrayclassTeacherId", arrayClassTeacherById.getArrayclassTeacherId());
        model.addAttribute("arrayClassName", arrayClassName);
        model.addAttribute("teacherPersonShow", teacherPersonShow);
        return "business/educational/arrayclass/arraycalssplan/arrayclassArrayTeacherList";
    }

    @RequestMapping("/arrayclassplan/toArrayclassArrayTeacherAdd")
    public String toArrayclassArrayTeacherAdd(String arrayclassTeacherId, Model model) {
        ArrayClassTeacher arrayClassTeacher = arrayClassService.getArrayClassTeacherById
                (arrayclassTeacherId);
        ArrayclassArray arrayclassArray = new ArrayclassArray();
        arrayclassArray.setTeacherPersonId(arrayClassTeacher.getTeacherPersonId());
        arrayclassArray.setTeacherDeptId(arrayClassTeacher.getTeacherDeptId());
        arrayclassArray.setArrayclassId(arrayClassTeacher.getArrayclassId());
        model.addAttribute("head", "新增");
        model.addAttribute("data", arrayclassArray);
        model.addAttribute("arrayclassTeacherId", arrayclassTeacherId);
        return "business/educational/arrayclass/arraycalssplan/arrayclassArrayTeacherEdit";
    }

    @RequestMapping("/arrayclassplan/toArrayclassArrayTeacherEdit")
    public String toArrayclassArrayTeacherEdit(String id, Model model) {
        model.addAttribute("data", arrayClassPlanService.getArrayclassArrayById(id));
        model.addAttribute("head", "修改");
        return "business/educational/arrayclass/arraycalssplan/arrayclassArrayTeacherEdit";
    }

    @RequestMapping("/arrayclassplan/toArrayclassList")
    public String toArrayclassList() {
        return "business/educational/arrayclass/arraycalssplan/arrayclassList";
    }

    @ResponseBody
    @RequestMapping("/arrayclassplan/schedulingCourse")
    public Message schedulingCourse(String arrayclassId) {
        ArrayClass arrayClass = arrayClassPlanService.getArrayClassById(arrayclassId);
        Message message = new Message(0, "排课成功！", "success");
        if ("0".equals(arrayClass.getArrayClassFlag())) {
            try {
                List<ArrayclassResultClass> arrayclassResultClasses = arrayClassPlanService
                        .getResultClassListById(arrayclassId);
                List<ArrayclassArray> arrayclassArrays = arrayClassPlanService
                        .getArrayclassArrayListByArrayclassId(arrayclassId);
                List<ArrayClassTeacherCourse> arrayClassTeacherCourses = arrayClassPlanService
                        .getArrayClassTeacherCoursesByArrayclassId(arrayclassId);
                SchedulingCourse schedulingCourse = new SchedulingCourse(arrayClass,
                        arrayclassResultClasses, arrayClassTeacherCourses, arrayclassArrays);
                Map<String, ArrayclassResultClass>[] rc = schedulingCourse.getSchedulingCourse();
                arrayClassPlanService.savaArrayClassResultClass(rc);
                arrayClassPlanService.updateArrayclass(arrayclassId);
            } catch (Exception e) {
                e.printStackTrace();
                message.setMsg("排课失败！");
                message.setResult("error");
                return message;
            }
        } else {
            message.setMsg("当前计划已经排过课了！");
            message.setResult("error");
        }
        return message;
    }
}
