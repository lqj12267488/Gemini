package com.goisan.studentwork.graduatearchivesaddress.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.studentwork.graduatearchivesaddress.bean.Arcad;
import com.goisan.studentwork.graduatearchivesaddress.bean.StuArcad;
import com.goisan.studentwork.graduatearchivesaddress.dao.ArcadDao;
import com.goisan.studentwork.graduatearchivesaddress.dao.StuArcadDao;
import com.goisan.studentwork.graduatearchivesaddress.service.ArcadServcie;
import com.goisan.studentwork.graduatearchivesaddress.service.StuArcadService;
import com.goisan.system.bean.Student;
import com.goisan.system.tools.Message;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created  By hanjie ON 2019/8/30
 */
@Controller
public class StuArcadController {

    @Autowired
    private StuArcadService stuArcadService;

    @Autowired
    private  ArcadServcie arcadServcie;

    @Autowired
    private ArcadDao arcadDao;

    @Autowired
    private StuArcadDao stuArcadDao;

    @RequestMapping("/stuArcad/stuArcadList")
    public String stuArcadList(){
        return "/business/studentwork/graduatearchivesaddress/stuArcadList";
    }


    @ResponseBody
    @RequestMapping("/stuArcad/getstuArcadList")
    public Map<String,Object> getstuArcadList(StuArcad stuArcad, int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> insurances = new HashMap();
        List<StuArcad> list = stuArcadService.getStuArcadList(stuArcad);
        PageInfo<List<Student>> info = new PageInfo(list);
        insurances.put("draw", draw);
        insurances.put("recordsTotal", info.getTotal());
        insurances.put("recordsFiltered", info.getTotal());
        insurances.put("data", list);
        return insurances;
    }

    @RequestMapping("/stuArcad/editStuArcad")
    public ModelAndView editStuArcad(StuArcad stuArcad){
        ModelAndView modelAndView = new ModelAndView();
        if (!"".equals(stuArcad.getArcadId())&& null!=stuArcad.getArcadId()){
            List<StuArcad> stuArcadList = stuArcadService.getStuByArcadId(stuArcad.getArcadId());
            StringBuilder studentIds = new StringBuilder();
            StringBuilder studentNames = new StringBuilder();
            if (stuArcadList.get(0).getStudentId()!=null&&!"".equals(stuArcadList.get(0).getStudentId())) {
                for (StuArcad stu : stuArcadList) {
                    studentIds.append(stu.getStudentId());
                    studentNames.append(stu.getStudentName());
                    studentNames.append(",");
                    studentIds.append(",");
                }
            }
            if (studentIds.lastIndexOf(",")!= -1) {
                studentIds.deleteCharAt(studentIds.lastIndexOf(","));
            }
            if (studentNames.lastIndexOf(",") != -1) {
                studentNames.deleteCharAt(studentNames.lastIndexOf(","));
            }

            Arcad arcad = arcadServcie.getArcadById(stuArcad.getArcadId());
            StuArcad stuArcadEdit = new StuArcad();
            stuArcadEdit.setArcadId(arcad.getArcadId());
            stuArcadEdit.setStudentIds(studentIds.toString());
            stuArcadEdit.setArcadCity(arcad.getArcadCity());
            stuArcadEdit.setArcadCounty(arcad.getArcadCounty());
            stuArcadEdit.setArcadProvince(arcad.getArcadProvince());
            stuArcadEdit.setArcadDetail(arcad.getArcadDetail());
            if ("null".equals(studentNames.toString())){
                stuArcadEdit.setStudentNames("");
            }else{
                stuArcadEdit.setStudentNames(studentNames.toString());
            }
            modelAndView.addObject("head", "修改");
            modelAndView.addObject("stuArcadEdit", stuArcadEdit);
//          editFlag 1不让改
            modelAndView.addObject("editFlag",1);
        }else {
            modelAndView.addObject("head", "新增");
        }

        modelAndView.setViewName("/business/studentwork/graduatearchivesaddress/editStuArcad");
        return modelAndView;
    }

