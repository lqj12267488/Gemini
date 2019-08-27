package com.goisan.educational.backboneTeacher.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.backboneTeacher.bean.BackboneTeacher;
import com.goisan.educational.backboneTeacher.service.BackboneTeacherService;
import com.goisan.system.bean.CommonBean;
import com.goisan.system.bean.UserDic;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BackboneTeacherController {
    @Resource
    BackboneTeacherService backboneTeacherService;

    /**
     * 骨干教师页面跳转
     * @return
     */
    @RequestMapping("/backboneTeacher")
    public ModelAndView backboneTeacherList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/backboneTeacher/backboneTeacher");
        return mv;
    }


    /**
     * 骨干教师首页数据查询
     * @param backboneTeacher
     * @return
     */
    @ResponseBody
    @RequestMapping("/backboneTeacher/backboneTeacherAction")
    public Map<String, Object> getBackboneTeacherList(BackboneTeacher backboneTeacher,int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String,Object> backboneTeacherList = new HashMap<String, Object>();
        List<BackboneTeacher> list = backboneTeacherService.backboneTeacherAction(backboneTeacher);
        PageInfo<List<BackboneTeacher>> info = new PageInfo(list);
        backboneTeacherList.put("draw", draw);
        backboneTeacherList.put("recordsTotal", info.getTotal());
        backboneTeacherList.put("recordsFiltered", info.getTotal());
        backboneTeacherList.put("data", list);
        //backboneTeacherMap.put("data", backboneTeacherService.backboneTeacherAction(backboneTeacher));
        return backboneTeacherList;
    }

    @ResponseBody
    @RequestMapping("/backboneTeacher/addBackboneTeacher")
    public ModelAndView addBackboneTeacher(String id , String type) {
        ModelAndView mv = new ModelAndView("/business/educational/backboneTeacher/editBackboneTeacher");
        if(id==""||id==null){
            mv.addObject("head", "新增");
        }else{
            mv.addObject("head", "修改");
            BackboneTeacher backboneTeacher= backboneTeacherService.getBackboneTeacherById(id);
            mv.addObject("backboneTeacher",backboneTeacher);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/backboneTeacher/updateBackboneTeacherById")
    public Message updateBackboneTeacher(BackboneTeacher backboneTeacher) {
        if (backboneTeacher.getId() == null || backboneTeacher.equals("") || backboneTeacher.getId() == "") {
            backboneTeacher.setCreator(CommonUtil.getPersonId());
            backboneTeacher.setCreateDept(CommonUtil.getDefaultDept());
            backboneTeacherService.insertBackboneTeacher(backboneTeacher);
            return new Message(1, "新增成功！", null);
        } else {
            backboneTeacher.setChanger(CommonUtil.getPersonId());
            backboneTeacher.setChangeDept(CommonUtil.getDefaultDept());
            backboneTeacherService.updateBackboneTeacherById(backboneTeacher);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/backboneTeacher/deleteBackboneTeacherById")
    public Message deleteBackboneTeacherById(String id) {
        backboneTeacherService.deleteBackboneTeacherById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/backboneTeacher/exportBackboneTeacher")
    public void exportRepair(HttpServletRequest request, HttpServletResponse response) {
        BackboneTeacher backboneTeacher = new BackboneTeacher();
        List<BackboneTeacher> list = backboneTeacherService.backboneTeacherAction(backboneTeacher);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("专业骨干教师表");
        CellStyle cellStyle0 = wb.createCellStyle();
        cellStyle0.setAlignment(HorizontalAlignment.CENTER);
        cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle0.setWrapText(true);
        HSSFFont font = wb.createFont();
        font.setFontHeightInPoints((short) 26);
        font.setFontName("宋体");
        cellStyle0.setFont(font);

        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 7));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 7));

        //创建HSSFRow对象

        Row row0 = sheet.createRow(0);
        Cell cell00 = row0.createCell(0);
        String xxmc= CommonBean.getParamValue("SZXXMC");
        cell00.setCellValue(xxmc);
        cell00.setCellStyle(cellStyle0);
        Row row1 = sheet.createRow(1);
        Cell cell10 = row1.createCell(0);
        cell10.setCellValue("骨干教师情况统计表");
        cell10.setCellStyle(cellStyle0);
        sheet.setColumnWidth(0, 15 * 256);
        sheet.setColumnWidth(1, 20 * 256);
        sheet.setColumnWidth(2, 20 * 256);
        sheet.setColumnWidth(3, 20 * 256);
        sheet.setColumnWidth(4, 20 * 256);
        sheet.setColumnWidth(5, 20 * 256);
        sheet.setColumnWidth(6, 20 * 256);
        sheet.setColumnWidth(7, 20 * 256);
        int tmp = 2;
        HSSFRow row2 = sheet.createRow(tmp);
        //创建HSSFCell对象   会员姓名	部门	会员编号	工会职务	入会时间    备注
        row2.createCell(0).setCellValue("序号");
        row2.createCell(1).setCellValue("系部");
        row2.createCell(2).setCellValue("专业");
        row2.createCell(3).setCellValue("教师姓名");
        row2.createCell(4).setCellValue("性别");
        row2.createCell(5).setCellValue("出生日期");
        row2.createCell(6).setCellValue("所学专业");
        row2.createCell(7).setCellValue("任教课程");
        tmp++;
        int i = 1;
        for (BackboneTeacher textBookObj : list) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(textBookObj.getDepartmentId());
            row.createCell(2).setCellValue(textBookObj.getMajorCode());
            row.createCell(3).setCellValue(textBookObj.getTeacherId());
            row.createCell(4).setCellValue(textBookObj.getSex());
            row.createCell(5).setCellValue(textBookObj.getBirthday());
            row.createCell(6).setCellValue(textBookObj.getStudyMajor());
            row.createCell(7).setCellValue(textBookObj.getCourseId());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("专业骨干教师表.xls", "utf-8"));
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
