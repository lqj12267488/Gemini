package com.goisan.studentwork.employments.controller;

import com.goisan.studentwork.employments.bean.EmploymentManage;
import com.goisan.studentwork.employments.bean.Employments;
import com.goisan.studentwork.employments.service.EmploymentsService;
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

/**
 * Created by hanyu on 2017/8/11.
 */
@Controller
public class EmploymentsController {
    @Resource
    private EmploymentsService employmentsService;


    /**
     * 就业单位维护跳转
     * request by hanyue
     * modify by hanyue
     * @return
     */

    @RequestMapping("/employments/request")
    public ModelAndView employmentsList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/employments/employmentsList");
        return mv;
    }


    /**
     * 就业单位维护URL
     *  url by hanyue
     *  modify by hanyue
     * @param employments
     * @return
     */
    @ResponseBody
    @RequestMapping("/employments/EmploymentsAction")
    public Map<String, List<Employments>> EmploymentsAction(Employments employments) {
        Map<String, List<Employments>> employmentsMap = new HashMap<String, List<Employments>>();
        employmentsMap.put("data", employmentsService.EmploymentsAction(employments));
        return employmentsMap;
    }
    /**
     * 跳转到实习单位页面
     */
    @RequestMapping("/employments/obtainInternshipUnit")
    public ModelAndView obtainInternshipUnit() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/internships/obtainInternshipsUnitList");
        return mv;
    }
    /**
     * 维护跳转
     * request by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/employmentExt/request")
    public ModelAndView employmentExtList(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/employments/employmentExtList");
        return mv;
    }
    /**
     * 就业单位维护修改
     * update by hanyue
     * modify by hanyue
     * @param employmentUnitId
     * @return
     */

    @ResponseBody
    @RequestMapping("/employments/getEmploymentsById")
    public ModelAndView getEmploymentsById(String employmentUnitId) {
        Employments employments = employmentsService.getEmploymentsById(employmentUnitId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "修改就业单位");
        mv.addObject("employments", employments);
        mv.setViewName("/business/studentwork/employments/editEmployments");
        return mv;
    }

    /**
     * 查看详情
     * @param employmentUnitId
     * @return
     */
    @ResponseBody
    @RequestMapping("/employments/employmentList")
    public ModelAndView employmentList(String employmentUnitId) {
        Employments employments = employmentsService.employmentList(employmentUnitId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "查看详情");
        mv.addObject("employments", employments);
        mv.setViewName("/business/studentwork/employments/selectEmployment");
        return mv;
    }
    /**
     * 就业单位维护新增
     * add by hanyue
     * modify by hanyue
     * @return
     */

    @ResponseBody
    @RequestMapping("/employments/addEmployments")
    public ModelAndView addEmployments() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/employments/editEmployments");
        mv.addObject("head", "新增就业单位");
        return mv;
    }
    /**
     * 删除就业单位
     * delete by hanyue
     * modify by hanyue
     * @param employmentUnitId
     * @return
     */

    @ResponseBody
    @RequestMapping("/employments/deleteEmploymentsById")
    public Message deleteEmploymentsById(String employmentUnitId) {
        employmentsService.deleteEmploymentsById(employmentUnitId);
        return new Message(1, "删除成功！", null);
    }

    /**
     * 删除校验
     * @param internshipUnitName
     * @return
     */
    @ResponseBody
    @RequestMapping("/employments/getEmploymentsByInternshipUnitName")
    public boolean getEmploymentsByInternshipUnitName(String internshipUnitName) {
        List<EmploymentManage> list=employmentsService.getEmploymentsByInternshipUnitName(internshipUnitName);
        if(list.size()>0){
            return true;
        }else{
            return false;
        }
    }
    /**
     * 保存就业单位
     * save by hanyue
     * modify by hanyue
     * @param employments
     * @return
     */

    @ResponseBody
    @RequestMapping("/employments/saveEmployments")
    public Message saveEmployments(Employments employments){
        if(employments.getEmploymentUnitId()==null || employments.getEmploymentUnitId().equals("")){
            employments.setCreator(CommonUtil.getPersonId());
            employments.setCreateDept(CommonUtil.getDefaultDept());
            employmentsService.insertEmployments(employments);
            return new Message(1, "新增成功！", null);
        }else{
            employments.setChanger(CommonUtil.getPersonId());
            employments.setChangeDept(CommonUtil.getDefaultDept());
            employmentsService.updateEmploymentsById(employments);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 从实习单位获取新增
     * @param employments
     * @return
     */
    @ResponseBody
    @RequestMapping("/employments/saveEmployments1")
    public Message saveEmployments1(Employments employments){
        ModelAndView mv = new ModelAndView("/business/studentwork/employments/employmentsList");
        if(employments.getEmploymentUnitId()==null || employments.getEmploymentUnitId().equals("")){
            employments.setCreator(CommonUtil.getPersonId());
            employments.setCreateDept(CommonUtil.getDefaultDept());
            employmentsService.insertEmployments1(employments);
            return new Message(1, "新增成功！",mv);
        }else{
            employments.setChanger(CommonUtil.getPersonId());
            employments.setChangeDept(CommonUtil.getDefaultDept());
            employmentsService.insertEmployments1(employments);
            return new Message(1, "新增成功！",mv);
        }
    }
}
