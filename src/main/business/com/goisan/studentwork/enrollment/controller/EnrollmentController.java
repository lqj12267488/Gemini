package com.goisan.studentwork.enrollment.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.stuxuhai.jpinyin.PinyinException;
import com.github.stuxuhai.jpinyin.PinyinFormat;
import com.github.stuxuhai.jpinyin.PinyinHelper;
import com.goisan.educational.major.bean.Major;
import com.goisan.educational.major.service.MajorService;
import com.goisan.studentwork.enrollment.bean.Enrollment;
import com.goisan.studentwork.enrollment.bean.EnrollmentStudent;
import com.goisan.studentwork.enrollment.dao.EnrollmentDao;
import com.goisan.studentwork.enrollment.service.EnrollmentService;
import com.goisan.system.bean.*;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.DeptService;
import com.goisan.system.service.LoginUserService;
import com.goisan.system.service.StudentService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2017/8/30.
 */
@Controller
public class EnrollmentController {
    @Resource
    private EnrollmentDao enrollmentDao;
    @Resource
    private EnrollmentService enrollmentService;
    @Resource
    private MajorService majorService;
    @Resource
    private StudentService studentService;
    @Resource
    private LoginUserService loginUserService;
    @Resource
    private CommonService commonService;

    //招生计划维护URL
    @RequestMapping("/enrollment")
    public ModelAndView enrollmentList() {
        ModelAndView mv = new ModelAndView();
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
        String year = formatDate.format(new java.util.Date());
        mv.addObject("year", year);
        mv.setViewName("/business/studentwork/enrollment/enrollmentList");
        return mv;
    }


    //招生计划统计URL
    @RequestMapping("/enrollment/count")
    public ModelAndView enrollmentStatistics(){
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
        String year = formatDate.format(new java.util.Date());
        ModelAndView mv = new ModelAndView();
        mv.addObject("year",year);
        mv.setViewName("/business/studentwork/enrollment/enrollmentCount");
        return mv;
    }

    //新生报到登记URL
    @RequestMapping("/enrollment/studentRegister")
    public ModelAndView newStuRegister(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/enrollment/studentRegister");
        return mv;
    }
    //新生报到登记维护
    @RequestMapping("/enrollment/stuMaintain")
    public ModelAndView stuMaintain(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/enrollment/stuMaintain");
        return mv;
    }
    //新生报到修改
    @RequestMapping("/enrollment/editStuMaintain")
    public ModelAndView updateStuMaintain(String studentId) {
        EnrollmentStudent enrollmentstudent = enrollmentService.getEnrollmentStudentById(studentId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "修改登记信息");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
        String year = formatDate.format(new Date());;
        enrollmentstudent.setJoinYear(year);
        mv.addObject("enrollmentstudent", enrollmentstudent);
        mv.setViewName("/business/studentwork/enrollment/editStuMaintain");
        return mv;
    }

    //保存批量修改报到状态
    @ResponseBody
    @RequestMapping("/enrollment/saveAllStuMaintain")
    public Message saveManyPlan(String ids,String id,String reportStatus) {
        String idArray[]=id.split(",");
        for(String studentId:idArray){
                EnrollmentStudent newEnrollment = new EnrollmentStudent();
                newEnrollment.setStudentId(studentId);
                newEnrollment.setReportStatus(reportStatus);
                enrollmentService.updateAllStuMaintain(newEnrollment);
        }
        return new Message(1, "保存成功", null);
    }
    //批量取消报到状态
    @ResponseBody
    @RequestMapping("/enrollment/saveAllStuMaintainCancel")
    public Message saveAllStuMaintainCancel(String ids,String id,String reportStatus) {
        String idArray[]=id.split(",");
        for(String studentId:idArray){
            EnrollmentStudent newEnrollment = new EnrollmentStudent();
            newEnrollment.setStudentId(studentId);
            newEnrollment.setReportStatus(reportStatus);
            enrollmentService.updateAllStuMaintainCancel(newEnrollment);
        }
        return new Message(1, "保存成功", null);
    }
    //新生报到维护查询
    @ResponseBody
    @RequestMapping("/enrollment/getStuEnrollmentList")
    public Map<String,List<EnrollmentStudent>> getEnrollmentList(EnrollmentStudent enrollmentStudent,String majorCode,String departmentsId,String name){
        Map<String,List<EnrollmentStudent>> map = new HashMap<String, List<EnrollmentStudent>>();
        enrollmentStudent.setMajorCode(majorCode);
        enrollmentStudent.setDepartmentsId(departmentsId);
        enrollmentStudent.setName(name);
        map.put("data",enrollmentService.getStuEnrollmentList(enrollmentStudent));

        return map;
    }
    //新生分班URL
    @RequestMapping("/enrollment/studentDistribute")
    public ModelAndView newStuPlacement(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/enrollment/studentDistribute");
        return mv;
    }

    //新生报到统计URL
    @RequestMapping("/enrollment/studentEnrollmentCount")
    public ModelAndView studenEnrollmentCount(){
        ModelAndView mv = new ModelAndView();
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
        String year = formatDate.format(new java.util.Date());
        mv.addObject("year",year);
        mv.setViewName("/business/studentwork/enrollment/studenEnrollmentCount");
        return mv;
    }
    //专业招生统计URL
    @RequestMapping("/enrollment/majorEnrollmentCount")
    public ModelAndView majorEnrollmentCount(){
        ModelAndView mv = new ModelAndView();
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
        String year = formatDate.format(new java.util.Date());

        mv.addObject("year",year);
        mv.setViewName("/business/studentwork/enrollment/majorEnrollmentCount");
        return mv;
    }

