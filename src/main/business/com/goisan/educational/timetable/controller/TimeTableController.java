package com.goisan.educational.timetable.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.course.service.CourseService;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.teachingtask.service.TeachingTaskService;
import com.goisan.educational.timetable.bean.*;
import com.goisan.educational.timetable.service.TimeTableCourseService;
import com.goisan.educational.timetable.service.TimeTableDepartmentService;
import com.goisan.educational.timetable.service.TimeTableService;
import com.goisan.educational.timetable.service.TimeTableSpecialPlaceService;
import com.goisan.educational.timetable.util.TimeTableExcelUtils;
import com.goisan.educational.timetable.util.TimeTableSpecialPlaceConstants;
import com.goisan.system.bean.CommonBean;
import com.goisan.system.bean.Emp;
import com.goisan.system.bean.Select2;
import com.goisan.system.service.DeptService;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.Case;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;


@RestController
@RequestMapping("/timeTable")
public class TimeTableController {

    @Autowired
    private TimeTableService timeTableService;
    @Autowired
    TimeTableSpecialPlaceService timeTableSpecialPlaceService;
    @Autowired
    TimeTableCourseService timeTableCourseService;
    @Autowired
    DeptService deptService;

    @Autowired
    CourseService courseService;

    @Autowired
    EmpService empService;

    @RequestMapping("/toTimeTable")
    public ModelAndView toTimeTable() {
        ModelAndView mv = new ModelAndView();
        Set<String> roles = CommonUtil.getLoginUser().getRoles();
        if (roles.contains("ec10678d-96ef-4883-9342-9fdb58473824")) {
            mv.addObject("isDean", 1);
        } else {
            mv.addObject("isDean", 0);
        }
        mv.setViewName("business/educational/timetable/timeTableList");
        return mv;

    }


    @RequestMapping("getTimetableList")
    public Map<String, Object> getTimetableList(TimeTable timeTable, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> timeTables = new HashMap();
        Set<String> roles = CommonUtil.getLoginUser().getRoles();
        if (roles.contains("ec10678d-96ef-4883-9342-9fdb58473824")) {
            timeTable.setCreateDept("1");
        } else {
            timeTable.setCreateDept("0");
        }
        timeTable.setCreator(CommonUtil.getPersonId());
        List<TimeTable> list = timeTableService.getTimeTableList(timeTable);
        PageInfo<List<TimeTable>> info = new PageInfo(list);
        timeTables.put("draw", draw);
        timeTables.put("recordsTotal", info.getTotal());
        timeTables.put("recordsFiltered", info.getTotal());
        timeTables.put("data", list);
        return timeTables;

    }

    @RequestMapping("/toTimetableAdd")
    public ModelAndView toTimetableAdd(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/educational/timetable/timeTableEdit");
        if (id != null && !"".equals(id)) {
            TimeTable timeTable = timeTableService.getTimeTableById(id);
            mv.addObject("data", timeTable);
            mv.addObject("head", "修改课程表");
        } else {
            mv.addObject("head", "新增课程表");
        }
        return mv;
    }


    @RequestMapping("deleteTimeTable")
    public Message deleteTimeTable(String id) {
        timeTableService.deleteTimeTable(id);
        return new Message(1, "删除成功！", null);
    }


    @RequestMapping("saveTimetable")
    public Message saveTimetable(TimeTable timeTable) {
        //判断是否重复课程表名
        if (this.timeTableService.getTimeTableByName(timeTable.getTimeTableName(),timeTable.getId()).size() != 0)
            return new Message(0, "已有该课程表！", "warning");
        if (timeTable.getId() != null && !"".equals(timeTable.getId())) {
            timeTableService.updateTimeTable(timeTable);
            return new Message(1, "修改成功！", "success");
        } else {
            timeTable.setId(CommonUtil.getUUID());
            timeTable.setCreateDept(CommonUtil.getDefaultDept());
            timeTableService.saveTimeTable(timeTable);
            return new Message(1, "新增成功！", "success");
        }
    }


