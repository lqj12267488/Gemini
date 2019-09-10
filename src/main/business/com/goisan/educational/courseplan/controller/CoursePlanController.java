package com.goisan.educational.courseplan.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.courseplan.bean.CoursePlan;
import com.goisan.educational.courseplan.bean.CoursePlanDetail;
import com.goisan.educational.courseplan.bean.CoursePlanExcel;
import com.goisan.educational.courseplan.bean.CourseplanTerm;
import com.goisan.educational.courseplan.service.CoursePlanService;
import com.goisan.educational.textbook.service.TextBookService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.system.tools.PoiUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.NumberFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/courseplan")
public class CoursePlanController {

    @Resource
    private CoursePlanService coursePlanService;
    @Resource
    private TextBookService textBookService;

    @RequestMapping("/toCoursePlan")
    public String toList(Model model) {
        return "business/educational/courseplan/list";
    }

    @RequestMapping("/toCoursePlanTeacher")
    public String toCoursePlanTeacher(Model model) {
        return "business/educational/courseplan/list";
    }

    @ResponseBody
    @RequestMapping("/getList")
    public Map<String, Object> getList(CoursePlan coursePlan,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> coursePlanList = new HashMap<String, Object>();
        List<CoursePlan> list = coursePlanService.selectList(coursePlan);
        PageInfo<List<CoursePlan>> info = new PageInfo(list);
        coursePlanList.put("draw", draw);
        coursePlanList.put("recordsTotal", info.getTotal());
        coursePlanList.put("recordsFiltered", info.getTotal());
        coursePlanList.put("data", list);
       // return CommonUtil.tableMap(coursePlanService.selectList(coursePlan));
        return coursePlanList;
    }


    @RequestMapping("/toAddTeacher")
    public String toAddTeacher(Model model) {
        model.addAttribute("head", "新增");
        return "business/educational/courseplan/editCoursePlanList";
    }

    @RequestMapping("/toEditTeacher")
    public String toEditTeacher(String id, Model model) {
        model.addAttribute("data", coursePlanService.selectById(id));
        model.addAttribute("head", "修改");
        return "business/educational/courseplan/editCoursePlanList";
    }

    @RequestMapping("/toAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "business/educational/courseplan/edit";
    }

    @ResponseBody
    @RequestMapping("/save")
    public Message save(CoursePlan coursePlan) {
        int count = coursePlanService.checkPlanName(coursePlan);
        if (count > 0) {
            String msg = "";
            if (coursePlan.getPlanId() == "")
                msg = "您新增的计划名称已存在，请更改一个新的计划名称";
            else
                msg = "您修改的计划名称已存在，请更改一个新的计划名称";
            return new Message(0, msg, "error");
        }
        if (coursePlan.getPlanId() == "") {
            coursePlan.setPlanId(CommonUtil.getUUID());
            CommonUtil.save(coursePlan);
            coursePlan.setTeacherPersonId(CommonUtil.getPersonId());
            coursePlanService.save(coursePlan);
            return new Message(1, "添加成功！", "success");
        } else {
            CommonUtil.update(coursePlan);
            coursePlanService.update(coursePlan);
            return new Message(1, "修改成功！", "success");
        }

    }

