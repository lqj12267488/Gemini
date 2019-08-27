package com.goisan.studentwork.internships.controller;

import com.goisan.studentwork.employments.bean.EmploymentManage;
import com.goisan.studentwork.internships.bean.InternshipManage;
import com.goisan.studentwork.internships.bean.Internships;
import com.goisan.studentwork.internships.service.InternshipsService;
import com.goisan.system.bean.AutoComplete;
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
 * Created by hanyu on 2017/7/31.
 */
@Controller
public class InternshipsController {
    @Resource
    private InternshipsService internshipsService;


    /**
     * 实习单位维护跳转
     * request by hanyue
     * modify by hanyue
     * @return
     */

    @RequestMapping("/internships/request")
    public ModelAndView internshipsList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/internships/internshipsList");
        return mv;
    }
    @RequestMapping("/internships/internshipExtList")
    public ModelAndView internshipExt(String internshipUnitId,String internshipUnitName){
        Internships internships=internshipsService.selectId(internshipUnitId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("internshipExt", internships);
        mv.addObject("internshipUnitName",internshipUnitName);
        mv.setViewName("/business/studentwork/internships/internshipExtList");
        return mv;
    }

    /**
     * 查看详情
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/internships/getInternships")
    public ModelAndView getInternshipExtId(String id) {
        ModelAndView mv = new ModelAndView();
       Internships internships = internshipsService.selectAll(id);
        mv.addObject("head", "查看详情");
        mv.addObject("internships", internships);
        mv.setViewName("/business/studentwork/internships/addInternships");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/internshipExt/selectInterInfo")
    public Message selectInterInfo(String internshipUnitId){
        Internships internships=internshipsService.selectAll(internshipUnitId);
        Message message=new Message();
        if(internships==null) {
            message.setStatus(1);
        }else {
            message.setStatus(0);
        }
        return message;
    }


    /**
     * 查看详情
     * @param internshipUnitId
     * @return
     */
    @ResponseBody
    @RequestMapping("/internships/getInternshipsId1")
    public ModelAndView getInternshipExtId1(String internshipUnitId){
        ModelAndView mv = new ModelAndView();
        Internships internships = internshipsService.selectAll(internshipUnitId);
        mv.addObject("head", "查看详情");
        mv.addObject("internships", internships);
        mv.setViewName("/business/studentwork/internships/obtainInternshipsUnitListAll");
        return mv;
    }
    /**
     * 更改为就业单位
     *
     */
    @ResponseBody
    @RequestMapping("/internships/changeEmployment")
    public ModelAndView changeEmployment(String internshipUnitId) {
        ModelAndView mv = new ModelAndView();
        Internships internships = internshipsService.selectOne(internshipUnitId);
        mv.addObject("head", "新增就业单位");
        mv.addObject("employment", internships);
        mv.setViewName("/business/studentwork/employments/addEmployment");
        return mv;
    }
    /**
     * 实习单位维护URL
     *  url by hanyue
     *  modify by hanyue
     * @param internships
     * @return
     */
    @ResponseBody
    @RequestMapping("/internships/InternshipsAction")
    public Map<String, List<Internships>> InternshipsAction(Internships internships) {
        Map<String, List<Internships>> internshipsMap = new HashMap<String, List<Internships>>();
        internshipsMap.put("data", internshipsService.InternshipsAction(internships));
        return internshipsMap;
    }

    /**
     * 从实习单位获取URL
     *  url by hanyue
     *  modify by hanyue
     * @param internships
     * @return
     */
    @ResponseBody
    @RequestMapping("/internships/InternshipsActionList")
    public Map<String, List<Internships>> InternshipsActionList(Internships internships) {
        Map<String, List<Internships>> internshipsMap = new HashMap<String, List<Internships>>();
        internshipsMap.put("data", internshipsService.InternshipsActionList(internships));
        return internshipsMap;
    }
    /**
     * 维护跳转
     * request by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/internshipExt/request")
    public ModelAndView internshipExtList(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/internships/internshipExtList");
        return mv;
    }
    /**
     * 实习单位维护修改
     * update by hanyue
     * modify by hanyue
     * @param internshipUnitId
     * @return
     */

    @ResponseBody
    @RequestMapping("/internships/getInternshipsById")
    public ModelAndView getInternshipsById(String internshipUnitId) {
        Internships internships = internshipsService.getInternshipsById(internshipUnitId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "实习单位修改");
        mv.addObject("internships", internships);
        mv.setViewName("/business/studentwork/internships/editInternshipsReadonly");
        return mv;
    }
    /**
     * 实习单位维护新增
     * add by hanyue
     * modify by hanyue
     * @return
     */

    @ResponseBody
    @RequestMapping("/internships/addInternships")
    public ModelAndView addInternships() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/internships/editInternships");
        mv.addObject("head", "实习单位新增");
        return mv;
    }
    /**
     * 删除实习单位
     * delete by hanyue
     * modify by hanyue
     * @param internshipUnitId
     * @return
     */
    @ResponseBody
    @RequestMapping("/internships/deleteInternshipsById")
    public Message deleteInternshipsById(String internshipUnitId) {
        internshipsService.deleteInternshipsById(internshipUnitId);
        return new Message(1, "删除成功！", null);
    }
    @ResponseBody
    @RequestMapping("/internships/getInternshipsByInternshipUnitName")
    public boolean getInternshipsByInternshipUnitName(String internshipUnitName) {
        List<InternshipManage> list=internshipsService.getInternshipsByInternshipUnitName(internshipUnitName);
        if(list.size()>0){
            return true;
        }else{
            return false;
        }
    }
    /**
     * 保存实习单位
     * save by hanyue
     * modify by hanyue
     * @param internships
     * @return
     */

    @ResponseBody
    @RequestMapping("/internships/saveInternships")
    public Message saveInternships(Internships internships){
        if(internships.getInternshipUnitId()==null || internships.getInternshipUnitId().equals("")){
            internships.setCreator(CommonUtil.getPersonId());
            internships.setCreateDept(CommonUtil.getDefaultDept());
            internshipsService.insertInternships(internships);
            return new Message(1, "新增成功！", null);
        }else{
            internships.setChanger(CommonUtil.getPersonId());
            internships.setChangeDept(CommonUtil.getDefaultDept());
            internshipsService.updateInternshipsById(internships);
            return new Message(1, "修改成功！", null);
        }
    }
    /**
     * 部门自动提示框
     * dept by hanyue
     * modify by hanyue
     * @return
     */

    @ResponseBody
    @RequestMapping("/internships/getDept")
    public List<AutoComplete> getDept() {
        return internshipsService.selectDept();
    }

    /**
     * 人员自动提示框
     * person by hanyue
     * modify by hanyue
     * @return
     */

    @ResponseBody
    @RequestMapping("/internships/getPerson")
    public List<AutoComplete> getPerson() {
        return internshipsService.selectPerson();
    }

}
