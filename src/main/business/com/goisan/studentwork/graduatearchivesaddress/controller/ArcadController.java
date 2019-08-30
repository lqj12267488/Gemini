package com.goisan.studentwork.graduatearchivesaddress.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.studentwork.graduatearchivesaddress.bean.Arcad;
import com.goisan.studentwork.graduatearchivesaddress.service.ArcadServcie;
import com.goisan.studentwork.studentinsurance.bean.StudentInsurance;
import com.goisan.system.bean.Student;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created  By hanjie ON 2019/8/29
 */
@Controller
public class ArcadController {

    @Autowired
    private ArcadServcie arcadServcie;

    @RequestMapping("/acrad/acradList")
    public String acradList(){
        return "/business/studentwork/graduatearchivesaddress/arcadList";
    }


    @ResponseBody
    @RequestMapping("/arcad/getArcadList")
    public Map<String,Object> getArcadList(Arcad arcad, int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> insurances = new HashMap();
        List<Arcad> list = arcadServcie.getArcadList(arcad);
        PageInfo<List<Student>> info = new PageInfo(list);
        insurances.put("draw", draw);
        insurances.put("recordsTotal", info.getTotal());
        insurances.put("recordsFiltered", info.getTotal());
        insurances.put("data", list);
        return insurances;
    }

    @RequestMapping("/arcad/editArcad")
    public ModelAndView editArcad(Arcad arcad){
        ModelAndView modelAndView = new ModelAndView();
        if (!"".equals(arcad.getArcadId())&&null!=arcad.getArcadId()){
            Arcad arcadEdit = arcadServcie.getArcadById(arcad.getArcadId());
            modelAndView.addObject("head", "修改");
            modelAndView.addObject("arcadEdit", arcadEdit);
        }else {
            modelAndView.addObject("head", "新增");
        }
        modelAndView.setViewName("/business/studentwork/graduatearchivesaddress/editArcad");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/arcad/saveArcad")
    public Message saveArcad(Arcad arcad){
        if (!"".equals(arcad.getArcadId())&&null!=arcad.getArcadId()){
            arcadServcie.updateArcadById(arcad);
            return new Message(1,"修改成功",null);
        }else {
            arcadServcie.insertArcad(arcad);
            return new Message(1,"保存成功",null);
        }
    }

    @ResponseBody
    @RequestMapping("/arcad/delArcad")
    public Message delArcad(Arcad arcad){
        arcadServcie.delArcadById(arcad);
        return new Message(1,"删除成功","success");
    }

    //    导出以及导出模板
    @RequestMapping("/arcad/importArcadTemplate")
    public void exportArcad(HttpServletRequest request, HttpServletResponse response) {
        HSSFWorkbook wb = new HSSFWorkbook();
        String export = request.getParameter("export");
        HSSFSheet sheet = wb.createSheet("新疆现代职业技术学院档案接收地址");
        String fileName = "新疆现代职业技术学院档案接收地址";
//        设置字体
        HSSFFont fontHead = this.createFont(wb, 14, "宋体", false);
        HSSFFont font11 = this.createFont(wb, 11, "宋体", false);
        HSSFFont font12 = this.createFont(wb, 12, "宋体", false);
//      设置样式
        HSSFCellStyle styleHead = this.createStyle(wb, fontHead);
        HSSFCellStyle style11;
        HSSFCellStyle style12;
        if (null==export) {
           style11 = this.createStyle(wb, font11);
           style12 = this.createStyle(wb, font12);
        }else {
            style11 = this.createBorderStyle(wb, font11);
            style12 = this.createBorderStyle(wb, font12);
        }
//        设置合并单元格
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 4));

        this.setColumnDefaultStyleAndWidth(sheet,style12);

        HSSFRow row0 = sheet.createRow(0);
        row0.setHeightInPoints(28);
        this.createCellWithStyleAndValue(row0,0,fileName,styleHead);
        HSSFRow row1 = sheet.createRow(1);
        row1.setHeightInPoints(28);
        this.createCellWithStyleAndValue(row1,0,"序号",style11);
        this.createCellWithStyleAndValue(row1,1,"省",style11);
        this.createCellWithStyleAndValue(row1,2,"市",style11);
        this.createCellWithStyleAndValue(row1,3,"区县",style11);
        this.createCellWithStyleAndValue(row1,4,"详细地址",style11);

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

    private HSSFFont createFont ( HSSFWorkbook wb,int fontSize,String fontName,Boolean bold){
        HSSFFont font = wb.createFont();
        font.setFontHeightInPoints((short) fontSize);
        font.setFontName(fontName);
        font.setBold(bold);
        return font;
    }

    private HSSFCellStyle createStyle (HSSFWorkbook wb,HSSFFont font){
        HSSFCellStyle cellStyle = wb.createCellStyle();
        cellStyle.setFont(font);
        cellStyle.setWrapText(true);
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        return cellStyle;
    }

    private HSSFCellStyle createBorderStyle (HSSFWorkbook wb,HSSFFont font){
        HSSFCellStyle cellStyle = wb.createCellStyle();
        cellStyle.setFont(font);
        cellStyle.setWrapText(true);
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        return cellStyle;
    }

    private void createCellWithStyleAndValue (HSSFRow row,Integer col,String value,HSSFCellStyle style){
        HSSFCell cell = row.createCell(col);
        cell.setCellValue(value);
        cell.setCellStyle(style);
    }

    private void setColumnDefaultStyleAndWidth(HSSFSheet sheet,HSSFCellStyle style){
        sheet.setColumnWidth(0,5* 256);
        sheet.setColumnWidth(1,33* 256);
        sheet.setColumnWidth(2,33* 256);
        sheet.setColumnWidth(3,33* 256);
        sheet.setColumnWidth(4,33* 256);
        sheet.setDefaultRowHeightInPoints(28);
        sheet.setDefaultColumnStyle(0,style);
        sheet.setDefaultColumnStyle(1,style);
        sheet.setDefaultColumnStyle(2,style);
        sheet.setDefaultColumnStyle(3,style);
        sheet.setDefaultColumnStyle(4,style);
    }

    private Boolean checkExcel(HSSFWorkbook workbook){
        return workbook.getSheetName(0).contains("新疆现代职业技术学院社保缴费名单");
    }
}