    @RequestMapping("/toEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", coursePlanService.selectById(id));
        model.addAttribute("head", "修改");
        return "business/educational/courseplan/edit";
    }

    @ResponseBody
    @RequestMapping("/del")
    public Message del(String id) {
        Message message = new Message(0, "删除成功！", null);
        List<String> strings = coursePlanService.getArrayClassCourseIdsPlanByCouesePlanId(id);
        if (strings.size() > 0) {
            message.setMsg("该计划已关联排课计划,不能删除！");
        } else {
            coursePlanService.del(id);
        }
        return message;
    }

    @RequestMapping("/toPlanDetails")
    public String toPlanDetail(String id, String planName, String majorCode, String trainingLevel, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("planName", planName);
        model.addAttribute("majorCode", majorCode);
        model.addAttribute("trainingLevel", trainingLevel);
        return "business/educational/courseplan/planDetails";
    }

    @ResponseBody
    @RequestMapping("/getPlanDetails")
    public Map getPlanDetails(CoursePlanDetail coursePlanDetail) {
        return CommonUtil.tableMap(coursePlanService.getPlanDetails(coursePlanDetail));
    }

    @RequestMapping("/toAddPlanDetail")
    public String toAddPlanDetails(CoursePlanDetail coursePlanDetail, String majorCode, String trainingLevel, Model
            model) {
        model.addAttribute("head", "新增");
        model.addAttribute("data", coursePlanDetail);
        model.addAttribute("majorCode", majorCode);
        model.addAttribute("trainingLevel", trainingLevel);
        return "business/educational/courseplan/planDetailEdit";
    }

    @RequestMapping("/toEditPlanDetail")
    public String toEditPlanDetails(String id, String majorCode, String trainingLevel, Model model) {
        model.addAttribute("data", coursePlanService.getPlanDetail(id));
        model.addAttribute("head", "修改");
        model.addAttribute("majorCode", majorCode);
        model.addAttribute("trainingLevel", trainingLevel);
        return "business/educational/courseplan/planDetailEdit";
    }

    @ResponseBody
    @RequestMapping("/getTextBookAll")
    public List<AutoComplete> getTextBook() {
        return this.textBookService.getTextBookAll();
    }
    @ResponseBody
    @RequestMapping("/savePlanDetail")
    public Message savePlanDetail(CoursePlanDetail coursePlanDetail) {
        if ("".equals(coursePlanDetail.getId())) {
            coursePlanDetail.setId(CommonUtil.getUUID());
            CommonUtil.save(coursePlanDetail);
            coursePlanService.savePlanDetail(coursePlanDetail);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(coursePlanDetail);
            coursePlanService.updatePlanDetail(coursePlanDetail);
            return new Message(0, "修改成功！", null);
        }

    }

    @ResponseBody
    @RequestMapping("/delPlanDetail")
    public Message delPlanDetail(String id) {
        coursePlanService.delPlanDetail(id);
        return new Message(0, "删除成功！", null);

    }

    @ResponseBody
    @RequestMapping("/getTextbook")
    public List<Select2> getTextbook() {
        return coursePlanService.getTextbook();
    }

    @ResponseBody
    @RequestMapping("/getCourse")
    public List<Select2> getCourse(String courseType) {
        return coursePlanService.getCourse(courseType);
    }

    @RequestMapping("/toPlanTerm")
    public String toPlanTerm(String id, String planName, Model model, String courseName) {
        model.addAttribute("data", coursePlanService.getPlanDetail(id));
        model.addAttribute("planName", planName);
        model.addAttribute("courseName", courseName);
        return "business/educational/courseplan/planTerms";
    }

    @RequestMapping("/toPlanTermList")
    public String toPlanTermList(String id, String planName, Model model, String courseName) {
        model.addAttribute("data", coursePlanService.getPlanDetail(id));
        model.addAttribute("planName", planName);
        model.addAttribute("courseName", courseName);
        return "business/educational/courseplan/planTermsList";
    }

    @ResponseBody
    @RequestMapping("/getPlanTerms")
    public Map getPlanTerms(CourseplanTerm courseplanTerm) {
        return CommonUtil.tableMap(coursePlanService.getPlanTerms(courseplanTerm));
    }

    @RequestMapping("/toAddPlanTerm")
    public String toAddPlanTerm(CourseplanTerm courseplanTerm, String planName, Model model) {
        model.addAttribute("head", "新增");
        model.addAttribute("planName", planName);
        CoursePlanDetail coursePlanDetail = coursePlanService.getPlanDetail(courseplanTerm
                .getDetailsId());
        courseplanTerm.setCourseId(coursePlanDetail.getCourseId());
        courseplanTerm.setCourseName(coursePlanDetail.getCourseName());
        courseplanTerm.setPlanId(coursePlanDetail.getPlanId());
        model.addAttribute("data", courseplanTerm);
        return "business/educational/courseplan/planTermEdit";
    }

    @ResponseBody
    @RequestMapping("/savePlanTerm")
    public Message savePlanTerm(CourseplanTerm courseplanTerm) {
        if ("".equals(courseplanTerm.getId())) {
            courseplanTerm.setId(CommonUtil.getUUID());
            CommonUtil.save(courseplanTerm);
            coursePlanService.savePlanTerm(courseplanTerm);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(courseplanTerm);
            coursePlanService.updatePlanTerm(courseplanTerm);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/toEditPlanTerm")
    public String toEditPlanTerm(String id, Model model) {
        model.addAttribute("data", coursePlanService.getPlanTerm(id));
        model.addAttribute("head", "修改");
        return "business/educational/courseplan/planTermEdit";
    }

    @ResponseBody
    @RequestMapping("/delPlanTerm")
    public Message delPlanTerm(String id) {
        coursePlanService.delPlanTerm(id);
        return new Message(0, "删除成功！", null);

    }

    @RequestMapping("/toCoursePlanQuery")
    public String toListQuery(Model model) {
        return "business/educational/courseplanQuery/list";
    }

    @RequestMapping("/toPlanDetailsQuery")
    public String toPlanDetailQuery(String id, String planName, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("planName", planName);
        return "business/educational/courseplanQuery/planDetails";
    }

    @RequestMapping("/toPlanTermQuery")
    public String toPlanTermQuery(String id, String planName, Model model) {
        model.addAttribute("data", coursePlanService.getPlanDetail(id));
        model.addAttribute("planName", planName);
        return "business/educational/courseplan/planTermsQuery";
    }

    @RequestMapping("/toExportPlan")
    public void toExportPlan(String planName, HttpServletResponse response) {

        HSSFWorkbook workbook = new HSSFWorkbook();
        CellStyle cellStyle0 = workbook.createCellStyle();
        Sheet sheet = workbook.createSheet("课时分配表");

        cellStyle0.setAlignment(HorizontalAlignment.CENTER);
        cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle0.setWrapText(true);


        sheet.addMergedRegion(new CellRangeAddress(0, 3, 0, 0));//课程属性
        sheet.addMergedRegion(new CellRangeAddress(0, 3, 1, 1));//课程代码
        sheet.addMergedRegion(new CellRangeAddress(0, 3, 2, 2));//课程名称
        sheet.addMergedRegion(new CellRangeAddress(0, 3, 3, 3));//总学时
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 4, 6));//学时总分配
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 7, 24));//学期周学时分配
        sheet.addMergedRegion(new CellRangeAddress(0, 3, 25, 25));//理实实践地点
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 4, 4));//理论
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 5, 5));//理实
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 6, 6));//实践
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 7, 12));//第一学年
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 13, 18));//第二学年
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 19, 24));//第三学年
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 7, 9));//1
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 10, 12));//2
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 13, 15));//3
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 16, 18));//4
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 19, 21));//5
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 22, 24));//6


        sheet.setColumnWidth(0, 4 * 256);
        sheet.setColumnWidth(1, 8 * 256);
        sheet.setColumnWidth(2, 18 * 256);
        sheet.setColumnWidth(3, 7 * 256);
        sheet.setColumnWidth(4, 10 * 256);

        Row row0 = sheet.createRow(0);
        Row row1 = sheet.createRow(1);
        Row row2 = sheet.createRow(2);
        Row row3 = sheet.createRow(3);

        Cell cell00 = row0.createCell(0);
        cell00.setCellValue("课\n程\n属\n性");
        cell00.setCellStyle(cellStyle0);

        Cell cell01 = row0.createCell(1);
        cell01.setCellValue("课\n程\n代\n码");
        cell01.setCellStyle(cellStyle0);

        Cell cell02 = row0.createCell(2);
        cell02.setCellValue("课程名称");
        cell02.setCellStyle(cellStyle0);

        Cell cell03 = row0.createCell(3);
        cell03.setCellValue("总\n学\n时");
        cell03.setCellStyle(cellStyle0);

        Cell cell04 = row0.createCell(4);
        cell04.setCellValue("学时总分配");
        cell04.setCellStyle(cellStyle0);

        Cell cell07 = row0.createCell(7);
        cell07.setCellValue("学期周学时分配");
        cell07.setCellStyle(cellStyle0);

        Cell cell025 = row0.createCell(25);
        cell025.setCellValue("理实\n实践\n地点");
        cell025.setCellStyle(cellStyle0);

        Cell cell14 = row1.createCell(4);
        cell14.setCellValue("理\n论");
        cell14.setCellStyle(cellStyle0);

        Cell cell15 = row1.createCell(5);
        cell15.setCellValue("理\n实");
        cell15.setCellStyle(cellStyle0);

        Cell cell16 = row1.createCell(6);
        cell16.setCellValue("实\n践");
        cell16.setCellStyle(cellStyle0);


        Cell cell17 = row1.createCell(7);
        cell17.setCellValue("第一学年");
        cell17.setCellStyle(cellStyle0);

        Cell cell18 = row1.createCell(13);
        cell18.setCellValue("第二学年");
        cell18.setCellStyle(cellStyle0);

        Cell cell19 = row1.createCell(19);
        cell19.setCellValue("第三学年");
        cell19.setCellStyle(cellStyle0);

        Cell cell27 = row2.createCell(7);
        cell27.setCellValue("1");
        cell27.setCellStyle(cellStyle0);

        Cell cell210 = row2.createCell(10);
        cell210.setCellValue("2");
        cell210.setCellStyle(cellStyle0);

        Cell cell213 = row2.createCell(13);
        cell213.setCellValue("3");
        cell213.setCellStyle(cellStyle0);

        Cell cell216 = row2.createCell(16);
        cell216.setCellValue("4");
        cell216.setCellStyle(cellStyle0);

        Cell cell219 = row2.createCell(19);
        cell219.setCellValue("5");
        cell219.setCellStyle(cellStyle0);

        Cell cell224 = row2.createCell(22);
        cell224.setCellValue("6");
        cell224.setCellStyle(cellStyle0);

        Cell cell37 = row3.createCell(7);
        cell37.setCellValue("理论");
        cell37.setCellStyle(cellStyle0);

        Cell cell38 = row3.createCell(8);
        cell38.setCellValue("理实");
        cell38.setCellStyle(cellStyle0);

        Cell cell39 = row3.createCell(9);
        cell39.setCellValue("实践");
        cell39.setCellStyle(cellStyle0);

        Cell cell310 = row3.createCell(10);
        cell310.setCellValue("理论");
        cell310.setCellStyle(cellStyle0);

        Cell cell311 = row3.createCell(11);
        cell311.setCellValue("理实");
        cell311.setCellStyle(cellStyle0);

        Cell cell312 = row3.createCell(12);
        cell312.setCellValue("实践");
        cell312.setCellStyle(cellStyle0);

        Cell cell313 = row3.createCell(13);
        cell313.setCellValue("理论");
        cell313.setCellStyle(cellStyle0);

        Cell cell314 = row3.createCell(14);
        cell314.setCellValue("理实");
        cell314.setCellStyle(cellStyle0);

        Cell cell315 = row3.createCell(15);
        cell315.setCellValue("实践");
        cell315.setCellStyle(cellStyle0);

        Cell cell316 = row3.createCell(16);
        cell316.setCellValue("理论");
        cell316.setCellStyle(cellStyle0);

        Cell cell317 = row3.createCell(17);
        cell317.setCellValue("理实");
        cell317.setCellStyle(cellStyle0);

        Cell cell318 = row3.createCell(18);
        cell318.setCellValue("实践");
        cell318.setCellStyle(cellStyle0);

        Cell cell319 = row3.createCell(19);
        cell319.setCellValue("理论");
        cell319.setCellStyle(cellStyle0);

        Cell cell320 = row3.createCell(20);
        cell320.setCellValue("理实");
        cell320.setCellStyle(cellStyle0);

        Cell cell321 = row3.createCell(21);
        cell321.setCellValue("实践");
        cell321.setCellStyle(cellStyle0);

        Cell cell322 = row3.createCell(22);
        cell322.setCellValue("理论");
        cell322.setCellStyle(cellStyle0);

        Cell cell323 = row3.createCell(23);
        cell323.setCellValue("理实");
        cell323.setCellStyle(cellStyle0);

        Cell cell324 = row3.createCell(24);
        cell324.setCellValue("实践");
        cell324.setCellStyle(cellStyle0);
        List<CoursePlanExcel> coursePlanExcelList = coursePlanService.getCoursePlanExcelList(planName);
        int i = 4;
        int totalTotalHours = 0;// 合计总学时
        int totalTheoreticalHours = 0;// 合计理论学时
        int totalTheorypracticeHours = 0;// 合计理实学时
        int totalPracticeHours = 0;// 合计实践学时

        int totalS1theoretical = 0;// 合计第一学期理论学时
        int totalS1theorypractice = 0;// 合计第一学期理实学时
        int totalS1practice = 0;// 合计第一学期实践学时

        int totalS2theoretical = 0;// 合计第二学期理论学时
        int totalS2theorypractice = 0;// 合计第二学期理实学时
        int totalS2practice = 0;// 合计第二学期实践学时

        int totalS3theoretical = 0;// 合计第三学期理论学时
        int totalS3theorypractice = 0;// 合计第三学期理实学时
        int totalS3practice = 0;// 合计第三学期实践学时

        int totalS4theoretical = 0;// 合计第四学期理论学时
        int totalS4theorypractice = 0;// 合计第四学期理实学时
        int totalS4practice = 0;// 合计第四学期实践学时

        int totalS5theoretical = 0;// 合计第五学期理论学时
        int totalS5theorypractice = 0;// 合计第五学期理实学时
        int totalS5practice = 0;// 合计第五学期实践学时

        int totalS6theoretical = 0;// 合计第六学期理论学时
        int totalS6theorypractice = 0;// 合计第六学期理实学时
        int totalS6practice = 0;// 合计第六学期实践学时


        for (CoursePlanExcel coursePlanExcel : coursePlanExcelList) {
            Row row = sheet.createRow(i);

            Cell cells0 = row.createCell(0);
            cells0.setCellValue(coursePlanExcel.getCourseType());
            cells0.setCellStyle(cellStyle0);

            Cell cells1 = row.createCell(1);
            cells1.setCellValue(coursePlanExcel.getCourseCode());
            cells1.setCellStyle(cellStyle0);

            Cell cells2 = row.createCell(2);
            cells2.setCellValue(coursePlanExcel.getCourseName());
            cells2.setCellStyle(cellStyle0);

            Cell cells3 = row.createCell(3);
            cells3.setCellValue(coursePlanExcel.getTotalHours());
            cells3.setCellStyle(cellStyle0);

            Cell cells4 = row.createCell(4);
            cells4.setCellValue(coursePlanExcel.getTheoreticalHours());
            cells4.setCellStyle(cellStyle0);

            Cell cells5 = row.createCell(5);
            cells5.setCellValue(coursePlanExcel.getTheorypracticeHours());
            cells5.setCellStyle(cellStyle0);

            Cell cells6 = row.createCell(6);
            cells6.setCellValue(coursePlanExcel.getPracticeHours());
            cells6.setCellStyle(cellStyle0);

            Cell cells7 = row.createCell(7);
            cells7.setCellValue(coursePlanExcel.getS1theoretical());
            cells7.setCellStyle(cellStyle0);

            Cell cells8 = row.createCell(8);
            cells8.setCellValue(coursePlanExcel.getS1theorypractice());
            cells8.setCellStyle(cellStyle0);

            Cell cells9 = row.createCell(9);
            cells9.setCellValue(coursePlanExcel.getS1practice());
            cells9.setCellStyle(cellStyle0);


            Cell cells10 = row.createCell(10);
            cells10.setCellValue(coursePlanExcel.getS2theoretical());
            cells10.setCellStyle(cellStyle0);

            Cell cells11 = row.createCell(11);
            cells11.setCellValue(coursePlanExcel.getS2theorypractice());
            cells11.setCellStyle(cellStyle0);

            Cell cells12 = row.createCell(12);
            cells12.setCellValue(coursePlanExcel.getS2practice());
            cells12.setCellStyle(cellStyle0);

            Cell cells13 = row.createCell(13);
            cells13.setCellValue(coursePlanExcel.getS3theoretical());
            cells13.setCellStyle(cellStyle0);


            Cell cells14 = row.createCell(14);
            cells14.setCellValue(coursePlanExcel.getS3theorypractice());
            cells14.setCellStyle(cellStyle0);

            Cell cells15 = row.createCell(15);
            cells15.setCellValue(coursePlanExcel.getS3practice());
            cells15.setCellStyle(cellStyle0);

            Cell cells16 = row.createCell(16);
            cells16.setCellValue(coursePlanExcel.getS4theoretical());
            cells16.setCellStyle(cellStyle0);

            Cell cells17 = row.createCell(17);
            cells17.setCellValue(coursePlanExcel.getS4theorypractice());
            cells17.setCellStyle(cellStyle0);

            Cell cells18 = row.createCell(18);
            cells18.setCellValue(coursePlanExcel.getS4practice());
            cells18.setCellStyle(cellStyle0);

            Cell cells19 = row.createCell(19);
            cells19.setCellValue(coursePlanExcel.getS5theoretical());
            cells19.setCellStyle(cellStyle0);

            Cell cells20 = row.createCell(20);
            cells20.setCellValue(coursePlanExcel.getS5theorypractice());
            cells20.setCellStyle(cellStyle0);

            Cell cells21 = row.createCell(21);
            cells21.setCellValue(coursePlanExcel.getS5practice());
            cells21.setCellStyle(cellStyle0);

            Cell cells22 = row.createCell(22);
            cells22.setCellValue(coursePlanExcel.getS6theoretical());
            cells22.setCellStyle(cellStyle0);

            Cell cells23 = row.createCell(23);
            cells23.setCellValue(coursePlanExcel.getS6theorypractice());
            cells23.setCellStyle(cellStyle0);

            Cell cells24 = row.createCell(24);
            cells24.setCellValue(coursePlanExcel.getS6practice());
            cells24.setCellStyle(cellStyle0);

            Cell cells25 = row.createCell(25);
            cells25.setCellValue(coursePlanExcel.getPracticePlace());
            cells25.setCellStyle(cellStyle0);


            totalTotalHours = totalTotalHours + coursePlanExcel.getTotalHours();
            totalTheoreticalHours = totalTheoreticalHours + coursePlanExcel.getTheoreticalHours();
            totalTheorypracticeHours = totalTheorypracticeHours + coursePlanExcel.getTheorypracticeHours();
            totalPracticeHours = totalPracticeHours + coursePlanExcel.getPracticeHours();

            totalS1theoretical = totalS1theoretical + coursePlanExcel.getS1theoretical();
            totalS1theorypractice = totalS1theorypractice + coursePlanExcel.getS1theorypractice();
            totalS1practice = totalS1practice + coursePlanExcel.getS1practice();

            totalS2theoretical = totalS2theoretical + coursePlanExcel.getS2theoretical();
            totalS2theorypractice = totalS2theorypractice + coursePlanExcel.getS2theorypractice();
            totalS2practice = totalS2practice + coursePlanExcel.getS2practice();

            totalS3theoretical = totalS3theoretical + coursePlanExcel.getS3theoretical();
            totalS3theorypractice = totalS3theorypractice + coursePlanExcel.getS3theorypractice();
            totalS3practice = totalS3practice + coursePlanExcel.getS3practice();

            totalS4theoretical = totalS4theoretical + coursePlanExcel.getS4theoretical();
            totalS4theorypractice = totalS4theorypractice + coursePlanExcel.getS4theorypractice();
            totalS4practice = totalS4practice + coursePlanExcel.getS4practice();

            totalS5theoretical = totalS5theoretical + coursePlanExcel.getS5theoretical();
            totalS5theorypractice = totalS5theorypractice + coursePlanExcel.getS5theorypractice();
            totalS5practice = totalS5practice + coursePlanExcel.getS5practice();

            totalS6theoretical = totalS6theoretical + coursePlanExcel.getS6theoretical();
            totalS6theorypractice = totalS6theorypractice + coursePlanExcel.getS6theorypractice();
            totalS6practice = totalS6practice + coursePlanExcel.getS6practice();

            i = i + 1;
        }
        i = i - 1;

        sheet.addMergedRegion(new CellRangeAddress(i + 1, i + 1, 0, 2));//合计
        sheet.addMergedRegion(new CellRangeAddress(i + 2, i + 2, 0, 2));//学期周学时
        sheet.addMergedRegion(new CellRangeAddress(i + 3, i + 3, 0, 2));//学期总学时
        sheet.addMergedRegion(new CellRangeAddress(i + 4, i + 4, 0, 2));//学期学时占本学期总学期比例
        sheet.addMergedRegion(new CellRangeAddress(i + 5, i + 5, 0, 2));//总学时比例






        String[] courseTypeSplit = coursePlanExcelList.get(0).getCourseTypeSplit().split(",");
        int a = 4;
        if (Integer.parseInt(courseTypeSplit[0]) == 0){
             a = 4;
        }else if (Integer.parseInt(courseTypeSplit[0]) == 1){
             a = a + 1;

        }else {
             a = 4 + Integer.parseInt(courseTypeSplit[0])-1;
            sheet.addMergedRegion(new CellRangeAddress(4, a, 0, 0));//合并公共基础类型单元格

        }
        int b = a+1;
        if (Integer.parseInt(courseTypeSplit[1]) == 0){
            a = a;
        }else if (Integer.parseInt(courseTypeSplit[1]) == 1){
            a = a + 1;
        }else {
            a = a + Integer.parseInt(courseTypeSplit[1]);
            sheet.addMergedRegion(new CellRangeAddress(b, a, 0, 0));//合并公共基础类型单元格
        }
        int c = a+1;
        if (Integer.parseInt(courseTypeSplit[2]) == 0){
            a = a;
        }else if (Integer.parseInt(courseTypeSplit[2]) == 1){
            a = a + 1;
        }else {
            a = a + Integer.parseInt(courseTypeSplit[2]);
            sheet.addMergedRegion(new CellRangeAddress(c, a, 0, 0));//合并公共基础类型单元格
        }
        int d = a+1;
        if (Integer.parseInt(courseTypeSplit[3]) == 0){
            a = a;
        }else if (Integer.parseInt(courseTypeSplit[3]) == 1){
            a = a + 1;
        }else {
            a = a + Integer.parseInt(courseTypeSplit[3]);
            sheet.addMergedRegion(new CellRangeAddress(d, a, 0, 0));//合并公共基础类型单元格
        }
        int f = a+1;
        if (Integer.parseInt(courseTypeSplit[4]) == 0){
            a = a;
        }else if (Integer.parseInt(courseTypeSplit[4]) == 1){
            a = a + 1;
        }else {
            a = a + Integer.parseInt(courseTypeSplit[4]);
            sheet.addMergedRegion(new CellRangeAddress(f, a, 0, 0));//合并公共基础类型单元格
        }
        Row rowi1 = sheet.createRow(i + 1);
        Row rowi2 = sheet.createRow(i + 2);
        Row rowi3 = sheet.createRow(i + 3);
        Row rowi4 = sheet.createRow(i + 4);
        Row rowi5 = sheet.createRow(i + 5);

        Cell celli0 = rowi1.createCell(0);
        celli0.setCellValue("合计");
        celli0.setCellStyle(cellStyle0);

        Cell celli3 = rowi1.createCell(3);
        celli3.setCellValue(totalTotalHours);
        celli3.setCellStyle(cellStyle0);

        Cell celli4 = rowi1.createCell(4);
        celli4.setCellValue(totalTheoreticalHours);
        celli4.setCellStyle(cellStyle0);

        Cell celli5 = rowi1.createCell(5);
        celli5.setCellValue(totalTheorypracticeHours);
        celli5.setCellStyle(cellStyle0);

        Cell celli6 = rowi1.createCell(6);
        celli6.setCellValue(totalPracticeHours);
        celli6.setCellStyle(cellStyle0);

        Cell celli7 = rowi1.createCell(7);
        celli7.setCellValue(totalS1theoretical);
        celli7.setCellStyle(cellStyle0);

        Cell celli8 = rowi1.createCell(8);
        celli8.setCellValue(totalS1theorypractice);
        celli8.setCellStyle(cellStyle0);

        Cell celli9 = rowi1.createCell(9);
        celli9.setCellValue(totalS1practice);
        celli9.setCellStyle(cellStyle0);

        Cell celli10 = rowi1.createCell(10);
        celli10.setCellValue(totalS2theoretical);
        celli10.setCellStyle(cellStyle0);

        Cell celli11 = rowi1.createCell(11);
        celli11.setCellValue(totalS2theorypractice);
        celli11.setCellStyle(cellStyle0);

        Cell celli12 = rowi1.createCell(12);
        celli12.setCellValue(totalS2practice);
        celli12.setCellStyle(cellStyle0);

        Cell celli13 = rowi1.createCell(13);
        celli13.setCellValue(totalS3theoretical);
        celli13.setCellStyle(cellStyle0);

        Cell celli14 = rowi1.createCell(14);
        celli14.setCellValue(totalS3theorypractice);
        celli14.setCellStyle(cellStyle0);

        Cell celli15 = rowi1.createCell(15);
        celli15.setCellValue(totalS3practice);
        celli15.setCellStyle(cellStyle0);

        Cell celli16 = rowi1.createCell(16);
        celli16.setCellValue(totalS4theoretical);
        celli16.setCellStyle(cellStyle0);

        Cell celli17 = rowi1.createCell(17);
        celli17.setCellValue(totalS4theorypractice);
        celli17.setCellStyle(cellStyle0);

        Cell celli18 = rowi1.createCell(18);
        celli18.setCellValue(totalS4practice);
        celli18.setCellStyle(cellStyle0);

        Cell celli19 = rowi1.createCell(19);
        celli19.setCellValue(totalS5theoretical);
        celli19.setCellStyle(cellStyle0);

        Cell celli20 = rowi1.createCell(20);
        celli20.setCellValue(totalS5theorypractice);
        celli20.setCellStyle(cellStyle0);

        Cell celli21 = rowi1.createCell(21);
        celli21.setCellValue(totalS5practice);
        celli21.setCellStyle(cellStyle0);

        Cell celli22 = rowi1.createCell(22);
        celli22.setCellValue(totalS6theoretical);
        celli22.setCellStyle(cellStyle0);

        Cell celli23 = rowi1.createCell(23);
        celli23.setCellValue(totalS6theorypractice);
        celli23.setCellStyle(cellStyle0);

        Cell celli24 = rowi1.createCell(24);
        celli24.setCellValue(totalS6practice);
        celli24.setCellStyle(cellStyle0);


        Cell celli200 = rowi2.createCell(0);
        celli200.setCellValue("学期周学时");
        celli200.setCellStyle(cellStyle0);

        Cell celli30 = rowi3.createCell(0);
        celli30.setCellValue("学期总学时");
        celli30.setCellStyle(cellStyle0);

        Cell celli40 = rowi4.createCell(0);
        celli40.setCellValue("学期学时占本总学时比例");
        celli40.setCellStyle(cellStyle0);

        Cell celli50 = rowi5.createCell(0);
        celli50.setCellValue("总学时比例");
        celli50.setCellStyle(cellStyle0);

        i = i + 1;
        sheet.addMergedRegion(new CellRangeAddress(i + 1, i + 1, 7, 9));//学期周学时
        sheet.addMergedRegion(new CellRangeAddress(i + 1, i + 1, 10, 12));//学期周学时
        sheet.addMergedRegion(new CellRangeAddress(i + 1, i + 1, 13, 15));//学期周学时
        sheet.addMergedRegion(new CellRangeAddress(i + 1, i + 1, 16, 18));//学期周学时
        sheet.addMergedRegion(new CellRangeAddress(i + 1, i + 1, 19, 21));//学期周学时
        sheet.addMergedRegion(new CellRangeAddress(i + 1, i + 1, 22, 24));//学期周学时
        sheet.addMergedRegion(new CellRangeAddress(i + 2, i + 2, 7, 9));//学期总学时
        sheet.addMergedRegion(new CellRangeAddress(i + 2, i + 2, 10, 12));//学期总学时
        sheet.addMergedRegion(new CellRangeAddress(i + 2, i + 2, 13, 15));//学期总学时
        sheet.addMergedRegion(new CellRangeAddress(i + 2, i + 2, 16, 18));//学期总学时
        sheet.addMergedRegion(new CellRangeAddress(i + 2, i + 2, 19, 21));//学期总学时
        sheet.addMergedRegion(new CellRangeAddress(i + 2, i + 2, 22, 24));//学期总学时

        sheet.addMergedRegion(new CellRangeAddress(i + 4, i + 4, 3, 6));//学期总学时
        sheet.addMergedRegion(new CellRangeAddress(i + 4, i + 4, 7, 8));//学期总学时
        sheet.addMergedRegion(new CellRangeAddress(i + 4, i + 4, 9, 12));//学期总学时
        sheet.addMergedRegion(new CellRangeAddress(i + 4, i + 4, 13, 14));//学期总学时
        sheet.addMergedRegion(new CellRangeAddress(i + 4, i + 4, 15, 18));//学期总学时
        sheet.addMergedRegion(new CellRangeAddress(i + 4, i + 4, 19, 20));//学期总学时


        Cell cellc7 = rowi2.createCell(7);
        cellc7.setCellValue(30);
        cellc7.setCellStyle(cellStyle0);
        Cell cellc10 = rowi2.createCell(10);
        cellc10.setCellValue(26);
        cellc10.setCellStyle(cellStyle0);
        Cell cellc13 = rowi2.createCell(13);
        cellc13.setCellValue(26);
        cellc13.setCellStyle(cellStyle0);
        Cell cellc16 = rowi2.createCell(16);
        cellc16.setCellValue(26);
        cellc16.setCellStyle(cellStyle0);
        Cell cellc19 = rowi2.createCell(19);
        cellc19.setCellValue(24);
        cellc19.setCellStyle(cellStyle0);
        Cell cellc22 = rowi2.createCell(22);
        cellc22.setCellValue(0);
        cellc22.setCellStyle(cellStyle0);


        Cell celld7 = rowi3.createCell(7);
        celld7.setCellValue(totalS1practice+totalS1theoretical+totalS1theorypractice);
        celld7.setCellStyle(cellStyle0);
        Cell celld10 = rowi3.createCell(10);
        celld10.setCellValue(totalS2practice+totalS2theoretical+totalS2theorypractice);
        celld10.setCellStyle(cellStyle0);
        Cell celld13 = rowi3.createCell(13);
        celld13.setCellValue(totalS3practice+totalS3theoretical+totalS3theorypractice);
        celld13.setCellStyle(cellStyle0);
        Cell celld16 = rowi3.createCell(16);
        celld16.setCellValue(totalS4practice+totalS4theoretical+totalS4theorypractice);
        celld16.setCellStyle(cellStyle0);
        Cell celld19 = rowi3.createCell(19);
        celld19.setCellValue(totalS5practice+totalS5theoretical+totalS5theorypractice);
        celld19.setCellStyle(cellStyle0);
        Cell celld22 = rowi3.createCell(22);
        celld22.setCellValue(totalS6practice+totalS6theoretical+totalS6theorypractice);
        celld22.setCellStyle(cellStyle0);

        NumberFormat format = NumberFormat.getPercentInstance();
        format.setMaximumFractionDigits(2);//设置保留几位小数


        if(totalS1theoretical==0.0){
            Cell celle7 = rowi4.createCell(7);
            celle7.setCellValue("");
            celle7.setCellStyle(cellStyle0);
        }else {
            Cell celle7 = rowi4.createCell(7);
            celle7.setCellValue(format.format(totalS1theoretical/(totalS1practice+totalS1theoretical+totalS1theorypractice+0.00)));
            celle7.setCellStyle(cellStyle0);
        }
        if(totalS1theorypractice==0.0) {
            Cell celle8 = rowi4.createCell(8);
            celle8.setCellValue("");
            celle8.setCellStyle(cellStyle0);
        }else {
            Cell celle8 = rowi4.createCell(8);
            celle8.setCellValue(format.format(totalS1theorypractice / (totalS1practice + totalS1theoretical + totalS1theorypractice + 0.00)));
            celle8.setCellStyle(cellStyle0);

        }
        if(totalS1practice==0.0) {
            Cell celle9 = rowi4.createCell(9);
            celle9.setCellValue("");
            celle9.setCellStyle(cellStyle0);
        }else {
            Cell celle9 = rowi4.createCell(9);
            celle9.setCellValue(format.format(totalS1practice / (totalS1practice + totalS1theoretical + totalS1theorypractice + 0.00)));
            celle9.setCellStyle(cellStyle0);
        }
        if(totalS2theoretical==0.0) {
            Cell celle10 = rowi4.createCell(10);
            celle10.setCellValue("");
            celle10.setCellStyle(cellStyle0);
        }else {
            Cell celle10 = rowi4.createCell(10);
            celle10.setCellValue(format.format(totalS2theoretical / (totalS2practice + totalS2theoretical + totalS2theorypractice + 0.00)));
            celle10.setCellStyle(cellStyle0);
        }
        if(totalS2theorypractice==0.0) {
            Cell celle11 = rowi4.createCell(11);
            celle11.setCellValue("");
            celle11.setCellStyle(cellStyle0);
        }else {
            Cell celle11 = rowi4.createCell(11);
            celle11.setCellValue(format.format(totalS2theorypractice / (totalS2practice + totalS2theoretical + totalS2theorypractice + 0.00)));
            celle11.setCellStyle(cellStyle0);
        }
        if(totalS2practice==0.0) {
            Cell celle12 = rowi4.createCell(12);
            celle12.setCellValue("");
            celle12.setCellStyle(cellStyle0);
        }else {
            Cell celle12 = rowi4.createCell(12);
            celle12.setCellValue(format.format(totalS2practice / (totalS2practice + totalS2theoretical + totalS2theorypractice + 0.00)));
            celle12.setCellStyle(cellStyle0);
        }
        if(totalS3theoretical==0.0) {
            Cell celle13 = rowi4.createCell(13);
            celle13.setCellValue("");
            celle13.setCellStyle(cellStyle0);
        }else {
            Cell celle13 = rowi4.createCell(13);
            celle13.setCellValue(format.format(totalS3theoretical / (totalS3practice + totalS3theoretical + totalS3theorypractice + 0.00)));
            celle13.setCellStyle(cellStyle0);
        }if(totalS3theorypractice==0.0) {
            Cell celle14 = rowi4.createCell(14);
            celle14.setCellValue("");
            celle14.setCellStyle(cellStyle0);
        }else {
            Cell celle14 = rowi4.createCell(14);
            celle14.setCellValue(format.format(totalS3theorypractice / (totalS3practice + totalS3theoretical + totalS3theorypractice + 0.00)));
            celle14.setCellStyle(cellStyle0);
        }if(totalS3practice==0.0) {
            Cell celle15 = rowi4.createCell(15);
            celle15.setCellValue("");
            celle15.setCellStyle(cellStyle0);
        }else {
            Cell celle15 = rowi4.createCell(15);
            celle15.setCellValue(format.format(totalS3practice / (totalS3practice + totalS3theoretical + totalS3theorypractice + 0.00)));
            celle15.setCellStyle(cellStyle0);
        }if(totalS4theoretical==0.0) {
            Cell celle16 = rowi4.createCell(16);
            celle16.setCellValue("");
            celle16.setCellStyle(cellStyle0);
        }else {
            Cell celle16 = rowi4.createCell(16);
            celle16.setCellValue(format.format(totalS4theoretical / (totalS4practice + totalS4theoretical + totalS4theorypractice + 0.00)));
            celle16.setCellStyle(cellStyle0);
        }if(totalS4theorypractice==0.0) {
            Cell celle17 = rowi4.createCell(17);
            celle17.setCellValue("");
            celle17.setCellStyle(cellStyle0);
        }else {
            Cell celle17 = rowi4.createCell(17);
            celle17.setCellValue(format.format(totalS4theorypractice / (totalS4practice + totalS4theoretical + totalS4theorypractice + 0.00)));
            celle17.setCellStyle(cellStyle0);
        }if(totalS4practice==0.0) {
            Cell celle18 = rowi4.createCell(18);
            celle18.setCellValue("");
            celle18.setCellStyle(cellStyle0);
        }else {
            Cell celle18 = rowi4.createCell(18);
            celle18.setCellValue(format.format(totalS4practice / (totalS4practice + totalS1theoretical + totalS1theorypractice + 0.00)));
            celle18.setCellStyle(cellStyle0);
        }if(totalS5theoretical==0.0) {
            Cell celle19 = rowi4.createCell(19);
            celle19.setCellValue("");
            celle19.setCellStyle(cellStyle0);
        }else {
            Cell celle19 = rowi4.createCell(19);
            celle19.setCellValue(format.format(totalS5theoretical / (totalS5practice + totalS5theoretical + totalS5theorypractice + 0.00)));
            celle19.setCellStyle(cellStyle0);
        }if(totalS5theorypractice==0.0) {
            Cell celle20 = rowi4.createCell(20);
            celle20.setCellValue("");
            celle20.setCellStyle(cellStyle0);
        }else {
            Cell celle20 = rowi4.createCell(20);
            celle20.setCellValue(format.format(totalS5theorypractice / (totalS5practice + totalS5theoretical + totalS5theorypractice + 0.00)));
            celle20.setCellStyle(cellStyle0);
        }if(totalS5practice==0.0) {
            Cell celle21 = rowi4.createCell(21);
            celle21.setCellValue("");
            celle21.setCellStyle(cellStyle0);
        }else {
            Cell celle21 = rowi4.createCell(21);
            celle21.setCellValue(format.format(totalS5practice / (totalS5practice + totalS5theoretical + totalS5theorypractice + 0.00)));
            celle21.setCellStyle(cellStyle0);
        }if(totalS6theoretical==0.0) {
            Cell celle22 = rowi4.createCell(22);
            celle22.setCellValue("");
            celle22.setCellStyle(cellStyle0);
        }else {
            Cell celle22 = rowi4.createCell(22);
            celle22.setCellValue(format.format(totalS6theoretical / (totalS6practice + totalS6theoretical + totalS6theorypractice + 0.00)));
            celle22.setCellStyle(cellStyle0);
        }if(totalS6theorypractice==0.0) {
            Cell celle23 = rowi4.createCell(23);
            celle23.setCellValue("");
            celle23.setCellStyle(cellStyle0);
        }else {
            Cell celle23 = rowi4.createCell(23);
            celle23.setCellValue(format.format(totalS6theorypractice / (totalS6practice + totalS6theoretical + totalS6theorypractice + 0.00)));
            celle23.setCellStyle(cellStyle0);
        }if(totalS6practice==0.0) {
            Cell celle24 = rowi4.createCell(24);
            celle24.setCellValue("");
            celle24.setCellStyle(cellStyle0);
        }else {
            Cell celle24 = rowi4.createCell(24);
            celle24.setCellValue(format.format(totalS6practice / (totalS6practice + totalS6theoretical + totalS6theorypractice + 0.00)));
            celle24.setCellStyle(cellStyle0);
        }

        Cell cellf3 = rowi5.createCell(3);
        cellf3.setCellValue("理论占总学时比例");
        cellf3.setCellStyle(cellStyle0);
            Cell cellf7 = rowi5.createCell(7);
            if(0==totalTheoreticalHours){
                if(0==totalTotalHours){
                    cellf7.setCellValue("");
                    cellf7.setCellStyle(cellStyle0);
                }else{
                    cellf7.setCellValue(format.format((totalTheoreticalHours) / (totalTotalHours+ 0.00)));
                    cellf7.setCellStyle(cellStyle0);
                }
            }else{
                cellf7.setCellValue(format.format((totalTheoreticalHours) / (totalTotalHours+ 0.00)));
                cellf7.setCellStyle(cellStyle0);
            }
        Cell cellf9 = rowi5.createCell(9);
        cellf9.setCellValue("理实占总学时比例");
        cellf9.setCellStyle(cellStyle0);
        if(totalTotalHours==0){
            Cell cellf13 = rowi5.createCell(13);
            cellf13.setCellValue("");
            cellf13.setCellStyle(cellStyle0);
        }else {
            Cell cellf13 = rowi5.createCell(13);
            cellf13.setCellValue(format.format((totalTheorypracticeHours) / (totalTotalHours + 0.00)));
            cellf13.setCellStyle(cellStyle0);
        }

        Cell cellf15 = rowi5.createCell(15);
        cellf15.setCellValue("实践占总学时比例");
        cellf15.setCellStyle(cellStyle0);
        if(totalTotalHours==0) {
            Cell cellf18 = rowi5.createCell(19);
            cellf18.setCellValue("");
            cellf18.setCellStyle(cellStyle0);
        }else {
            Cell cellf18 = rowi5.createCell(19);
            cellf18.setCellValue(format.format((totalPracticeHours) / (totalTotalHours + 0.00)));
            cellf18.setCellStyle(cellStyle0);
        }
        try {
            PoiUtils.setBorder(workbook, sheet, 0, 12, 26, (short) 0, null);
        } catch (Exception e) {
            e.printStackTrace();
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    (planName + "课时分配表.xls", "utf-8"));
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
