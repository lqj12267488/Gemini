package com.goisan.educational.score.tools;

import com.goisan.educational.score.bean.ScoreImport;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.util.CellRangeAddress;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @function:
 * @author: ZhangHao
 * @date: 2018/11/14
 */
public class ExportScoreInfo {

    public boolean writeScoreInfo(List<ScoreImport> scoreImportList, OutputStream os, String titleName) {

        try {

            if (os != null && checkStringEmpty(titleName) && scoreImportList != null && scoreImportList.size() > 0) {

                Map<String, Map<String, Map<String, Map<String, List<ScoreImport>>>>> dataMap = this.checkScoreList(scoreImportList);

                if (dataMap != null && dataMap.size() > 0) {

                    HSSFWorkbook workbook = new HSSFWorkbook();

                    for (String term : dataMap.keySet()) {

                        if (checkStringEmpty(titleName)) {

                            Map<String, Map<String, Map<String, List<ScoreImport>>>> classMap = dataMap.get(term);

                            if (classMap != null && classMap.size() > 0) {

                                for (String classId : classMap.keySet()) {

                                    if (checkStringEmpty(classId)) {

                                        Map<String, Map<String, List<ScoreImport>>> courseMap = classMap.get(classId);

                                        if (courseMap != null && courseMap.size() > 0) {

                                            for (String courseId : courseMap.keySet()) {

                                                if (checkStringEmpty(courseId)) {

                                                    Map<String, List<ScoreImport>> examMethodMap = courseMap.get(courseId);

                                                    if (examMethodMap != null && examMethodMap.size() > 0) {

                                                        for (String examMethod : examMethodMap.keySet()) {

                                                            if (checkStringEmpty(examMethod)) {

                                                                List<ScoreImport> tempList = examMethodMap.get(examMethod);
                                                                courseId = courseId.replaceAll("[\\]\\[\\\\*\\\\?/\\\\]", "|");
                                                                workbook.createSheet(courseId + "_" + classId);
                                                                HSSFSheet sheet = workbook.getSheet(courseId + "_" + classId);
                                                                this.readTitle(workbook, sheet, titleName);
                                                                this.readTitle2(workbook, sheet, classId, examMethod, courseId, term);
                                                                this.readExcelTr(workbook, sheet);
                                                                this.readData(workbook, sheet, tempList);
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    workbook.write(os);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;
    }

    private boolean readTitle(HSSFWorkbook workbook, HSSFSheet sheet, String titleName) {

        try {

            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 17));//合并单元格

            HSSFRow row1 = sheet.createRow(0);

            row1.setHeight((short) 450);

            HSSFCell cell1 = row1.createCell(0);
            HSSFCellStyle titleStyle = workbook.createCellStyle();
            titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

            HSSFFont titleFont = workbook.createFont();
            titleFont.setFontName("宋体");
            titleFont.setFontHeightInPoints((short) 18);
            titleFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            titleFont.setColor(HSSFColor.RED.index);
            titleFont.setUnderline(Font.U_SINGLE);
            titleStyle.setFont(titleFont);

            cell1.setCellStyle(titleStyle);
            cell1.setCellValue(titleName);

            return true;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }

    private boolean readTitle2(HSSFWorkbook workbook, HSSFSheet sheet, String className, String examMethod, String couserName, String termShow) {

        try {

            sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 5));//合并单元格
            sheet.addMergedRegion(new CellRangeAddress(1, 1, 14, 17));//合并单元格
            sheet.addMergedRegion(new CellRangeAddress(2, 2, 0, 5));//合并单元格
            sheet.addMergedRegion(new CellRangeAddress(2, 2, 14, 17));//合并单元格
            HSSFRow row1 = sheet.createRow(1);
            HSSFRow row2 = sheet.createRow(2);
            row1.setHeight((short) 285);
            HSSFCell cell1 = row1.createCell(0);
            HSSFCell cell2 = row2.createCell(0);
            HSSFCellStyle titleStyle = workbook.createCellStyle();
            titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            titleStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
            HSSFFont titleFont = workbook.createFont();
            titleFont.setFontName("宋体");
            titleFont.setFontHeightInPoints((short) 9);
            titleStyle.setFont(titleFont);
            cell1.setCellValue("班级：" + className);
            HSSFCell cell3 = row1.createCell(14);
            HSSFCell cell4 = row2.createCell(14);
            cell3.setCellStyle(titleStyle);
            cell3.setCellValue("考核类型：" + examMethod);
            cell2.setCellValue("课程：" + couserName);
            cell4.setCellValue(" 学期：" + termShow);
            cell4.setCellStyle(titleStyle);

            return true;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }

    private boolean readExcelTr(HSSFWorkbook workbook, HSSFSheet sheet) {

        try {

            HSSFCellStyle trStyle = workbook.createCellStyle();//生成样式

            trStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
            trStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中

            trStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
            trStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
            trStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
            trStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框

            HSSFFont trFont = workbook.createFont();//生成字体

            trFont.setFontName("宋体");//字体样式
            trFont.setFontHeightInPoints((short) 9);//字体大小
            trFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
            trStyle.setFont(trFont);//装配字体

            HSSFRow row1 = sheet.createRow(3);

            row1.setHeight((short) 450);

            List<String> title_cn_list = this.getCnTrList();

            for (int i = 0; i < title_cn_list.size(); i++) {

                HSSFCell cell2 = row1.createCell(i);

                cell2.setCellStyle(trStyle);
                cell2.setCellValue(title_cn_list.get(i));

                sheet.autoSizeColumn(i);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }

    private void readData(HSSFWorkbook workbook, HSSFSheet sheet, List<ScoreImport> scoreImportList) {

        try {

            if (workbook != null && sheet != null) {

                HSSFCellStyle style = workbook.createCellStyle();//生成样式

                style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
                style.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中

                style.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
                style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
                style.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
                style.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框

                HSSFFont trFont = workbook.createFont();//生成字体

                trFont.setFontName("宋体");//字体样式
                trFont.setFontHeightInPoints((short) 12);//字体大小
                style.setFont(trFont);//装配字体

                if (scoreImportList != null && scoreImportList.size() > 0) {

                    int i = 0;
                    int j = 0;

                    for (; i < 80; i++) {

                        if (i < scoreImportList.size()) {

                            ScoreImport scoreImport = scoreImportList.get(i);

                            if (scoreImport != null) {

                                if (i < 40) {

                                    HSSFRow row = sheet.createRow(i + 4);
                                    row.setHeight((short) 285);

                                    HSSFCell cell = row.createCell(0);
                                    cell.setCellValue(i + 1);
                                    cell.setCellStyle(style);

                                    cell = row.createCell(1);
                                    cell.setCellValue(scoreImport.getStudentName());
                                    cell.setCellStyle(style);

                                    cell = row.createCell(2);
                                    cell.setCellValue(scoreImport.getPeacetimeScoreA());
                                    cell.setCellStyle(style);

                                    cell = row.createCell(3);
                                    cell.setCellValue(scoreImport.getPeacetimeScoreB());
                                    cell.setCellStyle(style);

                                    cell = row.createCell(4);
                                    cell.setCellValue(scoreImport.getPeacetimeScoreC());
                                    cell.setCellStyle(style);

                                    cell = row.createCell(5);
                                    cell.setCellValue(scoreImport.getPeacetimeScoreD());
                                    cell.setCellStyle(style);

                                    String scoreA = scoreImport.getPeacetimeScoreA();
                                    String scoreB = scoreImport.getPeacetimeScoreB();
                                    String scoreC = scoreImport.getPeacetimeScoreC();
                                    String scoreD = scoreImport.getPeacetimeScoreD();
                                    if (null==scoreImport.getPeacetimeScoreA()||"".equals(scoreImport.getPeacetimeScoreA())){
                                        scoreA = "0.0";
                                    }
                                    if (null==scoreImport.getPeacetimeScoreB()||"".equals(scoreImport.getPeacetimeScoreB())){
                                         scoreB = "0.0";
                                    }
                                    if (null==scoreImport.getPeacetimeScoreC()||"".equals(scoreImport.getPeacetimeScoreC())){
                                         scoreC = "0.0";
                                    }
                                    if (null==scoreImport.getPeacetimeScoreC()||"".equals(scoreImport.getPeacetimeScoreC())){
                                         scoreC = "0.0";
                                    }

                                    if (null==scoreImport.getPeacetimeScoreD()||"".equals(scoreImport.getPeacetimeScoreD())){
                                         scoreD = "0.0";
                                    }

                                    int allabcd = Integer.parseInt(scoreA.replace(".0", "")) + Integer.parseInt(scoreB.replace(".0", "")) + Integer.parseInt(scoreC.replace(".0", "")) + Integer.parseInt(scoreD.replace(".0", ""));

                                    cell = row.createCell(6);
                                    cell.setCellValue(allabcd);
                                    cell.setCellStyle(style);

                                    cell = row.createCell(7);
//                                    cell.setCellValue(scoreImport.getScore());
//                                    修改为考试成绩
                                    cell.setCellValue(scoreImport.getExamScore());
                                    cell.setCellStyle(style);

                                    cell = row.createCell(8);

//                                    if (this.isNumber(scoreImport.getScore())) {
//
//                                        cell.setCellValue((Math.round(Double.parseDouble(scoreImport.getScore()) * 0.6 + allabcd) * 100) / 100);
//
//                                    } else {
//
//                                        cell.setCellValue(scoreImport.getScore());
//                                    }
//                                    修改为期末成绩
                                    cell.setCellValue(scoreImport.getScore());
                                    cell.setCellStyle(style);

                                } else {

                                    HSSFRow row = sheet.getRow(j + 4);
                                    row.setHeight((short) 285);

                                    HSSFCell cell = row.createCell(9);
                                    cell.setCellValue(i + 1);
                                    cell.setCellStyle(style);

                                    cell = row.createCell(10);
                                    cell.setCellValue(scoreImport.getStudentName());
                                    cell.setCellStyle(style);

                                    cell = row.createCell(11);
                                    cell.setCellValue(scoreImport.getPeacetimeScoreA());
                                    cell.setCellStyle(style);

                                    cell = row.createCell(12);
                                    cell.setCellValue(scoreImport.getPeacetimeScoreB());
                                    cell.setCellStyle(style);

                                    cell = row.createCell(13);
                                    cell.setCellValue(scoreImport.getPeacetimeScoreC());
                                    cell.setCellStyle(style);

                                    cell = row.createCell(14);
                                    cell.setCellValue(scoreImport.getPeacetimeScoreD());
                                    cell.setCellStyle(style);

                                    int allabcd = Integer.parseInt(scoreImport.getPeacetimeScoreA().replace(".0", "")) + Integer.parseInt(scoreImport.getPeacetimeScoreB().replace(".0", "")) + Integer.parseInt(scoreImport.getPeacetimeScoreC().replace(".0", "")) + Integer.parseInt(scoreImport.getPeacetimeScoreD().replace(".0", ""));

                                    cell = row.createCell(15);
                                    cell.setCellValue(allabcd);
                                    cell.setCellStyle(style);

                                    cell = row.createCell(16);
//                                    修改为考试成绩
//                                    cell.setCellValue(scoreImport.getScore());
                                    cell.setCellValue(scoreImport.getExamScore());
                                    cell.setCellStyle(style);

                                    cell = row.createCell(17);
//                                      修改为平时成绩
//                                    if (this.isNumber(scoreImport.getScore())) {
//
//                                        cell.setCellValue((Math.round(Double.parseDouble(scoreImport.getScore()) * 0.6 + allabcd) * 100) / 100);
//
//                                    } else {
//
//                                        cell.setCellValue(scoreImport.getScore());
//                                    }
                                    cell.setCellValue(scoreImport.getScore());
                                    cell.setCellStyle(style);
                                    j++;
                                }
                            }

                        } else {

                            if (i < 40) {

                                HSSFRow row = sheet.createRow(i + 4);
                                row.setHeight((short) 285);

                                HSSFCell cell = row.createCell(0);
                                cell.setCellValue(i + 1);
                                cell.setCellStyle(style);

                                cell = row.createCell(1);
                                cell.setCellStyle(style);

                                cell = row.createCell(2);
                                cell.setCellStyle(style);

                                cell = row.createCell(3);
                                cell.setCellStyle(style);

                                cell = row.createCell(4);
                                cell.setCellStyle(style);

                                cell = row.createCell(5);
                                cell.setCellStyle(style);

                                cell = row.createCell(6);
                                cell.setCellStyle(style);

                                cell = row.createCell(7);
                                cell.setCellStyle(style);

                                cell = row.createCell(8);
                                cell.setCellValue("");
                                cell.setCellStyle(style);

                            } else {

                                HSSFRow row = sheet.getRow(j + 4);
                                row.setHeight((short) 285);

                                HSSFCell cell = row.createCell(9);
                                cell.setCellValue(i + 1);
                                cell.setCellStyle(style);

                                cell = row.createCell(10);
                                cell.setCellStyle(style);

                                cell = row.createCell(11);
                                cell.setCellStyle(style);

                                cell = row.createCell(12);
                                cell.setCellStyle(style);

                                cell = row.createCell(13);
                                cell.setCellStyle(style);

                                cell = row.createCell(14);
                                cell.setCellStyle(style);

                                cell = row.createCell(15);
                                cell.setCellStyle(style);

                                cell = row.createCell(16);
                                cell.setCellStyle(style);

                                cell = row.createCell(17);
                                cell.setCellStyle(style);

                                j++;
                            }
                        }
                    }
                }

                sheet.autoSizeColumn(0);
                sheet.autoSizeColumn(1);
                sheet.autoSizeColumn(2);
                sheet.autoSizeColumn(3);
                sheet.autoSizeColumn(4);
                sheet.autoSizeColumn(5);
                sheet.autoSizeColumn(6);
                sheet.autoSizeColumn(7);
                sheet.autoSizeColumn(8);
                sheet.autoSizeColumn(9);
                sheet.autoSizeColumn(10);
                sheet.autoSizeColumn(11);
                sheet.autoSizeColumn(12);
                sheet.autoSizeColumn(13);
                sheet.autoSizeColumn(14);
                sheet.autoSizeColumn(15);
                sheet.autoSizeColumn(16);
                sheet.autoSizeColumn(17);

                trFont = workbook.createFont();//生成字体

                trFont.setFontName("宋体");//字体样式
                trFont.setFontHeightInPoints((short) 9);//字体大小
                style.setFont(trFont);//装配字体

                sheet.addMergedRegion(new CellRangeAddress(44, 44, 0, 17));//合并单元格

                HSSFRow row = sheet.createRow(44);
                row.setHeight((short) 285);

                HSSFCell cell = row.createCell(0);
                cell.setCellValue("说明：A栏填学生到课情况满分10；B栏填学生作业情况满分10；C栏填学生测验情况满分10；D栏填学生课上提问情况满分10。");

                sheet.addMergedRegion(new CellRangeAddress(45, 45, 0, 3));//合并单元格
                sheet.addMergedRegion(new CellRangeAddress(45, 45, 14, 17));//合并单元格
                row = sheet.createRow(45);
                row.setHeight((short) 285);

                cell = row.createCell(0);

                if (scoreImportList.get(0).getTeachingTeacherId() != null) {

                    cell.setCellValue("任课教师：" + scoreImportList.get(0).getTeachingTeacherId());

                } else {

                    cell.setCellValue("任课教师：无");
                }

                HSSFCell cell1 = row.createCell(14);
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy年MM月dd日");
                String s = simpleDateFormat.format(new Date(System.currentTimeMillis()));
                cell1.setCellValue(s + " 第 1 页");
            }

        } catch (Exception e) {

            e.printStackTrace();
        }
    }

    private List<String> getCnTrList() {

        List<String> title_cn_list = new LinkedList<>();

        title_cn_list.add("序号");
        title_cn_list.add("姓名");
        title_cn_list.add("A(10)");
        title_cn_list.add("B(10)");
        title_cn_list.add("C(10)");
        title_cn_list.add("D(10)");
        title_cn_list.add("平时合计");
        title_cn_list.add("期末成绩");
        title_cn_list.add("总评");
        title_cn_list.add("序号");
        title_cn_list.add("姓名");
        title_cn_list.add("A(10)");
        title_cn_list.add("B(10)");
        title_cn_list.add("C(10)");
        title_cn_list.add("D(10)");
        title_cn_list.add("平时合计");
        title_cn_list.add("期末成绩");
        title_cn_list.add("总评");

        return title_cn_list;
    }

    private Map<String, Map<String, Map<String, Map<String, List<ScoreImport>>>>> checkScoreList(List<ScoreImport> scoreImportList) {

        try {

            if (scoreImportList != null && scoreImportList.size() > 0) {

                Map<String, Map<String, Map<String, Map<String, List<ScoreImport>>>>> dataMap = new HashMap<>();

                for (ScoreImport scoreImport : scoreImportList) {

                    if (scoreImport != null) {

                        Map<String, Map<String, Map<String, List<ScoreImport>>>> classMap = dataMap.get(scoreImport.getTermShow());

                        if (classMap == null) {

                            classMap = new HashMap<>();
                        }

                        Map<String, Map<String, List<ScoreImport>>> courseMap = classMap.get(scoreImport.getClassId());

                        if (courseMap == null) {

                            courseMap = new HashMap<>();
                        }

                        Map<String, List<ScoreImport>> examMethodMap = courseMap.get(scoreImport.getCourseShow());

                        if (examMethodMap == null) {

                            examMethodMap = new HashMap<>();
                        }

                        List<ScoreImport> tempList = examMethodMap.get(scoreImport.getExamMethod());

                        if (tempList == null) {

                            tempList = new ArrayList<>();
                        }

                        tempList.add(scoreImport);
                        examMethodMap.put(scoreImport.getExamMethod(), tempList);
                        courseMap.put(scoreImport.getCourseShow(), examMethodMap);
                        classMap.put(scoreImport.getClassId(), courseMap);
                        dataMap.put(scoreImport.getTermShow(), classMap);
                    }
                }

                return dataMap;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    private boolean checkStringEmpty(String str) {

        return str != null && !"".equals(str);
    }

    private boolean isNumber(Object obj) {
        if (obj instanceof Number) {
            return true;
        } else if (obj instanceof String) {
            try {
                Double.parseDouble((String) obj);
                return true;
            } catch (Exception e) {
                return false;
            }
        }
        return false;
    }

}