    //历年招生统计URL
    @RequestMapping("/enrollment/enrollmentCountOverYears")
    public ModelAndView enrollmenCountOverYears(){
        ModelAndView mv = new ModelAndView();
        Enrollment enrollment=new Enrollment();
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
        String year = formatDate.format(new java.util.Date());
        enrollment.setYear(year);
        List <Enrollment> List=enrollmentService.findOverYearsList(enrollment);
        List<SysDic>yearList=enrollmentService.findYearsList();
        for(int i=0;i<List.size();i++){
            if("2017".equals(year)){
                if(List.get(i).getSeventeenNumber()==null){
                    List.get(i).setSeventeenNumber("0");
                }
                if(List.get(i).getSixteenNumber()==null){
                    List.get(i).setSixteenNumber("0");
                }
                if(List.get(i).getFiveteenNumber()==null){
                    List.get(i).setFiveteenNumber("0");
                }
                if(List.get(i).getFourteenNumber()==null){
                    List.get(i).setFourteenNumber("0");
                }

            }
            if("2018".equals(year)){
                if(List.get(i).getEigthteenNumber()==null){
                    List.get(i).setEigthteenNumber("0");
                }
                if(List.get(i).getSeventeenNumber()==null){
                    List.get(i).setSeventeenNumber("0");
                }
                if(List.get(i).getSixteenNumber()==null){
                    List.get(i).setSixteenNumber("0");
                }
                if(List.get(i).getFiveteenNumber()==null){
                    List.get(i).setFiveteenNumber("0");
                }
                if(List.get(i).getFourteenNumber()==null){
                    List.get(i).setFourteenNumber("0");
                }
            }
            if("2019".equals(year)){
                if(List.get(i).getNineteenNumber()==null){
                    List.get(i).setNineteenNumber("0");
                }
                if(List.get(i).getEigthteenNumber()==null){
                    List.get(i).setEigthteenNumber("0");
                }
                if(List.get(i).getSeventeenNumber()==null){
                    List.get(i).setSeventeenNumber("0");
                }
                if(List.get(i).getSixteenNumber()==null){
                    List.get(i).setSixteenNumber("0");
                }
                if(List.get(i).getFiveteenNumber()==null){
                    List.get(i).setFiveteenNumber("0");
                }
                if(List.get(i).getFourteenNumber()==null){
                    List.get(i).setFourteenNumber("0");
                }
            }
            if("2020".equals(year)){
                if(List.get(i).getTwentyNumber()==null){
                    List.get(i).setTwentyNumber("0");
                }
                if(List.get(i).getNineteenNumber()==null){
                    List.get(i).setNineteenNumber("0");
                }
                if(List.get(i).getEigthteenNumber()==null){
                    List.get(i).setEigthteenNumber("0");
                }
                if(List.get(i).getSeventeenNumber()==null){
                    List.get(i).setSeventeenNumber("0");
                }
                if(List.get(i).getSixteenNumber()==null){
                    List.get(i).setSixteenNumber("0");
                }
                if(List.get(i).getFiveteenNumber()==null){
                    List.get(i).setFiveteenNumber("0");
                }
                if(List.get(i).getFourteenNumber()==null){
                    List.get(i).setFourteenNumber("0");
                }
            }
        }
        mv.addObject("yearList",yearList);
        mv.addObject("year",year);
        mv.addObject("list",List);
        mv.setViewName("/business/studentwork/enrollment/enrollmenCountOverYears");
        return mv;
    }
    //招生结果查看
    @RequestMapping("/enrollment/enrollmentStudentResult")
    public ModelAndView enrollmentStudentResult(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/enrollment/enrollmentStudentResult");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/enrollment/studentDetailsResult")
    public Map getEnrollmentStudent(String name,String idcard){
        EnrollmentStudent enrollmentStudent=new EnrollmentStudent();
        enrollmentStudent.setName(name);
        enrollmentStudent.setIdcard(idcard);
        Map map = enrollmentService.getEnrollmentStudent(enrollmentStudent);
        return map;
    }
    //招生结果查看
    @RequestMapping("/enrollment/enrollmentResult")
    public ModelAndView enrollmentResultByIdCard(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/enrollment/enrollmentResult");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/enrollment/result")
    public Message enrollmentResult(String name,String idcard){
        EnrollmentStudent enrollmentStudent=new EnrollmentStudent();
        enrollmentStudent.setName(name);
        enrollmentStudent.setIdcard(idcard);
        EnrollmentStudent enrollment= enrollmentDao.getStudentDetailsResultList(enrollmentStudent);
        if(null == enrollment.getDepartmentShow()){
            enrollment.setDepartmentShow("");
        }
        if(null == enrollment.getMajorShow()){
            enrollment.setMajorShow("");
        }
        if(enrollment!=null){
            String  string = "恭喜！您已经被我校录取！"+"录取系部："+enrollment.getDepartmentShow()+","+"录取专业："+enrollment.getMajorShow();
            return new Message(1, string, null);
        }
        return new Message(0, "" +
                "抱歉！暂时没有查询到您的录取信息！", null);
    }
    //新生信息综合查询URL
    @RequestMapping("/enrollment/enrollmentStudentInfo")
    public ModelAndView enrollmentStudentInfo(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/enrollment/enrollmentStudentInfo");
        return mv;
    }
    //新生信息综合查询列表数据
    @ResponseBody
    @RequestMapping("/enrollment/getStudentInfoList")
    public Map<String, Object> getStudentInfoList(EnrollmentStudent enrollmentStudent,int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String,Object> enrollmentStudentList = new HashMap<String, Object>();
        //Map<String,List<EnrollmentStudent>> map = new HashMap<String, List<EnrollmentStudent>>();
        if("undefined".equals(enrollmentStudent.getMajorCode()) || "".equals(enrollmentStudent.getMajorCode())){
            enrollmentStudent.setMajorCode(null);
        }
        if("undefined".equals(enrollmentStudent.getMajorDirection()) || "".equals(enrollmentStudent.getMajorDirection())){
            enrollmentStudent.setMajorDirection(null);
        }
        if("undefined".equals(enrollmentStudent.getTrainingLevel()) || "".equals(enrollmentStudent.getTrainingLevel())){
            enrollmentStudent.setTrainingLevel(null);
        }
        if("undefined".equals(enrollmentStudent.getHouseCity()) || "".equals(enrollmentStudent.getHouseCity())){
            enrollmentStudent.setHouseCity(null);
        }
        if("undefined".equals(enrollmentStudent.getHouseCounty()) || "".equals(enrollmentStudent.getHouseCounty())){
            enrollmentStudent.setHouseCounty(null);
        }
        List<EnrollmentStudent> list = enrollmentService.getStudentInfoList(enrollmentStudent);
        PageInfo<List<EnrollmentStudent>> info = new PageInfo(list);
        enrollmentStudentList.put("draw", draw);
        enrollmentStudentList.put("recordsTotal", info.getTotal());
        enrollmentStudentList.put("recordsFiltered", info.getTotal());
        enrollmentStudentList.put("data", list);
        //map.put("data",enrollmentService.getStudentInfoList(enrollmentStudent));
        return enrollmentStudentList;
    }

