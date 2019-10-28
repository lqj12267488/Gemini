package com.goisan.educational.teacher.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.courseplan.bean.CoursePlanExcel;
import com.goisan.educational.exam.bean.ExamTeacherCourse;
import com.goisan.educational.score.bean.ScoreExam;
import com.goisan.educational.teacher.bean.*;
import com.goisan.educational.teacher.service.TeacherInfoService;
import com.goisan.educational.teachingevent.service.TeachingEventService;
import com.goisan.synergy.workflow.bean.Stamp;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by znw on 2017/7/13.
 */
@Controller
public class TeacherInfoController {
    @Resource
    private TeacherInfoService teacherInfoService;

    /**
     * 教师自然情况页面跳转
     */
    @RequestMapping("/teacher/condition")
    public ModelAndView teachingEventList(String teacherId) {
        ModelAndView mv = new ModelAndView();
        ExamTeacherCourse examTeacherCourse = new ExamTeacherCourse();
            mv.setViewName("/business/educational/teacher/teacherCondition");
        mv.addObject("examTeacherCourse", examTeacherCourse);
        mv.addObject("teacherId",teacherId);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/teacher/getTeacherInfoList")
    public Map<String, Object> getScoreExamList(TeacherCondition teacherCondition, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> teacherConditionList = new HashMap<String, Object>();
        teacherCondition.setCreateDept(CommonUtil.getDefaultDept());
        teacherCondition.setLevel(CommonUtil.getLoginUser().getLevel());
        List<TeacherCondition> list = teacherInfoService.getTeacherInfoList(teacherCondition);
        PageInfo<List<TeacherCondition>> info = new PageInfo(list);
        teacherConditionList.put("draw", draw);
        teacherConditionList.put("recordsTotal", info.getTotal());
        teacherConditionList.put("recordsFiltered", info.getTotal());
        teacherConditionList.put("data", list);
        return teacherConditionList;
    }


    @ResponseBody
    @RequestMapping("/teacher/editTeacherCondition")
    public ModelAndView editScoreExam(String teacherId, String flag) {
        ModelAndView mv = new ModelAndView();
        ExamTeacherCourse examTeacherCourse = new ExamTeacherCourse();
        mv.addObject("examTeacherCourse", examTeacherCourse);
        mv.setViewName("/business/educational/teacher/teacherConditionEdit");
        if (teacherId == "" || teacherId == null) {
            mv.addObject("head", "新增");
        } else {
            TeacherCondition teacherCondition = teacherInfoService.getTeacherInfoById(teacherId);
            String ab = teacherCondition.getTeacherCategoryShow();
            mv.addObject("head", "修改");
            mv.addObject("teacherCondition", teacherCondition);
        }
        return mv;
    }

    /**
     * 展示教师自然信息
     * @param teacherId
     * @return
     */
    @ResponseBody
    @RequestMapping("/teacher/showTeacherCondition")
    public ModelAndView showTeacherCondition(String teacherId){
        ModelAndView mv = new ModelAndView();
        ExamTeacherCourse examTeacherCourse = new ExamTeacherCourse();
        mv.addObject("examTeacherCourse", examTeacherCourse);
        mv.setViewName("/business/educational/teacher/teacherConditionEdit");
        TeacherCondition teacherCondition = teacherInfoService.getTeacherInfoByTeacherName(teacherId);
        //添加判断页面是否为只读状态
        mv.addObject("type", "show");
        mv.addObject("head", "查看");
        mv.addObject("teacherCondition", teacherCondition);
        return mv;

    }

    @ResponseBody
    @RequestMapping("/teacher/saveTeacherInfo")
    public Message saveScoreExam(TeacherCondition teacherCondition) {
        if (teacherCondition.getTeacherId() == "") {
            teacherCondition.setCreator(CommonUtil.getPersonId());
            teacherCondition.setCreateDept(CommonUtil.getDefaultDept());
            teacherInfoService.insertTeacherInfo(teacherCondition);
            return new Message(1, "新增成功！", "success");
        } else {
            teacherCondition.setChanger(CommonUtil.getPersonId());
            teacherCondition.setChangeDept(CommonUtil.getDefaultDept());
            teacherInfoService.updateTeacherInfoById(teacherCondition);
            return new Message(1, "修改成功！", "success");
        }
    }

    @ResponseBody
    @RequestMapping("/teacher/deleteTeacherInfoById")
    public Message deleteTeacherInfoById(String teacherId) {
        teacherInfoService.deleteTeacherInfoById(teacherId);
        return new Message(1, "删除成功！", "success");
    }

    /*查询条件--教师姓名模糊查询*/
    @ResponseBody
    @RequestMapping("/teacher/selectTeacherName")
    public List<TeacherCondition> selectTeacherName() {
        List<TeacherCondition> list = teacherInfoService.selectTeacherName();
        return teacherInfoService.selectTeacherName();
    }

    /**
     * 教师自然情况页面跳转
     */
    @RequestMapping("/teacher/doubleDivision")
    public ModelAndView doubleDivision() {
        ModelAndView mv = new ModelAndView();
        ExamTeacherCourse examTeacherCourse = new ExamTeacherCourse();
        mv.setViewName("/business/educational/teacher/doubleDivisionTeacher");
        mv.addObject("examTeacherCourse", examTeacherCourse);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/teacher/doubleDivisionList")
    public Map<String, Object> getScoreExamList(DoubleDivisionTeacher doubleDivisionTeacher,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> doubleDivisionTeacherList = new HashMap<String, Object>();
        doubleDivisionTeacher.setCreateDept(CommonUtil.getDefaultDept());
        doubleDivisionTeacher.setLevel(CommonUtil.getLoginUser().getLevel());
        String a = doubleDivisionTeacher.getTeacherName();
        List<DoubleDivisionTeacher> list = teacherInfoService.getDoubleDivisionList(doubleDivisionTeacher);
        PageInfo<List<DoubleDivisionTeacher>> info = new PageInfo(list);
        doubleDivisionTeacherList.put("draw", draw);
        doubleDivisionTeacherList.put("recordsTotal", info.getTotal());
        doubleDivisionTeacherList.put("recordsFiltered", info.getTotal());
        doubleDivisionTeacherList.put("data", list);
        return doubleDivisionTeacherList;
    }

    @ResponseBody
    @RequestMapping("/teacher/toAddDoubleDivision")
    public ModelAndView editDoubleDivision(String teacherId, String flag) {
        ModelAndView mv = new ModelAndView();
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String date = formatDate.format(new Date());
        ExamTeacherCourse examTeacherCourse = new ExamTeacherCourse();
        mv.addObject("examTeacherCourse", examTeacherCourse);
        mv.setViewName("/business/educational/teacher/doubleDivisionEdit");
        if (teacherId == "" || teacherId == null) {
            mv.addObject("head", "新增");
            DoubleDivisionTeacher doubleDivisionTeacher = new DoubleDivisionTeacher();
            doubleDivisionTeacher.setIssuingTime(date);
            mv.addObject("doubleDivisionTeacher", doubleDivisionTeacher);
        } else {
            DoubleDivisionTeacher doubleDivisionTeacher = teacherInfoService.getDoubleDivisionById(teacherId);
            mv.addObject("head", "修改");
            mv.addObject("doubleDivisionTeacher", doubleDivisionTeacher);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/teacher/doubleDivisionSave")
    public Message doubleDivisionSave(DoubleDivisionTeacher doubleDivisionTeacher) {
        if (doubleDivisionTeacher.getTeacherId() == "") {
            doubleDivisionTeacher.setCreator(CommonUtil.getPersonId());
            doubleDivisionTeacher.setCreateDept(CommonUtil.getDefaultDept());
            teacherInfoService.insertDoubleDivision(doubleDivisionTeacher);
            return new Message(1, "新增成功！", "success");
        } else {
            doubleDivisionTeacher.setChanger(CommonUtil.getPersonId());
            doubleDivisionTeacher.setChangeDept(CommonUtil.getDefaultDept());
            teacherInfoService.updateDoubleDivisionById(doubleDivisionTeacher);
            return new Message(1, "修改成功！", "success");
        }
    }

    @ResponseBody
    @RequestMapping("/teacher/delDoubleDivision")
    public Message deleteDoubleDivisionById(String teacherId) {
        teacherInfoService.deleteDoubleDivisionById(teacherId);
        return new Message(1, "删除成功！", "success");
    }

    /**
     * 进修培训页面跳转
     */
    @RequestMapping("/teacher/training")
    public ModelAndView teacherTraining() {
        ModelAndView mv = new ModelAndView();
        ExamTeacherCourse examTeacherCourse = new ExamTeacherCourse();
        mv.setViewName("/business/educational/teacher/teacherTraining");
        mv.addObject("examTeacherCourse", examTeacherCourse);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/teacher/trainingList")
    public Map<String, Object> getScoreExamList(TeacherTraining teacherTraining,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> teacherTrainingList = new HashMap<String, Object>();
        teacherTraining.setCreateDept(CommonUtil.getDefaultDept());
        teacherTraining.setLevel(CommonUtil.getLoginUser().getLevel());
        List<TeacherTraining> list = teacherInfoService.getTeacherTrainingList(teacherTraining);
        PageInfo<List<TeacherTraining>> info = new PageInfo(list);
        teacherTrainingList.put("draw", draw);
        teacherTrainingList.put("recordsTotal", info.getTotal());
        teacherTrainingList.put("recordsFiltered", info.getTotal());
        teacherTrainingList.put("data", list);
        return teacherTrainingList;
    }

    @ResponseBody
    @RequestMapping("/teacher/teacherTrainingtoAdd")
    public ModelAndView editTeacherTraining(String teacherId, String flag) {
        ModelAndView mv = new ModelAndView();
        ExamTeacherCourse examTeacherCourse = new ExamTeacherCourse();
        mv.addObject("examTeacherCourse", examTeacherCourse);
        mv.setViewName("/business/educational/teacher/teacherTrainingEdit");
        if (teacherId == "" || teacherId == null) {
            mv.addObject("head", "新增");
        } else {
            TeacherTraining teacherTraining = teacherInfoService.getTeacherTrainingById(teacherId);
            mv.addObject("head", "修改");
            mv.addObject("teacherTraining", teacherTraining);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/teacherTraining/save")
    public Message teacherTrainingSave(TeacherTraining teacherTraining) {
        if (teacherTraining.getTeacherId() == "") {
            teacherTraining.setCreator(CommonUtil.getPersonId());
            teacherTraining.setCreateDept(CommonUtil.getDefaultDept());
            teacherInfoService.insertTeacherTraining(teacherTraining);
            return new Message(1, "新增成功！", "success");
        } else {
            teacherTraining.setChanger(CommonUtil.getPersonId());
            teacherTraining.setChangeDept(CommonUtil.getDefaultDept());
            teacherInfoService.updateTeacherTrainingById(teacherTraining);
            return new Message(1, "修改成功！", "success");
        }
    }

    @ResponseBody
    @RequestMapping("/teacher/delTeacherTrainingById")
    public Message deleteTeacherTrainingById(String teacherId) {
        teacherInfoService.deleteTeacherTrainingById(teacherId);
        return new Message(1, "删除成功！", "success");
    }

    /**
     * 获得荣誉页面跳转
     */
    @RequestMapping("/teacher/getHonor")
    public ModelAndView getHonor() {
        ModelAndView mv = new ModelAndView();
        ExamTeacherCourse examTeacherCourse = new ExamTeacherCourse();
        mv.setViewName("/business/educational/teacher/getHonor");
        mv.addObject("examTeacherCourse", examTeacherCourse);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/teacher/getHonorList")
    public Map<String, List<GetHonor>> getScoreExamList(GetHonor getHonor) {
        Map<String, List<GetHonor>> map = new HashMap<String, List<GetHonor>>();
        getHonor.setCreateDept(CommonUtil.getDefaultDept());
        getHonor.setLevel(CommonUtil.getLoginUser().getLevel());
//        String a=doubleDivisionTeacher.getTeacherName();
        map.put("data", teacherInfoService.getHonorList(getHonor));
//        List<DoubleDivisionTeacher> list=teacherInfoService.getDoubleDivisionList(doubleDivisionTeacher);
        return map;
    }

    @ResponseBody
    @RequestMapping("/teacher/honorToAdd")
    public ModelAndView editHonor(String teacherId, String flag) {
        ModelAndView mv = new ModelAndView();
        ExamTeacherCourse examTeacherCourse = new ExamTeacherCourse();
        mv.addObject("examTeacherCourse", examTeacherCourse);
        mv.setViewName("/business/educational/teacher/honorEdit");
        if (teacherId == "" || teacherId == null) {
            mv.addObject("head", "新增");
        } else {
            GetHonor getHonor = teacherInfoService.getHonorById(teacherId);
            mv.addObject("head", "修改");
            mv.addObject("getHonor", getHonor);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/honor/save")
    public Message honorSave(GetHonor getHonor) {
        if (getHonor.getTeacherId() == "") {
            getHonor.setCreator(CommonUtil.getPersonId());
            getHonor.setCreateDept(CommonUtil.getDefaultDept());
            teacherInfoService.insertHonor(getHonor);
            return new Message(1, "新增成功！", "success");
        } else {
            getHonor.setChanger(CommonUtil.getPersonId());
            getHonor.setChangeDept(CommonUtil.getDefaultDept());
            teacherInfoService.updateHonorById(getHonor);
            return new Message(1, "修改成功！", "success");
        }
    }

    @ResponseBody
    @RequestMapping("/teacher/delHonorById")
    public Message deleteHonorById(String teacherId) {
        teacherInfoService.deleteHonorById(teacherId);
        return new Message(1, "删除成功！", "success");
    }

    /**
     * 学历提高页面跳转
     */
    @RequestMapping("/teacher/educationImprove")
    public ModelAndView educationImprove() {
        ModelAndView mv = new ModelAndView();
        ExamTeacherCourse examTeacherCourse = new ExamTeacherCourse();
        mv.setViewName("/business/educational/teacher/educationImprove");
        mv.addObject("examTeacherCourse", examTeacherCourse);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/teacher/getEducationImproveList")
    public Map<String, Object> getScoreExamList(EducationImprove educationImprove,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> educationImproveList = new HashMap<String, Object>();
        educationImprove.setCreateDept(CommonUtil.getDefaultDept());
        educationImprove.setLevel(CommonUtil.getLoginUser().getLevel());
        List<EducationImprove> list = teacherInfoService.getEducationImproveList(educationImprove);
        PageInfo<List<EducationImprove>> info = new PageInfo(list);
        educationImproveList.put("draw", draw);
        educationImproveList.put("recordsTotal", info.getTotal());
        educationImproveList.put("recordsFiltered", info.getTotal());
        educationImproveList.put("data", list);
        return educationImproveList;
    }

    @ResponseBody
    @RequestMapping("/teacher/educationImproveToAdd")
    public ModelAndView editEducationImprove(String teacherId, String flag) {
        ModelAndView mv = new ModelAndView();
        ExamTeacherCourse examTeacherCourse = new ExamTeacherCourse();
        mv.addObject("examTeacherCourse", examTeacherCourse);
        mv.setViewName("/business/educational/teacher/educationImproveEdit");
        if (teacherId == "" || teacherId == null) {
            mv.addObject("head", "新增");
        } else {
            EducationImprove educationImprove = teacherInfoService.getEducationById(teacherId);
            mv.addObject("head", "修改");
            mv.addObject("educationImprove", educationImprove);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/educationImprove/save")
    public Message educationImproveSave(EducationImprove educationImprove) {
        if (educationImprove.getTeacherId() == "") {
            educationImprove.setCreator(CommonUtil.getPersonId());
            educationImprove.setCreateDept(CommonUtil.getDefaultDept());
            teacherInfoService.insertEducationImprove(educationImprove);
            return new Message(1, "新增成功！", "success");
        } else {
            educationImprove.setChanger(CommonUtil.getPersonId());
            educationImprove.setChangeDept(CommonUtil.getDefaultDept());
            teacherInfoService.updateEdcuationById(educationImprove);
            return new Message(1, "修改成功！", "success");
        }
    }

    @ResponseBody
    @RequestMapping("/teacher/delEducationImprove")
    public Message delEducationImprove(String teacherId) {
        teacherInfoService.delEducationImprove(teacherId);
        return new Message(1, "删除成功！", "success");
    }

    /**
     * 业务考核页面跳转
     */
    @RequestMapping("/teacher/businessAssessment")
    public ModelAndView businessAssessment() {
        ModelAndView mv = new ModelAndView();
        ExamTeacherCourse examTeacherCourse = new ExamTeacherCourse();
        mv.setViewName("/business/educational/teacher/businessAssessment");
        mv.addObject("examTeacherCourse", examTeacherCourse);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/teacher/getBusinessAssessmentList")
    public Map<String, Object> getBusinessAssessmentList(BusinessAssessment businessAssessment,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> businessAssessmentList = new HashMap<String, Object>();
        businessAssessment.setCreateDept(CommonUtil.getDefaultDept());
        businessAssessment.setLevel(CommonUtil.getLoginUser().getLevel());
        List<BusinessAssessment> list = teacherInfoService.getAssessmentList(businessAssessment);
        PageInfo<List<BusinessAssessment>> info = new PageInfo(list);
        businessAssessmentList.put("draw", draw);
        businessAssessmentList.put("recordsTotal", info.getTotal());
        businessAssessmentList.put("recordsFiltered", info.getTotal());
        businessAssessmentList.put("data", list);
        return businessAssessmentList;
    }

    @ResponseBody
    @RequestMapping("/teacher/businessAssessmentToAdd")
    public ModelAndView editBusinessAssessment(String teacherId, String flag) {
        ModelAndView mv = new ModelAndView();
        ExamTeacherCourse examTeacherCourse = new ExamTeacherCourse();
        mv.addObject("examTeacherCourse", examTeacherCourse);
        mv.setViewName("/business/educational/teacher/businessAssessmentEdit");
        if (teacherId == "" || teacherId == null) {
            mv.addObject("head", "新增");
        } else {
            BusinessAssessment businessAssessment = teacherInfoService.getAssessmentById(teacherId);
            mv.addObject("head", "修改");
            mv.addObject("businessAssessment", businessAssessment);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/businessAssessment/save")
    public Message businessAssessmentSave(BusinessAssessment businessAssessment) {
        if (businessAssessment.getTeacherId() == "") {
            businessAssessment.setCreator(CommonUtil.getPersonId());
            businessAssessment.setCreateDept(CommonUtil.getDefaultDept());
            teacherInfoService.insertBusinessAssessment(businessAssessment);
            return new Message(1, "新增成功！", "success");
        } else {
            businessAssessment.setChanger(CommonUtil.getPersonId());
            businessAssessment.setChangeDept(CommonUtil.getDefaultDept());
            teacherInfoService.updateAssessmentById(businessAssessment);
            return new Message(1, "修改成功！", "success");
        }
    }

    @ResponseBody
    @RequestMapping("/teacher/delAssessmentById")
    public Message delAssessmentById(String teacherId) {
        teacherInfoService.delAssessmentById(teacherId);
        return new Message(1, "删除成功！", "success");
    }


    @ResponseBody
    @RequestMapping("/teacher/competition")
    public ModelAndView competition() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teacher/competitionList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/teacher/getCompetitionList")
    public Map<String, Object> getCompetitionList(Competition competition,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> competitionList = new HashMap<String, Object>();
        competition.setCreateDept(CommonUtil.getDefaultDept());
        competition.setLevel(CommonUtil.getLoginUser().getLevel());
        List<Competition> list = teacherInfoService.getCompetitionList(competition);
        PageInfo<List<Competition>> info = new PageInfo(list);
        competitionList.put("draw", draw);
        competitionList.put("recordsTotal", info.getTotal());
        competitionList.put("recordsFiltered", info.getTotal());
        competitionList.put("data", list);
        return competitionList;
    }

    /**
     * 竞赛业务修改
     *
     * @param competitionId
     * @return
     */
    @ResponseBody
    @RequestMapping("/teacher/toAddCompetition")
    public ModelAndView editCompetition(String competitionId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teacher/editCompetition");
        if ("".equals(competitionId) || competitionId == null) {
            mv.addObject("head", "新增");
            Competition competition = new Competition();
            mv.addObject("competition", competition);
        } else {
            Competition competition = teacherInfoService.getCompetitionIdById(competitionId);
            mv.addObject("head", "修改");
            mv.addObject("competition", competition);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/teacher/deleteCompetitionIdById")
    public Message deleteCompetitionIdById(String competitionId) {
        teacherInfoService.deleteCompetitionIdById(competitionId);
        return new Message(1, "删除成功！", "success");
    }

    @ResponseBody
    @RequestMapping("/teacher/competitionSave")
    public Message competitionSave(Competition competition) {
        if ("".equals(competition.getCompetitionId())) {
            competition.setCreator(CommonUtil.getPersonId());
            competition.setCreateDept(CommonUtil.getDefaultDept());
            teacherInfoService.insertCompetition(competition);
            return new Message(1, "新增成功！", "success");
        } else {
            competition.setChanger(CommonUtil.getPersonId());
            competition.setChangeDept(CommonUtil.getDefaultDept());
            teacherInfoService.updateCompetitionById(competition);
            return new Message(1, "修改成功！", "success");
        }
    }
/**
 * 导出教师自然情况,teacherType:
 * 1、校内专任教师
 * 2、校外兼课教师
 * 3、校外兼职教师
 * 4、校内兼课教师*/
    @RequestMapping("/teacher/toExportDate")
    public void toExportDate(String teacherType, HttpServletResponse response) {
        List<TeacherCondition> teacherConditionsList = teacherInfoService.getTeacherTypeToExp(teacherType);
        HSSFWorkbook workbook = new HSSFWorkbook();
        CellStyle cellStyle0 = workbook.createCellStyle();
        String tablename="";
        if("1".equals(teacherType)){
            tablename="校内专任教师信息表";
            Sheet sheet = workbook.createSheet(tablename);
            cellStyle0.setAlignment(HorizontalAlignment.CENTER);
            cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
            cellStyle0.setWrapText(true);
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));//教师所属系部
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1));//行政职务
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 2, 2));//教工号
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 3, 3));//姓名
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 4, 4));//性别
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 5, 5));//出生日期
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 6, 6));//民族
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 7, 7));//籍贯
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 8, 8));//政治面貌
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 9, 13));//第一学历
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 14, 18));//最后学历
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 19, 19));//专业领域
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 20, 20));//专业特长
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 21, 22));//高校教师资格证书
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 23, 24));//行业、企业一线工作时间
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 25, 28));//专业技术职务（最高）
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 29, 29));//已聘职称
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 30, 33));//职业资格证书（最高）
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 34, 34));//是否专业教师
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 35, 35));//是否为骨干教师
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 36, 36));//是否为双师型教师
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 37, 37));//是否教学名师
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 38, 39));//行政所属专业

            sheet.setColumnWidth(0, 18 * 256);
            sheet.setColumnWidth(1, 18 * 256);
            sheet.setColumnWidth(2, 18 * 256);
            sheet.setColumnWidth(3, 10 * 256);
            sheet.setColumnWidth(4, 10 * 256);
            sheet.setColumnWidth(5, 18 * 256);
            sheet.setColumnWidth(8, 18 * 256);
            sheet.setColumnWidth(11, 18 * 256);
            sheet.setColumnWidth(13, 18 * 256);
            sheet.setColumnWidth(16, 18 * 256);
            sheet.setColumnWidth(18, 18 * 256);
            sheet.setColumnWidth(21, 18 * 256);
            sheet.setColumnWidth(22, 18 * 256);
            sheet.setColumnWidth(23, 18 * 256);
            sheet.setColumnWidth(26, 18 * 256);
            sheet.setColumnWidth(27, 18 * 256);
            sheet.setColumnWidth(31, 18 * 256);
            sheet.setColumnWidth(32, 18 * 256);

            Row row0 = sheet.createRow(0);
            Row row1 = sheet.createRow(1);

            Cell ce1 = row0.createCell(0);
            ce1.setCellValue("教师所属系部");
            ce1.setCellStyle(cellStyle0);

            Cell ce2 = row0.createCell(1);
            ce2.setCellValue("行政职务");
            ce2.setCellStyle(cellStyle0);

            Cell ce3 = row0.createCell(2);
            ce3.setCellValue("教工号");
            ce3.setCellStyle(cellStyle0);

            Cell ce4 = row0.createCell(3);
            ce4.setCellValue("姓名");
            ce4.setCellStyle(cellStyle0);

            Cell ce5 = row0.createCell(4);
            ce5.setCellValue("性别");
            ce5.setCellStyle(cellStyle0);

            Cell ce6 = row0.createCell(5);
            ce6.setCellValue("出生日期");
            ce6.setCellStyle(cellStyle0);

            Cell ce7 = row0.createCell(6);
            ce7.setCellValue("民族");
            ce7.setCellStyle(cellStyle0);

            Cell ce8 = row0.createCell(7);
            ce8.setCellValue("籍贯");
            ce8.setCellStyle(cellStyle0);

            Cell ce9 = row0.createCell(8);
            ce9.setCellValue("政治面貌");
            ce9.setCellStyle(cellStyle0);

            Cell ce10 = row0.createCell(9);
            ce10.setCellValue("第一学历");
            ce10.setCellStyle(cellStyle0);

            Cell ce11 = row1.createCell(9);
            ce11.setCellValue("学历");
            ce11.setCellStyle(cellStyle0);

            Cell ce12 = row1.createCell(10);
            ce12.setCellValue("学位");
            ce12.setCellStyle(cellStyle0);

            Cell ce13 = row1.createCell(11);
            ce13.setCellValue("毕业院校");
            ce13.setCellStyle(cellStyle0);

            Cell ce14 = row1.createCell(12);
            ce14.setCellValue("专业");
            ce14.setCellStyle(cellStyle0);

            Cell ce15 = row1.createCell(13);
            ce15.setCellValue("毕业时间");
            ce15.setCellStyle(cellStyle0);

            Cell ce16 = row0.createCell(14);
            ce16.setCellValue("最后学历");
            ce16.setCellStyle(cellStyle0);

            Cell ce17 = row1.createCell(14);
            ce17.setCellValue("学历");
            ce17.setCellStyle(cellStyle0);

            Cell ce18 = row1.createCell(15);
            ce18.setCellValue("学位");
            ce18.setCellStyle(cellStyle0);

            Cell ce19 = row1.createCell(16);
            ce19.setCellValue("毕业院校");
            ce19.setCellStyle(cellStyle0);

            Cell ce20 = row1.createCell(17);
            ce20.setCellValue("专业");
            ce20.setCellStyle(cellStyle0);

            Cell ce21 = row1.createCell(18);
            ce21.setCellValue("毕业时间");
            ce21.setCellStyle(cellStyle0);

            Cell ce22 = row0.createCell(19);
            ce22.setCellValue("专业领域");
            ce22.setCellStyle(cellStyle0);

            Cell ce23 = row0.createCell(20);
            ce23.setCellValue("专业特长");
            ce23.setCellStyle(cellStyle0);

            Cell ce24 = row0.createCell(21);
            ce24.setCellValue("高校教师资格证书");
            ce24.setCellStyle(cellStyle0);

            Cell ce25 = row1.createCell(21);
            ce25.setCellValue("发证单位");
            ce25.setCellStyle(cellStyle0);

            Cell ce26 = row1.createCell(22);
            ce26.setCellValue("获取日期");
            ce26.setCellStyle(cellStyle0);

            Cell ce27 = row0.createCell(23);
            ce27.setCellValue("行业、企业一线工作时间");
            ce27.setCellStyle(cellStyle0);

            Cell ce28 = row1.createCell(23);
            ce28.setCellValue("历年（年）");
            ce28.setCellStyle(cellStyle0);

            Cell ce29 = row1.createCell(24);
            ce29.setCellValue("本学年（天）");
            ce29.setCellStyle(cellStyle0);

            Cell ce30 = row0.createCell(25);
            ce30.setCellValue("专业技术职务（最高）");
            ce30.setCellStyle(cellStyle0);

            Cell ce31 = row1.createCell(25);
            ce31.setCellValue("等级");
            ce31.setCellStyle(cellStyle0);

            Cell ce32 = row1.createCell(26);
            ce32.setCellValue("名称（全称）");
            ce32.setCellStyle(cellStyle0);

            Cell ce33 = row1.createCell(27);
            ce33.setCellValue("发证单位（全称）");
            ce33.setCellStyle(cellStyle0);

            Cell ce34 = row1.createCell(28);
            ce34.setCellValue("获取日期（年月）");
            ce34.setCellStyle(cellStyle0);

            Cell ce35 = row0.createCell(29);
            ce35.setCellValue("已聘职称");
            ce35.setCellStyle(cellStyle0);

            Cell ce36 = row0.createCell(30);
            ce36.setCellValue("职业资格证书（最高）");
            ce36.setCellStyle(cellStyle0);

            Cell ce37 = row1.createCell(30);
            ce37.setCellValue("等级");
            ce37.setCellStyle(cellStyle0);

            Cell ce38 = row1.createCell(31);
            ce38.setCellValue("名称（全称）");
            ce38.setCellStyle(cellStyle0);

            Cell ce39 = row1.createCell(32);
            ce39.setCellValue("发证单位（全称）");
            ce39.setCellStyle(cellStyle0);

            Cell ce40 = row1.createCell(33);
            ce40.setCellValue("获取日期（年月）");
            ce40.setCellStyle(cellStyle0);

            Cell ce41 = row0.createCell(34);
            ce41.setCellValue("是否专业教师");
            ce41.setCellStyle(cellStyle0);

            Cell ce42 = row0.createCell(35);
            ce42.setCellValue("是否为骨干教师");
            ce42.setCellStyle(cellStyle0);

            Cell ce43 = row0.createCell(36);
            ce43.setCellValue("是否为双师型教师");
            ce43.setCellStyle(cellStyle0);

            Cell ce44 = row0.createCell(37);
            ce44.setCellValue("是否教学名师");
            ce44.setCellStyle(cellStyle0);

            Cell ce45 = row0.createCell(38);
            ce45.setCellValue("行政所属专业");
            ce45.setCellStyle(cellStyle0);

            Cell ce46 = row1.createCell(38);
            ce46.setCellValue("专业代码");
            ce46.setCellStyle(cellStyle0);

            Cell ce47 = row1.createCell(39);
            ce47.setCellValue("专业名称");
            ce47.setCellStyle(cellStyle0);

            int i = 2;
            for (TeacherCondition teacherCondition : teacherConditionsList) {
                Row row = sheet.createRow(i);
                Cell cells0 = row.createCell(0);
                cells0.setCellValue(teacherCondition.getDepartmentId());
                cells0.setCellStyle(cellStyle0);

                Cell cells1 = row.createCell(1);
                cells1.setCellValue(teacherCondition.getXzPosition());
                cells1.setCellStyle(cellStyle0);

                Cell cells2 = row.createCell(2);
                cells2.setCellValue(teacherCondition.getTeacherNum());
                cells2.setCellStyle(cellStyle0);

                Cell cells3 = row.createCell(3);
                cells3.setCellValue(teacherCondition.getTeacherName());
                cells3.setCellStyle(cellStyle0);

                Cell cells4 = row.createCell(4);
                cells4.setCellValue(teacherCondition.getTeacherSex());
                cells4.setCellStyle(cellStyle0);

                Cell cells5 = row.createCell(5);
                cells5.setCellValue(teacherCondition.getBirthday());
                cells5.setCellStyle(cellStyle0);

                Cell cells6 = row.createCell(6);
                cells6.setCellValue(teacherCondition.getNationShow());
                cells6.setCellStyle(cellStyle0);

                Cell cells7 = row.createCell(7);
                cells7.setCellValue(teacherCondition.getNativePlaceShow());
                cells7.setCellStyle(cellStyle0);

                Cell cells8 = row.createCell(8);
                cells8.setCellValue(teacherCondition.getPoliticalStatusShow());
                cells8.setCellStyle(cellStyle0);

                Cell cells9 = row.createCell(9);
                cells9.setCellValue(teacherCondition.getFirstEducation());
                cells9.setCellStyle(cellStyle0);


                Cell cells10 = row.createCell(10);
                cells10.setCellValue(teacherCondition.getFirstEducationStatus());
                cells10.setCellStyle(cellStyle0);

                Cell cells11 = row.createCell(11);
                cells11.setCellValue(teacherCondition.getFirstEducationSchool());
                cells11.setCellStyle(cellStyle0);

                Cell cells12 = row.createCell(12);
                cells12.setCellValue(teacherCondition.getFirstEducationMajor());
                cells12.setCellStyle(cellStyle0);

                Cell cells13 = row.createCell(13);
                cells13.setCellValue(teacherCondition.getFirsEndtime());
                cells13.setCellStyle(cellStyle0);

                Cell cells14 = row.createCell(14);
                cells14.setCellValue(teacherCondition.getFinalEducation());
                cells14.setCellStyle(cellStyle0);

                Cell cells15 = row.createCell(15);
                cells15.setCellValue(teacherCondition.getDegee());
                cells15.setCellStyle(cellStyle0);

                Cell cells16 = row.createCell(16);
                cells16.setCellValue(teacherCondition.getFirstEducationSchool());
                cells16.setCellStyle(cellStyle0);

                Cell cells17 = row.createCell(17);
                cells17.setCellValue(teacherCondition.getMajor());
                cells17.setCellStyle(cellStyle0);

                Cell cells18 = row.createCell(18);
                cells18.setCellValue(teacherCondition.getFinaleEndtime());
                cells18.setCellStyle(cellStyle0);

                Cell cells19 = row.createCell(19);
                cells19.setCellValue(teacherCondition.getMajorField());
                cells19.setCellStyle(cellStyle0);

                Cell cells20 = row.createCell(20);
                cells20.setCellValue(teacherCondition.getMajorSpecialty());
                cells20.setCellStyle(cellStyle0);

                Cell cells21 = row.createCell(21);
                cells21.setCellValue(teacherCondition.getLicence());
                cells21.setCellStyle(cellStyle0);

                Cell cells22 = row.createCell(22);
                cells22.setCellValue(teacherCondition.getGetTime());
                cells22.setCellStyle(cellStyle0);

                Cell cells23 = row.createCell(23);
                cells23.setCellValue(teacherCondition.getQiyeYear());
                cells23.setCellStyle(cellStyle0);

                Cell cells24 = row.createCell(24);
                cells24.setCellValue(teacherCondition.getQiyeDate());
                cells24.setCellStyle(cellStyle0);

                Cell cells25 = row.createCell(25);
                cells25.setCellValue(teacherCondition.getMajorGrade());
                cells25.setCellStyle(cellStyle0);

                Cell cells26 = row.createCell(26);
                cells26.setCellValue(teacherCondition.getMajorName());
                cells26.setCellStyle(cellStyle0);

                Cell cells27 = row.createCell(27);
                cells27.setCellValue(teacherCondition.getMajorDept());
                cells27.setCellStyle(cellStyle0);

                Cell cells28 = row.createCell(28);
                cells28.setCellValue(teacherCondition.getMajorDate());
                cells28.setCellStyle(cellStyle0);

                Cell cells29 = row.createCell(29);
                cells29.setCellValue(teacherCondition.getTitleShow());
                cells29.setCellStyle(cellStyle0);

                Cell cells30 = row.createCell(30);
                cells30.setCellValue(teacherCondition.getCareerGrade());
                cells30.setCellStyle(cellStyle0);

                Cell cells31 = row.createCell(31);
                cells31.setCellValue(teacherCondition.getCareerName());
                cells31.setCellStyle(cellStyle0);

                Cell cells32 = row.createCell(32);
                cells32.setCellValue(teacherCondition.getCareerDept());
                cells32.setCellStyle(cellStyle0);

                Cell cells33 = row.createCell(33);
                cells33.setCellValue(teacherCondition.getCareerGettime());
                cells33.setCellStyle(cellStyle0);

                Cell cells34 = row.createCell(34);
                cells34.setCellValue(teacherCondition.getSfzyTeacher());
                cells34.setCellStyle(cellStyle0);

                Cell cells35 = row.createCell(35);
                cells35.setCellValue(teacherCondition.getSfggTeacher());
                cells35.setCellStyle(cellStyle0);

                Cell cells36 = row.createCell(36);
                cells36.setCellValue(teacherCondition.getSfssTeacher());
                cells36.setCellStyle(cellStyle0);

                Cell cells37 = row.createCell(37);
                cells37.setCellValue(teacherCondition.getSfmsTeacher());
                cells37.setCellStyle(cellStyle0);

                Cell cells38 = row.createCell(38);
                cells38.setCellValue(teacherCondition.getPoliticsMajorCode());
                cells38.setCellStyle(cellStyle0);

                Cell cells39 = row.createCell(39);
                cells39.setCellValue(teacherCondition.getPoliticsMajorName());
                cells39.setCellStyle(cellStyle0);

                i = i + 1;
            }
        }else if("2".equals(teacherType)){
            tablename="校外兼课教师信息表";
            Sheet sheet = workbook.createSheet(tablename);
            cellStyle0.setAlignment(HorizontalAlignment.CENTER);
            cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
            cellStyle0.setWrapText(true);
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));//聘任系部
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1));//教工号
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 2, 2));//姓名
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 3, 3));//性别
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 4, 4));//出生日期
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 5, 5));//民族
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 6, 6));//参加工作日期
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 7, 7));//学历
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 8, 8));//学位
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 9, 9));//签约情况
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 10, 13));//专业技术职务（最高）
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 14, 17));//职业资格证书（最高）
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 18, 20));//当前专职工作背景
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 21, 23));//教学进修


            sheet.setColumnWidth(0, 18 * 256);
            sheet.setColumnWidth(1, 18 * 256);
            sheet.setColumnWidth(2, 18 * 256);
            sheet.setColumnWidth(3, 10 * 256);
            sheet.setColumnWidth(4, 10 * 256);
            sheet.setColumnWidth(5, 18 * 256);
            sheet.setColumnWidth(8, 18 * 256);
            sheet.setColumnWidth(11, 18 * 256);
            sheet.setColumnWidth(13, 18 * 256);
            sheet.setColumnWidth(16, 18 * 256);
            sheet.setColumnWidth(18, 18 * 256);
            sheet.setColumnWidth(21, 18 * 256);
            sheet.setColumnWidth(22, 18 * 256);
            sheet.setColumnWidth(23, 18 * 256);
            sheet.setColumnWidth(26, 18 * 256);
            sheet.setColumnWidth(27, 18 * 256);
            sheet.setColumnWidth(31, 18 * 256);
            sheet.setColumnWidth(32, 18 * 256);

            Row row0 = sheet.createRow(0);
            Row row1 = sheet.createRow(1);

            Cell ce1 = row0.createCell(0);
            ce1.setCellValue("聘任系部");
            ce1.setCellStyle(cellStyle0);

            Cell ce2 = row0.createCell(1);
            ce2.setCellValue("教工号");
            ce2.setCellStyle(cellStyle0);

            Cell ce3 = row0.createCell(2);
            ce3.setCellValue("姓名");
            ce3.setCellStyle(cellStyle0);

            Cell ce4 = row0.createCell(3);
            ce4.setCellValue("性别");
            ce4.setCellStyle(cellStyle0);

            Cell ce5 = row0.createCell(4);
            ce5.setCellValue("出生日期");
            ce5.setCellStyle(cellStyle0);

            Cell ce6 = row0.createCell(5);
            ce6.setCellValue("民族");
            ce6.setCellStyle(cellStyle0);

            Cell ce7 = row0.createCell(6);
            ce7.setCellValue("参加工作日期");
            ce7.setCellStyle(cellStyle0);

            Cell ce8 = row0.createCell(7);
            ce8.setCellValue("学历");
            ce8.setCellStyle(cellStyle0);

            Cell ce9 = row0.createCell(8);
            ce9.setCellValue("学位");
            ce9.setCellStyle(cellStyle0);

            Cell ce10 = row0.createCell(9);
            ce10.setCellValue("签约情况");
            ce10.setCellStyle(cellStyle0);

            Cell ce11 = row0.createCell(10);
            ce11.setCellValue("专业技术职务（最高）");
            ce11.setCellStyle(cellStyle0);

            Cell ce12 = row1.createCell(10);
            ce12.setCellValue("等级");
            ce12.setCellStyle(cellStyle0);

            Cell ce13 = row1.createCell(11);
            ce13.setCellValue("名称（全称）");
            ce13.setCellStyle(cellStyle0);

            Cell ce14 = row1.createCell(12);
            ce14.setCellValue("发证单位");
            ce14.setCellStyle(cellStyle0);

            Cell ce15 = row1.createCell(13);
            ce15.setCellValue("获取日期");
            ce15.setCellStyle(cellStyle0);

            Cell ce16 = row0.createCell(14);
            ce16.setCellValue("职业资格证书");
            ce16.setCellStyle(cellStyle0);

            Cell ce17 = row1.createCell(14);
            ce17.setCellValue("等级");
            ce17.setCellStyle(cellStyle0);

            Cell ce18 = row1.createCell(15);
            ce18.setCellValue("名称（全称）");
            ce18.setCellStyle(cellStyle0);

            Cell ce19 = row1.createCell(16);
            ce19.setCellValue("发证单位");
            ce19.setCellStyle(cellStyle0);

            Cell ce20 = row1.createCell(17);
            ce20.setCellValue("获取日期");
            ce20.setCellStyle(cellStyle0);

            Cell ce21 = row0.createCell(18);
            ce21.setCellValue("当前专职工作背景");
            ce21.setCellStyle(cellStyle0);

            Cell ce22 = row1.createCell(18);
            ce22.setCellValue("单位名称");
            ce22.setCellStyle(cellStyle0);

            Cell ce23 = row1.createCell(19);
            ce23.setCellValue("职务");
            ce23.setCellStyle(cellStyle0);

            Cell ce24 = row1.createCell(20);
            ce24.setCellValue("任职日期");
            ce24.setCellStyle(cellStyle0);

            Cell ce25 = row0.createCell(21);
            ce25.setCellValue("教学进修");
            ce25.setCellStyle(cellStyle0);

            Cell ce26 = row1.createCell(21);
            ce26.setCellValue("项目名称");
            ce26.setCellStyle(cellStyle0);

            Cell ce27 = row1.createCell(22);
            ce27.setCellValue("时间（天）");
            ce27.setCellStyle(cellStyle0);

            Cell ce28 = row1.createCell(23);
            ce28.setCellValue("地点");
            ce28.setCellStyle(cellStyle0);

            int i = 2;
            for (TeacherCondition teacherCondition : teacherConditionsList) {
                Row row = sheet.createRow(i);
                Cell cells0 = row.createCell(0);
                cells0.setCellValue(teacherCondition.getDepartmentId());
                cells0.setCellStyle(cellStyle0);

                Cell cells1 = row.createCell(1);
                cells1.setCellValue(teacherCondition.getTeacherNum());
                cells1.setCellStyle(cellStyle0);

                Cell cells2 = row.createCell(2);
                cells2.setCellValue(teacherCondition.getTeacherName());
                cells2.setCellStyle(cellStyle0);

                Cell cells3 = row.createCell(3);
                cells3.setCellValue(teacherCondition.getTeacherSex());
                cells3.setCellStyle(cellStyle0);

                Cell cells4 = row.createCell(4);
                cells4.setCellValue(teacherCondition.getBirthday());
                cells4.setCellStyle(cellStyle0);

                Cell cells5 = row.createCell(5);
                cells5.setCellValue(teacherCondition.getNationShow());
                cells5.setCellStyle(cellStyle0);

                Cell cells6 = row.createCell(6);
                cells6.setCellValue(teacherCondition.getWorkDate());
                cells6.setCellStyle(cellStyle0);

                Cell cells7 = row.createCell(7);
                cells7.setCellValue(teacherCondition.getFinalEducation());
                cells7.setCellStyle(cellStyle0);

                Cell cells8 = row.createCell(8);
                cells8.setCellValue(teacherCondition.getDegee());
                cells8.setCellStyle(cellStyle0);

                Cell cells9 = row.createCell(9);
                cells9.setCellValue(teacherCondition.getSigning());
                cells9.setCellStyle(cellStyle0);

                Cell cells10 = row.createCell(10);
                cells10.setCellValue(teacherCondition.getMajorGrade());
                cells10.setCellStyle(cellStyle0);

                Cell cells11 = row.createCell(11);
                cells11.setCellValue(teacherCondition.getMajorName());
                cells11.setCellStyle(cellStyle0);

                Cell cells12 = row.createCell(12);
                cells12.setCellValue(teacherCondition.getMajorDept());
                cells12.setCellStyle(cellStyle0);

                Cell cells13 = row.createCell(13);
                cells13.setCellValue(teacherCondition.getMajorDate());
                cells13.setCellStyle(cellStyle0);

                Cell cells14 = row.createCell(14);
                cells14.setCellValue(teacherCondition.getCareerGrade());
                cells14.setCellStyle(cellStyle0);

                Cell cells15 = row.createCell(15);
                cells15.setCellValue(teacherCondition.getCareerName());
                cells15.setCellStyle(cellStyle0);

                Cell cells16 = row.createCell(16);
                cells16.setCellValue(teacherCondition.getCareerDept());
                cells16.setCellStyle(cellStyle0);

                Cell cells17 = row.createCell(17);
                cells17.setCellValue(teacherCondition.getCareerGettime());
                cells17.setCellStyle(cellStyle0);

                Cell cells18 = row.createCell(18);
                cells18.setCellValue(teacherCondition.getExpertDept());
                cells18.setCellStyle(cellStyle0);

                Cell cells19 = row.createCell(19);
                cells19.setCellValue(teacherCondition.getExpertWork());
                cells19.setCellStyle(cellStyle0);

                Cell cells20 = row.createCell(20);
                cells20.setCellValue(teacherCondition.getExpertDate());
                cells20.setCellStyle(cellStyle0);

                Cell cells21 = row.createCell(21);
                cells21.setCellValue(teacherCondition.getTrainingName());
                cells21.setCellStyle(cellStyle0);

                Cell cells22 = row.createCell(22);
                cells22.setCellValue(teacherCondition.getTrainingDay());
                cells22.setCellStyle(cellStyle0);

                Cell cells23 = row.createCell(23);
                cells23.setCellValue(teacherCondition.getTrainingPlace());
                cells23.setCellStyle(cellStyle0);

                i = i + 1;
            }
        }else if("3".equals(teacherType)){
            tablename="校外兼职教师信息表";
            Sheet sheet = workbook.createSheet(tablename);
            cellStyle0.setAlignment(HorizontalAlignment.CENTER);
            cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
            cellStyle0.setWrapText(true);
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));//聘任系部
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1));//教工号
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 2, 2));//姓名
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 3, 3));//性别
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 4, 4));//出生日期
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 5, 5));//民族
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 6, 6));//参加工作日期
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 7, 7));//学历
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 8, 8));//学位
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 9, 9));//签约情况
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 10, 13));//专业技术职务（最高）
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 14, 17));//职业资格证书（最高）
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 18, 20));//当前专职工作背景
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 21, 23));//教学进修
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 24, 26));//行政所属专业


            sheet.setColumnWidth(0, 18 * 256);
            sheet.setColumnWidth(1, 18 * 256);
            sheet.setColumnWidth(2, 18 * 256);
            sheet.setColumnWidth(3, 10 * 256);
            sheet.setColumnWidth(4, 10 * 256);
            sheet.setColumnWidth(5, 18 * 256);
            sheet.setColumnWidth(8, 18 * 256);
            sheet.setColumnWidth(11, 18 * 256);
            sheet.setColumnWidth(13, 18 * 256);
            sheet.setColumnWidth(16, 18 * 256);
            sheet.setColumnWidth(18, 18 * 256);
            sheet.setColumnWidth(21, 18 * 256);
            sheet.setColumnWidth(22, 18 * 256);
            sheet.setColumnWidth(23, 18 * 256);
            sheet.setColumnWidth(26, 18 * 256);
            sheet.setColumnWidth(27, 18 * 256);
            sheet.setColumnWidth(31, 18 * 256);
            sheet.setColumnWidth(32, 18 * 256);

            Row row0 = sheet.createRow(0);
            Row row1 = sheet.createRow(1);

            Cell ce1 = row0.createCell(0);
            ce1.setCellValue("聘任系部");
            ce1.setCellStyle(cellStyle0);

            Cell ce2 = row0.createCell(1);
            ce2.setCellValue("教工号");
            ce2.setCellStyle(cellStyle0);

            Cell ce3 = row0.createCell(2);
            ce3.setCellValue("姓名");
            ce3.setCellStyle(cellStyle0);

            Cell ce4 = row0.createCell(3);
            ce4.setCellValue("性别");
            ce4.setCellStyle(cellStyle0);

            Cell ce5 = row0.createCell(4);
            ce5.setCellValue("出生日期");
            ce5.setCellStyle(cellStyle0);

            Cell ce6 = row0.createCell(5);
            ce6.setCellValue("民族");
            ce6.setCellStyle(cellStyle0);

            Cell ce7 = row0.createCell(6);
            ce7.setCellValue("参加工作日期");
            ce7.setCellStyle(cellStyle0);

            Cell ce8 = row0.createCell(7);
            ce8.setCellValue("学历");
            ce8.setCellStyle(cellStyle0);

            Cell ce9 = row0.createCell(8);
            ce9.setCellValue("学位");
            ce9.setCellStyle(cellStyle0);

            Cell ce10 = row0.createCell(9);
            ce10.setCellValue("签约情况");
            ce10.setCellStyle(cellStyle0);

            Cell ce11 = row0.createCell(10);
            ce11.setCellValue("专业技术职务（最高）");
            ce11.setCellStyle(cellStyle0);

            Cell ce12 = row1.createCell(10);
            ce12.setCellValue("等级");
            ce12.setCellStyle(cellStyle0);

            Cell ce13 = row1.createCell(11);
            ce13.setCellValue("名称（全称）");
            ce13.setCellStyle(cellStyle0);

            Cell ce14 = row1.createCell(12);
            ce14.setCellValue("发证单位");
            ce14.setCellStyle(cellStyle0);

            Cell ce15 = row1.createCell(13);
            ce15.setCellValue("获取日期");
            ce15.setCellStyle(cellStyle0);

            Cell ce16 = row0.createCell(14);
            ce16.setCellValue("职业资格证书");
            ce16.setCellStyle(cellStyle0);

            Cell ce17 = row1.createCell(14);
            ce17.setCellValue("等级");
            ce17.setCellStyle(cellStyle0);

            Cell ce18 = row1.createCell(15);
            ce18.setCellValue("名称（全称）");
            ce18.setCellStyle(cellStyle0);

            Cell ce19 = row1.createCell(16);
            ce19.setCellValue("发证单位");
            ce19.setCellStyle(cellStyle0);

            Cell ce20 = row1.createCell(17);
            ce20.setCellValue("获取日期");
            ce20.setCellStyle(cellStyle0);

            Cell ce21 = row0.createCell(18);
            ce21.setCellValue("当前专职工作背景");
            ce21.setCellStyle(cellStyle0);

            Cell ce22 = row1.createCell(18);
            ce22.setCellValue("单位名称");
            ce22.setCellStyle(cellStyle0);

            Cell ce23 = row1.createCell(19);
            ce23.setCellValue("职务");
            ce23.setCellStyle(cellStyle0);

            Cell ce24 = row1.createCell(20);
            ce24.setCellValue("任职日期");
            ce24.setCellStyle(cellStyle0);

            Cell ce25 = row0.createCell(21);
            ce25.setCellValue("教学进修");
            ce25.setCellStyle(cellStyle0);

            Cell ce26 = row1.createCell(21);
            ce26.setCellValue("项目名称");
            ce26.setCellStyle(cellStyle0);

            Cell ce27 = row1.createCell(22);
            ce27.setCellValue("时间（天）");
            ce27.setCellStyle(cellStyle0);

            Cell ce28 = row1.createCell(23);
            ce28.setCellValue("地点");
            ce28.setCellStyle(cellStyle0);

            Cell ce29 = row0.createCell(24);
            ce29.setCellValue("行政所属专业");
            ce29.setCellStyle(cellStyle0);

            Cell ce30 = row1.createCell(24);
            ce30.setCellValue("派出部门");
            ce30.setCellStyle(cellStyle0);

            Cell ce31 = row1.createCell(25);
            ce31.setCellValue("专业代码");
            ce31.setCellStyle(cellStyle0);

            Cell ce32 = row1.createCell(26);
            ce32.setCellValue("专业名称");
            ce32.setCellStyle(cellStyle0);

            int i = 2;
            for (TeacherCondition teacherCondition : teacherConditionsList) {
                Row row = sheet.createRow(i);
                Cell cells0 = row.createCell(0);
                cells0.setCellValue(teacherCondition.getDepartmentId());
                cells0.setCellStyle(cellStyle0);

                Cell cells1 = row.createCell(1);
                cells1.setCellValue(teacherCondition.getTeacherNum());
                cells1.setCellStyle(cellStyle0);

                Cell cells2 = row.createCell(2);
                cells2.setCellValue(teacherCondition.getTeacherName());
                cells2.setCellStyle(cellStyle0);

                Cell cells3 = row.createCell(3);
                cells3.setCellValue(teacherCondition.getTeacherSex());
                cells3.setCellStyle(cellStyle0);

                Cell cells4 = row.createCell(4);
                cells4.setCellValue(teacherCondition.getBirthday());
                cells4.setCellStyle(cellStyle0);

                Cell cells5 = row.createCell(5);
                cells5.setCellValue(teacherCondition.getNationShow());
                cells5.setCellStyle(cellStyle0);

                Cell cells6 = row.createCell(6);
                cells6.setCellValue(teacherCondition.getWorkDate());
                cells6.setCellStyle(cellStyle0);

                Cell cells7 = row.createCell(7);
                cells7.setCellValue(teacherCondition.getFinalEducation());
                cells7.setCellStyle(cellStyle0);

                Cell cells8 = row.createCell(8);
                cells8.setCellValue(teacherCondition.getDegee());
                cells8.setCellStyle(cellStyle0);

                Cell cells9 = row.createCell(9);
                cells9.setCellValue(teacherCondition.getSigning());
                cells9.setCellStyle(cellStyle0);

                Cell cells10 = row.createCell(10);
                cells10.setCellValue(teacherCondition.getMajorGrade());
                cells10.setCellStyle(cellStyle0);

                Cell cells11 = row.createCell(11);
                cells11.setCellValue(teacherCondition.getMajorName());
                cells11.setCellStyle(cellStyle0);

                Cell cells12 = row.createCell(12);
                cells12.setCellValue(teacherCondition.getMajorDept());
                cells12.setCellStyle(cellStyle0);

                Cell cells13 = row.createCell(13);
                cells13.setCellValue(teacherCondition.getMajorDate());
                cells13.setCellStyle(cellStyle0);

                Cell cells14 = row.createCell(14);
                cells14.setCellValue(teacherCondition.getCareerGrade());
                cells14.setCellStyle(cellStyle0);

                Cell cells15 = row.createCell(15);
                cells15.setCellValue(teacherCondition.getCareerName());
                cells15.setCellStyle(cellStyle0);

                Cell cells16 = row.createCell(16);
                cells16.setCellValue(teacherCondition.getCareerDept());
                cells16.setCellStyle(cellStyle0);

                Cell cells17 = row.createCell(17);
                cells17.setCellValue(teacherCondition.getCareerGettime());
                cells17.setCellStyle(cellStyle0);

                Cell cells18 = row.createCell(18);
                cells18.setCellValue(teacherCondition.getExpertDept());
                cells18.setCellStyle(cellStyle0);

                Cell cells19 = row.createCell(19);
                cells19.setCellValue(teacherCondition.getExpertWork());
                cells19.setCellStyle(cellStyle0);

                Cell cells20 = row.createCell(20);
                cells20.setCellValue(teacherCondition.getExpertDate());
                cells20.setCellStyle(cellStyle0);

                Cell cells21 = row.createCell(21);
                cells21.setCellValue(teacherCondition.getTrainingName());
                cells21.setCellStyle(cellStyle0);

                Cell cells22 = row.createCell(22);
                cells22.setCellValue(teacherCondition.getTrainingDay());
                cells22.setCellStyle(cellStyle0);

                Cell cells23 = row.createCell(23);
                cells23.setCellValue(teacherCondition.getTrainingPlace());
                cells23.setCellStyle(cellStyle0);

                Cell cells24 = row.createCell(24);
                cells24.setCellValue(teacherCondition.getSendDept());
                cells24.setCellStyle(cellStyle0);

                Cell cells25 = row.createCell(25);
                cells25.setCellValue(teacherCondition.getPoliticsMajorCode());
                cells25.setCellStyle(cellStyle0);

                Cell cells26 = row.createCell(26);
                cells26.setCellValue(teacherCondition.getPoliticsMajorName());
                cells26.setCellStyle(cellStyle0);

                i = i + 1;
            }
        }else {
            tablename="校内兼课教师信息表";
            Sheet sheet = workbook.createSheet(tablename);
            cellStyle0.setAlignment(HorizontalAlignment.CENTER);
            cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
            cellStyle0.setWrapText(true);
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));//任职部门
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1));//教工号
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 2, 2));//姓名
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 3, 3));//性别
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 4, 4));//出生日期
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 5, 5));//民族
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 6, 6));//学历
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 7, 7));//学位
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 8, 8));//专业领域
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 9, 9));//专业特长
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 10, 11));//行业、企业一线工作时间
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 12, 15));//专业技术职务（最高）
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 16, 16));//已聘职称
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 17, 18));//高校教师资格证书
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 19, 19));//所任职务
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 20, 20));//是否为骨干教师
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 21, 21));//是否为双师型教师
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 22, 22));//是否教学名师
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 23, 25));//行政所属专业

            sheet.setColumnWidth(0, 18 * 256);
            sheet.setColumnWidth(1, 18 * 256);
            sheet.setColumnWidth(2, 18 * 256);
            sheet.setColumnWidth(3, 10 * 256);
            sheet.setColumnWidth(4, 10 * 256);
            sheet.setColumnWidth(5, 18 * 256);
            sheet.setColumnWidth(8, 18 * 256);
            sheet.setColumnWidth(10, 18 * 256);
            sheet.setColumnWidth(11, 18 * 256);
            sheet.setColumnWidth(13, 18 * 256);
            sheet.setColumnWidth(14, 18 * 256);
            sheet.setColumnWidth(15, 18 * 256);
            sheet.setColumnWidth(16, 18 * 256);
            sheet.setColumnWidth(17, 18 * 256);
            sheet.setColumnWidth(18, 18 * 256);

            Row row0 = sheet.createRow(0);
            Row row1 = sheet.createRow(1);

            Cell ce1 = row0.createCell(0);
            ce1.setCellValue("任职部门");
            ce1.setCellStyle(cellStyle0);

            Cell ce2 = row0.createCell(1);
            ce2.setCellValue("教工号");
            ce2.setCellStyle(cellStyle0);

            Cell ce3 = row0.createCell(2);
            ce3.setCellValue("姓名");
            ce3.setCellStyle(cellStyle0);

            Cell ce4 = row0.createCell(3);
            ce4.setCellValue("性别");
            ce4.setCellStyle(cellStyle0);

            Cell ce5 = row0.createCell(4);
            ce5.setCellValue("出生日期");
            ce5.setCellStyle(cellStyle0);

            Cell ce6 = row0.createCell(5);
            ce6.setCellValue("民族");
            ce6.setCellStyle(cellStyle0);

            Cell ce7 = row0.createCell(6);
            ce7.setCellValue("学历");
            ce7.setCellStyle(cellStyle0);

            Cell ce8 = row0.createCell(7);
            ce8.setCellValue("学位");
            ce8.setCellStyle(cellStyle0);

            Cell ce9 = row0.createCell(8);
            ce9.setCellValue("专业领域");
            ce9.setCellStyle(cellStyle0);

            Cell ce10 = row0.createCell(9);
            ce10.setCellValue("专业特长");
            ce10.setCellStyle(cellStyle0);

            Cell ce13 = row0.createCell(10);
            ce13.setCellValue("行业、企业一线工作时间");
            ce13.setCellStyle(cellStyle0);

            Cell ce14 = row1.createCell(10);
            ce14.setCellValue("历年（年）");
            ce14.setCellStyle(cellStyle0);

            Cell ce15 = row1.createCell(11);
            ce15.setCellValue("本学年（天）");
            ce15.setCellStyle(cellStyle0);

            Cell ce16 = row0.createCell(12);
            ce16.setCellValue("专业技术职务（最高）");
            ce16.setCellStyle(cellStyle0);

            Cell ce17 = row1.createCell(12);
            ce17.setCellValue("等级");
            ce17.setCellStyle(cellStyle0);

            Cell ce18 = row1.createCell(13);
            ce18.setCellValue("名称（全称）");
            ce18.setCellStyle(cellStyle0);

            Cell ce19 = row1.createCell(14);
            ce19.setCellValue("发证单位（全称）");
            ce19.setCellStyle(cellStyle0);

            Cell ce20 = row1.createCell(15);
            ce20.setCellValue("获取日期（年月）");
            ce20.setCellStyle(cellStyle0);

            Cell ce21 = row0.createCell(16);
            ce21.setCellValue("已聘职称");
            ce21.setCellStyle(cellStyle0);

            Cell ce22 = row0.createCell(17);
            ce22.setCellValue("高校教师资格证书");
            ce22.setCellStyle(cellStyle0);

            Cell ce23 = row1.createCell(17);
            ce23.setCellValue("发证单位（全称）");
            ce23.setCellStyle(cellStyle0);

            Cell ce24 = row1.createCell(18);
            ce24.setCellValue("获取日期（年月）");
            ce24.setCellStyle(cellStyle0);

            Cell ce25 = row0.createCell(19);
            ce25.setCellValue("所任职务");
            ce25.setCellStyle(cellStyle0);

            Cell ce26 = row0.createCell(20);
            ce26.setCellValue("是否为骨干教师");
            ce26.setCellStyle(cellStyle0);

            Cell ce27 = row0.createCell(21);
            ce27.setCellValue("是否为双师型教师");
            ce27.setCellStyle(cellStyle0);

            Cell ce28 = row0.createCell(22);
            ce28.setCellValue("是否教学名师");
            ce28.setCellStyle(cellStyle0);

            Cell ce29 = row0.createCell(23);
            ce29.setCellValue("行政所属专业");
            ce29.setCellStyle(cellStyle0);

            Cell ce30 = row1.createCell(23);
            ce30.setCellValue("派出部门");
            ce30.setCellStyle(cellStyle0);

            Cell ce31 = row1.createCell(24);
            ce31.setCellValue("专业代码");
            ce31.setCellStyle(cellStyle0);

            Cell ce32 = row1.createCell(25);
            ce32.setCellValue("专业名称");
            ce32.setCellStyle(cellStyle0);






            int i = 2;
            for (TeacherCondition teacherCondition : teacherConditionsList) {
                Row row = sheet.createRow(i);
                Cell cells0 = row.createCell(0);
                cells0.setCellValue(teacherCondition.getDepartmentId());
                cells0.setCellStyle(cellStyle0);

                Cell cells1 = row.createCell(1);
                cells1.setCellValue(teacherCondition.getTeacherNum());
                cells1.setCellStyle(cellStyle0);

                Cell cells2 = row.createCell(2);
                cells2.setCellValue(teacherCondition.getTeacherName());
                cells2.setCellStyle(cellStyle0);

                Cell cells3 = row.createCell(3);
                cells3.setCellValue(teacherCondition.getTeacherSex());
                cells3.setCellStyle(cellStyle0);

                Cell cells4 = row.createCell(4);
                cells4.setCellValue(teacherCondition.getBirthday());
                cells4.setCellStyle(cellStyle0);

                Cell cells5 = row.createCell(5);
                cells5.setCellValue(teacherCondition.getNationShow());
                cells5.setCellStyle(cellStyle0);

                Cell cells6 = row.createCell(6);
                cells6.setCellValue(teacherCondition.getFinalEducation());
                cells6.setCellStyle(cellStyle0);

                Cell cells7 = row.createCell(7);
                cells7.setCellValue(teacherCondition.getDegee());
                cells7.setCellStyle(cellStyle0);

                Cell cells8 = row.createCell(8);
                cells8.setCellValue(teacherCondition.getMajorField());
                cells8.setCellStyle(cellStyle0);


                Cell cells9 = row.createCell(9);
                cells9.setCellValue(teacherCondition.getMajorSpecialty());
                cells9.setCellStyle(cellStyle0);

                Cell cells10 = row.createCell(10);
                cells10.setCellValue(teacherCondition.getQiyeYear());
                cells10.setCellStyle(cellStyle0);

                Cell cells11 = row.createCell(11);
                cells11.setCellValue(teacherCondition.getQiyeDate());
                cells11.setCellStyle(cellStyle0);

                Cell cells12 = row.createCell(12);
                cells12.setCellValue(teacherCondition.getMajorGrade());
                cells12.setCellStyle(cellStyle0);

                Cell cells13 = row.createCell(13);
                cells13.setCellValue(teacherCondition.getMajorName());
                cells13.setCellStyle(cellStyle0);

                Cell cells14 = row.createCell(14);
                cells14.setCellValue(teacherCondition.getMajorDept());
                cells14.setCellStyle(cellStyle0);

                Cell cells15 = row.createCell(15);
                cells15.setCellValue(teacherCondition.getMajorDate());
                cells15.setCellStyle(cellStyle0);

                Cell cells16 = row.createCell(16);
                cells16.setCellValue(teacherCondition.getTitle());
                cells16.setCellStyle(cellStyle0);

                Cell cells17 = row.createCell(17);
                cells17.setCellValue(teacherCondition.getLicence());
                cells17.setCellStyle(cellStyle0);

                Cell cells18 = row.createCell(18);
                cells18.setCellValue(teacherCondition.getGetTime());
                cells18.setCellStyle(cellStyle0);

                Cell cells19 = row.createCell(19);
                cells19.setCellValue(teacherCondition.getSrPosition());
                cells19.setCellStyle(cellStyle0);

                Cell cells20 = row.createCell(20);
                cells20.setCellValue(teacherCondition.getSfggTeacher());
                cells20.setCellStyle(cellStyle0);

                Cell cells21 = row.createCell(21);
                cells21.setCellValue(teacherCondition.getSfssTeacher());
                cells21.setCellStyle(cellStyle0);

                Cell cells22 = row.createCell(22);
                cells22.setCellValue(teacherCondition.getSfmsTeacher());
                cells22.setCellStyle(cellStyle0);

                Cell cells23 = row.createCell(23);
                cells23.setCellValue(teacherCondition.getSendDept());
                cells23.setCellStyle(cellStyle0);

                Cell cells24 = row.createCell(24);
                cells24.setCellValue(teacherCondition.getPoliticsMajorCode());
                cells24.setCellStyle(cellStyle0);

                Cell cells25 = row.createCell(25);
                cells25.setCellValue(teacherCondition.getPoliticsMajorName());
                cells25.setCellStyle(cellStyle0);

                i = i + 1;
            }
        }




        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    (tablename+".xls", "utf-8"));
            os = response.getOutputStream();
            workbook.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                }
                workbook.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

}
