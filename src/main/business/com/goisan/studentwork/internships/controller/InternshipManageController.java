package com.goisan.studentwork.internships.controller;

import com.goisan.studentwork.internships.bean.InternshipManage;
import com.goisan.studentwork.internships.service.InternshipManageService;
import com.goisan.system.bean.Student;
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
 * Created by hanyu on 2017/8/1.
 */
@Controller
public class InternshipManageController {
    @Resource
    private InternshipManageService internshipManageService;
    @RequestMapping("/internships/statistics")
    public ModelAndView internshipManageTongJi() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/internships/statistics");
        return mv;
    }
    /**
     * 详情url
     */
    @ResponseBody
    @RequestMapping("/internshipManage/selectInternshipManage")
    public Map<String, List<InternshipManage>> selectInternshipManage(String  internshipId) {
        Map<String, List<InternshipManage>> internshipManageMap = new HashMap<String, List<InternshipManage>>();
        internshipManageMap.put("data", internshipManageService.selectInternshipManage(internshipId));
        return internshipManageMap;
    }

   /*@RequestMapping("/internships/internshipManageList1")
    public String internshipExt1(Model model) {
        return "/business/studentwork/internships/internshipManageList";
    }
    */
    /**
     * 实习单位维护跳转
     * request by hanyue
     * modify by hanyue
     * @return
     */

    @RequestMapping("/internships/manage")
    public ModelAndView internshipManageList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/internships/internshipManageList");
        return mv;
    }
    @RequestMapping("/internshipManage/getInternshipManageId")
    public ModelAndView getInternshipManageId(String internshipId,String studentIdShow) {
        InternshipManage internshipManage= internshipManageService.selectId(internshipId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("internshipChangeLog",internshipManage);
        mv.addObject("studentIdShow",studentIdShow);
        mv.setViewName("/business/studentwork/internships/internshipChangeLogList");
        return mv;
    }

    /**
     * 实习单位维护URL
     *  url by hanyue
     *  modify by hanyue
     * @param internshipManage
     * @return
     */

    @ResponseBody
    @RequestMapping("/internshipManage/InternshipManageAction")
    public Map<String, List<InternshipManage>> InternshipManageAction(InternshipManage internshipManage) {
        Map<String, List<InternshipManage>> internshipManageMap = new HashMap<String, List<InternshipManage>>();
        internshipManageMap.put("data", internshipManageService.InternshipManageAction(internshipManage));
        return internshipManageMap;
    }

    /**
     * 实习单位维护修改
     * update by hanyue
     * modify by hanyue
     * @param internshipId
     * @return
     */

    @ResponseBody
    @RequestMapping("/internshipManage/getInternshipManageById")
    public ModelAndView getInternshipManageById(String internshipId) {
        InternshipManage internshipManage = internshipManageService.getInternshipManageById(internshipId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "顶岗实习修改");
        mv.addObject("internshipManage", internshipManage);
        mv.setViewName("/business/studentwork/internships/editInternshipManage");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/internshipManage/editAddInternshipManageById")
    public ModelAndView editAddInternshipManageById(String internshipId) {
        InternshipManage internshipManage = internshipManageService.getInternshipManageById(internshipId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "顶岗实习修改");
        mv.addObject("internshipManage", internshipManage);
        mv.setViewName("/business/studentwork/internships/editAddInternshipManage");
        return mv;
    }

    /**
     * 查看详情跳转页面
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("/internshipManage/getInternshipManage")
    public ModelAndView getInternshipManage(String internshipId,String studentIdShow) {
        ModelAndView mv = new ModelAndView();
        InternshipManage internshipManage= internshipManageService.selectId(internshipId);
        mv.addObject("internshipManage",internshipManage);
        mv.addObject("studentIdShow",studentIdShow);
        mv.setViewName("/business/studentwork/internships/internshipChangeLogList");
        /*mv.addObject("internshipManage",internshipId);*/
        return mv;
    }
    /**
     * 实习单位维护新增
     * add by hanyue
     * modify by hanyue
     * @return
     */

    @ResponseBody
    @RequestMapping("/internshipManage/addInternshipManage")
    public ModelAndView addInternshipManage() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/internships/addInternshipManage");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String date = formatDate.format(new Date());
        InternshipManage internshipManage=new InternshipManage();
        internshipManage.setPostsTime(date);
        mv.addObject("head", "顶岗实习维护");
        mv.addObject("internshipManage",internshipManage);
        return mv;
    }

    /**
     * 实习单位变更新增
     * add by hanyue
     * modify by hanyue
     * @return
     */

    @ResponseBody
    @RequestMapping("/internshipManage/addInternshipChangeLog")
    public ModelAndView addInternshipChangeLog(String internshipId) {
        InternshipManage internshipManage=internshipManageService.select(internshipId);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/internships/editInternshipChangeLog");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String date = formatDate.format(new Date());
        internshipManage.setAlertTime(date);
        mv.addObject("head", "实习单位变更");
        mv.addObject("internshipChangeLog", internshipManage);
        return mv;
    }
    /**
     * 删除实习单位
     * delete by hanyue
     * modify by hanyue
     * @param internshipId
     * @return
     */

    @ResponseBody
    @RequestMapping("/internshipManage/deleteInternshipManageById")
    public Message deleteInternshipManageById(String internshipId) {
        internshipManageService.deleteInternshipManageById(internshipId);
        return new Message(1, "删除成功！", null);
    }
    /**
     * /internshipManage/selectInternshipChangeFlag
     * 保存实习单位
     * save by hanyue
     * modify by hanyue
     * @param internshipManage
     * @return
     */

    @ResponseBody
    @RequestMapping("/internshipManage/saveInternshipManage")
    public Message saveInternshipManage(InternshipManage internshipManage){
        if(internshipManage.getInternshipId()==null || internshipManage.getInternshipId().equals("")){
            internshipManage.setCreator(CommonUtil.getPersonId());
            internshipManage.setCreateDept(CommonUtil.getDefaultDept());
            internshipManageService.insertInternshipManage(internshipManage);
            return new Message(1, "新增成功！", null);
        }else{
            internshipManage.setChanger(CommonUtil.getPersonId());
            internshipManage.setChangeDept(CommonUtil.getDefaultDept());
            internshipManageService.updateInternshipManageById(internshipManage);
            return new Message(1, "修改成功！", null);
        }
    }
    @ResponseBody
    @RequestMapping("/internshipManage/getStudentByStudentNumber")
    public Map getStudentByStudentNumber(String studentNumber) {
        Student student = internshipManageService.selectStudent(studentNumber);
        Map studentList = new HashMap();
        studentList.put("sex",student.getSex());
        studentList.put("idcard",student.getIdcard());
        studentList.put("studentId",student.getStudentId());
        studentList.put("classId",student.getClassId());
        studentList.put("departmentsId",student.getDepartmentsId());
        studentList.put("majorCode",student.getMajorCode());
        studentList.put("trainingLevel",student.getTrainingLevel());
        return studentList;
    }

    @ResponseBody
    @RequestMapping("/internshipManage/selectArea")
    public String selectArea(String internshipUnitId) {
        String string=internshipManageService.selectArea(internshipUnitId);
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
    @RequestMapping("/internshipManage/selectInternshipType")
    public String selectInternshipType(String internshipId) {
        return internshipManageService.selectInternshipType(internshipId);
    }
}
