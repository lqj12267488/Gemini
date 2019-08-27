package com.goisan.type.controller;

import com.goisan.type.bean.ResourceTypeCourse;
import com.goisan.type.bean.ResourceTypeMajor;
import com.goisan.type.bean.ResourceTypeSubject;
import com.goisan.type.service.ResourceTypeCourseService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.type.service.ResourceTypeMajorService;
import com.goisan.type.service.ResourceTypeSubjectService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Controller
public class ResourceTypeController {

    /**
     * 资源所属课程类型表  typeCourse
     */
    @Resource
    private ResourceTypeCourseService resourceTypeCourseService;

    @RequestMapping("/resourceLibrary/typeCourse/toResourceTypeCourseList")
    public String toListCourse() {
        return "/resourcelibrary/type/resourceTypeCourseList";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/typeCourse/getResourceTypeCourseList")
    public Map getListCourse(ResourceTypeCourse resourceTypeCourse) {
        return CommonUtil.tableMap(resourceTypeCourseService.getResourceTypeCourseList(resourceTypeCourse));
    }

    @RequestMapping("/resourceLibrary/typeCourse/toResourceTypeCourseAdd")
    public String toAddCourse(Model model) {
        model.addAttribute("head", "新增");
        return "/resourcelibrary/type/resourceTypeCourseEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/typeCourse/saveResourceTypeCourse")
    public Message saveCourse(ResourceTypeCourse resourceTypeCourse) {
        if ("".equals(resourceTypeCourse.getResourceCourseId())) {
            resourceTypeCourse.setResourceCourseId(CommonUtil.getUUID());
            CommonUtil.save(resourceTypeCourse);
            resourceTypeCourseService.saveResourceTypeCourse(resourceTypeCourse);
            return new Message(0, "添加成功！", "success");
        } else {
            CommonUtil.update(resourceTypeCourse);
            resourceTypeCourseService.updateResourceTypeCourse(resourceTypeCourse);
            return new Message(0, "修改成功！", "success");
        }

    }

    @RequestMapping("/resourceLibrary/typeCourse/toResourceTypeCourseEdit")
    public String toEditCourse(String id, Model model) {
        model.addAttribute("data", resourceTypeCourseService.getResourceTypeCourseById(id));
        model.addAttribute("head", "修改");
        return "/resourcelibrary/type/resourceTypeCourseEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/typeCourse/delResourceTypeCourse")
    public Message delCourse(String id) {
        String count = resourceTypeCourseService.checkTypeCourse(id);
        if(null == count || count.equals("0")|| count.equals("")){
            resourceTypeCourseService.delResourceTypeCourse(id);
            return new Message(1, "删除成功！", "success");
        }else{
            return new Message(0, "此资源类型下有数据，目前不能删除", "error");
        }
    }

    /**
     * 资源所属专业类型表  typeMajor
     */
    @Resource
    private ResourceTypeMajorService resourceTypeMajorService;

    @RequestMapping("/resourceLibrary/typeMajor/toResourceTypeMajorList")
    public String toListMajor() {
        return "/resourcelibrary/type/resourceTypeMajorList";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/typeMajor/getResourceTypeMajorList")
    public Map getListMajor(ResourceTypeMajor resourceTypeMajor) {
        return CommonUtil.tableMap(resourceTypeMajorService.getResourceTypeMajorList(resourceTypeMajor));
    }

    @RequestMapping("/resourceLibrary/typeMajor/toResourceTypeMajorAdd")
    public String toAddMajor(Model model) {
        model.addAttribute("head", "新增");
        return "/resourcelibrary/type/resourceTypeMajorEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/typeMajor/saveResourceTypeMajor")
    public Message saveMajor(ResourceTypeMajor resourceTypeMajor) {
        if ("".equals(resourceTypeMajor.getResourceMajorId())) {
            resourceTypeMajor.setResourceMajorId(CommonUtil.getUUID());
            CommonUtil.save(resourceTypeMajor);
            resourceTypeMajorService.saveResourceTypeMajor(resourceTypeMajor);
            return new Message(0, "添加成功！", "success");
        } else {
            CommonUtil.update(resourceTypeMajor);
            resourceTypeMajorService.updateResourceTypeMajor(resourceTypeMajor);
            return new Message(1, "修改成功！", "success");
        }

    }

    @RequestMapping("/resourceLibrary/typeMajor/toResourceTypeMajorEdit")
    public String toEditMajor(String id, Model model) {
        model.addAttribute("data", resourceTypeMajorService.getResourceTypeMajorById(id));
        model.addAttribute("head", "修改");
        return "/resourcelibrary/type/resourceTypeMajorEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/typeMajor/delResourceTypeMajor")
    public Message delMajor(String id) {
        String count = resourceTypeMajorService.checkTypeMajor(id);
        if(null == count || count.equals("0")|| count.equals("")){
            resourceTypeMajorService.delResourceTypeMajor(id);
            return new Message(1, "删除成功！", "success");
        }else{
            return new Message(0, "此专业类型下有数据，目前不能删除", "error");
        }
    }

    /**
     *资源所属学科类型表 typeSubject
    * */
    @Resource
    private ResourceTypeSubjectService resourceTypeSubjectService;

    @RequestMapping("/resourceLibrary/typeSubject/toResourceTypeSubjectList")
    public String toListSubject() {
        return "/resourcelibrary/type/resourceTypeSubjectList";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/typeSubject/getResourceTypeSubjectList")
    public Map getListSubject(ResourceTypeSubject resourceTypeSubject) {
        return CommonUtil.tableMap(resourceTypeSubjectService.getResourceTypeSubjectList(resourceTypeSubject));
    }

    @RequestMapping("/resourceLibrary/typeSubject/toResourceTypeSubjectAdd")
    public String toAddSubject(Model model) {
        model.addAttribute("head", "新增");
        return "/resourcelibrary/type/resourceTypeSubjectEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/typeSubject/saveResourceTypeSubject")
    public Message saveSubject(ResourceTypeSubject resourceTypeSubject) {
        if ("".equals(resourceTypeSubject.getResourceSubjectId())) {
            resourceTypeSubject.setResourceSubjectId(CommonUtil.getUUID());
            CommonUtil.save(resourceTypeSubject);
            resourceTypeSubjectService.saveResourceTypeSubject(resourceTypeSubject);
            return new Message(0, "添加成功！", "success");
        } else {
            CommonUtil.update(resourceTypeSubject);
            resourceTypeSubjectService.updateResourceTypeSubject(resourceTypeSubject);
            return new Message(0, "修改成功！", "success");
        }

    }

    @RequestMapping("/resourceLibrary/typeSubject/toResourceTypeSubjectEdit")
    public String toEditSubject(String id, Model model) {
        model.addAttribute("data", resourceTypeSubjectService.getResourceTypeSubjectById(id));
        model.addAttribute("head", "修改");
        return "/resourcelibrary/type/resourceTypeSubjectEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/typeSubject/delResourceTypeSubject")
    public Message delSubject(String id) {
        String count = resourceTypeSubjectService.checkTypeSubject(id);
        if(null == count || count.equals("0")|| count.equals("")){
            resourceTypeSubjectService.delResourceTypeSubject(id);
            return new Message(1, "删除成功！", "success");
        }else{
            return new Message(0, "此学科类型下有数据，目前不能删除", "error");
        }
    }


}