    //新生信息综合详细
    @RequestMapping("/enrollment/studentDetails")
    public ModelAndView studentDetails(String studentId){
        ModelAndView mv = new ModelAndView();
        EnrollmentStudent enrollmentstudent=enrollmentService.getEnrollmentStudentById(studentId);
        mv.addObject("enrollmentstudent",enrollmentstudent);
        mv.addObject("head","详细信息");
        mv.setViewName("/business/studentwork/enrollment/studentDetails");
        return mv;
    }
    //招生计划维护（招生计划统计）列表数据
    @ResponseBody
    @RequestMapping("/enrollment/getEnrollmentList")
    public Map<String, Object> getEnrollmentList(Enrollment enrollment,String flag,int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String,Object> enrollmentList = new HashMap<String, Object>();
        String deptId=null;
//        if("plan".equals(flag)){
//            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
//            String year = formatDate.format(new java.util.Date());
//            if(enrollment.getYear()==null || "".equals(enrollment.getYear())){
//                enrollment.setYear(year);
//            }
//        }
//        if("count".equals(flag)){
//            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
//            String year = formatDate.format(new java.util.Date());;
//            enrollment.setYear(year);
//        }
//
//        if(enrollment.getYear()==null || "".equals(enrollment.getYear())){
//            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
//            String year = formatDate.format(new java.util.Date());
//            enrollment.setYear(year);
//        }
        /**
         * 修改, 如果没有年份，默认是今年
         * 如果有年份，则按年份进行过滤
         */
        if (enrollment.getYear()==null || "".equals(enrollment.getYear())){
            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
            String year = formatDate.format(new java.util.Date());
            enrollment.setYear(year);
        }else {
            //            YearFlag 1 为请选择
            if ("0".equals(enrollment.getYear())){
                enrollment.setYearFlag("1");
            }
            enrollment.setYear(enrollment.getYear());
        }
        if("undefined".equals(enrollment.getMajorCode()) || "0".equals(enrollment.getMajorCode()) || "请选择系部".equals(enrollment.getMajorCode())){
            enrollment.setMajorCode(null);
        }
        if("".equals(enrollment.getDepartmentsId())){
            enrollment.setDepartmentsId(null);
        }
        if("".equals(enrollment.getSchoolSystem())){
            enrollment.setSchoolSystem(null);
        }
        if("".equals(enrollment.getTrainingLevel())){
            enrollment.setTrainingLevel(null);
        }
        List<Enrollment> list = enrollmentService.getEnrollmentList(enrollment);
//        for (Enrollment enrollment1 : list) {
//            String aNull = enrollment1.getYear().equals("null") ? "" : enrollment1.getYear();
//            enrollment1.setYear(aNull);
//        }
        PageInfo<List<Enrollment>> info = new PageInfo(list);
        enrollmentList.put("draw", draw);
        enrollmentList.put("recordsTotal", info.getTotal());
        enrollmentList.put("recordsFiltered", info.getTotal());
        enrollmentList.put("data", list);
       // map.put("data",enrollmentService.getEnrollmentList(enrollment));
        return enrollmentList;
    }

    //专业招生统计列表数据
    @ResponseBody
    @RequestMapping("/enrollment/getMajorEnrollmentList")
    public Map<String, Object> getMajorEnrollmentList(Enrollment enrollment,int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String,Object> enrollmentList = new HashMap<String, Object>();
       // Map<String,List<Enrollment>> map = new HashMap<String, List<Enrollment>>();
        if("undefined".equals(enrollment.getTrainingLevel())){
            enrollment.setTrainingLevel(null);
        }
        if("undefined".equals(enrollment.getMajorCode())){
            enrollment.setMajorCode(null);
        }
        List<Enrollment> list = enrollmentService.getMajorEnrollmentList(enrollment);
        PageInfo<List<Enrollment>> info = new PageInfo(list);
        enrollmentList.put("draw", draw);
        enrollmentList.put("recordsTotal", info.getTotal());
        enrollmentList.put("recordsFiltered", info.getTotal());
        enrollmentList.put("data", list);
        //map.put("data",enrollmentService.getMajorEnrollmentList(enrollment));
        return enrollmentList;
    }

