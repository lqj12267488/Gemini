package com.goisan.studentwork.onlineregister.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.studentwork.onlineregister.bean.OnlineRegister;
import com.goisan.studentwork.onlineregister.service.OnlineRegisterService;
import com.goisan.system.bean.PathBean;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class OnlineRegisterController {

    @Resource
    private OnlineRegisterService onlineRegisterService;

    @RequestMapping("/onlineregister/toOnlineRegisterList")
    public String toList(Model model, String type, String origin) {
        model.addAttribute("type", type);
        model.addAttribute("origin", origin);
        model.addAttribute("allYear", onlineRegisterService.getAllYear());
        return "/business/studentwork/onlineregister/onlineRegisterList";
    }

    @ResponseBody
    @RequestMapping("/onlineregister/getOnlineRegisterList")
    public Map<String,Object> getList(OnlineRegister onlineRegister, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> result = new HashMap();
        List<OnlineRegister> list = onlineRegisterService.getOnlineRegisterList(onlineRegister);
        PageInfo<List<OnlineRegister>> info = new PageInfo(list);
        result.put("draw", draw);
        result.put("recordsTotal", info.getTotal());
        result.put("recordsFiltered", info.getTotal());
        result.put("data", list);
        return result;
    }

    @RequestMapping("/onlineregister/signUp")
    public String toAdd(Model model, String type) {
        model.addAttribute("type", type);
        return "/business/studentwork/onlineregister/signUp";
    }

    @ResponseBody
    @RequestMapping("/onlineregister/saveOnlineRegister")
    public Message save(OnlineRegister onlineRegister, @RequestParam(value = "file_img", required = false) MultipartFile img
            , @RequestParam(value = "file_idcardImg", required = false) MultipartFile idcardImg
            , @RequestParam(value = "file_examinationImg", required = false) MultipartFile examinationImg
            , @RequestParam(value = "file_scoreImg", required = false) MultipartFile scoreImg
            , @RequestParam(value = "file_hukouImg", required = false) MultipartFile[] hukouImg
            , @RequestParam(value = "file_graduatedImg", required = false) MultipartFile[] graduatedImg) {
        onlineRegisterService.saveOnlineRegister(onlineRegister, img, idcardImg, examinationImg, scoreImg, hukouImg, graduatedImg);
        return new Message(0, "添加成功！", null);
    }

    @RequestMapping("/onlineregister/toOnlineRegisterEdit")
    public String toEdit(String id, Model model) {
        OnlineRegister onlineRegister = onlineRegisterService.getOnlineRegisterById(id);
        model.addAttribute("data", onlineRegister);
        if ("0".equals(onlineRegister.getAuditFlag())){
            model.addAttribute("head", "报名审核");
        }else {
            model.addAttribute("head", "查看");
        }
        return "/business/studentwork/onlineregister/onlineRegisterEdit";
    }

    @ResponseBody
    @RequestMapping("/onlineregister/delOnlineRegister")
    public Message del(String id) {
        onlineRegisterService.delOnlineRegister(id);
        return new Message(0, "删除成功！", null);
    }

    //身份证校验
    @ResponseBody
    @RequestMapping(value = "/onlineregister/getRegisterByIDCard",produces = {"text/html;charset=utf-8"})
    public String getRegisterByIDCard(OnlineRegister onlineRegister) {
        List<OnlineRegister> list = onlineRegisterService.getRegisterByIDCard(onlineRegister);
        if (list.size() == 0) {
            return "notfound";
        } else {
            OnlineRegister or = (OnlineRegister) list.get(0);
            return or.getAuditFlag() + "-" + or.getRegisterType();
        }
    }

    @RequestMapping("/onlineregister/importRegister")
    public void importRegister(HttpServletRequest request, HttpServletResponse response, String type, String origin, String year) {
        HSSFWorkbook wb = new HSSFWorkbook();
        String fileName, fileName1, fileName2, fileName3, title;
        OnlineRegister onlineRegister = new OnlineRegister();
        onlineRegister.setRegisterType(type);
        onlineRegister.setYear(Integer.parseInt(year));
        if ("1".equals(type)){
            onlineRegister.setRegisterOrigin(origin);
            if ("1".equals(origin)){
                title = "中考成绩";
                fileName = year +  "年初中起点中专护理报名登记表(汉语言)";
                fileName1 = year + "年初中起点中专护理报名登记表(民考汉)";
                fileName2 = year + "年初中起点中专护理报名登记表(双语言)";
                fileName3 = year + "年初中起点中专护理报名登记表(汇总)";
            }else {
                title = "高考成绩";
                fileName = year +  "年高中起点中专护理报名登记表(汉语言)";
                fileName1 = year + "年高中起点中专护理报名登记表(民考汉)";
                fileName2 = year + "年高中起点中专护理报名登记表(双语言)";
                fileName3 = year + "年高中起点中专护理报名登记表(汇总)";
            }
        }else {
            title = "中考成绩";
            fileName = year + "年五年一贯制护理报名登记表(汉语言)";
            fileName1 = year + "年五年一贯制护理报名登记表(民考汉)";
            fileName2 = year + "年五年一贯制护理报名登记表(双语言)";
            fileName3 = year + "年五年一贯制护理报名登记表(汇总)";
        }


//        String export = request.getParameter("export");
        String export = "";
        HSSFSheet sheet = wb.createSheet("汉语言");
        //查询汉语言
        onlineRegister.setLanguage("1");
        List<OnlineRegister> listChinese =  onlineRegisterService.exportOnlineRegisterList(onlineRegister);
        addSheet(wb,export,sheet,fileName,listChinese, title);

        HSSFSheet sheet1 = wb.createSheet("民考汉");
        //查询民考汉
        onlineRegister.setLanguage("2");
        List<OnlineRegister> listMinkaoHan =  onlineRegisterService.exportOnlineRegisterList(onlineRegister);
        addSheet(wb,export,sheet1,fileName1,listMinkaoHan, title);

        HSSFSheet sheet2 = wb.createSheet("双语言");
        //查询双语言
        onlineRegister.setLanguage("3");
        List<OnlineRegister> listDoubleLanguage =  onlineRegisterService.exportOnlineRegisterList(onlineRegister);
        addSheet(wb,export,sheet2,fileName2,listDoubleLanguage, title);

        HSSFSheet sheet3 = wb.createSheet("汇总");
        ArrayList<OnlineRegister> listAll = new ArrayList<>();
        listAll.addAll(listChinese);
        listAll.addAll(listMinkaoHan);
        listAll.addAll(listDoubleLanguage);
        addSheet(wb,export,sheet3,fileName3,listAll, title);

        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(fileName.replace("(汉语言)", "")+".xls", "utf-8"));
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

    private void setColumnDefaultStyleAndWidth(HSSFSheet sheet,HSSFCellStyle style){
        sheet.setColumnWidth(0,5* 256);
        sheet.setColumnWidth(1,33* 256);
        sheet.setColumnWidth(2,8* 256);
        sheet.setColumnWidth(3,8* 256);
        sheet.setColumnWidth(4,10* 256);
        sheet.setColumnWidth(5,20* 256);
        sheet.setColumnWidth(6,25* 256);
        sheet.setColumnWidth(7,15* 256);
        sheet.setColumnWidth(8,15* 256);
        sheet.setColumnWidth(9,15* 256);
        sheet.setColumnWidth(10,15* 256);
        sheet.setColumnWidth(11,10* 256);
        sheet.setColumnWidth(12,12* 256);
        sheet.setColumnWidth(13,20* 256);
        sheet.setColumnWidth(14,15* 256);
        sheet.setColumnWidth(15,15* 256);
        sheet.setColumnWidth(16,15* 256);
        sheet.setDefaultRowHeightInPoints(28);
//        sheet.setDefaultColumnStyle(0,style);
//        sheet.setDefaultColumnStyle(1,style);
//        sheet.setDefaultColumnStyle(2,style);
//        sheet.setDefaultColumnStyle(3,style);
//        sheet.setDefaultColumnStyle(4,style);
    }
    private void createCellWithStyleAndValue (HSSFRow row,Integer col,String value,HSSFCellStyle style){
        HSSFCell cell = row.createCell(col);
        cell.setCellValue(value);
        cell.setCellStyle(style);
    }

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
    private void addSheet(HSSFWorkbook wb,String export,HSSFSheet sheet,String fileName,List<OnlineRegister> list, String title){
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
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 16));
        this.setColumnDefaultStyleAndWidth(sheet,style12);

        HSSFRow row0 = sheet.createRow(0);
        row0.setHeightInPoints(28);
        this.createCellWithStyleAndValue(row0,0,fileName,styleHead);
        HSSFRow row1 = sheet.createRow(1);
        row1.setHeightInPoints(28);

        this.createCellWithStyleAndValue(row1,0,"序号",style11);
        this.createCellWithStyleAndValue(row1,1,"姓名",style11);
        this.createCellWithStyleAndValue(row1,2,"性别",style11);
        this.createCellWithStyleAndValue(row1,3,"民族",style11);
        this.createCellWithStyleAndValue(row1,4,"语言",style11);
        this.createCellWithStyleAndValue(row1,5,"准考证号",style11);
        this.createCellWithStyleAndValue(row1,6,"身份证号",style11);
        this.createCellWithStyleAndValue(row1,7,"出生年月",style11);
        this.createCellWithStyleAndValue(row1,8,"父亲电话",style11);
        this.createCellWithStyleAndValue(row1,9,"母亲电话",style11);
        this.createCellWithStyleAndValue(row1,10,"毕业时间",style11);
        this.createCellWithStyleAndValue(row1,11,title,style11);
        this.createCellWithStyleAndValue(row1,12,"是否交资料",style11);
        this.createCellWithStyleAndValue(row1,13,"生源",style11);
        this.createCellWithStyleAndValue(row1,14,"考生类别",style11);
        this.createCellWithStyleAndValue(row1,15,"毕业学校",style11);
        this.createCellWithStyleAndValue(row1,16,"备注",style11);


        setHSSFPrompt(sheet, "", "", 1, 65535, 0, 0);
        setHSSFPrompt(sheet, "", "", 1, 65535, 1, 1);
        setHSSFPrompt(sheet, "", "", 1, 65535, 2, 2);
        setHSSFPrompt(sheet, "", "", 1, 65535, 3, 3);
        setHSSFPrompt(sheet, "", "", 1, 65535, 4, 4);
        setHSSFPrompt(sheet, "", "", 1, 65535, 5, 5);
        setHSSFPrompt(sheet, "", "", 1, 65535, 6, 6);
        setHSSFPrompt(sheet, "", "", 1, 65535, 7, 7);
        setHSSFPrompt(sheet, "", "", 1, 65535, 8, 8);
        setHSSFPrompt(sheet, "", "", 1, 65535, 9, 9);
        setHSSFPrompt(sheet, "", "", 1, 65535, 10, 10);
        setHSSFPrompt(sheet, "", "", 1, 65535, 11, 11);
        setHSSFPrompt(sheet, "", "", 1, 65535, 12, 12);
        setHSSFPrompt(sheet, "", "", 1, 65535, 13, 13);
        setHSSFPrompt(sheet, "", "", 1, 65535, 14, 14);
        setHSSFPrompt(sheet, "", "", 1, 65535, 15, 15);
        setHSSFPrompt(sheet, "", "", 1, 65535, 16, 16);

        for (int i = 0; i < list.size(); i++) {
            HSSFRow rowi = sheet.createRow(i+2);
            this.createCellWithStyleAndValue(rowi,0,i+1+"",style11);
            this.createCellWithStyleAndValue(rowi,1,list.get(i).getName(),style11);
            this.createCellWithStyleAndValue(rowi,2,list.get(i).getSex(),style11);
            this.createCellWithStyleAndValue(rowi,3,list.get(i).getNation(),style11);
            this.createCellWithStyleAndValue(rowi,4,list.get(i).getLanguage(),style11);
            this.createCellWithStyleAndValue(rowi,5,list.get(i).getExaminationCardNumber(),style11);
            this.createCellWithStyleAndValue(rowi,6,list.get(i).getIdcard(),style11);
            this.createCellWithStyleAndValue(rowi,7,list.get(i).getBirthday(),style11);
            this.createCellWithStyleAndValue(rowi,8,list.get(i).getFatherTel(),style11);
            this.createCellWithStyleAndValue(rowi,9,list.get(i).getMotherTel(),style11);
            this.createCellWithStyleAndValue(rowi,10,list.get(i).getGraduationDate(),style11);
            this.createCellWithStyleAndValue(rowi,11,list.get(i).getExamScore(),style11);
            this.createCellWithStyleAndValue(rowi,12,"是",style11);
            this.createCellWithStyleAndValue(rowi,13,list.get(i).getProvince(),style11);
            this.createCellWithStyleAndValue(rowi,14,list.get(i).getExamTypeShow(),style11);
            this.createCellWithStyleAndValue(rowi,15,list.get(i).getGraduatedSchool(),style11);
            this.createCellWithStyleAndValue(rowi,16,list.get(i).getRemark(),style11);
        }
    }

    @RequestMapping("/onlineregister/getOnlineRegisterPreview")
    public ModelAndView getOnlineRegisterPreview(String id, String files) {
        ModelAndView mv = new ModelAndView("/business/studentwork/onlineregister/onlineRegisterPreview");
        mv.addObject("head", "附件下载及预览");
        mv.addObject("id", id);
        mv.addObject("files", files);
        return mv;
    }

    @RequestMapping("/onlineregister/getPreview")
    public ModelAndView getPreview(HttpServletRequest request, String id, String file) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/onlineregister/preview");
        if (file != null && !"".equals(file)) {
            String fileView = "/upload/" + id + "/" + file;
            String fileType = CommonUtil.getFileExt(file);
            if (".txt.docx.doc.xls.xlsx.pptx.pptx.".indexOf("." + fileType + ".") != -1) {
                // 文本
                fileView = fileView.replace("." + fileType, ".pdf");
                mv.addObject("fileView", request.getContextPath() + fileView);
                mv.addObject("fileFormat", "1");
            } else if (".bmp.jpg.png.tiff.gif.pcx.tga.exif.fpx.svg.psd.cdr.pcd.dxf.ufo.eps.ai.raw.WMF.".indexOf("." +
                    fileType + ".") != -1) {
                // 图片
                mv.addObject("fileView", fileView);
                mv.addObject("fileFormat", "2");
            } else if (".mp3.wmv.".indexOf("." + fileType + ".") != -1) {
                // 音频
                mv.addObject("fileView", fileView);
                mv.addObject("fileFormat", "3");
            } else if (".avi.wmv.mpeg.mp4.mov.mkv.flv.f4v.m4v.rmvb.rm.3gp.dat.ts.mts.vob.".indexOf("." + fileType + "" +
                    ".") != -1) {
                // 视频
                fileView = fileView.replace("." + fileType, ".mp4");
                mv.addObject("fileView", fileView);
                mv.addObject("fileFormat", "4");
            } else {
                mv.addObject("fileFormat", "");
            }
        }
        mv.addObject("head", "");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/onlineregister/downloadFile")
    public void downloadFile(String id, String url, HttpServletResponse response) {
        String path = PathBean.BASEPATH + File.separator + "upload" + File.separator + id  + File.separator + url;
        File file = FileUtils.getFile(path);
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(file.getName(), "utf-8"));
            os = response.getOutputStream();
            os.write(FileUtils.readFileToByteArray(file));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
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

    @ResponseBody
    @RequestMapping("/onlineregister/audit")
    public Message audit(String ids, String flag, String mind) {
        onlineRegisterService.audit(ids, flag, mind);
        return new Message(1, "添加成功！", null);
    }

    @RequestMapping("/onlineregister/tonlineRegisterStatistics")
    public String tonlineRegisterStatistics(Model model) {
        model.addAttribute("allYear", onlineRegisterService.getAllYear());
        return "/business/studentwork/onlineregister/onlineRegisterStatistics";
    }

    @RequestMapping("/onlineregister/signUpResult")
    public ModelAndView signUpResult() {
        return new ModelAndView("/business/studentwork/onlineregister/signUpResult");
    }
}
