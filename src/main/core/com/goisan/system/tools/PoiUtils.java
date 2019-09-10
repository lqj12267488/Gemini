package com.goisan.system.tools;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;

public class PoiUtils {

    /**
     * 设置表格边框
     * @param wb
     * @param sheet
     * @param sartRow   起始行号
     * @param endRow    结束行号
     * @param cols      列数
     * @param height    行高（不设置放0）
     * @param font      字体（不设置null）
     * @throws Exception
     */
    public static  void setBorder(HSSFWorkbook wb, Sheet sheet, int sartRow, int endRow, int cols, short height, Font font) throws Exception{
        HSSFCellStyle style = wb.createCellStyle();
        //设置边框样式
        style.setBorderBottom(BorderStyle.THIN);
        style.setBorderLeft(BorderStyle.THIN);
        style.setBorderRight(BorderStyle.THIN);
        style.setBorderTop(BorderStyle.THIN);
        //设置边框颜色
        style.setTopBorderColor(HSSFColor.BLACK.index);
        style.setBottomBorderColor(HSSFColor.BLACK.index);
        style.setLeftBorderColor(HSSFColor.BLACK.index);
        style.setRightBorderColor(HSSFColor.BLACK.index);
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        style.setWrapText(true);//文本区域随内容多少自动调整
        //表格字体
        if (font != null){
            style.setFont(font);
        }
        //单元格为文本
        HSSFDataFormat format = wb.createDataFormat();
        style.setDataFormat(format.getFormat("@"));

        Row row;
        Cell cell;
        for(int j=sartRow; j<=endRow; j++){
            row = sheet.getRow(j);
            if(row != null){
                if (height != 0){
                    row.setHeight(height);
                }
                for(int i=0;i<cols;i++){
                    cell = row.getCell(i)==null ? row.createCell(i) : row.getCell(i);
                    cell.setCellStyle(style);
                }
            }
        }
    }
}
