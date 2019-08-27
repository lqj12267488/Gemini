package com.goisan.educational.major.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.major.bean.MajorBuildingCmte;
import com.goisan.educational.major.service.MajorBuildingCmteService;
import com.goisan.system.bean.*;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.*;

/**
 * @author 郭千恺
 * @version v1.0
 * @descroption 专业建设指导委员会
 * @date 2018/9/30 10:13
 */
@Controller
@RequestMapping("/major/majorBuildingCmte")
public class MajorBuildingCmteController {
    @Resource
    private MajorBuildingCmteService majorBuildingCmteService;

    /**
     * 专业建设指导委员会页面
     *
     * @return
     */
    @RequestMapping("/majorBuildingCmtePage")
    public ModelAndView majorBuildingCmtePage() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/majorBuildingCmte/majorBuildingCmtePage");
        return mv;
    }

    /**
     * 获取专业建设指导委员会列表
     *
     * @param majorBuildingCmte
     * @return
     */
    @ResponseBody
    @RequestMapping("/majorBuildingCmteList")
    public Map<String, Object> majorBuildingCmteList(MajorBuildingCmte majorBuildingCmte, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> majorBuildingCmteList = new HashMap<String, Object>();
        List<MajorBuildingCmte> list = this.majorBuildingCmteService.getList(majorBuildingCmte);
        //List<MajorBuildingCmte> returnList = this.majorBuildingCmteService.getList(majorBuildingCmte);
        PageInfo<List<MajorBuildingCmte>> info = new PageInfo(list);
        majorBuildingCmteList.put("draw", draw);
        majorBuildingCmteList.put("recordsTotal", info.getTotal());
        majorBuildingCmteList.put("recordsFiltered", info.getTotal());
        majorBuildingCmteList.put("data", list);
        return majorBuildingCmteList;
        // return CommonUtil.tableMap(returnList);
    }

    /**
     * 获取成员详情
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/getDetailPage")
    public ModelAndView getDetailPage(String id) {
        MajorBuildingCmte majorBuildingCmte = this.majorBuildingCmteService.getById(id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/majorBuildingCmte/majorBuildingCmteDetail");
        mv.addObject("head", "成员详情");
        mv.addObject("detail", majorBuildingCmte);
        return mv;
    }

    /**
     * 编辑成员页面
     *
     * @return
     */
    @RequestMapping("/editMajorBuildingCmte")
    public ModelAndView editMajorBuildingCmte(String id) {
        boolean newOne = id == null || id.equals("");
        MajorBuildingCmte majorBuildingCmte = (newOne) ? (new MajorBuildingCmte()) : (this.majorBuildingCmteService.getById(id));
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/majorBuildingCmte/editMajorBuildingCmte");
        mv.addObject("head", newOne ? "新增成员" : "编辑成员");
        mv.addObject("detail", majorBuildingCmte);
        return mv;
    }

    /**
     * 新增成员
     *
     * @param majorBuildingCmte
     * @return
     */
    @ResponseBody
    @RequestMapping("/save")
    public Result save(MajorBuildingCmte majorBuildingCmte) {
        return this.majorBuildingCmteService.save(majorBuildingCmte);
    }

    /**
     * 查询专业表
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/getMajorList")
    public List<AutoComplete> getMajorList() {
        return this.majorBuildingCmteService.getMajorList();
    }

    /**
     * 查询教师人员表
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/getTeacherList")
    public List<AutoComplete> getTeacherList() {
        return this.majorBuildingCmteService.getTeacherList();
    }

    /**
     * 删除回复
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/delete")
    public boolean delete(String id) {
        return this.majorBuildingCmteService.delete(id);
    }

    /**
     * 每个专业导出一个成员表
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/getCmteListGroupByMajor")
    public void getCmteListGroupByMajor(HttpServletResponse response) {
        this.majorBuildingCmteService.expertExcel(response);
    }

    /**
     * 导入成员页面
     *
     * @return
     */
    @RequestMapping("/toImportCmte")
    public String toImportCmte() {
        return "/core/major/majorBuildingCmte/importCmte";
    }

    /**
     * 导入成员
     *
     * @param file
     * @return
     */
    @ResponseBody
    @RequestMapping("/importCmte")
    @Transactional(rollbackFor = Exception.class)
    public Message importCmte(@RequestParam(value = "file", required = false) CommonsMultipartFile file) {
        int count = 0;
        int num = 0;
        int tag=0;
        String msg = "";
        HSSFWorkbook workbook = null;

        try {
             workbook = new HSSFWorkbook(file.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
            ++num;
        }
        if (num > 0) {
            return new Message(1, "导入失败！请重新导入", null);
        } else {
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            for (int i = 3; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                MajorBuildingCmte majorBuildingCmte = new MajorBuildingCmte();
                String majorName=row.getCell(0)==null?"":row.getCell(0).toString();
                List<String> majors=null;
                try {

                    if (majorName == null || "".equals(majorName)) {
                        tag=-1;
                        throw new Exception("数据不正确");
                    } else {
                        majors = this.majorBuildingCmteService.getMajorIdByMajorName(majorName);
                    }
                    if (majors.size() == 0) {
                        tag=-1;
                        throw new Exception("数据不正确");
                    } else {
                        majorBuildingCmte.setMajorId(majors.get(0));
                    }


                    String post = row.getCell(1).toString();
                    if (post == null || "".equals(post)) {
                        tag=-1;
                        throw new Exception("数据不正确");
                    }
                    majorBuildingCmte.setCmtePost(post);

                    String a = row.getCell(2).toString();
                    List<String> getPersonIdByName = majorBuildingCmteService.getPersonIdByName(a);
                    if (getPersonIdByName.size() > 0) {
                        majorBuildingCmte.setPersonId(getPersonIdByName.get(0));
                        majorBuildingCmte.setWorkUnit(row.getCell(3).toString());
                        majorBuildingCmte.setTeacherPost(row.getCell(4).toString());
                        majorBuildingCmte.setTeacherTitle(row.getCell(5).toString());
                    } else {
                        count = 1;
                        break;
                    }


                    if (row.getCell(6) != null) {
                        majorBuildingCmte.setTelephone(row.getCell(6).toString());
                    }
                    Result result = this.majorBuildingCmteService.save(majorBuildingCmte);
                    if (result.getState() == 0) {
                        tag=-2;
                        throw new Exception("重复数据");
                    } else if (result.getState() != 1) {
                        ++count;
                        break;
                    }
                }catch (Exception e){
                    if(tag==-1)
                        return new Message(0, "导入失败，请验证数据的正确性！", null);
                    else
                        return new Message(0, "导入失败，已有相同数据！", null);
                }
            }
            if (count > 0) {
                msg = "导入失败，请验证数据的正确性！";
            } else {
                msg = "导入成功！";
            }
            return new Message(1, msg, null);
        }
    }

    /**
     * 获取导入模板
     *
     * @return
     */
    @RequestMapping("/getCmteExcelTemplate")

    public void getCmteExcelTemplate(HttpServletResponse response) {
        Workbook wb = new HSSFWorkbook();
        Sheet sheet = wb.createSheet("专业建设指导委员会导入模板");
        int[] columnWidthArray = {30, 40, 30, 30, 20, 20, 30};
        int columnNums = columnWidthArray.length;
        for (int i = 0; i < columnNums; ++i) { // 预置列宽
            sheet.setColumnWidth(i, columnWidthArray[i] * 256);
        }
        // 全局行高
        sheet.setDefaultRowHeightInPoints(27.75f);
        // 全局样式
        CellStyle style = wb.createCellStyle();
        Font font = wb.createFont();
        font.setFontName("仿宋");
        font.setBold(false);
        font.setFontHeightInPoints((short) 16);
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setFont(font);
        DataFormat format = wb.createDataFormat();
        style.setDataFormat(format.getFormat("@"));
        for (int i = 0; i < columnNums; ++i) {
            sheet.setDefaultColumnStyle(i, style);
        }

        //标题样式
        CellStyle titleStyle=wb.createCellStyle();
        Font titleFont=wb.createFont();
        titleFont.setFontHeightInPoints((short)22);
        titleFont.setFontName("楷体");
        titleStyle.setFont(titleFont);
        titleStyle.setAlignment(CellStyle.ALIGN_CENTER);
        titleStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);

        //大标题
        Row titleRow=sheet.createRow(0);
        Cell titleCell=titleRow.createCell(0);
        String xxmc= CommonBean.getParamValue("SZXXMC");
        titleCell.setCellValue(xxmc);
        titleCell.setCellStyle(titleStyle);

        //二标题
        Row title1Row=sheet.createRow(1);
        Cell title1Cell=title1Row.createCell(0);
        title1Cell.setCellValue("专业建设指导委员会");
        title1Cell.setCellStyle(titleStyle);

        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 6));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 6));

        // 表头
        Row headRow = sheet.createRow(2);
        CellStyle headStyle = wb.createCellStyle();
        Font headFont = wb.createFont();
        headFont.setFontName("仿宋");
        headFont.setBold(true);
        headFont.setFontHeightInPoints((short) 16);
        headStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headStyle.setFont(headFont);
        String[] titles = {"专业名称", "专业建设指导委员会职务", "姓名", "工作单位", "职务", "职称", "联系电话"};
        for (int i = 0; i < titles.length; ++i) {
            Cell cellTemp = headRow.createCell(i);
            cellTemp.setCellValue(titles[i]);
            cellTemp.setCellStyle(headStyle);
        }


        List<AutoComplete> majorList = null; // 专业表
        List<AutoComplete> nameList = null; // 姓名表
        try {
            majorList = this.majorBuildingCmteService.getMajorList();
            nameList = this.majorBuildingCmteService.getTeacherList();
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }

        Sheet hideSheet = wb.createSheet("hidden");
        wb.setSheetHidden(wb.getSheetIndex(hideSheet), true);
        Iterator<AutoComplete> majorIterator = majorList.iterator();
        Iterator<AutoComplete> nameIterator = nameList.iterator();
        int majorRowNum = 1;
        int nameRowNum = 1;
        while (majorIterator.hasNext()) {
            String major = majorIterator.next().getLabel();
            Row row = hideSheet.createRow(majorRowNum++);
            Cell cell = row.createCell(0);
            cell.setCellValue(major);
        }
        while (nameIterator.hasNext()) {
            String name = nameIterator.next().getLabel();
            Row row = (nameRowNum >= majorRowNum) ? (hideSheet.createRow(nameRowNum++)) : (hideSheet.getRow(nameRowNum++));
            Cell cell = row.createCell(1);
            cell.setCellValue(name);
        }
        DVConstraint majorFormula = DVConstraint.createFormulaListConstraint("hidden!A1:A" + majorList.size());
        CellRangeAddressList majorRangeAddressList = new CellRangeAddressList(1, 65535, 0, 0);
        DataValidation majorDataValidation = new HSSFDataValidation(majorRangeAddressList, majorFormula);
        majorDataValidation.createErrorBox("错误", "请输入有效的专业,或从下拉框中选择!");
        sheet.addValidationData(majorDataValidation);

        // 两个名称选择器会有冲突,暂留