    @RequestMapping("/stuArcad/seeStuArcad")
    public ModelAndView seeStuArcad(String arcadId){
        List<StuArcad> stuArcadList = stuArcadService.getStuByArcadId(arcadId);

        Arcad arcad = arcadServcie.getArcadById(arcadId);;
        String addr = arcad.getArcadProvinceShow()+arcad.getArcadCityShow()+arcad.getArcadCountyShow()+arcad.getArcadDetail();
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("head","详情");
        modelAndView.addObject("addr",addr);
        modelAndView.addObject("stuArcadList",stuArcadList);
        modelAndView.setViewName("/business/studentwork/graduatearchivesaddress/seeStuArcad");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/stuArcad/saveStuArcad")
    public Message saveStuArcad(StuArcad stuArcad){
        if (!"".equals(stuArcad.getArcadId())&&null!=stuArcad.getArcadId()) {
                return  stuArcadService.updStuArcad(stuArcad);
        }
        else {
            return stuArcadService.insertStuArcad(stuArcad);
        }
    }


    @RequestMapping("/stuArcad/queryList")
    public ModelAndView queryList(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/business/studentwork/graduatearchivesaddress/queryStuArcadClassTree");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/stuArcad/getQueryStuArcadList")
    public  Map<String,Object> getQueryStuArcadList(StuArcad stuArcad, int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> map = new HashMap();
        List<StuArcad> list = stuArcadService.getStuArcadByClass(stuArcad);
        PageInfo<List<Student>> info = new PageInfo(list);
        map.put("draw", draw);
        map.put("recordsTotal", info.getTotal());
        map.put("recordsFiltered", info.getTotal());
        map.put("data", list);
        return map;
    }


    @RequestMapping("/stuArcad/queryStuArcadList")
    public ModelAndView studentGrid(String classId,String majorCode,String deptId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/graduatearchivesaddress/queryStuArcadList");
        mv.addObject("classId", classId);
        mv.addObject("majorCode", majorCode);
        mv.addObject("deptId", deptId);
        return mv;
    }

    @RequestMapping("/stuArcad/editQueryStuArcad")
    public ModelAndView editQueryStuArcad(StuArcad stuArcad){
        ModelAndView modelAndView = new ModelAndView();
        StuArcad stuArcadEdit = stuArcadService.getStuArcadById(stuArcad);
        if (StringUtils.isEmpty(stuArcad.getArcadId())){
            modelAndView.addObject("head", "新增");
        }else {
            modelAndView.addObject("head", "修改");
        }
        modelAndView.addObject("studentId", stuArcad.getStudentId());
        modelAndView.addObject("stuArcadEdit", stuArcadEdit);
//            editFlag 1不让改
        modelAndView.addObject("editFlag", 1);
        modelAndView.setViewName("/business/studentwork/graduatearchivesaddress/editQueryStuArcad");
        return modelAndView;
    }


    @ResponseBody
    @RequestMapping("/stuArcad/saveQueryStuArcad")
    public Message saveQueryStuArcad(StuArcad stuArcad) {
        if (StringUtils.isEmpty(stuArcad.getId())){
            /**
             * 1. 获取stdentId
             * 2. 获取地址Id
             * 3. 新增
             */
            Arcad arcad = new Arcad();
            arcad.setArcadProvince(stuArcad.getArcadProvince());
            arcad.setArcadCity(stuArcad.getArcadCity());
            arcad.setArcadProvince(stuArcad.getArcadProvince());
            arcad.setArcadCounty(stuArcad.getArcadCounty());
            arcad.setArcadDetail(stuArcad.getArcadDetail());
            Arcad checkArcad = arcadDao.checkArcad(arcad);
            if (checkArcad!= null) {
                stuArcad.setArcadId(checkArcad.getArcadId());
                stuArcadDao.insertStuArcad(stuArcad);
                return new Message(0, "新增成功", null);
            }else {
                return new Message(0, "新增失败,不存在该地址", null);
            }
        }else {
            stuArcadService.updQueryStuArcad(stuArcad);
            return new Message(0, "修改成功", null);
        }
    }
}
