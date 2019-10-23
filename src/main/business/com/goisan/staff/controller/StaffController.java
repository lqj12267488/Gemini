package com.goisan.staff.controller;

import com.goisan.staff.bean.Staff;
import com.goisan.staff.service.StaffService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.system.bean.BaseBean;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class StaffController {

    @Resource
    private StaffService staffService;

    @RequestMapping("/Staff/toStaffList")
    public String toStaffList() {
        return "/business/staff/staffList";
    }

    @RequestMapping("/Staff/toStaffStudentList")
    public String toStaffStudentList(){
        return "/business/staff/staffStudentList";
    }

    @RequestMapping("/Staff/toStaffEnrollingList")
    public String toStaffEnrollingList(){
        return "/business/staff/staffeEnrollingList";
    }

    @RequestMapping("/Staff/toStaffDirectList")
    public String toStaffDirectList(){
        return "/business/staff/staffeDirectList";
    }

    @ResponseBody
    @RequestMapping("/Staff/getStaffList")
    public Map<String,Object> getStaffList(Staff staff,int draw, int start, int length,String type) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         staff.setType(type);
         List<Staff> list =  staffService.getStaffList(staff);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         if ("2".equals(staff.getType())){
             for (Staff sta : list) {
                 sta.setPoliticalcounselor("0".equals(sta.getPoliticalcounselor())?"否":"是");
                 sta.setPsychologicalconsultant("0".equals(sta.getPsychologicalconsultant())?"否":"是");
             }
         }
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/Staff/toStaffAdd")
    public String toAddStaff(Model model) {
        model.addAttribute("head", "新增");
        return "/business/staff/staffEdit";
    }

    @RequestMapping("/Staff/toStaffStudentAdd")
    public String toStaffStudentAdd(Model model){
        model.addAttribute("head", "新增");
        return "/business/staff/staffStudentEdit";
    }

    @RequestMapping("/Staff/toStaffEnrollingAdd")
    public String toStaffEnrollingAdd(Model model){
        model.addAttribute("head", "新增");
        return "/business/staff/staffEnrollingEdit";
    }

    @RequestMapping("/Staff/toStaffDirectAdd")
    public String toStaffDirectAdd(Model model){
        model.addAttribute("head", "新增");
        return "/business/staff/staffDirectEdit";
    }

    @ResponseBody
    @RequestMapping("/Staff/saveStaff")
    public Message saveStaff(Staff staff) {
        if (null != staff.getPersonid() && !"".equals(staff.getPersonid())) {
            CommonUtil.update(staff);
            staffService.updateStaff(staff);
            return new Message(0, "修改成功！", null);
        } else {
            try {
                CommonUtil.save(staff);
                staff.setPersonid(staff.getPersonidvalue());
                staffService.saveStaff(staff);
                return new Message(1, "添加成功！", "success");
            } catch (Exception e) {
                e.printStackTrace();
                return new Message(0, "教职工添加不合理！", "error");
            }

        }
    }

    @RequestMapping("/Staff/toStaffEdit")
    public String toEditStaff(String id, String type,Model model) {
        Staff staff = staffService.getStaffById(id);
        AutoComplete autoComplete =  staffService.getPersonDept(staff.getPersonid());
        staff.setPerson(autoComplete.getLabel());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        staff.setGetDateStr(simpleDateFormat.format(staff.getGetdate()));
        model.addAttribute("data", staff);
        model.addAttribute("head", "修改");
        return "/business/staff/staffEdit";
    }

    @RequestMapping("/Staff/toStaffStudentEdit")
    public String toStaffStudentEdit(String id, String type,Model model) {
        Staff staff = staffService.getStaffById(id);
        AutoComplete autoComplete =  staffService.getPersonDept(staff.getPersonid());
        staff.setPerson(autoComplete.getLabel());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        staff.setGetDateStr(simpleDateFormat.format(staff.getGetdate()));
        model.addAttribute("data", staff);
        model.addAttribute("head", "修改");
        return "/business/staff/staffStudentEdit";
    }

    @RequestMapping("/Staff/toStaffEnrollingEdit")
    public String toStaffEnrollingEdit(String id, String type,Model model) {
        Staff staff = staffService.getStaffById(id);
        AutoComplete autoComplete =  staffService.getPersonDept(staff.getPersonid());
        staff.setPerson(autoComplete.getLabel());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        staff.setGetDateStr(simpleDateFormat.format(staff.getGetdate()));
        model.addAttribute("data", staff);
        model.addAttribute("head", "修改");
        return "/business/staff/staffEnrollingEdit";
    }

    @RequestMapping("/Staff/toStaffDirectEdit")
    public String toStaffDirectEdit(String id, String type,Model model) {
        Staff staff = staffService.getStaffById(id);
        AutoComplete autoComplete =  staffService.getPersonDept(staff.getPersonid());
        staff.setPerson(autoComplete.getLabel());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        staff.setGetDateStr(simpleDateFormat.format(staff.getGetdate()));
        model.addAttribute("data", staff);
        model.addAttribute("head", "修改");
        return "/business/staff/staffDirectEdit";
    }

    @ResponseBody
    @RequestMapping("/Staff/delStaff")
    public Message delStaff(String id) {
        staffService.delStaff(id);
        return new Message(0, "删除成功！", null);
    }

}
