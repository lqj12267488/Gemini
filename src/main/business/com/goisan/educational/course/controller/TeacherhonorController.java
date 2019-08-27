package com.goisan.educational.course.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.course.bean.Teacherhonor;
import com.goisan.educational.course.service.TeacherhonorService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class TeacherhonorController {


    @Resource
    private TeacherhonorService teacherhonorService;



    /**
     *  首页跳转
     * @return
     */
    @RequestMapping("/teacherhonor/teacherhonorList")
    public ModelAndView teacherhonorList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/educational/teacherhonor/teacherhonorList");
        return mv;
    }

    /**
     *  首页查询数据
     * @param teacherhonor
     * @return
     */
    @ResponseBody
    @RequestMapping("/teacherhonor/getTeacherhonorList")
    public Map<String, Object> getTeacherhonorList(Teacherhonor teacherhonor,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> teacherhonorList = new HashMap<String, Object>();
        teacherhonor.setCreator(CommonUtil.getPersonId());
        teacherhonor.setChangeDept(CommonUtil.getDefaultDept());
        List<Teacherhonor> list = teacherhonorService.teacherhonorAction(teacherhonor);
        PageInfo<List<Teacherhonor>> info = new PageInfo(list);
        teacherhonorList.put("draw", draw);
        teacherhonorList.put("recordsTotal", info.getTotal());
        teacherhonorList.put("recordsFiltered", info.getTotal());
        teacherhonorList.put("data", list);
        return teacherhonorList;
    }

    /**
     *  查看查询数据
     * @param teacherhonor
     * @return
     */
    @ResponseBody
    @RequestMapping("/teacherhonor/getTeacherhonorCheckList")
    public Map<String, List<Teacherhonor>> getTeacherhonorCheckList(Teacherhonor teacherhonor) {
        Map<String, List<Teacherhonor>> softInstallMap = new HashMap<String, List<Teacherhonor>>();
        teacherhonor.setCreator(CommonUtil.getPersonId());
        teacherhonor.setChangeDept(CommonUtil.getDefaultDept());
        softInstallMap.put("data", teacherhonorService.teacherhonorCheckAction(teacherhonor));
        return softInstallMap;
    }





    /**
     *  管理查询数据
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("/teacherhonor/getTeacherhonorManagelList")
    public Map<String, List<Teacherhonor>> getTeacherhonorManagelList(Teacherhonor teacherhonor) {
        Map<String, List<Teacherhonor>> softInstallMap = new HashMap<String, List<Teacherhonor>>();
        softInstallMap.put("data", teacherhonorService.teacherhonorManageAction(teacherhonor));
        return softInstallMap;
    }


    /**
     * 新增 
     * @return
     */
    @ResponseBody
    @RequestMapping("/teacherhonor/addTeacherhonor")
    public ModelAndView addTeacherhonorInstall() {
        ModelAndView mv = new ModelAndView("business/educational/teacherhonor/editTeacherhonor");
        mv.addObject("head", "新增荣誉");
        return mv;
    }


    /**
     * 新增 
     * @return
     */
    @ResponseBody
    @RequestMapping("/teacherhonor/addTeacherhonorManage")
    public ModelAndView addTeacherhonorManageInstall(String id) {
        ModelAndView mv = new ModelAndView("business/educational/teacherhonor/editTeacherhonorManage");
        mv.addObject("head", "新增荣誉");
        mv.addObject("teacherId", id);
        return mv;
    }







    /**
     *  修改跳转
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/teacherhonor/getTeacherhonorById")
    public ModelAndView getTeacherhonorById(String id) {
        ModelAndView mv = new ModelAndView("business/educational/teacherhonor/editTeacherhonor");
        Teacherhonor teacherhonor = teacherhonorService.getTeacherhonorById(id);
        mv.addObject("head", " 修改");
        mv.addObject("teacherhonor", teacherhonor);
        return mv;
    }


    /**
     *  修改跳转
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/teacherhonor/editTeacherhonorManageById")
    public ModelAndView editTeacherhonorManageById(String id) {
        ModelAndView mv = new ModelAndView("business/educational/teacherhonor/editTeacherhonorManage");
        Teacherhonor teacherhonor = teacherhonorService.getTeacherhonorManageById(id);
        mv.addObject("head", " 修改");
        mv.addObject("teacherhonor", teacherhonor);
        return mv;
    }



    /**
     *  修改跳转
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/teacherhonor/toTeacherhonorManager")
    public ModelAndView addTeacherhonorManager(String id) {
        ModelAndView mv = new ModelAndView("business/educational/teacherhonor/toTeacherhonorManager");
        mv.addObject("teacherId", id);
        return mv;
    }


    /**
     *  查看
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/teacherhonor/toTeacherhonorCheck")
    public ModelAndView toTeacherhonorCheck(String id) {
        ModelAndView mv = new ModelAndView("business/educational/teacherhonor/toTeacherhonorcheck");
        mv.addObject("teacherId", id);
        return mv;
    }







    /**
     * 新增和修改保存
     * @param teacherhonor
     * @return
     */
    @ResponseBody
    @RequestMapping("/teacherhonor/saveTeacherhonor")
    public Message saveteacherhonor(Teacherhonor teacherhonor){
        //判断同一系部，同一教师姓名是否有重复数据
        if(this.teacherhonorService.getTeacherhonorByDeptAndTeacherId(teacherhonor.getDepartmentsId(), teacherhonor.getTeacherId() ,teacherhonor.getId()).size()!=0){
            return new Message(0, "已有同系部同姓名的数据！", "warning");
        }
        if(teacherhonor.getId() == null || teacherhonor.equals("") || teacherhonor.getId() == ""){
            teacherhonor.setCreator(CommonUtil.getPersonId());
            teacherhonor.setCreateDept(CommonUtil.getDefaultDept());
            teacherhonorService.insertTeacherhonor(teacherhonor);
            return new Message(1, "新增成功！", null);
        }else{
            teacherhonor.setChanger(CommonUtil.getPersonId());
            teacherhonor.setChangeDept(CommonUtil.getDefaultDept());
            teacherhonorService.updateTeacherhonorById(teacherhonor);
            return new Message(1, "修改成功！", null);
        }
    }


    /**
     * 新增和修改保存
     * @param teacherhonor
     * @return
     */
    @ResponseBody
    @RequestMapping("/teacherhonor/saveTeacherhonorManage")
    public Message saveteacherhonorManage(Teacherhonor teacherhonor){
        if(teacherhonor.getId() == null || teacherhonor.equals("") || teacherhonor.getId() == ""){
            teacherhonor.setCreator(CommonUtil.getPersonId());
            teacherhonor.setCreateDept(CommonUtil.getDefaultDept());
            teacherhonorService.insertTeacherhonorManage(teacherhonor);
            return new Message(1, "新增成功！", null);
        }else{
            teacherhonor.setChanger(CommonUtil.getPersonId());
            teacherhonor.setChangeDept(CommonUtil.getDefaultDept());
            teacherhonorService.updateTeacherhonorManageById(teacherhonor);
            return new Message(1, "修改成功！", null);
        }
    }




    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/teacherhonor/deleteTeacherhonorById")
    public Message deleteTeacherhonorById(String id) {
        teacherhonorService.deleteTeacherhonorById(id);
        return new Message(1, "删除成功！", null);
    }


    @ResponseBody
    @RequestMapping("/teacherhonor/deleteTeacherhonorManageById")
    public Message deleteTeacherhonorManageById(String id) {
        teacherhonorService.deleteTeacherhonorManageById(id);
        return new Message(1, "删除成功！", null);
    }




}
