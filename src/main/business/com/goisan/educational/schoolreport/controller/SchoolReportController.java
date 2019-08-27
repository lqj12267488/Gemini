package com.goisan.educational.schoolreport.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.schoolreport.bean.SchoolReport;
import com.goisan.educational.schoolreport.dao.SchoolReportDao;
import com.goisan.educational.score.service.ScoreChangeService;
import com.goisan.educational.textbook.service.TextBookService;
import com.goisan.system.bean.ClassBean;
import com.goisan.system.bean.CommonBean;
import com.goisan.system.bean.EmpDeptRelation;
import com.goisan.system.bean.RoleEmpDeptRelation;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.ZipUtils;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/schoolReport")
public class SchoolReportController {
    @Autowired
    SchoolReportDao schoolReportDao;


    /**
     * 跳转 页面方法
     *
     * @return
     */
    @RequestMapping("/toPersonalSchoolReport")
    public ModelAndView toPersonalSchoolReport() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/schoolreport/SchoolReportList");//教务处查看页面
        return mv;
    }


    @RequestMapping("/exportSchoolReport")
    public void exportSchoolReport(String ids, String deptId, String classId, String majorId, String studentName, HttpServletResponse response) {
        if (ids == null || "".equals(ids)) {
            List<String> studentIds = schoolReportDao.getStudentIds(deptId, classId, majorId, studentName);
            StringBuilder idsBuilder = new StringBuilder();
            for (String s : studentIds) {
                idsBuilder.append(s).append(",");
            }
            if (idsBuilder.length() > 32) {
                ids = idsBuilder.substring(0, idsBuilder.length() - 1);
            }
        }
        String baseName = System.getProperty("java.io.tmpdir") + File.separator + System.currentTimeMillis();
        File file = new File(baseName + File.separator + "学生成绩单");
        file.mkdirs();
        SimpleDateFormat ft = new SimpleDateFormat("yyyy年MM月");
        for (String id : ids.split(",")) {
            SchoolReport report = new SchoolReport();
            report.setStudentId(id);
            //获取学生的个人信息
            List<SchoolReport> schoolReportList = schoolReportDao.getStudentInfo(report);
            if (schoolReportList.size() > 0) {
                SchoolReport studentInfo = schoolReportList.get(0);
                //获取成绩数据
                List<SchoolReport> infoList = schoolReportDao.getSchoolReportList(report);
                HSSFWorkbook wb = new HSSFWorkbook();
                HSSFSheet sheet = wb.createSheet("个人成绩单");
                HSSFRow row1 = sheet.createRow(0);
                HSSFRow row2 = sheet.createRow(1);
                HSSFRow row3 = sheet.createRow(2);
                HSSFRow row4 = sheet.createRow(3);
                HSSFRow row5 = sheet.createRow(4);
                HSSFRow row6 = sheet.createRow(5);

                CellStyle cellStyle1 = wb.createCellStyle();
                cellStyle1.setAlignment(HorizontalAlignment.CENTER);
                cellStyle1.setVerticalAlignment(VerticalAlignment.CENTER);
                cellStyle1.setWrapText(true);
                Font font1 = wb.createFont();
                font1.setFontHeightInPoints((short) 19);
                cellStyle1.setFont(font1);

                CellStyle cellStyle2 = wb.createCellStyle();
                cellStyle2.setAlignment(HorizontalAlignment.CENTER);
                cellStyle2.setVerticalAlignment(VerticalAlignment.CENTER);
                cellStyle2.setWrapText(true);
                Font font2 = wb.createFont();
                font2.setFontHeightInPoints((short) 28);
                cellStyle2.setFont(font2);


                CellStyle cellStyle3 = wb.createCellStyle();
                cellStyle3.setAlignment(HorizontalAlignment.CENTER);
                cellStyle3.setVerticalAlignment(VerticalAlignment.CENTER);
                cellStyle3.setWrapText(true);
                Font font3 = wb.createFont();
                font3.setFontHeightInPoints((short) 12);
                cellStyle3.setFont(font3);

                CellStyle cellStyle4 = wb.createCellStyle();
                cellStyle4.cloneStyleFrom(cellStyle3);
                cellStyle4.setBorderTop(BorderStyle.THIN);
                cellStyle4.setBorderBottom(BorderStyle.THIN);
                cellStyle4.setBorderLeft(BorderStyle.THIN);
                cellStyle4.setBorderRight(BorderStyle.THIN);

                CellStyle cellStyle5 = wb.createCellStyle();
                cellStyle5.setBorderTop(BorderStyle.THIN);
                cellStyle5.setBorderBottom(BorderStyle.THIN);
                cellStyle5.setBorderLeft(BorderStyle.THIN);
                cellStyle5.setBorderRight(BorderStyle.THIN);
                cellStyle5.setAlignment(HorizontalAlignment.CENTER);
                cellStyle5.setVerticalAlignment(VerticalAlignment.CENTER);
                cellStyle5.setWrapText(true);
                Font font5 = wb.createFont();
                font5.setFontHeightInPoints((short) 14);
                font5.setBold(true);
                font5.setFontName("仿宋_GB2312");
                cellStyle5.setFont(font5);


                sheet.setColumnWidth(0, 16 * 256);
                sheet.setColumnWidth(3, 20 * 256);
                sheet.setColumnWidth(7, 20 * 256);

                row1.setHeightInPoints(28);
                row2.setHeightInPoints(35);
                CellRangeAddress cellRangeAddress4 = new CellRangeAddress(3, 3, 1, 2);
                CellRangeAddress cellRangeAddress5 = new CellRangeAddress(3, 3, 4, 5);
                CellRangeAddress cellRangeAddress6 = new CellRangeAddress(4, 4, 1, 2);
                CellRangeAddress cellRangeAddress7 = new CellRangeAddress(4, 4, 4, 5);
                setRegionStyle(cellStyle4, cellRangeAddress4, sheet);
                setRegionStyle(cellStyle4, cellRangeAddress5, sheet);
                setRegionStyle(cellStyle4, cellRangeAddress6, sheet);
                setRegionStyle(cellStyle4, cellRangeAddress7, sheet);
                sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 7));//白城职业技术学院
                sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 7));//学生成绩单
                sheet.addMergedRegion(cellRangeAddress4);//姓名
                sheet.addMergedRegion(cellRangeAddress5);//入学时间
                sheet.addMergedRegion(cellRangeAddress6);//院系名
                sheet.addMergedRegion(cellRangeAddress7);//专业

                HSSFCell cell_1_0 = row1.createCell(0);
                String xxmc= CommonBean.getParamValue("SZXXMC");
                cell_1_0.setCellValue(xxmc);
                cell_1_0.setCellStyle(cellStyle1);


                HSSFCell cell_2_0 = row2.createCell(0);
                cell_2_0.setCellValue("学  生  成  绩  单");
                cell_2_0.setCellStyle(cellStyle2);

                HSSFCell cell_4_0 = row4.createCell(0);
                cell_4_0.setCellValue("姓名");
                cell_4_0.setCellStyle(cellStyle5);
                HSSFCell cell_4_1 = row4.createCell(1);
                cell_4_1.setCellValue(studentInfo.getStudentName());
                cell_4_1.setCellStyle(cellStyle4);

                HSSFCell cell_4_3 = row4.createCell(3);
                cell_4_3.setCellValue("入学时间");
                cell_4_3.setCellStyle(cellStyle5);
                HSSFCell cell_4_4 = row4.createCell(4);
                cell_4_4.setCellValue(studentInfo.getEnrolmentTime());
                cell_4_4.setCellStyle(cellStyle4);

                List<String> time = scoreChangeService.getStudentEndTime(studentInfo.getStudentId());
                if (time.size() == 0) {
                    time.add("未毕业");
                }
                HSSFCell cell_4_6 = row4.createCell(6);
                cell_4_6.setCellValue("毕业时间");
                cell_4_6.setCellStyle(cellStyle5);
                HSSFCell cell_4_7 = row4.createCell(7);
                cell_4_7.setCellValue(time.get(0));
                cell_4_7.setCellStyle(cellStyle4);


                HSSFCell cell_5_0 = row5.createCell(0);
                cell_5_0.setCellValue("院系名");
                cell_5_0.setCellStyle(cellStyle5);
                HSSFCell cell_5_1 = row5.createCell(1);
                cell_5_1.setCellValue(studentInfo.getDepartmentName());
                cell_5_1.setCellStyle(cellStyle4);

                HSSFCell cell_5_3 = row5.createCell(3);
                cell_5_3.setCellValue("专业");
                cell_5_3.setCellStyle(cellStyle5);
                HSSFCell cell_5_4 = row5.createCell(4);
                cell_5_4.setCellValue(studentInfo.getMajorName());
                cell_5_4.setCellStyle(cellStyle4);

                HSSFCell cell_5_6 = row5.createCell(6);
                cell_5_6.setCellValue("班级");
                cell_5_6.setCellStyle(cellStyle5);
                HSSFCell cell_5_7 = row5.createCell(7);
                cell_5_7.setCellValue(studentInfo.getClassName());
                cell_5_7.setCellStyle(cellStyle4);

                CellRangeAddress cellRangeAddress1 = new CellRangeAddress(5, 5, 0, 1);
                CellRangeAddress cellRangeAddress2 = new CellRangeAddress(5, 5, 4, 5);
                setRegionStyle(cellStyle4, cellRangeAddress1, sheet);
                setRegionStyle(cellStyle4, cellRangeAddress2, sheet);
                sheet.addMergedRegion(cellRangeAddress1);//课程名
                sheet.addMergedRegion(cellRangeAddress2);//课程名

                HSSFCell cell_6_0 = row6.createCell(0);
                cell_6_0.setCellValue("课程名");
                cell_6_0.setCellStyle(cellStyle5);

                HSSFCell cell_6_2 = row6.createCell(2);
                cell_6_2.setCellValue("成绩");
                cell_6_2.setCellStyle(cellStyle5);

                HSSFCell cell_6_3 = row6.createCell(3);
                cell_6_3.setCellValue("考试时间");
                cell_6_3.setCellStyle(cellStyle5);

                HSSFCell cell_6_4 = row6.createCell(4);
                cell_6_4.setCellValue("课程名");
                cell_6_4.setCellStyle(cellStyle5);

                HSSFCell cell_6_6 = row6.createCell(6);
                cell_6_6.setCellValue("成绩");
                cell_6_6.setCellStyle(cellStyle5);

                HSSFCell cell_6_7 = row6.createCell(7);
                cell_6_7.setCellValue("考试时间");
                cell_6_7.setCellStyle(cellStyle5);

                int tmp = 6;
                HSSFRow rowtmp = null;
                boolean sflag = true;
                for (SchoolReport sr : infoList) {
                    String testTime = "";
                    if (Integer.parseInt(sr.getTestTime().split("-")[1]) <= 7) {
                        testTime = sr.getTestTime().split("-")[0] + "年7月";
                    } else {
                        testTime = sr.getTestTime().split("-")[0] + "年12月";
                    }
                    if (sflag) {
                        rowtmp = sheet.createRow(tmp);
                        HSSFCell cell_tmp_0 = rowtmp.createCell(0);
                        cell_tmp_0.setCellValue(sr.getCourseName());
                        cell_tmp_0.setCellStyle(cellStyle4);

                        HSSFCell cell_tmp_2 = rowtmp.createCell(2);
                        cell_tmp_2.setCellValue(sr.getStudentSource());
                        cell_tmp_2.setCellStyle(cellStyle4);

                        HSSFCell cell_tmp_3 = rowtmp.createCell(3);
                        cell_tmp_3.setCellValue(testTime);
                        cell_tmp_3.setCellStyle(cellStyle4);
                        sflag = !sflag;

                        CellRangeAddress cellRangeAddress8 = new CellRangeAddress(tmp, tmp, 0, 1);
                        CellRangeAddress cellRangeAddress9 = new CellRangeAddress(tmp, tmp, 4, 5);
                        setRegionStyle(cellStyle4, cellRangeAddress8, sheet);
                        setRegionStyle(cellStyle4, cellRangeAddress9, sheet);
                        sheet.addMergedRegion(cellRangeAddress8);//课程名
                        sheet.addMergedRegion(cellRangeAddress9);//课程名
                    } else {
                        sflag = true;
                        HSSFCell cell_tmp_4 = rowtmp.createCell(4);
                        cell_tmp_4.setCellValue(sr.getCourseName());
                        cell_tmp_4.setCellStyle(cellStyle4);

                        HSSFCell cell_tmp_6 = rowtmp.createCell(6);
                        cell_tmp_6.setCellValue(sr.getStudentSource());
                        cell_tmp_6.setCellStyle(cellStyle4);

                        HSSFCell cell_tmp_7 = rowtmp.createCell(7);
                        cell_tmp_7.setCellValue(testTime);
                        cell_tmp_7.setCellStyle(cellStyle4);
                        tmp++;
                    }
                }
                tmp = tmp + 1;
                sheet.addMergedRegion(new CellRangeAddress(tmp, tmp, 0, 4));//制表人
                sheet.addMergedRegion(new CellRangeAddress(tmp, tmp, 5, 7));//日期
                sheet.addMergedRegion(new CellRangeAddress(tmp + 1, tmp + 1, 0, 7));//说明

                HSSFRow rowtmp1 = sheet.createRow(tmp);
                HSSFRow rowtmp2 = sheet.createRow(tmp + 1);

                HSSFCell cell_tmp1_1 = rowtmp1.createCell(0);
                cell_tmp1_1.setCellValue("  制表人：张铭            教务处长：                  教务处（盖章）");
                cell_tmp1_1.setCellStyle(cellStyle3);

                Date now = new Date();

                HSSFCell cell_tmp1_2 = rowtmp1.createCell(5);
                cell_tmp1_2.setCellValue(ft.format(now));
                cell_tmp1_2.setCellStyle(cellStyle3);

                HSSFCell cell_tmp2_1 = rowtmp2.createCell(0);
                cell_tmp2_1.setCellValue("注：考查课成绩分优秀、良好、合格、不合格，补考合格后成绩为补合格。");
                cell_tmp2_1.setCellStyle(cellStyle3);
                OutputStream os = null;
                try {
                    os = new FileOutputStream(new File(baseName + File.separator + "学生成绩单" + File.separator
                            + studentInfo.getClassName() + "-" + studentInfo.getStudentName() + "-" + studentInfo.getStudentNumber() + ".xls"));
                    wb.write(os);
                } catch (IOException e) {
                    try {
                        os.close();
                        wb.close();
                    } catch (IOException e1) {
                        e1.printStackTrace();
                    }
                    e.printStackTrace();
                }
            }
        }
        String zipName = baseName + File.separator + "学生成绩单.zip";
        FileOutputStream fileOutputStream = null;
        BufferedOutputStream bufferedOutputStream = null;
        try {
            fileOutputStream = new FileOutputStream(zipName);
            bufferedOutputStream = new BufferedOutputStream(fileOutputStream);
            ZipUtils.toZip(baseName + File.separator + "学生成绩单", bufferedOutputStream, true);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                bufferedOutputStream.close();
                fileOutputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        OutputStream os = null;
        FileInputStream fis = null;
        BufferedInputStream bis = null;
        response.setContentType("application/zip");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("学生成绩单.zip", "utf-8"));
            os = response.getOutputStream();
            fis = FileUtils.openInputStream(new File(zipName));
            bis = new BufferedInputStream(fis);
            int b;
            while ((b = bis.read()) != -1) {
                os.write(b);
                os.flush();
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                bis.close();
                fis.close();
                os.close();
                FileUtils.deleteDirectory(new File(baseName));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @Resource
    private ScoreChangeService scoreChangeService;
    @Resource
    private TextBookService textBookService;

    @ResponseBody
    @RequestMapping("/getSchoolReportList")
    public Map<String, Object> getMajorList(SchoolReport schoolReport, int draw, int start, int length) {

        List<EmpDeptRelation> list = scoreChangeService.getEmployeeDeptByDeptIdPersonId(CommonUtil.getPersonId());
        List<RoleEmpDeptRelation> list1 = schoolReportDao.getRoleByPersonId(CommonUtil.getPersonId());
        List<ClassBean> clssses = schoolReportDao.getClassBeanByPersonId(CommonUtil.getPersonId());
        String s = textBookService.getUserTypeByPersonId(CommonUtil.getPersonId());
        if ("0".equals(s)) {
            if (list.size() > 0) {
                PageHelper.startPage(start / length + 1, length);
                Map<String, Object> stringListHashMap = new HashMap<>();
                List<SchoolReport> empList = schoolReportDao.getStudentInfo(schoolReport);
                PageInfo<List<SchoolReport>> info = new PageInfo(empList);
                stringListHashMap.put("draw", draw);
                stringListHashMap.put("recordsTotal", info.getTotal());
                stringListHashMap.put("recordsFiltered", info.getTotal());
                stringListHashMap.put("data", empList);
                return stringListHashMap;
            } else if (list1.size() > 0) {
                PageHelper.startPage(start / length + 1, length);
                Map<String, Object> stringListHashMap = new HashMap<>();
                schoolReport.setDepartmentsId(CommonUtil.getDefaultDept());
                List<SchoolReport> empList = schoolReportDao.getStudentInfo(schoolReport);
                PageInfo<List<SchoolReport>> info = new PageInfo(empList);
                stringListHashMap.put("draw", draw);
                stringListHashMap.put("recordsTotal", info.getTotal());
                stringListHashMap.put("recordsFiltered", info.getTotal());
                stringListHashMap.put("data", empList);
                return stringListHashMap;
            } else if (!(null == clssses)) {
                String classIds = "'";
                for (ClassBean classBean : clssses) {
                    classIds += classBean.getClassId() + "','";
                }
                classIds = classIds.substring(0, classIds.length() - 2);
                PageHelper.startPage(start / length + 1, length);
                Map<String, Object> stringListHashMap = new HashMap<>();
                schoolReport.setClassId(classIds);
                List<SchoolReport> empList = schoolReportDao.getStudentInfo(schoolReport);
                PageInfo<List<SchoolReport>> info = new PageInfo(empList);
                stringListHashMap.put("draw", draw);
                stringListHashMap.put("recordsTotal", info.getTotal());
                stringListHashMap.put("recordsFiltered", info.getTotal());
                stringListHashMap.put("data", empList);
                return stringListHashMap;
            } else {
                PageHelper.startPage(start / length + 1, length);
                Map<String, Object> stringListHashMap = new HashMap<>();
                List<SchoolReport> empList = schoolReportDao.getStudentInfo(schoolReport);
                PageInfo<List<SchoolReport>> info = new PageInfo(empList);
                stringListHashMap.put("draw", draw);
                stringListHashMap.put("recordsTotal", info.getTotal());
                stringListHashMap.put("recordsFiltered", info.getTotal());
                stringListHashMap.put("data", empList);
                return stringListHashMap;
            }
        } else if ("1".equals(s)) {
            PageHelper.startPage(start / length + 1, length);
            Map<String, Object> stringListHashMap = new HashMap<>();
            schoolReport.setStudentId(CommonUtil.getPersonId());
            List<SchoolReport> empList = schoolReportDao.getStudentInfo(schoolReport);
            PageInfo<List<SchoolReport>> info = new PageInfo(empList);
            stringListHashMap.put("draw", draw);
            stringListHashMap.put("recordsTotal", info.getTotal());
            stringListHashMap.put("recordsFiltered", info.getTotal());
            stringListHashMap.put("data", empList);
            return stringListHashMap;
        } else {
            PageHelper.startPage(start / length + 1, length);
            Map<String, Object> stringListHashMap = new HashMap<>();
            List<SchoolReport> empList = schoolReportDao.getStudentInfo(schoolReport);
            PageInfo<List<SchoolReport>> info = new PageInfo(empList);
            stringListHashMap.put("draw", draw);
            stringListHashMap.put("recordsTotal", info.getTotal());
            stringListHashMap.put("recordsFiltered", info.getTotal());
            stringListHashMap.put("data", empList);
            return stringListHashMap;
        }

    }

    private static void setRegionStyle(CellStyle cs, CellRangeAddress region, Sheet sheet) {

        for (int i = region.getFirstRow(); i <= region.getLastRow(); i++) {
            Row row = sheet.getRow(i);
            if (row == null) {
                row = sheet.createRow(i);
            }
            for (int j = region.getFirstColumn(); j <= region.getLastColumn(); j++) {
                Cell cell = row.getCell(j);
                if (cell == null) {
                    cell = row.createCell(j);
                }
                cell.setCellStyle(cs);
            }
        }
    }

}