//        DVConstraint nameFormula = DVConstraint.createFormulaListConstraint("hidden!B1:B" + nameList.size());
//        CellRangeAddressList nameRangeAddressList = new CellRangeAddressList(1, 65535, 2, 2);
//        DataValidation nameDataValidation = new HSSFDataValidation(nameRangeAddressList, nameFormula);
//        nameDataValidation.createErrorBox("错误", "请输入有效的姓名,或从下拉框中选择!");
//        sheet.addValidationData(nameDataValidation);

        CellRangeAddressList cmtePostRegions = new CellRangeAddressList(1, 65535, 1, 1);
        DVConstraint cmtePostConstraint = DVConstraint.createNumericConstraint(DVConstraint.ValidationType.TEXT_LENGTH, DVConstraint.OperatorType.BETWEEN, "1", "25");
        HSSFDataValidation cmtePostValidation = new HSSFDataValidation(cmtePostRegions, cmtePostConstraint);
        cmtePostValidation.createErrorBox("错误", "输入的职务名称长度不得大于25字符!");
        sheet.addValidationData(cmtePostValidation);

        CellRangeAddressList workUnitRegions = new CellRangeAddressList(1, 65535, 3, 3);
        DVConstraint workUnitConstraint = DVConstraint.createNumericConstraint(DVConstraint.ValidationType.TEXT_LENGTH, DVConstraint.OperatorType.BETWEEN, "1", "25");
        HSSFDataValidation workUnitValidation = new HSSFDataValidation(workUnitRegions, workUnitConstraint);
        workUnitValidation.createErrorBox("错误", "输入的工作单位名称长度不得大于25字符!");
        sheet.addValidationData(workUnitValidation);

        CellRangeAddressList telephoneRegions = new CellRangeAddressList(1, 65535, 4, 4);
        DVConstraint telephoneConstraint = DVConstraint.createNumericConstraint(DVConstraint.ValidationType.TEXT_LENGTH, DVConstraint.OperatorType.BETWEEN, "1", "11");
        HSSFDataValidation telephoneValidation = new HSSFDataValidation(telephoneRegions, telephoneConstraint);
        telephoneValidation.createErrorBox("错误", "输入的号码长度不得大于11字符!");
        sheet.addValidationData(telephoneValidation);

        // 导出
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("专业建设指导委员会导入模板.xls", "utf-8"));
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