    //登记学生列表数据
    @ResponseBody
    @RequestMapping("/enrollment/getEnrollmentStudentList")
    public Map<String, Object> getEnrollmentStudentList(EnrollmentStudent enrollmentStudent,int draw, int start, int length){

        Map<String,Object> enrollmentStudentList = new HashMap<String, Object>();
        LoginUser loginUser=CommonUtil.getLoginUser();
        String sa = loginUser.getPersonId();
        List<EnrollmentStudent> list = null;
        PageHelper.startPage(start / length + 1, length);
        if (sa.equals("sa")){
            enrollmentStudent.setCreator(CommonUtil.getPersonId());
            enrollmentStudent.setCreateDept(CommonUtil.getDefaultDept());
//             enrollmentStudentList.put("data", enrollmentService.getEnrollmentStudentList(enrollmentStudent));
             list = enrollmentService.getEnrollmentStudentList(enrollmentStudent);
         }else {
            if (CommonUtil.getDefaultDept().equals("001008") || CommonUtil.getDefaultDept().equals("001012")) {
                enrollmentStudent.setDepartmentsId(null);
                enrollmentStudent.setCreator(CommonUtil.getPersonId());
                enrollmentStudent.setCreateDept(CommonUtil.getDefaultDept());
//                enrollmentStudentList.put("data", enrollmentService.getEnrollmentStudentList(enrollmentStudent));
                list = enrollmentService.getEnrollmentStudentList(enrollmentStudent);
            } else {
                //enrollmentStudent.setDepartmentsId(CommonUtil.getDefaultDept());
                enrollmentStudent.setCreator(CommonUtil.getPersonId());
                enrollmentStudent.setCreateDept(CommonUtil.getDefaultDept());
//                enrollmentStudentList.put("data", enrollmentService.getEnrollmentStudentList(enrollmentStudent));
                list = enrollmentService.getEnrollmentStudentList(enrollmentStudent);
            }
        }

        //List<EnrollmentStudent> list = enrollmentService.getEnrollmentStudentList(enrollmentStudent);
       // PageInfo<List<EnrollmentStudent>> info = new PageInfo(list);
//        PageInfo<List<EnrollmentStudent>> info = new PageInfo(enrollmentService.getEnrollmentStudentList(enrollmentStudent));
        PageInfo<List<EnrollmentStudent>> info = new PageInfo(list);
        enrollmentStudentList.put("draw", draw);
        enrollmentStudentList.put("recordsTotal", info.getTotal());
        enrollmentStudentList.put("recordsFiltered", info.getTotal());
       //enrollmentStudentList.put("data", enrollmentService.getEnrollmentStudentList(enrollmentStudent));
        //enrollmentStudentList.put("data", list);
        enrollmentStudentList.put("data", list);
        return enrollmentStudentList;
    }

    //学生分班列表数据
    @ResponseBody
    @RequestMapping("/enrollment/getDistributeStudentList")
    public Map<String, Object> getDistributeStudentList(EnrollmentStudent enrollmentStudent,int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String,Object> enrollmentStudentList = new HashMap<String, Object>();
        //Map<String,List<EnrollmentStudent>> map = new HashMap<String, List<EnrollmentStudent>>();
        enrollmentStudent.setCreator(CommonUtil.getPersonId());
        enrollmentStudent.setCreateDept(CommonUtil.getDefaultDept());
        if("undefined".equals(enrollmentStudent.getMajorCode()) || "".equals(enrollmentStudent.getMajorCode()) || "0".equals(enrollmentStudent.getMajorCode())){
            enrollmentStudent.setMajorCode(null);
        }
        if("undefined".equals(enrollmentStudent.getClassId()) || "".equals(enrollmentStudent.getClassId()) || "0".equals(enrollmentStudent.getClassId())){
            enrollmentStudent.setClassId(null);
        }
        List<EnrollmentStudent> list = enrollmentService.getDistributeStudentList(enrollmentStudent);
       // map.put("data",enrollmentService.getDistributeStudentList(enrollmentStudent));
        PageInfo<List<EnrollmentStudent>> info = new PageInfo(list);
        enrollmentStudentList.put("draw", draw);
        enrollmentStudentList.put("recordsTotal", info.getTotal());
        enrollmentStudentList.put("recordsFiltered", info.getTotal());
        enrollmentStudentList.put("data", list);
        return enrollmentStudentList;
    }

