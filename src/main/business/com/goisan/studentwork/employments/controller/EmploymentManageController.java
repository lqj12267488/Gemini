package com.goisan.studentwork.employments.controller;

import com.goisan.studentwork.employments.bean.EmploymentManage;
import com.goisan.studentwork.employments.service.EmploymentManageService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hanyu on 2017/8/11.
 */
@Controller
public class EmploymentManageController {
    @Resource
    private EmploymentManageService employmentManageService;

    /**
     * 学生实习查询
     * @return
     */
    @RequestMapping("/employments/statistics")
    public ModelAndView employmentManageChaXun() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/employments/employmentStatistics");
        return mv;
    }

    /**
     * 学生实习统计
     * @return
     */
    @RequestMapping("/internships/select")
    public ModelAndView employmentManageTongJi() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/employments/employmentSelectTongJi");
        return mv;
    }

    /**
     * 统计页面初始化
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/employments/employmentSelectTongJi")
    public Map<String, List<EmploymentManage>> employmentSelectTongJi(EmploymentManage employmentManage) {
        Map<String, List<EmploymentManage>> employmentManageMap = new HashMap<String, List<EmploymentManage>>();
        employmentManageMap.put("data", employmentManageService.employmentSelectStatistics(employmentManage));
        return employmentManageMap;
    }
    /**
     * 就业单位统计URL
     *  url by hanyue
     *  modify by hanyue
     * @param employmentManage
     * @return
     */

    @ResponseBody
    @RequestMapping("/employments/selectEmploymentStatistics")
    public Map<String, List<EmploymentManage>> selectEmploymentStatistics(EmploymentManage employmentManage) {
        Map<String, List<EmploymentManage>> employmentManageMap = new HashMap<String, List<EmploymentManage>>();
        employmentManageMap.put("data", employmentManageService.selectEmploymentStatistics(employmentManage));
        return employmentManageMap;
    }
    /**
     * 实习单位维护跳转
     * request by hanyue
     * modify by hanyue
     * @return
     */

    @RequestMapping("/employments/manage")
    public ModelAndView employmentManageList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/employments/employmentManageList");
        return mv;
    }
    @RequestMapping("/employmentManage/getEmploymentManageId")
    public ModelAndView getEmploymentManageId(String employmentId) {
        EmploymentManage employmentManage= employmentManageService.getEmploymentManageById(employmentId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("employmentManage",employmentManage);
        mv.setViewName("/business/studentwork/employments/selectEmploymentList");
        return mv;
    }

    /**
     * 实习单位维护URL
     *  url by hanyue
     *  modify by hanyue
     * @param employmentManage
     * @return
     */

    @ResponseBody
    @RequestMapping("/employmentManage/EmploymentManageAction")
    public Map<String, List<EmploymentManage>> EmploymentManageAction(EmploymentManage employmentManage) {
        Map<String, List<EmploymentManage>> employmentManageMap = new HashMap<String, List<EmploymentManage>>();
        employmentManage.setDepartmentsId(CommonUtil.getDefaultDept());
        employmentManage.setLevel(CommonUtil.getLoginUser().getLevel());
        employmentManageMap.put("data", employmentManageService.EmploymentManageAction(employmentManage));
        return employmentManageMap;
    }

    /**
     * 实习单位维护修改
     * update by hanyue
     * modify by hanyue
     * @param employmentId
     * @return
     */

    @ResponseBody
    @RequestMapping("/employmentManage/getEmploymentManageById")
    public ModelAndView getEmploymentManageById(String employmentId) {
        EmploymentManage employmentManage = employmentManageService.getEmploymentManageById(employmentId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "就业信息修改");
        mv.addObject("employmentManage", employmentManage);
        mv.setViewName("/business/studentwork/employments/editEmploymentManage");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/employmentManage/editAddEmploymentManageById")
    public ModelAndView editAddEmploymentManageById(String employmentId) {
        EmploymentManage employmentManage = employmentManageService.getEmploymentManageById(employmentId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "就业信息修改");
        mv.addObject("employmentManage", employmentManage);
        mv.setViewName("/business/studentwork/employments/editAddEmploymentManage");
        return mv;
    }
    /**
     * 实习单位维护新增
     * add by hanyue
     * modify by hanyue
     * @return
     */

    @ResponseBody
    @RequestMapping("/employmentManage/addEmploymentManage")
    public ModelAndView addEmploymentManage() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/employments/addEmploymentManage");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String date = formatDate.format(new Date());
        EmploymentManage employmentManage=new EmploymentManage();
        employmentManage.setEmploymentYear(date);
        mv.addObject("head", "就业信息维护");
        mv.addObject("employmentManage",employmentManage);
        return mv;
    }
    /**
     * 删除实习单位
     * delete by hanyue
     * modify by hanyue
     * @param employmentId
     * @return
     */

    @ResponseBody
    @RequestMapping("/employmentManage/deleteEmploymentManageById")
    public Message deleteEmploymentManageById(String employmentId) {
        employmentManageService.deleteEmploymentManageById(employmentId);
        return new Message(1, "删除成功！", null);
    }
    /**
     * 保存实习单位
     * save by hanyue
     * modify by hanyue
     *
     * @param employmentManage
     * @return
     */

    @ResponseBody
    @RequestMapping("/employmentManage/saveEmploymentManage")
    public Message saveEmploymentManage(EmploymentManage employmentManage){
        if(employmentManage.getEmploymentId()==null || employmentManage.getEmploymentId().equals("")){
            employmentManage.setCreator(CommonUtil.getPersonId());
            employmentManage.setCreateDept(CommonUtil.getDefaultDept());
            employmentManageService.insertEmploymentManage(employmentManage);
            return new Message(1, "新增成功！", null);
        }else{
            employmentManage.setChanger(CommonUtil.getPersonId());
            employmentManage.setChangeDept(CommonUtil.getDefaultDept());
            employmentManageService.updateEmploymentManageById(employmentManage);
            return new Message(1, "修改成功！", null);
        }
    }
    @ResponseBody
    @RequestMapping("/employmentManage/selectEmploymentArea")
    public String selectEmploymentArea(String employmentUnitId) {
        String string=employmentManageService.selectEmploymentArea(employmentUnitId);
        try {
            string =java.net.URLEncoder.encode(string,"UTF-8");
            string =java.net.URLEncoder.encode(string,"UTF-8");
        } catch (UnsupportedEncodingException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        return  string;
    }

    @ResponseBody
    @RequestMapping("/employmentManage/selectEmploymentType")
    public String selectEmploymentType(String employmentId){
        return employmentManageService.selectEmploymentType(employmentId);
    }
}
