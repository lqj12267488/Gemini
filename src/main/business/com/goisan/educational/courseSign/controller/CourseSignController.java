package com.goisan.educational.courseSign.controller;

import com.goisan.educational.courseSign.bean.CourseSign;
import com.goisan.educational.courseSign.bean.CourseSignClass;
import com.goisan.educational.courseSign.service.CourseSignService;
import com.goisan.educational.courseplan.bean.CoursePlanDetail;
import com.goisan.educational.courseplan.bean.CourseplanTerm;
import com.goisan.educational.courseplan.service.CoursePlanService;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.CommonService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * Created by admin on 2017/8/9.
 */
@Controller
public class CourseSignController {
    @Resource
    private CoursePlanService coursePlanService;

    @Resource
    private CourseSignService courseSignService;

    @RequestMapping("/coursesign/toCoursePlan")
    public String signtoList(Model model) {
        LoginUser user = CommonUtil.getLoginUser();
        model.addAttribute("userId", user.getPersonId());
        return "business/educational/coursesign/list";
    }

    @RequestMapping("/coursesign/toPlanDetails")
    public String toPlanDetail(String id, String planName, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("planName", planName);
        return "business/educational/coursesign/planDetails";
    }

    @RequestMapping("/coursesign/toPlanTerm")
    public String toPlanTerm(String id, String planName, Model model) {
        model.addAttribute("data", coursePlanService.getPlanDetail(id));
        model.addAttribute("planName", planName);
        return "business/educational/coursesign/planTerms";
    }

    @RequestMapping("/coursesign/setSignTeacher")
    public ModelAndView setSignTeacher(CourseplanTerm term, String planName) {
        LoginUser user = CommonUtil.getLoginUser();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/coursesign/signAddTeacher");
        mv.addObject("term", term);
        mv.addObject("personName", user.getName());
        mv.addObject("deptId", user.getDefaultDeptId());
        mv.addObject("planName",planName);
        return mv;
    }

    @RequestMapping("/coursesign/setSign")
    public ModelAndView setSign(CourseplanTerm term, String planName) {
        LoginUser user = CommonUtil.getLoginUser();
        ModelAndView mv = new ModelAndView();
        mv.addObject("term", term);
        mv.addObject("personName", user.getName());
        mv.addObject("deptId", user.getDefaultDeptId());
        mv.addObject("planName",planName);
        if(term.getPersonId().equals("0")){
            mv.setViewName("/business/educational/coursesign/signAddTeacher");
        }else{
            CourseSign seletSign = new CourseSign();
            seletSign.setTermId(term.getId());
            seletSign.setPersonId(user.getPersonId());
            List sign = courseSignService.getCourseSignList(seletSign);
            if(sign.size() == 0 || null == sign ){
                mv.setViewName("/business/educational/coursesign/signAddTeacher");
            }else{
                mv.setViewName("/business/educational/coursesign/signViewTeacher");
                mv.addObject("sign",sign.get(0));
            }
        }
        return mv;
    }

