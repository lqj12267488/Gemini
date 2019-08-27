package com.goisan.educational.textbook.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.textbook.bean.TextBook;
import com.goisan.educational.textbook.bean.TextBookLog;
import com.goisan.educational.textbook.service.TextBookLogService;
import com.goisan.educational.textbook.service.TextBookService;
import com.goisan.system.bean.Student;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.system.tools.ZipUtils;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class TextBookLogController {
    @Resource
    private TextBookLogService textBookLogService;
    @Resource
    private TextBookService textBookService;

    /**
     * @Description 库存管理列表页
     * @author FanNing
     * @date 2017-10-26
     */
    @RequestMapping("/textBookInventoryList")
    public ModelAndView textBookList() {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/textBookInventory");
        return mv;
    }

    /**
     * 库存管理list
     *
     * @param draw
     * @param start
     * @param length
     * @return
     */
    @ResponseBody
    @RequestMapping("/getTextBookInventory")
    public Map<String, Object> getTextBookInventory(TextBook textBook, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> textBookLogList = new HashMap<String, Object>();
        List<TextBook> list = textBookLogService.getTextBookInventory(textBook);
        PageInfo<List<TextBookLog>> info = new PageInfo(list);
        textBookLogList.put("draw", draw);
        textBookLogList.put("recordsTotal", info.getTotal());
        textBookLogList.put("recordsFiltered", info.getTotal());
        textBookLogList.put("data", list);
        return textBookLogList;
    }

    /**
     * 教材详情
     *
     * @param id
     * @return
     */
    @RequestMapping("/textBookLogList")
    public ModelAndView TextBookLogList(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/textBookInventoryList");
        mv.addObject("head","教材入库记录");
        mv.addObject("id",id);
        return mv;
    }
    /**
     * @param textBookLog
     * @Description 入库记录管理list
     * @author FanNing
     * @date 2017-10-26
     */
    @ResponseBody
    @RequestMapping("/getTextBookInventoryList")
    public Map<String, Object> getTextBookLogList(TextBookLog textBookLog, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> textBookLogList = new HashMap<String, Object>();
        textBookLog.setOperationType("1");
        List<TextBookLog> list = textBookLogService.textBookInventoryLog(textBookLog);
        PageInfo<List<TextBookLog>> info = new PageInfo(list);
        textBookLogList.put("draw", draw);
        textBookLogList.put("recordsTotal", info.getTotal());
        textBookLogList.put("recordsFiltered", info.getTotal());
        textBookLogList.put("data", list);
        return textBookLogList;
    }

    /**
     * @param textBookLog
     * @Description 库存管理查询
     * @author FanNing
     * @date 2017-10-26
     */
    @ResponseBody
    @RequestMapping("/searchTextBookInventory")
    public Map<String, List<TextBookLog>> searchTextBookInventory(TextBookLog textBookLog) {
        Map<String, List<TextBookLog>> textBookLogMap = new HashMap<String, List<TextBookLog>>();
        textBookLog.setOperationType("1");
        textBookLogMap.put("data", textBookLogService.textBookInventoryLog(textBookLog));
        return textBookLogMap;
    }

    /**
     * @Description 教材入库页面
     * @author FanNing
     * @date 2017-10-26
     */
    @ResponseBody
    @RequestMapping("/addTextBookInventory")
    public ModelAndView addTextBookInventory(String textbookId, String textbookNumIn) {
        ModelAndView mv = new ModelAndView("/business/educational/textbook/addTextBookInventory");
        TextBookLog textBookLog = new TextBookLog();
        TextBook textBook =textBookService.getTextBookById(textbookId);
        textBookLog.setTextbookName(textBook.getTextbookName());
        textBookLog.setRemark(textBook.getRemark());
        textBookLog.setTextbookId(textbookId);
        textBookLog.setTextbookNumIn(textbookNumIn);
        mv.addObject("head", "教材入库");
        mv.addObject("textBookLog", textBookLog);
        return mv;
    }

    /**
     * @param textBookLog
     * @Description 教材入库保存方法
     * @author FanNing
     * @date 2017-10-26
     */
    @ResponseBody
    @RequestMapping("/saveTextBookInventory")
    public Message saveTextBookInventory(TextBookLog textBookLog) {
        textBookLog.setChanger(CommonUtil.getPersonId());
        textBookLog.setChangeDept(CommonUtil.getDefaultDept());
        textBookLogService.updateTextBookNum(textBookLog);
        textBookLog.setCreator(CommonUtil.getPersonId());
        textBookLog.setCreateDept(CommonUtil.getDefaultDept());
        textBookLog.setOperationType("1");
        textBookLogService.insertTextBookLog(textBookLog);
        return new Message(1, "入库成功！", null);
    }


    /**
     * @param request
     * @param response
     * @Description 教材入库信息表导出
     * @author FanNing
     */
    @ResponseBody
    @RequestMapping("/exportTextBookInventory")
    public void exportTextBookInventory(HttpServletRequest request, HttpServletResponse response) {
        TextBookLog textBookLog = new TextBookLog();
        textBookLog.setOperationType("1");
        List<TextBookLog> textBookLogList = textBookLogService.textBookInventoryLog(textBookLog);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("教材入库信息表");
        sheet.setVerticallyCenter(true);

        //下面样式可作为导出左右分栏的表格模板
        sheet.setColumnWidth((short) 0, (short) 1500);// 设置列宽
        sheet.setColumnWidth((short) 1, (short) 6000);
        sheet.setColumnWidth((short) 2, (short) 2500);
        sheet.setColumnWidth((short) 3, (short) 2500);
        sheet.setColumnWidth((short) 4, (short) 8000);
        sheet.setColumnWidth((short) 5, (short) 5000);// 空列设置小一些

        int tmp = 0;
        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("教材名称");
        row1.createCell(2).setCellValue("操作类型");
        row1.createCell(3).setCellValue("入库数量");
        row1.createCell(4).setCellValue("操作时间");
        row1.createCell(5).setCellValue("备注");
        tmp++;
        int i = 1;
        for (TextBookLog textBookLogObj : textBookLogList) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(textBookLogObj.getTextbookId());
            row.createCell(2).setCellValue(textBookLogObj.getOperationType());
            row.createCell(3).setCellValue(textBookLogObj.getOperationNum());
            row.createCell(4).setCellValue(textBookLogObj.getOperationTime());
            row.createCell(5).setCellValue(textBookLogObj.getRemark());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("教材入库信息表.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 导出当前教材入库数据
     * @param textbookName
     * @param textbookNumber
     * @param textbookNature
     * @param response
     */
    @RequestMapping("/exportTextBookListInventory")
    public void exportTextBookListInventory(String textbookName, String textbookNumber, String textbookNature, HttpServletResponse response) {
        TextBook textBook = new TextBook();
        textBook.setTextbookName(textbookName);
        textBook.setTextbookNumber(textbookNumber);
        textBook.setTextbookNature(textbookNature);
        List<TextBook> list = textBookLogService.getTextBookInventory(textBook);
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("教材入库信息表");
        sheet.setVerticallyCenter(true);

        //下面样式可作为导出左右分栏的表格模板
        sheet.setColumnWidth((short) 0, (short) 1500);// 设置列宽
        sheet.setColumnWidth((short) 1, (short) 6000);
        sheet.setColumnWidth((short) 2, (short) 2500);
        sheet.setColumnWidth((short) 3, (short) 2500);
        sheet.setColumnWidth((short) 4, (short) 8000);
        sheet.setColumnWidth((short) 5, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 6, (short) 5000);
        sheet.setColumnWidth((short) 7, (short) 5000);
        sheet.setColumnWidth((short) 8, (short) 5000);
        sheet.setColumnWidth((short) 9, (short) 5000);
        sheet.setColumnWidth((short) 10, (short) 5000);
        sheet.setColumnWidth((short) 11, (short) 5000);

        int tmp = 0;
        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("教材名称");
        row1.createCell(2).setCellValue("教材编号");
        row1.createCell(3).setCellValue("教材性质");
        row1.createCell(4).setCellValue("教材类型");
        row1.createCell(5).setCellValue("出版社");
        row1.createCell(6).setCellValue("第一主编单位");
        row1.createCell(7).setCellValue("主编");
        row1.createCell(8).setCellValue("版次");
        row1.createCell(9).setCellValue("征订代号");
        row1.createCell(10).setCellValue("版本日期");
        row1.createCell(11).setCellValue("单价");
        row1.createCell(12).setCellValue("在库数量");
        row1.createCell(13).setCellValue("备注");
        tmp++;
        int i = 1;
        for (TextBook textBookLogObj : list) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(textBookLogObj.getTextbookName());
            row.createCell(2).setCellValue(textBookLogObj.getTextbookNumber());
            row.createCell(3).setCellValue(textBookLogObj.getTextbookNature());
            row.createCell(4).setCellValue(textBookLogObj.getTextbookCategory());
            row.createCell(5).setCellValue(textBookLogObj.getPublishingHouse());
            row.createCell(6).setCellValue(textBookLogObj.getFirstEditorCompany());
            row.createCell(7).setCellValue(textBookLogObj.getEditor());
            row.createCell(8).setCellValue(textBookLogObj.getEdition());
            row.createCell(9).setCellValue(textBookLogObj.getSubscribeCode());
            row.createCell(10).setCellValue(textBookLogObj.getVersionDate());
            row.createCell(11).setCellValue(textBookLogObj.getPrice());
            row.createCell(12).setCellValue(textBookLogObj.getTextbookNumIn());
            row.createCell(13).setCellValue(textBookLogObj.getRemark());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("教材入库信息表.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

       @RequestMapping("/exportTextBookListIds")
    public void exportTextBookListIds(String ids, HttpServletResponse response) {
        List<TextBook> list = textBookLogService.getTextBookByIds(ids);
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("教材入库信息表");
        sheet.setVerticallyCenter(true);

        //下面样式可作为导出左右分栏的表格模板
        sheet.setColumnWidth((short) 0, (short) 1500);// 设置列宽
        sheet.setColumnWidth((short) 1, (short) 6000);
        sheet.setColumnWidth((short) 2, (short) 2500);
        sheet.setColumnWidth((short) 3, (short) 2500);
        sheet.setColumnWidth((short) 4, (short) 8000);
        sheet.setColumnWidth((short) 5, (short) 5000);// 空列设置小一些
        sheet.setColumnWidth((short) 6, (short) 5000);
        sheet.setColumnWidth((short) 7, (short) 5000);
        sheet.setColumnWidth((short) 8, (short) 5000);
        sheet.setColumnWidth((short) 9, (short) 5000);
        sheet.setColumnWidth((short) 10, (short) 5000);
        sheet.setColumnWidth((short) 11, (short) 5000);

        int tmp = 0;
        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("教材名称");
        row1.createCell(2).setCellValue("教材编号");
        row1.createCell(3).setCellValue("教材性质");
        row1.createCell(4).setCellValue("教材类型");
        row1.createCell(5).setCellValue("出版社");
        row1.createCell(6).setCellValue("第一主编单位");
        row1.createCell(7).setCellValue("主编");
        row1.createCell(8).setCellValue("版次");
        row1.createCell(9).setCellValue("征订代号");
        row1.createCell(10).setCellValue("版本日期");
        row1.createCell(11).setCellValue("单价");
        row1.createCell(12).setCellValue("在库数量");
        row1.createCell(13).setCellValue("备注");
        tmp++;
        int i = 1;
        for (TextBook textBookLogObj : list) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(textBookLogObj.getTextbookName());
            row.createCell(2).setCellValue(textBookLogObj.getTextbookNumber());
            row.createCell(3).setCellValue(textBookLogObj.getTextbookNature());
            row.createCell(4).setCellValue(textBookLogObj.getTextbookCategory());
            row.createCell(5).setCellValue(textBookLogObj.getPublishingHouse());
            row.createCell(6).setCellValue(textBookLogObj.getFirstEditorCompany());
            row.createCell(7).setCellValue(textBookLogObj.getEditor());
            row.createCell(8).setCellValue(textBookLogObj.getEdition());
            row.createCell(9).setCellValue(textBookLogObj.getSubscribeCode());
            row.createCell(10).setCellValue(textBookLogObj.getVersionDate());
            row.createCell(11).setCellValue(textBookLogObj.getPrice());
            row.createCell(12).setCellValue(textBookLogObj.getTextbookNumIn());
            row.createCell(13).setCellValue(textBookLogObj.getRemark());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("教材入库信息表.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

}