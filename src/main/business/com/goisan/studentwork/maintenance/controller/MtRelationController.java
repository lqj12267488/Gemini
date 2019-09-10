package com.goisan.studentwork.maintenance.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.studentwork.maintenance.bean.MtRelation;
import com.goisan.studentwork.maintenance.bean.MtType;
import com.goisan.studentwork.maintenance.service.MtRelationService;
import com.goisan.studentwork.studentinsurance.bean.StudentInsurance;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Student;
import com.goisan.system.bean.TableDict;
import com.goisan.system.service.CommonService;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
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
 * Created  By hanjie ON 2019/9/2
 */
@Controller
public class MtRelationController {

    @Autowired
    private MtRelationService mtRelationService;

    @Autowired
    private CommonService commonService;

    @RequestMapping("/mtRelation/mtRelationList")
    public ModelAndView mtRelationList(String relType){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("relType",relType);
        modelAndView.setViewName("/business/studentwork/maintenance/mtRelationList");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/mtRelation/getMRList")
    public Map<String,Object> getMRList(MtRelation mtRelation, int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> map = new HashMap();
        List<MtRelation> list = mtRelationService.getMRList(mtRelation);
        PageInfo<List<MtType>> info = new PageInfo(list);
        map.put("draw", draw);
        map.put("recordsTotal", info.getTotal());
        map.put("recordsFiltered", info.getTotal());
        map.put("data", list);
        return map;
    }

    @RequestMapping("/mtRelation/editMR")
    public ModelAndView editMR(String relId,String relType){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("relId",relId);
        modelAndView.addObject("relType",relType);
        modelAndView.setViewName("/business/studentwork/maintenance/mtRelationDetailList");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/mtRelation/getMRDList")
    public Map<String,Object> getMRDList(MtRelation mtRelation, int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> map = new HashMap();
        List<MtRelation> list = mtRelationService.getMRListByRelId(mtRelation);
        PageInfo<List<MtType>> info = new PageInfo(list);
        map.put("draw", draw);
        map.put("recordsTotal", info.getTotal());
        map.put("recordsFiltered", info.getTotal());
        map.put("data", list);
        return map;
    }


    @RequestMapping("/mtRelation/editMRDetail")
    public ModelAndView editMRDetail(String id,String relId){
        ModelAndView modelAndView = new ModelAndView();
        MtRelation mrDetailEdit ;
        if (null!=id && !"".equals(id)){
            mrDetailEdit = mtRelationService.getMRDetailById(id);
            modelAndView.addObject("head","修改");
            modelAndView.addObject("mrDetailEdit",mrDetailEdit);
        }else {
            mrDetailEdit = new MtRelation();
            mrDetailEdit.setRelId(relId);
            modelAndView.addObject("head","新增");
            modelAndView.addObject("mrDetailEdit",mrDetailEdit);
        }
        modelAndView.setViewName("/business/studentwork/maintenance/editMtRelationDetail");
        return modelAndView;
    }


    @ResponseBody
    @RequestMapping("/mtRelation/saveMRDetail")
    public Message saveMRDetail(MtRelation mtRelation){
        if (!"".equals(mtRelation.getId())&&null!=mtRelation.getId()){
            mtRelationService.updateMRDetailById(mtRelation);
            return new Message(1,"修改成功",null);
        }else {
//            检查是否详情是否存在
            mtRelationService.insertMRDetail(mtRelation);
            return  new Message(1,"新增成功",null);
        }
    }

    @ResponseBody
    @RequestMapping("/mtRelation/delMRDetail")
    public Message delMRDetail(MtRelation mtRelation){
       mtRelationService.delMRDetailById(mtRelation);
       return new Message(1,"删除成功",null);
    }


    @ResponseBody
    @RequestMapping("/mtRelation/mtMRDetail")
    public Message mtMRDetail(MtRelation mtRelation){
        mtRelationService.mtMRDetailById(mtRelation);
        return new Message(1,"维护成功",null);
    }


    @RequestMapping("/mtRelation/importMRDetail")
    public ModelAndView importMRDetail(String relId){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/business/studentwork/maintenance/importMRDetail");
        modelAndView.addObject("relId",relId);
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/mtRelation/importData")
    public Message importData(@RequestParam(value = "file", required = false)CommonsMultipartFile file,String relId){
        int count=3;
        int rightCount = 0 ;
        int errCount = 0 ;
        StringBuilder sb = new StringBuilder();

        TableDict tableDict = new TableDict();
        tableDict.setId("MT_ID");
        tableDict.setText("MT_NAME");
        tableDict.setTableName("T_XG_MAINTENANCE_TYPE");
        tableDict.setWhere("where VALID_FLAG ='1'");
        List<Select2> mtNameList = commonService.getTableDict(tableDict);

        try {
            HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
            Boolean checkExcel = this.checkExcel(workbook);
            if (!checkExcel){
                return new Message(1,"请检查导入模板",null);
            }
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            for (int i = 2; i <= end; i++) {
                MtRelation mtRelation = new MtRelation();
                HSSFRow row = sheet.getRow(i);
                mtRelation.setRelId(relId);
                if (null == row.getCell(1) || null == row.getCell(2) || null == row.getCell(3)
                        || null == row.getCell(4) || null == row.getCell(5) ||
                        "".equals(row.getCell(1).toString()) || "".equals(row.getCell(2).toString()) || "".equals(row.getCell(3).toString())
                        || "".equals(row.getCell(4).toString()) || "".equals(row.getCell(5).toString())
                ) {
                    sb.append("第");
                    sb.append(count);
                    sb.append("行 ");
                    errCount++;
                } else {
                    mtRelation.setGoodName(row.getCell(1).toString());
                    String relName = row.getCell(2).toString();
                    for (Select2 mt : mtNameList) {
                        if (mt.getText().equals(relName)) {
                            mtRelation.setMtId(mt.getId());
                            break;
                        }
                    }
                    mtRelation.setGoodUnit(row.getCell(3).toString());
                    mtRelation.setGoodNum(row.getCell(4).toString());
                    mtRelation.setUnitPrice(row.getCell(5).toString());
                    if (null != row.getCell(6)) {
                        mtRelation.setGoodCase(row.getCell(6).toString());
                    }
                    if (null != row.getCell(7)) {
                        mtRelation.setGoodRemark(row.getCell(7).toString());
                    }
                    mtRelationService.insertMRDetail(mtRelation);
                    rightCount++;
                }
                count++;
            }
//          检查模板
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (errCount==0) {
            return new Message(1, "成功导入" + rightCount + "条", null);
        }else {
            return new Message(0,"成功导入"+ rightCount + "条\n 失败"+errCount+"条："+sb.toString()+"信息有误",null);
        }
    }


    @ResponseBody
    @RequestMapping("/mtRelation/export")
    public void exportStudentInsurance(HttpServletRequest request, HttpServletResponse response) {
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("公物维护");

//        设置字体
        HSSFFont fontHead = this.createFont(wb, 14, "宋体", false);
        HSSFFont font11 = this.createFont(wb, 11, "宋体", false);
        HSSFFont font12 = this.createFont(wb, 12, "宋体", false);
//      设置样式
        HSSFCellStyle styleHead = this.createStyle(wb, fontHead);
        HSSFCellStyle style11 = this.createStyle(wb, font11);
        HSSFCellStyle style12 = this.createStyle(wb, font12);
//        设置合并单元格
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 7));
        this.setColumnDefaultStyleAndWidth(sheet,style12);
        HSSFRow row0 = sheet.createRow(0);
        row0.setHeightInPoints(28);
        this.createCellWithStyleAndValue(row0,0,"公物维护",styleHead);

        HSSFRow row1 = sheet.createRow(1);
        row1.setHeightInPoints(28);
        this.createCellWithStyleAndValue(row1,0,"序号",style11);
        this.createCellWithStyleAndValue(row1,1,"物品名称(*)",style11);
        this.createCellWithStyleAndValue(row1,2,"公物类别(*)",style11);
        this.createCellWithStyleAndValue(row1,3,"单位(*)",style11);
        this.createCellWithStyleAndValue(row1,4,"数量(*)",style11);
        this.createCellWithStyleAndValue(row1,5,"单价(*)",style11);
        this.createCellWithStyleAndValue(row1,6,"物品使用情况",style11);
        this.createCellWithStyleAndValue(row1,7,"备注",style11);
        TableDict tableDict = new TableDict();
        tableDict.setId("MT_ID");
        tableDict.setText("MT_NAME");
        tableDict.setTableName("T_XG_MAINTENANCE_TYPE");
        tableDict.setWhere("where VALID_FLAG ='1'");
        List<Select2> mtNameList = commonService.getTableDict(tableDict);

        String[] mtNames = new String[mtNameList.size()];
        for (int j = 0; j < mtNameList.size(); j++) {
            mtNames[j] = mtNameList.get(j).getText();
        }
        setHSSFValidation(sheet, mtNames, 2, 65535, 2, 2);

        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("公物维护.xls", "utf-8"));
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


    private HSSFFont createFont (HSSFWorkbook wb, int fontSize, String fontName, Boolean bold){
        HSSFFont font = wb.createFont();
        font.setFontHeightInPoints((short) fontSize);
        font.setFontName(fontName);
        font.setBold(bold);
        return font;
    }

    private HSSFCellStyle createStyle (HSSFWorkbook wb, HSSFFont font){
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

    private void createCellWithStyleAndValue (HSSFRow row, Integer col, String value, HSSFCellStyle style){
        HSSFCell cell = row.createCell(col);
        cell.setCellValue(value);
        cell.setCellStyle(style);
    }

    private void setColumnDefaultStyleAndWidth(HSSFSheet sheet,HSSFCellStyle style){
        sheet.setColumnWidth(0,5* 256);
        sheet.setColumnWidth(1,30* 256);
        sheet.setColumnWidth(2,15* 256);
        sheet.setColumnWidth(3,10* 256);
        sheet.setColumnWidth(4,10* 256);
        sheet.setColumnWidth(5,10* 256);
        sheet.setColumnWidth(6,22* 256);
        sheet.setColumnWidth(7,30* 256);

        sheet.setDefaultRowHeightInPoints(28);
        sheet.setDefaultColumnStyle(0,style);
        sheet.setDefaultColumnStyle(1,style);
        sheet.setDefaultColumnStyle(2,style);
        sheet.setDefaultColumnStyle(3,style);
        sheet.setDefaultColumnStyle(4,style);
        sheet.setDefaultColumnStyle(5,style);
        sheet.setDefaultColumnStyle(6,style);
        sheet.setDefaultColumnStyle(7,style);
    }

    private Boolean checkExcel(HSSFWorkbook workbook){
        return workbook.getSheetName(0).contains("公物维护");
    }


//    下拉菜单
    public static void setHSSFValidation(HSSFSheet sheet, String[] textlist, int firstRow, int endRow, int firstCol, int endCol) {
        // 加载下拉列表内容
        DVConstraint constraint = DVConstraint.createExplicitListConstraint(textlist);
        // 设置数据有效性加载在哪个单元格上,四个参数分别是：起始行、终止行、起始列、终止列
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        // 数据有效性对象
        HSSFDataValidation hssfDataValidation = new HSSFDataValidation(regions, constraint);
        sheet.addValidationData(hssfDataValidation);
    }
}