    @RequestMapping("/toExportTimeTable")
    public void toExportTimeTable(String id, HttpServletResponse response) {

        TimeTableExcel timeTableExcel = null;
        //查询课程表数据
        List<TimeTableExcel> list = timeTableService.getTimeTableExcelList(id);
        if (list.size() == 0) {
            timeTableExcel = new TimeTableExcel();
        } else {
            //取第一条课程表数据信息
            timeTableExcel = list.get(0);
        }
        String timeTableName = timeTableExcel.getTimeTableName();// 课程表名称
        String[] executionDateSplit = null;
        if (timeTableExcel.getExecutionDate() == null) {
            executionDateSplit = null;
        } else {
            executionDateSplit = timeTableExcel.getExecutionDate().split("-");// 执行日期
        }

        SXSSFWorkbook xssfWorkbook = new SXSSFWorkbook();
        xssfWorkbook.setCompressTempFiles(true);
        //创建样式 居中 自动换行
        CellStyle cellStyle0 = xssfWorkbook.createCellStyle();
        cellStyle0.setAlignment(HorizontalAlignment.CENTER);
        cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle0.setWrapText(true);

        //课表大标题样式
        CellStyle cellStyle1 = xssfWorkbook.createCellStyle();
        cellStyle1.setAlignment(HorizontalAlignment.CENTER);
        cellStyle1.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle1.setWrapText(true);
        Font font1 = xssfWorkbook.createFont();
        font1.setFontHeightInPoints((short) 19);
        cellStyle1.setFont(font1);

        //2018年9月3日起执行 样式
        CellStyle cellStyle2 = xssfWorkbook.createCellStyle();
        cellStyle2.setAlignment(HorizontalAlignment.RIGHT);
        cellStyle2.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle2.setWrapText(true);

        //创建 sheet 页
        SXSSFSheet sheet1 = xssfWorkbook.createSheet("Sheet1");
        sheet1.setRandomAccessWindowSize(100);

        SXSSFRow row0 = sheet1.createRow(0);
        SXSSFRow row1 = sheet1.createRow(1);
        SXSSFRow row2 = sheet1.createRow(2);
        SXSSFRow row3 = sheet1.createRow(3);
        SXSSFRow row4 = sheet1.createRow(4);
        SXSSFRow row5 = sheet1.createRow(5);
        SXSSFRow row6 = sheet1.createRow(6);
        //数据开始行
        SXSSFRow row7 = sheet1.createRow(7);
        SXSSFRow row8 = sheet1.createRow(8);
        SXSSFRow row9 = sheet1.createRow(9);
        SXSSFRow row10 = sheet1.createRow(10);
        SXSSFRow row11 = sheet1.createRow(11);
        SXSSFRow row12 = sheet1.createRow(12);
        SXSSFRow row13 = sheet1.createRow(13);
        SXSSFRow row14 = sheet1.createRow(14);
        SXSSFRow row15 = sheet1.createRow(15);
        SXSSFRow row16 = sheet1.createRow(16);
        SXSSFRow row17 = sheet1.createRow(17);
        SXSSFRow row18 = sheet1.createRow(18);
        SXSSFRow row19 = sheet1.createRow(19);
        SXSSFRow row20 = sheet1.createRow(20);
        SXSSFRow row21 = sheet1.createRow(21);
        SXSSFRow row22 = sheet1.createRow(22);
        SXSSFRow row23 = sheet1.createRow(23);
        SXSSFRow row24 = sheet1.createRow(24);
        SXSSFRow row25 = sheet1.createRow(25);
        SXSSFRow row26 = sheet1.createRow(26);
        SXSSFRow row27 = sheet1.createRow(27);

        //设置行高
        row0.setHeightInPoints(80);
        row1.setHeightInPoints(40);

        row2.setHeightInPoints(30);
        row3.setHeightInPoints(30);
        row4.setHeightInPoints(40);
        row5.setHeightInPoints(30);
        row6.setHeightInPoints(30);

        //数据开始
        row7.setHeightInPoints(28);
        row8.setHeightInPoints(28);
        row9.setHeightInPoints(28);
        row10.setHeightInPoints(28);
        row11.setHeightInPoints(28);
        row12.setHeightInPoints(28);
        row13.setHeightInPoints(28);
        row14.setHeightInPoints(28);
        row15.setHeightInPoints(28);
        row16.setHeightInPoints(28);
        row17.setHeightInPoints(28);
        row18.setHeightInPoints(28);
        row19.setHeightInPoints(28);
        row20.setHeightInPoints(28);
        row21.setHeightInPoints(28);
        row22.setHeightInPoints(28);
        row23.setHeightInPoints(28);
        row24.setHeightInPoints(28);
        row25.setHeightInPoints(28);
        row26.setHeightInPoints(28);
        row27.setHeightInPoints(28);

        //设置列宽
        sheet1.setColumnWidth(0, 4 * 256);
        sheet1.setColumnWidth(1, 4 * 256);

        //数据开始 统一设置宽度
        for (int i = 2; i < 40; i++) {
            sheet1.setColumnWidth(i, 8 * 256);
        }

        //设置合并单元格

        sheet1.addMergedRegion(new CellRangeAddress(2, 6, 0, 1));//专业班 内容 时间

        sheet1.addMergedRegion(new CellRangeAddress(7, 10, 0, 0));//周一
        sheet1.addMergedRegion(new CellRangeAddress(11, 14, 0, 0));//周二
        sheet1.addMergedRegion(new CellRangeAddress(15, 18, 0, 0));//周三
        sheet1.addMergedRegion(new CellRangeAddress(19, 22, 0, 0));//周四
        sheet1.addMergedRegion(new CellRangeAddress(23, 26, 0, 0));//周五


        XSSFDrawing drawingPatriarch = (XSSFDrawing) sheet1.createDrawingPatriarch();//创建画图对象
        // 创建锚点
        //第一个锚点 用于绘制第一条斜线
        XSSFClientAnchor a1 = new XSSFClientAnchor(250000, 0, 0, 0, 0, 2, 2, 7);
        //第二个锚点 用于绘制第二条斜线
        XSSFClientAnchor a2 = new XSSFClientAnchor(0, 150000, 0, 0, 0, 4, 2, 7);
        //第三个锚点 用于绘制文本框  "专业班"
        XSSFClientAnchor a3 = new XSSFClientAnchor(30000, 50000, 555000, 1055000, 1, 2, 1, 3);
        //第四个锚点 用于绘制文本框  "内容"
        XSSFClientAnchor a4 = new XSSFClientAnchor(20000, 100000, 555000, 1055000, 0, 3, 0, 4);
        //第五个锚点 用于绘制文本框  "时间"
        XSSFClientAnchor a5 = new XSSFClientAnchor(20000, 50000, 555000, 1055000, 0, 5, 0, 6);
        //第一条线
        XSSFSimpleShape line1 = drawingPatriarch.createSimpleShape(a1);
        line1.setShapeType(ShapeTypes.LINE);//设置形状 为一条实线
        line1.setLineStyleColor(0, 0, 0);//设置线的样式为一条直线
        line1.setLineWidth(1);//设置线的宽度
        //第二条线 同第一条线
        XSSFSimpleShape line2 = drawingPatriarch.createSimpleShape(a2);
        line2.setShapeType(ShapeTypes.LINE);
        line2.setLineStyleColor(0, 0, 0);
        line2.setLineWidth(1);
        //文本框  "专业班"
        XSSFTextBox textbox1 = drawingPatriarch.createTextbox(a3);
        textbox1.setText("专业班");
        //文本框  "内容"
        XSSFTextBox textbox2 = drawingPatriarch.createTextbox(a4);
        textbox2.setText("内容");
        //文本框  "时间"
        XSSFTextBox textbox3 = drawingPatriarch.createTextbox(a5);
        textbox3.setText("时间");

        //课表大标题
        Cell cell_0_0 = row0.createCell(0);
        String xxmc= CommonBean.getParamValue("SZXXMC");
        cell_0_0.setCellValue(xxmc + timeTableName + " 课程表 ");
        cell_0_0.setCellStyle(cellStyle1);

        Cell cell_1_0 = row1.createCell(0);
        if (executionDateSplit == null) {
            cell_1_0.setCellValue("");
        } else {
            cell_1_0.setCellValue(executionDateSplit[0] + "年" + executionDateSplit[1] + "月" + executionDateSplit[2] + "日起执行");
        }
        cell_1_0.setCellStyle(cellStyle2);


        Cell cell_7_0 = row7.createCell(0);
        cell_7_0.setCellValue("周一");
        cell_7_0.setCellStyle(cellStyle0);

        Cell cell_11_0 = row11.createCell(0);
        cell_11_0.setCellValue("周二");
        cell_11_0.setCellStyle(cellStyle0);

        Cell cell_15_0 = row15.createCell(0);
        cell_15_0.setCellValue("周三");
        cell_15_0.setCellStyle(cellStyle0);

        Cell cell_19_0 = row19.createCell(0);
        cell_19_0.setCellValue("周四");
        cell_19_0.setCellStyle(cellStyle0);

        Cell cell_23_0 = row23.createCell(0);
        cell_23_0.setCellValue("周五");
        cell_23_0.setCellStyle(cellStyle0);


        Cell cell_7_1 = row7.createCell(1);
        cell_7_1.setCellValue("1.2");
        cell_7_1.setCellStyle(cellStyle0);
        Cell cell_8_1 = row8.createCell(1);
        cell_8_1.setCellValue("3.4");
        cell_8_1.setCellStyle(cellStyle0);
        Cell cell_9_1 = row9.createCell(1);
        cell_9_1.setCellValue("5.6");
        cell_9_1.setCellStyle(cellStyle0);
        Cell cell_10_1 = row10.createCell(1);
        cell_10_1.setCellValue("7.8");
        cell_10_1.setCellStyle(cellStyle0);


        Cell cell_11_1 = row11.createCell(1);
        cell_11_1.setCellValue("1.2");
        cell_11_1.setCellStyle(cellStyle0);
        Cell cell_12_1 = row12.createCell(1);
        cell_12_1.setCellValue("3.4");
        cell_12_1.setCellStyle(cellStyle0);
        Cell cell_13_1 = row13.createCell(1);
        cell_13_1.setCellValue("5.6");
        cell_13_1.setCellStyle(cellStyle0);
        Cell cell_14_1 = row14.createCell(1);
        cell_14_1.setCellValue("7.8");
        cell_14_1.setCellStyle(cellStyle0);


        Cell cell_15_1 = row15.createCell(1);
        cell_15_1.setCellValue("1.2");
        cell_15_1.setCellStyle(cellStyle0);
        Cell cell_16_1 = row16.createCell(1);
        cell_16_1.setCellValue("3.4");
        cell_16_1.setCellStyle(cellStyle0);
        Cell cell_17_1 = row17.createCell(1);
        cell_17_1.setCellValue("5.6");
        cell_17_1.setCellStyle(cellStyle0);
        Cell cell_18_1 = row18.createCell(1);
        cell_18_1.setCellValue("7.8");
        cell_18_1.setCellStyle(cellStyle0);


        Cell cell_19_1 = row19.createCell(1);
        cell_19_1.setCellValue("1.2");
        cell_19_1.setCellStyle(cellStyle0);
        Cell cell_20_1 = row20.createCell(1);
        cell_20_1.setCellValue("3.4");
        cell_20_1.setCellStyle(cellStyle0);
        Cell cell_21_1 = row21.createCell(1);
        cell_21_1.setCellValue("5.6");
        cell_21_1.setCellStyle(cellStyle0);
        Cell cell_22_1 = row22.createCell(1);
        cell_22_1.setCellValue("7.8");
        cell_22_1.setCellStyle(cellStyle0);


        Cell cell_23_1 = row23.createCell(1);
        cell_23_1.setCellValue("1.2");
        cell_23_1.setCellStyle(cellStyle0);
        Cell cell_24_1 = row24.createCell(1);
        cell_24_1.setCellValue("3.4");
        cell_24_1.setCellStyle(cellStyle0);
        Cell cell_25_1 = row25.createCell(1);
        cell_25_1.setCellValue("5.6");
        cell_25_1.setCellStyle(cellStyle0);
        Cell cell_26_1 = row26.createCell(1);
        cell_26_1.setCellValue("7.8");
        cell_26_1.setCellStyle(cellStyle0);


        int i = 2;
        String oldFlag = null;
        if (list.size() == 0) {
            oldFlag = null;
        } else {
            oldFlag = list.get(0).getClassId() + list.get(0).getPeopleNumber() + list.get(0).getPeopleNumber();
        }
        for (TimeTableExcel tableExcel : list) {

            String newFlag = tableExcel.getClassId() + tableExcel.getPeopleNumber() + tableExcel.getPeopleNumber();

            if (!oldFlag.equals(newFlag)) {
                i = i + 1;
                oldFlag = tableExcel.getClassId() + tableExcel.getPeopleNumber() + tableExcel.getPeopleNumber();
            }

            //设置班级
            Cell row4Cell = row4.createCell(i);
            row4Cell.setCellValue(tableExcel.getClassId());
            row4Cell.setCellStyle(cellStyle0);
            // 设置人数
            Cell row5Cell = row5.createCell(i);
            row5Cell.setCellValue(tableExcel.getPeopleNumber());
            row5Cell.setCellStyle(cellStyle0);
            //设置班级
            Cell row6Cell = row6.createCell(i);
            row6Cell.setCellValue(tableExcel.getClassRom());
            row6Cell.setCellStyle(cellStyle0);

            String weekCourseFlag = tableExcel.getWeeks() + tableExcel.getCourseNum();
            String lineFlag = tableExcel.getSpecialFlag();
            switch (weekCourseFlag) {
                case "周一1.2":
                    Cell row7Cell = row7.createCell(i);
                    row7Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row7Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 7, i, lineFlag);
                    break;
                case "周一3.4":
                    Cell row8Cell = row8.createCell(i);
                    row8Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row8Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 8, i, lineFlag);
                    break;
                case "周一5.6":
                    Cell row9Cell = row9.createCell(i);
                    row9Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row9Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 9, i, lineFlag);
                    break;
                case "周一7.8":
                    Cell row10Cell = row10.createCell(i);
                    row10Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row10Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 10, i, lineFlag);
                    break;
                case "周二1.2":
                    Cell row11Cell = row11.createCell(i);
                    row11Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row11Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 11, i, lineFlag);
                    break;
                case "周二3.4":
                    Cell row12Cell = row12.createCell(i);
                    row12Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row12Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 12, i, lineFlag);
                    break;
                case "周二5.6":
                    Cell row13Cell = row13.createCell(i);
                    row13Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row13Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 13, i, lineFlag);
                    break;
                case "周二7.8":
                    Cell row14Cell = row14.createCell(i);
                    row14Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row14Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 14, i, lineFlag);
                    break;
                case "周三1.2":
                    Cell row15Cell = row15.createCell(i);
                    row15Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row15Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 15, i, lineFlag);
                    break;
                case "周三3.4":
                    Cell row16Cell = row16.createCell(i);
                    row16Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row16Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 16, i, lineFlag);
                    break;
                case "周三5.6":
                    Cell row17Cell = row17.createCell(i);
                    row17Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row17Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 17, i, lineFlag);
                    break;
                case "周三7.8":
                    Cell row18Cell = row18.createCell(i);
                    row18Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row18Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 18, i, lineFlag);
                    break;
                case "周四1.2":
                    Cell row19Cell = row19.createCell(i);
                    row19Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row19Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 19, i, lineFlag);
                    break;
                case "周四3.4":
                    Cell row20Cell = row20.createCell(i);
                    row20Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row20Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 20, i, lineFlag);
                    break;
                case "周四5.6":
                    Cell row21Cell = row21.createCell(i);
                    row21Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row21Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 21, i, lineFlag);
                    break;
                case "周四7.8":
                    Cell row22Cell = row22.createCell(i);
                    row22Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row22Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 22, i, lineFlag);
                    break;
                case "周五1.2":
                    Cell row23Cell = row23.createCell(i);
                    row23Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row23Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 23, i, lineFlag);
                    break;
                case "周五3.4":
                    Cell row24Cell = row24.createCell(i);
                    row24Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row24Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 24, i, lineFlag);
                    break;
                case "周五5.6":
                    Cell row25Cell = row25.createCell(i);
                    row25Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row25Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 25, i, lineFlag);
                    break;
                case "周五7.8":
                    Cell row26Cell = row26.createCell(i);
                    row26Cell.setCellValue(tableExcel.getCourseName() + "\n" + tableExcel.getCourseTeacher());
                    row26Cell.setCellStyle(cellStyle0);
                    drawline(drawingPatriarch, 26, i, lineFlag);
                    break;

                default:
                    break;
            }

        }
        sheet1.addMergedRegion(new CellRangeAddress(0, 0, 0, i));//课表大标题
        sheet1.addMergedRegion(new CellRangeAddress(1, 1, 0, i));//2018年9月3日起执行
        if (i > 2) {
            sheet1.addMergedRegion(new CellRangeAddress(2, 2, 2, i));//系部
            sheet1.addMergedRegion(new CellRangeAddress(3, 3, 2, i));//专业
        }

        sheet1.addMergedRegion(new CellRangeAddress(27, 27, 0, i));// 特殊标识 说明
        List<TimeTableSpecialPlace> timeTableSpecialPlaceList = timeTableSpecialPlaceService.getTimeTableSpecialPlaceList(new TimeTableSpecialPlace());
        StringBuilder explain = new StringBuilder("说明 : ");
        for (TimeTableSpecialPlace tableSpecialPlace : timeTableSpecialPlaceList) {
            explain.append(tableSpecialPlace.getSpecialFlag()).append(" : ").append(tableSpecialPlace.getSpecialPlace()).append("  ,");
        }
        Cell row27Cell = row27.createCell(0);
        row27Cell.setCellValue(explain.toString());

        Cell cell_2_0 = row2.createCell(2);
        cell_2_0.setCellValue(timeTableExcel.getDepartmentId());
        cell_2_0.setCellStyle(cellStyle0);

        Cell cell_3_0 = row3.createCell(2);
        cell_3_0.setCellValue(timeTableExcel.getMajorId());
        cell_3_0.setCellStyle(cellStyle0);
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    (timeTableExcel.getTimeTableName() + "课时分配表.xlsx", "utf-8"));
            os = response.getOutputStream();
            xssfWorkbook.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                }
                xssfWorkbook.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }

    private void drawline(XSSFDrawing drawingPatriarch, int row, int col, String lineFlag) {
        if ("虚线顶部".equals(lineFlag)) {
            TimeTableExcelUtils.drawingLine(TimeTableSpecialPlaceConstants.DOTTED_LINE_TOP, row, col, drawingPatriarch);
        } else if ("虚线底部".equals(lineFlag)) {
            TimeTableExcelUtils.drawingLine(TimeTableSpecialPlaceConstants.DOTTED_LINE_BOTTOM, row, col, drawingPatriarch);
        } else if ("虚线左部".equals(lineFlag)) {
            TimeTableExcelUtils.drawingLine(TimeTableSpecialPlaceConstants.DOTTED_LINE_LEFT, row, col, drawingPatriarch);
        } else if ("虚线右部".equals(lineFlag)) {
            TimeTableExcelUtils.drawingLine(TimeTableSpecialPlaceConstants.DOTTED_LINE_RIGHT, row, col, drawingPatriarch);
        } else if ("实线顶部".equals(lineFlag)) {
            TimeTableExcelUtils.drawingLine(TimeTableSpecialPlaceConstants.SOLID_LINE_TOP, row, col, drawingPatriarch);
        } else if ("实线底部".equals(lineFlag)) {
            TimeTableExcelUtils.drawingLine(TimeTableSpecialPlaceConstants.SOLID_LINE_BOTTOM, row, col, drawingPatriarch);
        } else if ("实线左部".equals(lineFlag)) {
            TimeTableExcelUtils.drawingLine(TimeTableSpecialPlaceConstants.SOLID_LINE_LEFT, row, col, drawingPatriarch);
        } else if ("实线右部".equals(lineFlag)) {
            TimeTableExcelUtils.drawingLine(TimeTableSpecialPlaceConstants.SOLID_LINE_RIGHT, row, col, drawingPatriarch);
        }
    }


    @RequestMapping("/timeTableImport")
    public ModelAndView timeTableImport(String timeTableId) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("timeTableId", timeTableId);

        mv.setViewName("business/educational/timetable/timeTableImport");
        return mv;
    }

    @RequestMapping("/exportTimeTableTemplate")
    public void exportTimeTableTemplate(HttpServletResponse response) {
        String rootPath = new File(getClass().getResource("/").getPath()).getParentFile().getParent().toString();
        rootPath = rootPath.replaceAll("%20", " ");
        String fileName = rootPath + "/template/timeTableTemplate.xlsx";
        File file = FileUtils.getFile(fileName);
        OutputStream os = null;
        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("课程表模板.xlsx", "utf-8"));
            os = response.getOutputStream();
            os.write(FileUtils.readFileToByteArray(file));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @Resource
    private TeachingTaskService teachingTaskService;

    //导入
    @ResponseBody
    @RequestMapping("/importTimeTableExcel")
    public Message importTimeTableExcel(@RequestParam(value = "file", required = false) CommonsMultipartFile file, String timeTableDepartmentId) {

        TimeTableCourse query = new TimeTableCourse();
        query.setTimeTableDepartmentId(timeTableDepartmentId);

        int count = 0;
        try {
            XSSFWorkbook workbook = new XSSFWorkbook(file.getInputStream());
            XSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            for (int i = 2; i <= end; i++) {
                List<TimeTableCourse> timeTableCourseList = timeTableCourseService.getTimeTableCourseList(query);

                count++;
                XSSFRow row = sheet.getRow(i);
                TimeTableCourse timeTableCourse = new TimeTableCourse();
                timeTableCourse.setTimeTableDepartmentId(timeTableDepartmentId);
                XSSFCell cell = row.getCell(1);
                cell.setCellType(CellType.STRING);
                timeTableCourse.setId(CommonUtil.getUUID());

                String courseName = row.getCell(2).getStringCellValue();
                Integer integer = courseService.selCourseCountByCN(courseName);
//                检查是否为0
                integer = 1 / integer;
                timeTableCourse.setCourseName(courseName);
                timeTableCourse.setCourseNum(cell.getStringCellValue());
                String teacherName = row.getCell(3).getStringCellValue();
                Integer integer1 = empService.selEmpCountByName(teacherName);
//                检查是否为0
                integer1 = 1 / integer1;
                try {
                    if ("".equals(row.getCell(4).getStringCellValue()) || null == row.getCell(4).getStringCellValue()) {
                    } else {
                        Emp emp = empService.getEmpByIdCard(row.getCell(4).getStringCellValue());
                        timeTableCourse.setCourseTeacher(emp.getName());
                        timeTableCourse.setCourseTeacherId(emp.getPersonId());
                    }
                } catch (Exception e) {
                    try {
                        if ("".equals(row.getCell(5).getStringCellValue()) || null == row.getCell(5).getStringCellValue()) {

                        } else {
                            String personId = teachingTaskService.getPersonIdByStaffId(row.getCell(5).getStringCellValue());
                            timeTableCourse.setCourseTeacher(empService.getPersonNameById(personId));
                            timeTableCourse.setCourseTeacherId(personId);
                        }
                    } catch (Exception s) {
                        s.printStackTrace();
                        return new Message(2, "请确认导入模版教师身份证号或教师教职工编号是否填写！", "info");
                    }
                }
                timeTableCourse.setWeeks(row.getCell(0).getStringCellValue());

                for (TimeTableCourse tc : timeTableCourseList) {
                    if (tc.getWeeks().equals(timeTableCourse.getWeeks()) && tc.getCourseNum().equals(timeTableCourse.getCourseNum())) {
                        int err = 5 / 0;
                    }
                }
                timeTableCourseService.saveTimeTableCourse(timeTableCourse);
            }

        } catch (Exception e) {
            e.printStackTrace();
            String msg = "";
            if (count == 0) {
                msg = "请确认导入模版是否正确！";
                return new Message(0, msg, "info");
            } else {
                msg = "导入" + (count - 1) + "条成功，第" + (count + 2) + "行数据异常。导入失败！";
                return new Message(2, msg, "info");
            }
        }
        return new Message(1, "共计" + count + "条，导入成功！", "success");
    }


}













