package com.goisan.educational.course.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.course.bean.Coursehonor;
import com.goisan.educational.course.service.CoursehonorService;
import com.goisan.system.bean.Emp;
import com.goisan.system.dao.EmpDao;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CoursehonorDaoController {
    @Resource
    private CoursehonorService coursehonorService;

    @Autowired
    private EmpDao empDao;
    /**
     * 课程荣誉首页跳转
     * @return
     */
    @RequestMapping("/coursehonor/coursehonorList")
    public ModelAndView coursehonorList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/educational/course/coursehonorList");
        return mv;
    }

    /**
     * 课程荣誉首页查询数据
     * @param coursehonor
     * @return
     */
    @ResponseBody
    @RequestMapping("/coursehonor/getCoursehonorList")
    public Map<String, Object> getCoursehonorList(Coursehonor coursehonor, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> coursehonors = new HashMap();
        Map<String, List<Coursehonor>> softInstallMap = new HashMap<String, List<Coursehonor>>();
        coursehonor.setCreator(CommonUtil.getPersonId());
        coursehonor.setChangeDept(CommonUtil.getDefaultDept());
        List<Coursehonor> list = coursehonorService.coursehonorAction(coursehonor);
        for (int i = 0; i <list.size() ; i++) {
            String honorMember = list.get(i).getHonorMember();
            StringBuffer memberShow = new StringBuffer();
            String[] members = honorMember.split(",");
            for (int j = 0; j < members.length; j++) {
                if (j==0) {
                    memberShow.append(empDao.getEmpByEmpId(members[j]).getName());
                }else {
                    memberShow.append(","+empDao.getEmpByEmpId(members[j]).getName());
                }
            }
            list.get(i).setHonorMember(memberShow.toString());
        }
        PageInfo<List<Coursehonor>> info = new PageInfo(list);
        coursehonors.put("draw", draw);
        coursehonors.put("recordsTotal", info.getTotal());
        coursehonors.put("recordsFiltered", info.getTotal());
        coursehonors.put("data", list);
        return coursehonors;
    }



    /**
     * 课程荣誉查看查询数据
     * @param coursehonor
     * @return
     */
    @ResponseBody
    @RequestMapping("/coursehonor/getCoursehonorCheckList")
    public Map<String, List<Coursehonor>> getCoursehonorCheckList(Coursehonor coursehonor) {
        Map<String, List<Coursehonor>> softInstallMap = new HashMap<String, List<Coursehonor>>();
        coursehonor.setCreator(CommonUtil.getPersonId());
        coursehonor.setChangeDept(CommonUtil.getDefaultDept());
        List<Coursehonor> list = coursehonorService.coursehonorCheckAction(coursehonor);

        for (int i = 0; i <list.size() ; i++) {
            String honorMember = list.get(i).getHonorMember();
            StringBuffer memberShow = new StringBuffer();
            String[] members = honorMember.split(",");
            for (int j = 0; j < members.length; j++) {
                if (j==0) {
                    memberShow.append(empDao.getEmpByEmpId(members[j]).getName());
                }else {
                    memberShow.append(","+empDao.getEmpByEmpId(members[j]).getName());
                }
            }
            list.get(i).setHonorMember(memberShow.toString());
        }
        softInstallMap.put("data", list);
        return softInstallMap;
    }





    /**
     * 课程荣誉管理查询数据
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("/coursehonor/getCoursehonorManagelList")
    public Map<String, List<Coursehonor>> getCoursehonorManagelList(Coursehonor coursehonor) {
        Map<String, List<Coursehonor>> softInstallMap = new HashMap<String, List<Coursehonor>>();
        softInstallMap.put("data", coursehonorService.coursehonorManageAction(coursehonor));
        return softInstallMap;
    }


    /**
     * 新增课程荣誉
     * @return
     */
    @ResponseBody
    @RequestMapping("/coursehonor/addCoursehonor")
    public ModelAndView addCoursehonorInstall() {
        ModelAndView mv = new ModelAndView("business/educational/course/editCoursehonor");
        mv.addObject("head", "新增课程荣誉");
        return mv;
    }


    /**
     * 新增课程荣誉
     * @return
     */
    @ResponseBody
    @RequestMapping("/coursehonor/addCoursehonorManage")
    public ModelAndView addCoursehonorManageInstall(String id) {
        ModelAndView mv = new ModelAndView("business/educational/course/editCoursehonorManage");
        mv.addObject("head", "新增荣誉");
        mv.addObject("courseHonorId", id);
        return mv;
    }

    /**
     * 课程荣誉修改跳转
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/coursehonor/getCoursehonorById")
    public ModelAndView getCoursehonorById(String id) {
        ModelAndView mv = new ModelAndView("business/educational/course/editCoursehonor");
        Coursehonor coursehonor = coursehonorService.getCoursehonorById(id);
        String honorMember = coursehonor.getHonorMember();
        StringBuffer memberShow = new StringBuffer();
        String[] members = honorMember.split(",");
            for (int i = 0; i < members.length; i++) {
                if (i==0) {
                    memberShow.append(empDao.getEmpByEmpId(members[i]).getName());
                }else {
                    memberShow.append(","+empDao.getEmpByEmpId(members[i]).getName());
                }
            }
        coursehonor.setHonorMemberShow(memberShow.toString());
        mv.addObject("head", "课程荣誉修改");
        mv.addObject("coursehonor", coursehonor);
        return mv;
    }


    /**
     * 课程荣誉修改跳转
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/coursehonor/editCoursehonorManageById")
    public ModelAndView editCoursehonorManageById(String id) {
        ModelAndView mv = new ModelAndView("business/educational/course/editCoursehonorManage");
        Coursehonor coursehonor = coursehonorService.getCoursehonorManageById(id);
        mv.addObject("head", "课程荣誉修改");
        mv.addObject("coursehonor", coursehonor);
        return mv;
    }



    /**
     * 课程荣誉修改跳转
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/coursehonor/toCoursehonorManager")
    public ModelAndView addCoursehonorManager(String id) {
        ModelAndView mv = new ModelAndView("business/educational/course/toCoursehonorManager");
        mv.addObject("courseHonorId", id);
        return mv;
    }


    /**
     * 课程荣誉查看
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/coursehonor/toCoursehonorCheck")
    public ModelAndView toCoursehonorCheck(String id) {
        ModelAndView mv = new ModelAndView("business/educational/course/toCoursehonorcheck");
        mv.addObject("courseHonorId", id);
        return mv;
    }







    /**
     * 新增和修改保存
     * @param coursehonor
     * @return
     */
    @ResponseBody
    @RequestMapping("/coursehonor/saveCoursehonor")
    public Message savecoursehonor(Coursehonor coursehonor){
        if(coursehonor.getCourseHonorId() == null || coursehonor.equals("") || coursehonor.getCourseHonorId() == ""){
            coursehonor.setCreator(CommonUtil.getPersonId());
            coursehonor.setCreateDept(CommonUtil.getDefaultDept());
            coursehonorService.insertCoursehonor(coursehonor);
            return new Message(1, "新增成功！", null);
        }else{
            coursehonor.setChanger(CommonUtil.getPersonId());
            coursehonor.setChangeDept(CommonUtil.getDefaultDept());
            coursehonorService.updateCoursehonorById(coursehonor);
            return new Message(1, "修改成功！", null);
        }
    }


    /**
     * 新增和修改保存
     * @param coursehonor
     * @return
     */
    @ResponseBody
    @RequestMapping("/coursehonor/saveCoursehonorManage")
    public Message savecoursehonorManage(Coursehonor coursehonor){
        if(coursehonor.getId() == null || coursehonor.equals("") || coursehonor.getId() == ""){
            coursehonor.setCreator(CommonUtil.getPersonId());
            coursehonor.setCreateDept(CommonUtil.getDefaultDept());
            coursehonorService.insertCoursehonorManage(coursehonor);
            return new Message(1, "新增成功！", null);
        }else{
            coursehonor.setChanger(CommonUtil.getPersonId());
            coursehonor.setChangeDept(CommonUtil.getDefaultDept());
            coursehonorService.updateCoursehonorManageById(coursehonor);
            return new Message(1, "修改成功！", null);
        }
    }




    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/coursehonor/deleteCoursehonorById")
    public Message deleteCoursehonorById(String id) {
        coursehonorService.deleteCoursehonorById(id);
        return new Message(1, "删除成功！", null);
    }


    @ResponseBody
    @RequestMapping("/coursehonor/deleteCoursehonorManageById")
    public Message deleteCoursehonorManageById(String id) {
        coursehonorService.deleteCoursehonorManageById(id);
        return new Message(1, "删除成功！", null);
    }




}