    //保存设置招生人数
    @ResponseBody
    @RequestMapping("/enrollment/saveSinglePlan")
    public Message saveSinglePlan(Enrollment enrollment) {
        String majorId=enrollment.getMajorId();
        String year=enrollment.getYear();
//        String number=enrollment.getPlanNumber();
//        Enrollment  old= enrollmentService.selectEnrollmentByMajorId(majorId,year);
//        if(old!=null){
//            CommonUtil.update(enrollment);
//            enrollmentService.updateEnrollment(enrollment);
//        }else{
//            Major major=majorService.getMajorByMajorId(majorId);
//            enrollment.setId(CommonUtil.getUUID());
//            enrollment.setDepartmentsId(major.getDepartmentsId());
//            enrollment.setMajorCode(major.getMajorCode());
//            enrollment.setMajorDirection(major.getMajorDirection());
//            enrollment.setSchoolSystem(major.getSchoolSystem());
//            enrollment.setTrainingLevel(major.getTrainingLevel());
//            enrollment.setRealNumber("0");
//            CommonUtil.save(enrollment);
//            enrollmentService.saveEnrollment(enrollment);
//        }
        if (!"null".equals(year)){
            CommonUtil.update(enrollment);
            enrollmentService.updateEnrollment(enrollment);
        }else {
            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
            year = formatDate.format(new java.util.Date());
            enrollment.setYear(year);
            Enrollment  old= enrollmentService.selectEnrollmentByMajorId(majorId,year);
            if(old!=null){
            CommonUtil.update(enrollment);
            enrollmentService.updateEnrollment(enrollment);
        }else {
                Major major = majorService.getMajorByMajorId(majorId);
                enrollment.setId(CommonUtil.getUUID());
                enrollment.setDepartmentsId(major.getDepartmentsId());
                enrollment.setMajorCode(major.getMajorCode());
                enrollment.setMajorDirection(major.getMajorDirection());
                enrollment.setSchoolSystem(major.getSchoolSystem());
                enrollment.setTrainingLevel(major.getTrainingLevel());
                enrollment.setRealNumber("0");
                CommonUtil.save(enrollment);
                enrollmentService.saveEnrollment(enrollment);
            }
        }
        return new Message(1, "保存成功", null);

    }
    //设置招生计划页面
    @RequestMapping("/enrollment/addEnrollmentPlan")
    public ModelAndView addEnrollmentPlan(String majorId,String year){
        ModelAndView mv = new ModelAndView();
        mv.addObject("majorId",majorId);
        mv.addObject("year",year);
        mv.addObject("head","设置招生计划");
        Enrollment enrollment= enrollmentService.selectEnrollmentByMajorId(majorId,year);
        mv.addObject("enrollment",enrollment);
        mv.setViewName("/business/studentwork/enrollment/addEnrollmentPlan");
        return mv;
    }
    //批量设置招生人数页面
    @RequestMapping("/enrollment/batchAddEnrollmentPlan")
    public ModelAndView batchAddEnrollmentPlan(String ids,String id,String year){
        ModelAndView mv = new ModelAndView();
        mv.addObject("ids",ids);
        mv.addObject("id",id);
        mv.addObject("hyear",year);
        mv.addObject("head","批量设置招生计划");
        mv.setViewName("/business/studentwork/enrollment/batchAddEnrollmentPlan");
        return mv;
    }
    //保存批量设置招生人数
    @ResponseBody
    @RequestMapping("/enrollment/saveManyPlan")
    public Message saveManyPlan(String ids,String id,Enrollment enrollment) {
        String year=enrollment.getYear();
        String number=enrollment.getPlanNumber();
        String idArray[]=id.split(",");
        for(String majorId:idArray){
            Enrollment old= enrollmentService.selectEnrollmentByMajorId(majorId,year);
            if(old==null){
                Enrollment newEnrollment=new Enrollment();
                Major major=majorService.getMajorByMajorId(majorId);
                newEnrollment.setId(CommonUtil.getUUID());
                newEnrollment.setMajorId(majorId);
                newEnrollment.setDepartmentsId(major.getDepartmentsId());
                newEnrollment.setMajorCode(major.getMajorCode());
                newEnrollment.setMajorDirection(major.getMajorDirection());
                newEnrollment.setSchoolSystem(major.getSchoolSystem());
                newEnrollment.setTrainingLevel(major.getTrainingLevel());
                newEnrollment.setYear(year);
                newEnrollment.setPlanNumber(number);
                newEnrollment.setRealNumber("0");
                newEnrollment.setCooperativeEnterprise(enrollment.getCooperativeEnterprise());
                newEnrollment.setLearningType(enrollment.getLearningType());
                newEnrollment.setMainCourse(enrollment.getMainCourse());
                newEnrollment.setClassAmount(enrollment.getClassAmount());
                newEnrollment.setSkillTicket(enrollment.getSkillTicket());
                newEnrollment.setIssuingUnit(enrollment.getIssuingUnit());
                CommonUtil.save(newEnrollment);
                enrollmentService.saveEnrollment(newEnrollment);
            }else{
                Enrollment enment=new Enrollment();
                enment.setMajorId(majorId);
                enment.setPlanNumber(number);
                enment.setYear(year);
                enment.setCooperativeEnterprise(enrollment.getCooperativeEnterprise());
                enment.setLearningType(enrollment.getLearningType());
                enment.setMainCourse(enrollment.getMainCourse());
                enment.setClassAmount(enrollment.getClassAmount());
                enment.setSkillTicket(enrollment.getSkillTicket());
                enment.setIssuingUnit(enrollment.getIssuingUnit());
                CommonUtil.update(enment);
                enrollmentService.updateEnrollment(enment);
            }
        }

        return new Message(1, "保存成功", null);

    }
    //登记新生
    @RequestMapping("/enrollment/addStudentRegister")
    public ModelAndView editStudentRegister() {
        ModelAndView mv = new ModelAndView();
        EnrollmentStudent enrollmentstudent=new EnrollmentStudent();
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
        String year = formatDate.format(new Date());;
        enrollmentstudent.setJoinYear(year);
        mv.addObject("enrollmentstudent",enrollmentstudent);
        mv.setViewName("/business/studentwork/enrollment/editStudentRegister");
        mv.addObject("head", "新生登记");
        return mv;
    }