    @RequestMapping("/coursesign/getSignTeacher")
    public ModelAndView setSignTeacher(String signId) {
        CourseSign sign = courseSignService.getCourseSignByid(signId);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/coursesign/signViewTeacher");
        mv.addObject("sign",sign);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/coursesign/saveCourseSign")
    public Message saveCourseSign(CourseSign sign) {
        LoginUser user = CommonUtil.getLoginUser();
        sign.setPersonId(user.getPersonId());
        sign.setDeptId(user.getDefaultDeptId());
        sign.setCreator(user.getPersonId());
        sign.setCreateDept(user.getDefaultDeptId());
        sign.setSignId(CommonUtil.getUUID());
        courseSignService.saveCourseSign(sign);
        String signId = sign.getSignId();
        CourseSignClass courseSignClass = courseSignService.getCourseDetailsByOne(signId);
        courseSignClass.setId(CommonUtil.getUUID());
        courseSignClass.setCreator(user.getPersonId());
        courseSignClass.setCreateDept(user.getDefaultDeptId());
        courseSignService.saveCourseClass(courseSignClass);
        return new Message(0, "保存成功！", null);
    }

    @RequestMapping("/coursesign/getSignList")
    public ModelAndView getSignList(String termId,String signId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/coursesign/signList");
        mv.addObject("termId",termId);
        mv.addObject("signId",signId);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/coursesign/viewSignList")
    public Map<String, List> viewSignList(CourseSign coursesign) {
        Map<String, List> map = new HashMap<String, List>();
        System.out.println(coursesign.getTermId());
        System.out.println(coursesign.getSignId());
        List<CourseSign> sign = courseSignService.getCourseSignList(coursesign);
        map.put("data", sign);
        return map;
    }

    @RequestMapping("/coursesign/signSearchBySelf")
    public ModelAndView signSearchBySelf() {
        LoginUser loginUser = CommonUtil.getLoginUser();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/coursesign/signSearchBySelf");
        mv.addObject("personId",loginUser.getPersonId());
        mv.addObject("deptId",loginUser.getDefaultDeptId());
        return mv;
    }

    @RequestMapping("/coursesign/signSearch")
    public ModelAndView signSearch() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/coursesign/signSearch");
        return mv;
    }

    @RequestMapping("/coursesign/signEditTeacher")
    public ModelAndView signEditTeacher(String signId) {
        CourseSign sign = courseSignService.getCourseSignByid(signId);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/coursesign/signEditTeacher");
        mv.addObject("sign",sign);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/coursesign/updateCourseSign")
    public Message updateCourseSign(CourseSign sign) {
        LoginUser user = CommonUtil.getLoginUser();
        sign.setChanger(user.getPersonId());
        sign.setChangeDept(user.getDefaultDeptId());
        courseSignService.updateCourseSign(sign);
        String signId = sign.getSignId();
        List<CourseSignClass> courseSignClasses = courseSignService.getClassBySignId(signId);
        CourseSignClass courseSignClass = courseSignClasses.get(0);
        courseSignService.updateCourseSignClass(courseSignClass);
        return new Message(0, "修改成功！", null);
    }

    @ResponseBody
    @RequestMapping("/coursesign/delSign")
    public Message delSign(String signId) {
        courseSignService.delCourseSign(signId);
        return new Message(0, "删除成功！", null);
    }

    /*班级分配跳转*/
    @RequestMapping("/coursesign/signClass")
    public ModelAndView signClass(){
        ModelAndView mv = new ModelAndView("business/educational/coursesign/signClass");
        return mv;
    }

    /*班级分配树跳转*/
    @RequestMapping("/coursesign/signClassTree")
    public ModelAndView signClassTree(String id,String planId){
        ModelAndView mv = new ModelAndView("/business/educational/coursesign/signClassTree");
        mv.addObject("id", id);
        mv.addObject("planId", planId);
        return mv;
    }
    /*获取树*/
    @ResponseBody
    @RequestMapping("/coursesign/getClassTreeBySign")
    public Map<String,List> getClassTreeBySign(String id,String planId){
        List<Tree> trees = courseSignService.getClassTreeBySign(planId);
        String signId = id;
        List<CourseSignClass> courseSignClasses = courseSignService.getClassBySignId(signId);
        Map<String,List> map = new HashMap<String, List>();
        map.put("tree",trees);
        map.put("selected",courseSignClasses);
        return map;
    }

    /*
    @ResponseBody
    @RequestMapping("/coursesign/getCourseDetails")
    public void getCourseDetails(String signId){

    }
    */

    @ResponseBody
    @RequestMapping("/coursesign/saveClass")
    public Message saveClass(String signId,String ids) {
        System.out.println(signId);
        System.out.println(ids);
        String[] tmp =  ids.split(",");
        courseSignService.saveClass(tmp , signId);
        return new Message(1,"保存成功!",null);

    }

}
