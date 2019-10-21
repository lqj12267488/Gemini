package com.goisan.system.tools;

import com.goisan.system.bean.Select2;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class PoiUtils {

    private static final String FONTNAME_SONG = "宋体";

    private static final Short FONTSIZE_SONG = 12;

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

    /**
     * 导出文件
     * @param wb
     * @param fileName 导出文件名
     * @param response
     */
    public static void outFile(HSSFWorkbook wb, String fileName, HttpServletResponse response){
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    (fileName+".xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.close();
                }
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 设置字体
     * @param wb
     * @param fontSize
     * @param fontName 字体名
     * @param bold 是否加粗
     * @return
     */
    public static HSSFFont createFont (HSSFWorkbook wb, int fontSize, String fontName, Boolean bold,Short color){
        HSSFFont font = wb.createFont();
        font.setFontHeightInPoints((short) fontSize);
        font.setFontName(fontName);
        font.setBold(bold);
        if (null!=color) {
            font.setColor(color);
        }
        return font;
    }

    /**
     *
     * @param wb
     * @param bold 是否加粗
     * @return
     */
    public static HSSFFont createDefaultFont (HSSFWorkbook wb,Boolean bold){
        HSSFFont font = wb.createFont();
        font.setFontHeightInPoints(FONTSIZE_SONG);
        font.setFontName(FONTNAME_SONG);
        font.setBold(bold);
        return font;
    }

    /**
     *
     * @param wb
     * @param font
     * @param border 是否设置边框
     * @return
     */
    public static HSSFCellStyle createStyle (HSSFWorkbook wb,HSSFFont font,Boolean border){
        HSSFCellStyle cellStyle = wb.createCellStyle();
        cellStyle.setFont(font);
        cellStyle.setWrapText(true);
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
//        设置边框
        if (border) {
            cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
            cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
            cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        }
        return cellStyle;
    }




    /**
     * 单元格赋值，赋样式
     * @param row 单元格所在行
     * @param col 单元格所在列
     * @param value 单元格值
     * @param style 单元格样式
     */
    public static void createCellWithStyleAndValue (HSSFRow row, Integer col, String value, HSSFCellStyle style){
//       createCell生成单元格
        HSSFCell cell = row.createCell(col);
//       setCellValue 设置单元格的值
        cell.setCellValue(value);
//        设置 单元格样式
        cell.setCellStyle(style);
    }

    /**
     * 设置下拉菜单
     * @param sheet
     * @param textlist
     * @param firstRow
     * @param endRow
     * @param firstCol
     * @param endCol
     */
    public static void setHSSFValidation(HSSFSheet sheet, String[] textlist, int firstRow, int endRow, int firstCol, int endCol) {
        // 加载下拉列表内容
        DVConstraint constraint = DVConstraint.createExplicitListConstraint(textlist);
        // 设置数据有效性加载在哪个单元格上,四个参数分别是：起始行、终止行、起始列、终止列
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        // 数据有效性对象
        HSSFDataValidation hssfDataValidation = new HSSFDataValidation(regions, constraint);
        sheet.addValidationData(hssfDataValidation);
    }

    public static String cellValue(HSSFCell cell){
        if (null!=cell){
            return cell.toString();
        }else {
            return null;
        }
    }

    /**
     * 获取date类型的cell
     * @param cell
     * @return
     */
    public static String cellDateValue(HSSFCell cell){
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        if (null!=cell){
            return  format.format(cell.getDateCellValue());
        }else {
            return null;
        }
    }

    /**
     * 获取下拉菜单的值
     * @param list
     * @param cell
     * @return
     */
    public static String cellSelectValue(List<Select2> list,HSSFCell cell){
        String target = null;
        if (null!=cell){
            for (Select2 select2:list) {
                if (select2.getText().equals(cell.toString())){
                    target = select2.getId();
                    break;
                }
            }
            return target;
        }else {
            return target;
        }
    }

    /**
     * 导入文件名是否正确
     */
    public static Boolean checkFile(String sheetName,String trueName){
        return sheetName.contains(trueName)?true:false;
    }

    /**
     * 根据url 创建Workbook
     * @param path
     * @return
     * @throws FileNotFoundException
     * @throws IOException
     */
    public static Workbook buildWorkbook(String path) throws FileNotFoundException, IOException{
        Workbook wb = null;
        if (path.endsWith(".xls")){
            wb = (Workbook) new HSSFWorkbook(new FileInputStream(path));
        } else if (path.endsWith(".xlsx")){
            wb = (Workbook) new XSSFWorkbook(new FileInputStream(path));
        }
        return wb;
    }

}