    //新生登记修改
    @RequestMapping("/enrollment/editStudentRegister")
    public ModelAndView updateStudentRegister(String studentId) {
        EnrollmentStudent enrollmentstudent = enrollmentService.getEnrollmentStudentById(studentId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "修改登记信息");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
        String year = formatDate.format(new Date());;
        enrollmentstudent.setJoinYear(year);
        mv.addObject("enrollmentstudent", enrollmentstudent);
        mv.setViewName("/business/studentwork/enrollment/editStudentRegister");
        return mv;
    }
    //删除登记学生
    @ResponseBody
    @RequestMapping("/enrollment/delEnrollmentStudent")
    public Message delEnrollmentStudent(String studentId) {
        EnrollmentStudent enrollmentStudent=enrollmentService.getEnrollmentStudentById(studentId);
        if(enrollmentStudent.getClassId()!=null){

            return new Message(1, "已分班的学生请到【学生工作-学生学籍管理-学籍信息维护】菜单进行删除！", null);
        }else{
            enrollmentService.delEnrollmentStudent(studentId);
            return new Message(0, "删除成功！", null);
        }

    }
    //校验身份证号是否重复
    @ResponseBody
    @RequestMapping("/enrollment/checkEnrollmentIdCard")
    public Message checkEnrollmentIdCard(String idcard) {
        List studentlist =  studentService.checkIdCard(idcard);
        List<EnrollmentStudent> enrollmentlist =enrollmentService.checkEnrollmentIdCard(idcard);
        if(enrollmentlist.size()>0 || studentlist.size()>0){
            return new Message(1, null, null);
        } else{
            return new Message(0, null, null);
        }

    }
    //保存登记学生
    @ResponseBody
    @RequestMapping("/enrollment/savaEnrollmentStudent")
    public Message savaEnrollmentStudent(EnrollmentStudent enrollmentStudent) {
        if(null == enrollmentStudent.getStudentId() || enrollmentStudent.getStudentId().equals("")){
            enrollmentStudent.setStudentId(enrollmentStudent.getIdcard());
            CommonUtil.save(enrollmentStudent);
            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
            String year = formatDate.format(new Date());
            enrollmentStudent.setJoinYear(year);
            enrollmentStudent.setStudentStatus("1");
            enrollmentStudent.setCutFlag("0");
            enrollmentService.insertEnrollmentStudent(enrollmentStudent);

        }else{
            CommonUtil.update(enrollmentStudent);
            enrollmentService.updateEnrollmentStudent(enrollmentStudent);
        }
        return new Message(1, "保存成功！", null);
    }
    //导入数据模版页
    @RequestMapping("/enrollment/toImportStudent")
    public ModelAndView toImportStudent() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/enrollment/toImportEnrollmentStudent");
        return mv;
    }
    //下载模版
    @RequestMapping("/enrollment/getEnrollmentStudentExcel")
    public void getStudentExcelTemplate(HttpServletResponse response) {
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("sheet0");
        sheet.setColumnWidth(0, 30 * 256);
        sheet.setColumnWidth(1, 30 * 256);
        sheet.setColumnWidth(2, 30 * 256);
        sheet.setColumnWidth(3, 30 * 256);
        sheet.setColumnWidth(4, 30 * 256);
        sheet.setColumnWidth(5, 30 * 256);
        sheet.setColumnWidth(6, 30 * 256);
        sheet.setColumnWidth(7, 30 * 256);
        sheet.setColumnWidth(8, 30 * 256);
        sheet.setColumnWidth(9, 30 * 256);
       //创建HSSFRow对象
        int tmp = 0;
        HSSFRow sayRow = sheet.createRow(tmp);
        //创建HSSFCell对象
        sayRow.createCell(0).setCellValue("此项为必填项");
        sayRow.createCell(1).setCellValue("此项为必填项");
        sayRow.createCell(2).setCellValue("此项为必填项");
        sayRow.createCell(3).setCellValue("此项为必填项");
        sayRow.createCell(4).setCellValue("此项为必填项");
        sayRow.createCell(5).setCellValue("此项为必填项");
        sayRow.createCell(6).setCellValue("此项为必填项");
        sayRow.createCell(7).setCellValue("此项为必填项");
        sayRow.createCell(8).setCellValue("此项为必填项");
        sayRow.createCell(9).setCellValue("此项为必填项");
         tmp++;
        //创建HSSFCell对象
        HSSFRow row = sheet.createRow(tmp);
        //创建HSSFCell对象
        row.createCell(0).setCellValue("学生姓名");
        row.createCell(1).setCellValue("性别");
        row.createCell(2).setCellValue("身份证号(不允许重复)");
        row.createCell(3).setCellValue("民族");
        row.createCell(4).setCellValue("系部(必须系统存在)");
        row.createCell(5).setCellValue("专业(必须系统存在)");
        row.createCell(6).setCellValue("专业方向(必须系统存在)");
        row.createCell(7).setCellValue("培养层次(必须系统存在)");
        row.createCell(8).setCellValue("学制(必须系统存在)");
        row.createCell(9).setCellValue("层次(必须系统存在)");
        HSSFCellStyle cellStyle = wb.createCellStyle();
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("登记新生导入模板.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    //导入数据保存
    @ResponseBody
    @RequestMapping("/enrollment/importEnrollmentStudent")
    public Message importEnrollmentStudent(@RequestParam(value = "file", required = false) CommonsMultipartFile file) {
        int count = 0 ;
        int errorCount=0;
        try {
            HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            String className="";
            List<Select2> sexs = commonService.getSysDict("XB","");
            List<Select2> nations = commonService.getSysDict("MZ","");
            List<Select2> levels = commonService.getSysDict("ZXZYPYCC","");
            List<Select2> derictions = commonService.getSysDict("ZXZYFX","");
            List<Select2> programDurations = commonService.getSysDict("XZ","");
            List<Select2> gradations = commonService.getSysDict("CC","");
            TableDict majorTable=new TableDict();
            majorTable.setId("MAJOR_CODE");
            majorTable.setText("MAJOR_NAME");
            majorTable.setTableName("T_XG_MAJOR");
            List<Select2> majors = commonService.getTableDict(majorTable);
            TableDict deptTable=new TableDict();
            deptTable.setId("DEPT_ID");
            deptTable.setText("DEPT_NAME");
            deptTable.setTableName("T_SYS_DEPT");
            List<Select2> depts = commonService.getTableDict(deptTable);
            for (int i = 2; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                //String studentNumber=row.getCell(0).toString();
                String studentName=row.getCell(0).toString();
                String sexName =row.getCell(1).toString();
                String idcard =row.getCell(2).toString();
                String nationName =row.getCell(3).toString();
                String deptName =row.getCell(4).toString();
                String majorName =row.getCell(5).toString();
                String deretionName =row.getCell(6).toString();
                String levelName =row.getCell(7).toString();
                String programDuration =row.getCell(8).toString();
                String gradation =row.getCell(9).toString();

                List list=  studentService.checkIdCard(idcard);
                List<EnrollmentStudent>  enrollmentStudents=enrollmentService.checkEnrollmentIdCard(idcard);
                if(list.size()>0 || enrollmentStudents.size()>0){//判断学生身份号是否存在
                    errorCount++;

                }else{
                    String majorResult = studentService.getMajorCodeByMajorName(majorName);
                    String deptResult=checkPoiHallCellPropoty(depts,deptName);
//                    String majorResult=checkPoiHallCellPropoty(majors,majorName);
                    String deretionResult=checkPoiHallCellPropoty(derictions,deretionName);
                    String levelResult=checkPoiHallCellPropoty(levels,levelName);
                    String sexResult=checkPoiHallCellPropoty(sexs,sexName);
                    String nationResult=checkPoiHallCellPropoty(nations,nationName);
                    String programDurationResult=checkPoiHallCellPropoty(programDurations,programDuration);
                    String gradationResult=checkPoiHallCellPropoty(gradations,gradation);
                    EnrollmentStudent enrollmentStudent = new EnrollmentStudent();
                    if (!"".equals(deptResult) &&  !"".equals(majorResult) &&
                            !"".equals(deretionResult) &&  !"".equals(levelResult) &&
                            !"".equals(sexResult) &&  !"".equals(nationResult)) {
                        enrollmentStudent.setDepartmentsId(deptResult);
                        enrollmentStudent.setMajorCode(majorResult);
                        enrollmentStudent.setMajorDirection(deretionResult);
                        enrollmentStudent.setTrainingLevel(levelResult);
                        enrollmentStudent.setSex(sexResult);
                        enrollmentStudent.setNation(nationResult);
                        for (Select2 xz : programDurations) {
                            if (xz.getText().equals(row.getCell(8).toString())) {
                                enrollmentStudent.setProgramDuration(xz.getId());
                            }
                        }
                        for (Select2 cc : gradations) {
                            if (cc.getText().equals(row.getCell(9).toString())) {
                                enrollmentStudent.setGradation(cc.getId());
                            }
                        }
//                        enrollmentStudent.setProgramDuration(programDurationResult);
//                        enrollmentStudent.setGradation(gradationResult);
                       // enrollmentStudent.setStudentNumber(studentNumber);
                        CommonUtil.save(enrollmentStudent);
                        enrollmentStudent.setStudentId(CommonUtil.getUUID());
                        enrollmentStudent.setName(studentName);
                        enrollmentStudent.setIdcard(idcard);
                        enrollmentService.insertEnrollmentStudent(enrollmentStudent);
                        count++;
                    }else{
                        errorCount++;
                    }

                }

            }
        }catch (Exception e) {
            e.printStackTrace();

        }
        if(count==0){
            if(errorCount>0){
                return new Message(0, "共计"+count+"条导入成功,"+(errorCount)+"条数据异常！", "error");
            }else{
                return new Message(0, "共计"+count+"条导入成功!", "error");
            }

        }else{
            if(errorCount>0){
                return new Message(0, "共计"+count+"条导入成功,"+(errorCount)+"条数据异常！", "success");
            }else{
                return new Message(1, "共计"+count+"条，导入成功！", "success");
            }
        }
    }

    //导出的登记新生数据
    @RequestMapping("/enrollment/exportEnrollmentStudent")
    public void exportEnrollmentStudent(HttpServletRequest request,HttpServletResponse response) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        EnrollmentStudent enrollmentStudent = new EnrollmentStudent();
        List<EnrollmentStudent> enrollmentStudentList ;
        LoginUser loginUser=CommonUtil.getLoginUser();
        String sa = loginUser.getPersonId();
        if (sa.equals("sa")){
            enrollmentStudent.setCreator(CommonUtil.getPersonId());
            enrollmentStudent.setCreateDept(CommonUtil.getDefaultDept());
            enrollmentStudentList = enrollmentService.getEnrollmentStudentList(enrollmentStudent);
        }else {
            if (CommonUtil.getDefaultDept().equals("001008") || CommonUtil.getDefaultDept().equals("001012")) {
                enrollmentStudent.setDepartmentsId(null);
                enrollmentStudent.setCreator(CommonUtil.getPersonId());
                enrollmentStudent.setCreateDept(CommonUtil.getDefaultDept());
                enrollmentStudentList = enrollmentService.getEnrollmentStudentList(enrollmentStudent);
            } else {
                //enrollmentStudent.setDepartmentsId(CommonUtil.getDefaultDept());
                enrollmentStudent.setCreator(CommonUtil.getPersonId());
                enrollmentStudent.setCreateDept(CommonUtil.getDefaultDept());
                enrollmentStudentList = enrollmentService.getEnrollmentStudentList(enrollmentStudent);
            }
        }

        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("sheet0");
        sheet.setColumnWidth(3, 30 * 256);
        sheet.setColumnWidth(5, 30 * 256);
        sheet.setColumnWidth(6, 30 * 256);
        //创建HSSFRow对象
        int tmp = 0;
        //创建HSSFCell对象
        HSSFRow row = sheet.createRow(tmp);
        //创建HSSFCell对象
        row.createCell(0).setCellValue("学生姓名");
        row.createCell(1).setCellValue("性别");
        row.createCell(2).setCellValue("身份证号");
        row.createCell(3).setCellValue("民族");
        row.createCell(4).setCellValue("系部");
        row.createCell(5).setCellValue("专业");
        row.createCell(6).setCellValue("专业方向");
        row.createCell(7).setCellValue("培养层次");
        row.createCell(8).setCellValue("学制");
        row.createCell(9).setCellValue("层次");
       tmp++;

        for (EnrollmentStudent studentobj : enrollmentStudentList) {
            HSSFRow HSSFRow = sheet.createRow(tmp);
            //创建HSSFCell对象
             HSSFRow.createCell(0).setCellValue(studentobj.getName());
            HSSFRow.createCell(1).setCellValue(studentobj.getSexShow());
            HSSFRow.createCell(2).setCellValue(studentobj.getIdcard());
            HSSFRow.createCell(3).setCellValue(studentobj.getNationShow());
            HSSFRow.createCell(4).setCellValue(studentobj.getDepartmentShow());
            HSSFRow.createCell(5).setCellValue(studentobj.getMajorShow());
            HSSFRow.createCell(6).setCellValue(studentobj.getMajorDirectionShow());
            HSSFRow.createCell(7).setCellValue(studentobj.getTrainingLevelShow());
            HSSFRow.createCell(8).setCellValue(studentobj.getProgramDurationShow());
            HSSFRow.createCell(9).setCellValue(studentobj.getGradationShow());
            tmp++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("登记学生基本信息.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    //导出招生计划统计
    @RequestMapping("/enrollment/exportEnrollmentCount")
    public void exportEnrollmentCount(HttpServletRequest request, HttpServletResponse response,String year) {
        Enrollment enrollment = new Enrollment();
        enrollment.setYear(year);
        List<Enrollment> enrollmentList = enrollmentService.getEnrollmentList(enrollment);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("sheet0");
        sheet.setColumnWidth(0, 30 * 256);
        sheet.setColumnWidth(1, 30 * 256);
        //创建HSSFRow对象
        int tmp = 0;
        //创建HSSFCell对象
        HSSFRow row = sheet.createRow(tmp);
        //创建HSSFCell对象
        row.createCell(0).setCellValue("系部");
        row.createCell(1).setCellValue("专业");
        row.createCell(2).setCellValue("培养层次");
        row.createCell(3).setCellValue("方向");
        row.createCell(4).setCellValue("学制");
        row.createCell(5).setCellValue("招生年份");
        row.createCell(6).setCellValue("计划招生人数");
        row.createCell(7).setCellValue("报到总人数");
        tmp++;

        for (Enrollment enroll : enrollmentList) {
            HSSFRow HSSFRow = sheet.createRow(tmp);
            //创建HSSFCell对象
            HSSFRow.createCell(0).setCellValue(enroll.getDepartmentShow());
            HSSFRow.createCell(1).setCellValue(enroll.getMajorShow());
            HSSFRow.createCell(2).setCellValue(enroll.getTrainingLevelShow());
            HSSFRow.createCell(3).setCellValue(enroll.getDirectionShow());
            HSSFRow.createCell(4).setCellValue(enroll.getSchoolSystemShow());
            HSSFRow.createCell(5).setCellValue(enroll.getYear());
            HSSFRow.createCell(6).setCellValue(enroll.getPlanNumber());
            HSSFRow.createCell(7).setCellValue(enroll.getRealNumber());
            tmp++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("招生计划统计信息.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    //学生分班弹出页
    @RequestMapping("/enrollment/toDistributeClass")
    public ModelAndView toDistributeClass(String ids,String id){
        ModelAndView mv = new ModelAndView();
        if(ids!=null){
            mv.addObject("ids",ids);
            mv.addObject("flag","all");
            mv.addObject("status",2);
            mv.addObject("head","批量分班");
        }
        if(id!=null){
            EnrollmentStudent enrollmentStudent=enrollmentService.getEnrollmentStudentById(id);
            mv.addObject("id",id);
            mv.addObject("status",1);
            mv.addObject("enrollmentStudent",enrollmentStudent);
            mv.addObject("flag","single");
            mv.addObject("head","学生分班");
        }
        mv.setViewName("/business/studentwork/enrollment/toDistributeClass");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/enrollment/checkDistributeClass")
    public Message checkDistributeClass(String id){
        EnrollmentStudent enrollmentStudent=enrollmentService.getEnrollmentStudentById(id);
        if("1".equals(enrollmentStudent.getCutFlag())){

            return new Message(1, "学生"+enrollmentStudent.getName()+"已完成分班，如需调班，请到【学生工作-学生学籍异动管理-学籍异动信息维护】菜单进行调整！", null);
        }else{
            return new Message(0, null, null);
        }
    }
    //保存分班数据
    @ResponseBody
    @RequestMapping("/enrollment/doDistributeClass")
    public Message doDistributeClass(String ids,String deptId,String majorCode,String trainingLevel,String majorDirection,String classId,String id) {
        if(ids!=null && !"".equals(ids)){
            List<EnrollmentStudent> checklist=enrollmentService.checkEnrollmentStudentListByIds(ids);
            if(checklist.size()>0){
                return new Message(1, "对不起,批量分班不支持已分班的学生,请重新选择", null);
            }else{

                //批量分班
                enrollmentService.doDistributeClasses(ids,deptId,majorCode,trainingLevel,classId,majorDirection);
            }
        }
        if(id!=null && !"".equals(id)){
            //分班
            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy");
            String year = formatDate.format(new Date());
            String planNumber=enrollmentService.selectRealNumberByIds(deptId, majorCode, trainingLevel,majorDirection,year);
            if(planNumber==null){
                return new Message(1, "对不起,该专业还未设置招生计划人数", null);
            }else{
                enrollmentService.doDistributeClass(id,deptId,majorCode,trainingLevel,classId,majorDirection);
            }

        }
        return new Message(0, "分班成功", null);
    }

    //保存设置招生人数
    @ResponseBody
    @RequestMapping("/enrollment/delPlan")
    public Message delPlan(String id,String year) {
        Enrollment enrollment=new Enrollment();
        Enrollment  old= enrollmentService.selectEnrollmentByMajorId(id,year);
        if(old!=null){
            enrollment.setYear(year);
            enrollment.setMajorId(id);
            enrollmentService.deleteEnrollment(enrollment);
            return new Message(0, "删除成功", null);
        }else{
            return new Message(1, "请先设置招生计划人数", null);
        }


    }
    //批量删除招生计划
    @ResponseBody
    @RequestMapping("/enrollment/batchDelPlan")
    public Message batchDelPlan(String ids,String id,String year) {
        Enrollment enrollment=new Enrollment();
        enrollment.setMajorId(ids);
        enrollment.setYear(year);
        enrollmentService.batchDeleteEnrollment(enrollment);
        return new Message(1, "删除成功", null);

    }
    //学生分班弹出页
    @RequestMapping("/enrollment/searchCountDetails")
    public ModelAndView searchCountDetails(String majorId,String year){
        ModelAndView mv = new ModelAndView();
        Enrollment enrollment=enrollmentService.selectEnrollmentByMajorId(majorId,year);
        mv.addObject("enrollment",enrollment);
        mv.addObject("head","招生计划统计详细");
        mv.setViewName("/business/studentwork/enrollment/searchCountDetails");
        return mv;
    }
    //校验导入时表选字典是否存在
    public String checkPoiHallCellPropoty(List<Select2> lists,String para){

        for (Select2 list : lists) {
            if (list.getText().equals(para)) {
                return list.getId();
            }
        }
        return "";
    }

}
