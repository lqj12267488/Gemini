package com.goisan.educational.score.tools;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;

import java.io.OutputStream;
import java.util.LinkedList;
import java.util.List;

/**
 * @function:
 * @author: ZhangHao
 * @date: 2018/11/18
 */
public class ExportFailCount {

    public boolean writeOutFailCount(List<MakeupCount> makeupCountList, OutputStream os, String titleName, String sheetName){

        try {

            if(os != null && checkStringEmpty(titleName) && checkStringEmpty(sheetName)){

                HSSFWorkbook workbook = new HSSFWorkbook();
                workbook.createSheet(sheetName);
                HSSFSheet sheet = workbook.getSheet(sheetName);

                this.readTitle(workbook, sheet, titleName);
                this.readExcelTr(workbook, sheet);
                this.readData(workbook, sheet, makeupCountList);

                workbook.write(os);
            }

        } catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }

    private boolean readTitle(HSSFWorkbook workbook, HSSFSheet sheet, String titleName){

        try {

            sheet.addMergedRegion(new CellRangeAddress(0,0,0,6));//合并单元格

            HSSFRow row1= sheet.createRow(0);

            row1.setHeight((short) 800);

            HSSFCell cell1 = row1.createCell(0);
            HSSFCellStyle titleStyle = workbook.createCellStyle();
            titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

            HSSFFont titleFont  = workbook.createFont();
            titleFont.setFontName("宋体");
            titleFont.setFontHeightInPoints((short) 12);
            titleFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            titleStyle.setFont(titleFont);

            cell1.setCellStyle(titleStyle);
            cell1.setCellValue(titleName);

            return true;

        }catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }

    private boolean readExcelTr(HSSFWorkbook workbook, HSSFSheet sheet){

        try {

            HSSFCellStyle trStyle = workbook.createCellStyle();//生成样式

            trStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
            trStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中

            trStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
            trStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
            trStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
            trStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框

            HSSFFont trFont  = workbook.createFont();//生成字体

            trFont.setFontName("宋体");//字体样式
            trFont.setFontHeightInPoints((short) 12);//字体大小
            trFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
            trStyle.setFont(trFont);//装配字体

            HSSFRow row1 = sheet.createRow(1);

            row1.setHeight((short) 800);

            List<String> title_cn_list = this.getCnTrList();

            for(int i = 0; i < title_cn_list.size(); i++){

                HSSFCell cell = row1.createCell(i);

                cell.setCellStyle(trStyle);
                cell.setCellValue(title_cn_list.get(i));

                sheet.autoSizeColumn(i);
            }

        } catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }

    private void readData(HSSFWorkbook workbook, HSSFSheet sheet, List<MakeupCount> makeupCountList){

        try {

            if(workbook != null && sheet != null){

                HSSFCellStyle style = workbook.createCellStyle();//生成样式

                style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
                style.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中

                style.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
                style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
                style.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
                style.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框

                HSSFFont trFont  = workbook.createFont();//生成字体

                trFont.setFontName("宋体");//字体样式
                trFont.setFontHeightInPoints((short) 12);//字体大小
                style.setFont(trFont);//装配字体

                if(makeupCountList != null && makeupCountList.size() > 0){

                    for(int i = 0; i < makeupCountList.size(); i++){

                        MakeupCount makeupCount = makeupCountList.get(i);

                        if(makeupCount != null){

                            HSSFRow row = sheet.createRow(i+2);
                            row.setHeight((short) 285);

                            HSSFCell cell = row.createCell(0);
                            cell.setCellValue(i+1);
                            cell.setCellStyle(style);

                            cell = row.createCell(1);
                            cell.setCellValue(makeupCount.getStudentNum());
                            cell.setCellStyle(style);

                            cell = row.createCell(2);
                            cell.setCellValue(makeupCount.getStudentName());
                            cell.setCellStyle(style);

                            cell = row.createCell(3);
                            cell.setCellValue(makeupCount.getClassName());
                            cell.setCellStyle(style);

                            cell = row.createCell(4);
                            cell.setCellValue(makeupCount.getCourseNum());
                            cell.setCellStyle(style);

                            cell = row.createCell(5);
                            cell.setCellValue(makeupCount.getFailNum());
                            cell.setCellStyle(style);

                            cell = row.createCell(6);
                            cell.setCellValue(makeupCount.getKaoShiNum());
                            cell.setCellStyle(style);
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
            }

        } catch (Exception e) {

            e.printStackTrace();
        }
    }

    private List<String> getCnTrList(){

        List<String> title_cn_list = new LinkedList<>();

        title_cn_list.add("序号");
        title_cn_list.add("学号");
        title_cn_list.add("姓名");
        title_cn_list.add("班级");
        title_cn_list.add("本学期科目数");
        title_cn_list.add("补考后不及格科目数");
        title_cn_list.add("考试课不过科目数");

        return title_cn_list;
    }

    private boolean checkStringEmpty(String str){

        return str!=null && !"".equals(str);
    }
}
