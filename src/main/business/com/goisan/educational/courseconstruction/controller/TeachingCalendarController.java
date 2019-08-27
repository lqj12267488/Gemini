package com.goisan.educational.courseconstruction.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.courseconstruction.bean.TeachingCalendar;
import com.goisan.educational.courseconstruction.bean.TeachingCalendarDetails;
import com.goisan.educational.courseconstruction.service.TeachingCalendarService;
import com.goisan.educational.major.bean.Major;
import com.goisan.system.bean.CommonBean;
import com.goisan.system.bean.Select2;
import com.goisan.system.service.CommonService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddressList;
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
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
@RequestMapping("courseconstruction")
public class TeachingCalendarController {

    @Autowired
    private TeachingCalendarService teachingCalendarService;

    @Resource
    private CommonService commonService;

    @RequestMapping("teachingCalendar")
    public ModelAndView teachingCalendar() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/educational/courseconstruction/teachingCalendar");
        return mv;
    }

    @RequestMapping("getTeachingCalendarList")
    public Map<String, Object> getTeachingCalendarList(TeachingCalendar teachingCalendar, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> teachingCalendars = new HashMap();
        teachingCalendar.setCreateDept(CommonUtil.getDefaultDept());
        List<TeachingCalendar> list = teachingCalendarService.getTeachingCalendarList(teachingCalendar);
        PageInfo<List<TeachingCalendar>> info = new PageInfo(list);
        teachingCalendars.put("draw", draw);
        teachingCalendars.put("recordsTotal", info.getTotal());
        teachingCalendars.put("recordsFiltered", info.getTotal());
        teachingCalendars.put("data", list);
        return teachingCalendars;
    }

    @RequestMapping("editTeachingCalendar")
    public ModelAndView editTeachingCalendar(String id) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        ModelAndView mv = new ModelAndView("business/educational/courseconstruction/editTeachingCalendar");
        if (id != null && !"".equals(id)) {
            TeachingCalendar teachingCalendar = teachingCalendarService.getTeachingCalendarById(id);
            mv.addObject("data", teachingCalendar);
            mv.addObject("head", "修改");
        } else {
            TeachingCalendar teachingCalendar = new TeachingCalendar();
            teachingCalendar.setCreator(CommonUtil.getPersonName());
            teachingCalendar.setTime(df.format(new Date()));
            mv.addObject("data", teachingCalendar);
            mv.addObject("head", "新增");
        }
        return mv;
    }

    @RequestMapping("saveTeachingCalendar")
    public Message saveTeachingCalendar(TeachingCalendar teachingCalendar) {
        if (teachingCalendar.getId() != null && !"".equals(teachingCalendar.getId())) {
            teachingCalendarService.updateTeachingCalendar(teachingCalendar);
            return new Message(0, "修改成功！", null);
        } else {
            teachingCalendar.setId(CommonUtil.getUUID());
            teachingCalendar.setCreateDept(CommonUtil.getDefaultDept());
            teachingCalendarService.saveTeachingCalendar(teachingCalendar);
            return new Message(0, "新增成功！", null);
        }
    }

    @RequestMapping("deleteTeachingCalendar")
    public Message deleteTeachingCalendar(String id) {
        teachingCalendarService.deleteTeachingCalendar(id);
        return new Message(1, "删除成功！", null);
    }

    @RequestMapping("details")
    public ModelAndView details(String id) {
        ModelAndView mv = new ModelAndView("business/educational/courseconstruction/details");
        List<Map<String, Object>> major = teachingCalendarService.getMajor(id);
        List<Map<String, Object>> classList = teachingCalendarService.getClass(id);
        Map<String, List<TeachingCalendarDetails[]>> content = teachingCalendarService.getTeachingCalendarDetailsListByCalendarId(classList, id);
        TeachingCalendar teachingCalendar = teachingCalendarService.getTeachingCalendarById(id);
        mv.addObject("majorList", major);
        mv.addObject("classList", classList);
        mv.addObject("id", id);
        mv.addObject("deptShow", teachingCalendar.getDeptShow());
        mv.addObject("contentList", content);
        return mv;
    }

    @RequestMapping("editTeachingCalendarDetails")
    public ModelAndView editTeachingCalendarDetails(String id) {
        ModelAndView mv = new ModelAndView("business/educational/courseconstruction/editDetails");
        TeachingCalendar teachingCalendar = teachingCalendarService.getTeachingCalendarById(id);
        mv.addObject("deptId", teachingCalendar.getDeptId());
        mv.addObject("id", id);
        return mv;
    }

    @RequestMapping("saveTeachingCalendarDetails")
    public Message saveTeachingCalendarDetails(TeachingCalendarDetails teachingCalendarDetails) {
        Major major = teachingCalendarService.getMajorByCode(teachingCalendarDetails.getMajorId());
        teachingCalendarDetails.setMajorId(major.getMajorId());
        teachingCalendarService.saveTeachingCalendarDetails(teachingCalendarDetails);
        return new Message(1, "新增成功", null);
    }

    @RequestMapping("deleteTeachingCalendarDetails")
    public Message deleteTeachingCalendarDetails(String id) {
        teachingCalendarService.deleteTeachingCalendarDetails(id);
        return new Message(1, "删除成功！", null);
    }

    /**
     * 导入页面跳转
     *
     * @param
     * @return
     */
    @RequestMapping("toImportCalendar")
    public ModelAndView toImportStudent() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/educational/courseconstruction/importCalendar");
        return mv;
    }


    /**
     * 教学日历模板
     *
     * @param response
     */
    @RequestMapping("getCalendarExcelTemplate")
    public void getStudentExcelTemplate(HttpServletResponse response) {
        String rootPath = new File(getClass().getResource("/").getPath()).getParentFile().getParent().toString();
        rootPath = rootPath.replaceAll("%20", " ");
        String fileName = rootPath + "/template/CalendarTemplate.xls";
        File file = FileUtils.getFile(fileName);
        OutputStream os = null;
        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("教学日历基本信息模板.xls", "utf-8"));
            os = response.getOutputStream();
            os.write(FileUtils.readFileToByteArray(file));
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


    /**
     * 导入教学日历
     *
     * @param file
     * @return
     */

    @ResponseBody
    @RequestMapping("importCalendar")
    public Message importCalendar(@RequestParam(value = "file", required = false) CommonsMultipartFile file, String id) {
        TeachingCalendar calendarById = teachingCalendarService.getTeachingCalendarById(id);
        List<Select2> majorByDeptId = commonService.getMajorByDeptId2(calendarById.getDeptId());
        List<Select2> classByDept = commonService.getClassByDeptId(calendarById.getDeptId());
        Map<String, String> majorMap = new HashMap<>();
        Map<String, String> classMap = new HashMap<>();
        for (Select2 select2 : majorByDeptId) {
            majorMap.put(select2.getText(), select2.getId());
        }
        for (Select2 select2 : classByDept) {
            classMap.put(select2.getText(), select2.getId());
        }
        int count = 0;
        StringBuilder rows = new StringBuilder();
        try {
            HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            for (int i = 2; i <= end; i++) {
                boolean flag = false;
                HSSFRow row = sheet.getRow(i);
                if (null == row && count == 0) {
                    return new Message(0, "无数据，导入失败！", "error");
                } else if (null == row || row.getLastCellNum() == 1) {
                    return new Message(1, "共计" + count + "条，导入成功！", "success");
                }
                TeachingCalendarDetails details = new TeachingCalendarDetails();
                details.setCalendarId(id);
                HSSFCell major = row.getCell(0);
                if (major != null) {
                    details.setMajorId(majorMap.get(major.toString()));
                } else {
                    flag = true;
                }
                HSSFCell c = row.getCell(1);
                if (c != null) {
                    String classId = commonService.getClassIdByMajorIdAndClassName(majorMap.get(major.toString()), c.toString());
                    if (classId != null) {
                        details.setClassId(classId);
                    } else {
                        flag = true;
                    }

                } else {
                    flag = true;
                }
                HSSFCell month = row.getCell(2);
                if (month != null) {
                    details.setMonth(month.toString());
                } else {
                    flag = true;
                }
                HSSFCell date = row.getCell(3);
                if (date != null) {
                    details.setDate(date.toString());
                } else {
                    flag = true;
                }
                HSSFCell week = row.getCell(4);
                if (week != null) {
                    details.setWeek(week.toString());
                } else {
                    flag = true;
                }
                String type = row.getCell(5).toString();
                if (type != null) {
                    details.setType(type);
                } else {
                    flag = true;
                }
                teachingCalendarService.saveTeachingCalendarDetails(details);
                if (flag) {
                    rows.append(i + 1).append(",");
                } else {
                    count++;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            String msg = "导入" + count + "条成功，第" + rows.substring(0, rows.length()) + "行数据异常。导入失败！";
            return new Message(0, msg, null);
        }
        if (rows.toString().isEmpty()) {
            return new Message(1, "共计" + count + "条，导入成功！", "success");
        } else {
            String msg = "导入" + count + "条成功，第" + rows.substring(0, rows.length()) + "行数据异常。导入失败！";
            return new Message(0, msg, null);
        }
    }

    @RequestMapping("/downImportTemplate")
    public void downImportTemplate(HttpServletResponse response, String id) {
        HSSFWorkbook wb = new HSSFWorkbook();
        int rowId = 0;
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("教学日历基本信息模板");
        CellStyle cellStyle1 = wb.createCellStyle();
        DataFormat format = wb.createDataFormat();
        cellStyle1.setDataFormat(format.getFormat("@"));
        sheet.setDefaultColumnStyle(3, cellStyle1);
        sheet.setDefaultColumnStyle(4, cellStyle1);
        HSSFCellStyle cellStyle = wb.createCellStyle();
        //cellStyle.setFillForegroundColor((short) 13);// 设置背景色
        cellStyle.setBorderLeft(BorderStyle.THIN);//左边框
        cellStyle.setBorderTop(BorderStyle.THIN);//上边框
        cellStyle.setBorderRight(BorderStyle.THIN);//右边框
        cellStyle.setBorderBottom(BorderStyle.THIN); //下边框
        cellStyle.setAlignment(HorizontalAlignment.CENTER); // 居中
        HSSFCellStyle headStyle = wb.createCellStyle();
        headStyle.cloneStyleFrom(cellStyle);
        HSSFFont hssfFont = wb.createFont();
        hssfFont.setColor(HSSFColor.RED.index);
        headStyle.setFont(hssfFont);
        sheet.setDefaultColumnWidth(25);
        sheet.createRow(0).createCell(0).setCellStyle(headStyle);
        sheet.getRow(0).getCell(0).setCellValue("* 请选择专业");
        sheet.getRow(0).createCell(1).setCellStyle(headStyle);
        sheet.getRow(0).getCell(1).setCellValue("* 请选择班级");
        sheet.getRow(0).createCell(2).setCellStyle(headStyle);
        sheet.getRow(0).getCell(2).setCellValue("* 请选择月份");
        sheet.getRow(0).createCell(3).setCellStyle(headStyle);
        sheet.getRow(0).getCell(3).setCellValue("* 请填写日期，例：1-7");
        sheet.getRow(0).createCell(4).setCellStyle(headStyle);
        sheet.getRow(0).getCell(4).setCellValue("* 请填写周,请填写小于52的整数");
        sheet.getRow(0).createCell(5).setCellStyle(headStyle);
        sheet.getRow(0).getCell(5).setCellValue("* 请选择课程类型,说明：1、↑↓课堂教学 ☆校外实习 ★校内实习 ▲讲座 ◆课程设计 △入学教育 ＃新生军训 ◇复习考试 。");
        sheet.createRow(1).createCell(0).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(0).setCellValue("专业");
        sheet.getRow(1).createCell(1).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(1).setCellValue("班级");
        sheet.getRow(1).createCell(2).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(2).setCellValue("月份");
        sheet.getRow(1).createCell(3).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(3).setCellValue("日期");
        sheet.getRow(1).createCell(4).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(4).setCellValue("周");
        sheet.getRow(1).createCell(5).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(5).setCellValue("课程类型");
        setHSSFPrompt(sheet, "", "", 1, 65535, 0, 0);
        setHSSFPrompt(sheet, "", "", 1, 65535, 1, 1);
        setHSSFPrompt(sheet, "", "", 1, 65535, 2, 2);
        setHSSFPrompt(sheet, "", "", 1, 65535, 3, 3);
        setHSSFPrompt(sheet, "", "", 1, 65535, 4, 4);
        setHSSFPrompt(sheet, "", "", 1, 65535, 5, 5);
        List<Select2> majorByDeptId = commonService.getMajorByDeptId2(teachingCalendarService.getTeachingCalendarById(id).getDeptId());
        //保存一级菜单选项
        List<String> list = new ArrayList();
        //保存一级二级关联列表数据
        Map<String,List<Select2>> areaMap = new HashMap<String, List<Select2>>();
        for (Select2 select2 : majorByDeptId) {
            list.add(select2.getText());
            List<Select2> classByDeptDz = commonService.getClassByDeptId1(teachingCalendarService.getTeachingCalendarById(id).getDeptId(),select2.getText());
            areaMap.put(select2.getText(),classByDeptDz);
        }
        HSSFSheet sheet2 = wb.createSheet("Sheet2");
        wb.setSheetHidden(1, 1);
        String[] months = new String[]{"一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"};
        String[] types = new String[]{"↑↓", "↑", "↓", "☆", "★", "▲", "◆", "△", "＃", "◇"};

        //一级列表
        String[] major = null;
        if(majorByDeptId.size()>0) {
             major = new String[majorByDeptId.size()];
            for (int i = 0; i < majorByDeptId.size(); i++) {
                major[i] = majorByDeptId.get(i).getText();
            }

        }
        //二级列表
        String formula1 = "";
        if(list.size()>0) {
            for (int i = 0; i < list.size(); i++) {
                String key = list.get(i);
                List<Select2> son  = areaMap.get(key);
                Row row = sheet2.createRow(rowId++);
                row.createCell(0).setCellValue(key);
                for(int j = 0; j < son.size(); j ++){
                    Cell cell = row.createCell(j + 1);
                    cell.setCellValue(son.get(j).getText());
                }

                // 添加名称管理器
                String range = getRange(1, rowId, son.size());
                Name name = wb.createName();
                //key不可重复
                name.setNameName(key);
                formula1 = "Sheet2!" + range;
                name.setRefersToFormula(formula1);
                //setDataValidation(sheet, formula, 2, 65535, 1, 1);

            }

        }
        setHSSFValidation(sheet, months, 2, 65535, 2, 2);
        setHSSFValidation(sheet, types, 2, 65535, 5, 5);
        setHSSFValidation(sheet, major, 2, 65535, 0, 0);

        DVConstraint formula = DVConstraint.createFormulaListConstraint("INDIRECT(INDIRECT(\"R\"&ROW()&\"C\"&COLUMN()-1,FALSE))"); // INDIRECT(INDIRECT("R"&ROW()&"C"&COLUMN()-1,FALSE)):取当前单元格左侧的单元格去名称管理器查询
        CellRangeAddressList rangeAddressList = new CellRangeAddressList(2, 65535, 1, 1);
        DataValidation majorDataValidation = new HSSFDataValidation(rangeAddressList, formula);
        majorDataValidation.createErrorBox("错误", "请输入有效的专业,或从下拉框中选择!");
        sheet.addValidationData(majorDataValidation);



        OutputStream os = null;
        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("教学日历基本信息模板.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                    wb.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private static void setDataValidation(HSSFSheet sheet, String strFormula, int firstRow, int endRow, int firstCol, int endCol) {
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        DVConstraint constraint = DVConstraint.createFormulaListConstraint(strFormula);//add
        HSSFDataValidation dataValidation = new HSSFDataValidation(regions, constraint);//add
        dataValidation.createErrorBox("Error", "Error");
        dataValidation.createPromptBox("", null);
        sheet.addValidationData(dataValidation);
    }


    public static void setHSSFValidation(HSSFSheet sheet, String[] textlist, int firstRow, int endRow, int firstCol, int endCol) {
        // 加载下拉列表内容
        DVConstraint constraint = DVConstraint.createExplicitListConstraint(textlist);
        // 设置数据有效性加载在哪个单元格上,四个参数分别是：起始行、终止行、起始列、终止列
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        // 数据有效性对象
        HSSFDataValidation hssfDataValidation = new HSSFDataValidation(regions, constraint);
        sheet.addValidationData(hssfDataValidation);

    }

    /**
     * 设置单元格上提示
     *
     * @param sheet         要设置的sheet.
     * @param promptTitle   标题
     * @param promptContent 内容
     * @param firstRow      开始行
     * @param endRow        结束行
     * @param firstCol      开始列
     * @param endCol        结束列
     * @return 设置好的sheet.
     */
    public static void setHSSFPrompt(HSSFSheet sheet, String promptTitle, String promptContent, int firstRow, int endRow, int firstCol, int endCol) {
        // 构造constraint对象
        DVConstraint constraint = DVConstraint.createCustomFormulaConstraint("BB1");
        // 四个参数分别是：起始行、终止行、起始列、终止列
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        // 数据有效性对象
        HSSFDataValidation hssfDataValidation = new HSSFDataValidation(regions, constraint);
        hssfDataValidation.createPromptBox(promptTitle, promptContent);
        sheet.addValidationData(hssfDataValidation);
    }


    public static String getRange(int offset, int rowId, int colCount) {
        char start = (char)('A' + offset);
        if (colCount <= 25) {
            char end = (char)(start + colCount - 1);
            return "$" + start + "$" + rowId + ":$" + end + "$" + rowId;
        } else {
            char endPrefix = 'A';
            char endSuffix = 'A';
            if ((colCount - 25) / 26 == 0 || colCount == 51) {// 26-51之间，包括边界（仅两次字母表计算）
                if ((colCount - 25) % 26 == 0) {// 边界值
                    endSuffix = (char)('A' + 25);
                } else {
                    endSuffix = (char)('A' + (colCount - 25) % 26 - 1);
                }
            } else {// 51以上
                if ((colCount - 25) % 26 == 0) {
                    endSuffix = (char)('A' + 25);
                    endPrefix = (char)(endPrefix + (colCount - 25) / 26 - 1);
                } else {
                    endSuffix = (char)('A' + (colCount - 25) % 26 - 1);
                    endPrefix = (char)(endPrefix + (colCount - 25) / 26);
                }
            }
            return "$" + start + "$" + rowId + ":$" + endPrefix + endSuffix + "$" + rowId;
        }
    }




}