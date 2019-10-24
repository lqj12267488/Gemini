package com.goisan.educational.competition.controller;

import com.goisan.educational.competition.bean.CompetitionRequest;
import com.goisan.educational.competition.service.CompetitionRequestService;
import com.goisan.educational.course.bean.Course;
import com.goisan.educational.course.service.CourseService;
import com.goisan.educational.major.service.MajorService;
import com.goisan.system.bean.*;
import com.goisan.system.service.CommonService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class CompetitionRequestController {
    @Resource
    private CompetitionRequestService competitionRequestService;
    @Resource
    private CommonService commonService;
    @Resource
    private CourseService courseService;
    @Resource
    private MajorService majorService;
    //申请页跳转
    @RequestMapping("/competition/request")
    public ModelAndView competitionRequestList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/competitionrequest/competitionRequestList");
        return mv;
    }
    //申请页列表初始化
    @ResponseBody
    @RequestMapping("/competitionRequest/getCompetitionRequestList")
    public Map<String, List<CompetitionRequest>> getCompetitionRequestList(CompetitionRequest competitionRequest) {
        Map<String, List<CompetitionRequest>> softInstallMap = new HashMap<String, List<CompetitionRequest>>();
        competitionRequest.setCreator(CommonUtil.getPersonId());
        competitionRequest.setChangeDept(CommonUtil.getDefaultDept());
        softInstallMap.put("data", competitionRequestService.competitionRequestAction(competitionRequest));
        return softInstallMap;
    }

    @ResponseBody
    @RequestMapping("/competitionRequest/addCompetitionRequest")
    public ModelAndView addCompetitionRequestInstall() {
        ModelAndView mv = new ModelAndView("/business/educational/competitionrequest/editCompetitionRequest");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String date = formatDate.format(new Date());
        CompetitionRequest competitionRequest=new CompetitionRequest();
        mv.addObject("head", "新增申请");
        mv.addObject("competitionRequest",competitionRequest);
        return mv;
    }
    //申请页修改界面跳转
    @ResponseBody
    @RequestMapping("/competitionRequest/getCompetitionRequestById")
    public ModelAndView getCompetitionRequestById(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/competitionrequest/editCompetitionRequest");
        CompetitionRequest competitionRequest = competitionRequestService.getCompetitionRequestById(id);
        mv.addObject("head", "参赛申请修改");
        mv.addObject("competitionRequest", competitionRequest);
        return mv;
    }
    //新增和修改保存
    @ResponseBody
    @RequestMapping("/competitionRequest/saveCompetitionRequest")
    public Message savecompetitionRequest(CompetitionRequest competitionRequest){
        if(competitionRequest.getId() == null || competitionRequest.equals("") || competitionRequest.getId() == ""){
            competitionRequest.setCreator(CommonUtil.getPersonId());
            competitionRequest.setCreateDept(CommonUtil.getDefaultDept());
            competitionRequestService.insertCompetitionRequest(competitionRequest);
            return new Message(1, "新增成功！", null);
        }else{
            competitionRequest.setChanger(CommonUtil.getPersonId());
            competitionRequest.setChangeDept(CommonUtil.getDefaultDept());
            competitionRequestService.updateCompetitionRequestById(competitionRequest);
            return new Message(1, "修改成功！", null);
        }
    }
    //删除
    @ResponseBody
    @RequestMapping("/competitionRequest/deleteCompetitionRequestById")
    public Message deleteDeptById(String id) {
        competitionRequestService.deleteCompetitionRequestById(id);
        return new Message(1, "删除成功！", null);
    }

    @RequestMapping("/competition/statistics")
    public ModelAndView competitionRequestStatisticsList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/competitionrequest/competitionRequestStatistics");
        return mv;
    }
    //申请页列表初始化
    @ResponseBody
    @RequestMapping("/competitionRequest/getStatisticsCompetitionRequestList")
    public Map<String, List<CompetitionRequest>> getStatisticsCompetitionRequestList(CompetitionRequest competitionRequest) {
        Map<String, List<CompetitionRequest>> softInstallMap = new HashMap<String, List<CompetitionRequest>>();
        competitionRequest.setCreator(CommonUtil.getPersonId());
        competitionRequest.setChangeDept(CommonUtil.getDefaultDept());
        softInstallMap.put("data", competitionRequestService.competitionRequestAction(competitionRequest));
        return softInstallMap;
    }

    /**
     * 获奖情况
     * @return
     */
    @RequestMapping("/competition/award")
    public ModelAndView competitionRequestAward(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/competitionrequest/competitionRequestAward");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/competitionRequest/getCompetitionRequestAwardById")
    public ModelAndView getCompetitionRequestAwardById(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/competitionrequest/editCompetitionRequestAward");
        CompetitionRequest competitionRequest = competitionRequestService.getCompetitionRequestById(id);
        mv.addObject("head", "获奖情况");
        mv.addObject("competitionRequest", competitionRequest);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/competition/competitionName")
    public List<AutoComplete> autoCompleteEmployee() {
        return competitionRequestService.autoCompleteCompetition();
    }
    @RequestMapping("/competitionRequest/toImportCompetitionRequest")
    public ModelAndView toImportMajorCourse(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/competitionrequest/competitionRequestImport");
        return mv;
    }

    /**
     * 导出获奖情况
     * @param request
     * @param response
     */
    @ResponseBody
    @RequestMapping("/competitionRequest/exportCompetitionRequestAward")
    public void exportCompetitionRequestAward(HttpServletRequest request, HttpServletResponse response) {
        CompetitionRequest competitionRequest = new CompetitionRequest();
        List<CompetitionRequest> courseList = competitionRequestService.competitionRequestAction(competitionRequest);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("获奖情况");

        //创建HSSFRow对象
        int tmp = 0;
        HSSFRow row2 = sheet.createRow(tmp);
        row2.createCell(1).setCellValue("说明：此项为必填项");
        tmp++;

        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象   会员姓名	部门	会员编号	工会职务	入会时间    备注
        row1.createCell(0).setCellValue("");
        row1.createCell(1).setCellValue("竞赛名称");
        row1.createCell(2).setCellValue("分赛项");
        row1.createCell(3).setCellValue("系部");
        row1.createCell(4).setCellValue("专业");
        row1.createCell(5).setCellValue("指导教师");
        row1.createCell(6).setCellValue("参赛性质");
        row1.createCell(7).setCellValue("参赛时间");
        row1.createCell(8).setCellValue("组织单位");
        row1.createCell(9).setCellValue("级别");
        row1.createCell(10).setCellValue("成绩");
        tmp++;
        int i = 1;
        for (CompetitionRequest courseObj : courseList) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(courseObj.getCompetitionName());
            row.createCell(2).setCellValue(courseObj.getBranchMatch());
            row.createCell(3).setCellValue(courseObj.getDepartment());
            row.createCell(4).setCellValue(courseObj.getMajor());
            row.createCell(5).setCellValue(courseObj.getInstructor());
            row.createCell(6).setCellValue(courseObj.getCompetitionNature());
            row.createCell(7).setCellValue(courseObj.getTime());
            row.createCell(8).setCellValue(courseObj.getOrganizationUnit());
            row.createCell(9).setCellValue(courseObj.getGrade());
            row.createCell(10).setCellValue(courseObj.getScore());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("获奖情况.xls", "utf-8"));
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


    @ResponseBody
    @RequestMapping("/competitionRequest/exportCompetitionRequestStatistics")
    public void exportCompetitionRequestStatistics(HttpServletRequest request, HttpServletResponse response) {
        CompetitionRequest competitionRequest = new CompetitionRequest();
        List<CompetitionRequest> courseList = competitionRequestService.competitionRequestAction(competitionRequest);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("参赛统计");

        //创建HSSFRow对象
        int tmp = 0;
        HSSFRow row0 = sheet.createRow(tmp);
       /* row2.createCell(1).setCellValue("说明：此项为必填项");
        tmp++;*/

        //HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象   会员姓名	部门	会员编号	工会职务	入会时间    备注
        row0.createCell(0).setCellValue("");
        row0.createCell(1).setCellValue("竞赛名称");
        row0.createCell(2).setCellValue("分赛项");
        row0.createCell(3).setCellValue("系部");
        row0.createCell(4).setCellValue("专业");
        row0.createCell(5).setCellValue("指导教师");
        row0.createCell(6).setCellValue("参赛性质");
        row0.createCell(7).setCellValue("参赛时间");
        row0.createCell(8).setCellValue("组织单位");
        tmp++;
        int i = 1;
        for (CompetitionRequest courseObj : courseList) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(courseObj.getCompetitionName());
            row.createCell(2).setCellValue(courseObj.getBranchMatch());
            row.createCell(3).setCellValue(courseObj.getDepartment());
            row.createCell(4).setCellValue(courseObj.getMajor());
            row.createCell(5).setCellValue(courseObj.getInstructor());
            row.createCell(6).setCellValue(courseObj.getCompetitionNature());
            row.createCell(7).setCellValue(courseObj.getTime());
            row.createCell(8).setCellValue(courseObj.getOrganizationUnit());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("参赛统计.xls", "utf-8"));
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
     * 导出竞赛申请
     * @param request
     * @param response
     */
    @ResponseBody
    @RequestMapping("/competitionRequest/exportCompetitionRequest")
    public void exportCompetitionRequest(HttpServletRequest request, HttpServletResponse response) {
        CompetitionRequest competitionRequest = new CompetitionRequest();
        List<CompetitionRequest> courseList = competitionRequestService.competitionRequestAction(competitionRequest);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("竞赛申请信息表");

        //创建HSSFRow对象
        int tmp = 0;
        HSSFRow row0 = sheet.createRow(tmp);
       /* row2.createCell(1).setCellValue("说明：此项为必填项");
        tmp++;*/

       /* HSSFRow row1 = sheet.createRow(tmp);*/
        //创建HSSFCell对象   会员姓名	部门	会员编号	工会职务	入会时间    备注
        row0.createCell(0).setCellValue("");
        row0.createCell(1).setCellValue("竞赛名称");
        row0.createCell(2).setCellValue("分赛项");
        row0.createCell(3).setCellValue("系部");
        row0.createCell(4).setCellValue("专业");
        row0.createCell(5).setCellValue("指导教师");
        row0.createCell(6).setCellValue("参赛性质");
        row0.createCell(7).setCellValue("参赛时间");
        row0.createCell(8).setCellValue("组织单位");
        tmp++;
        int i = 1;
        for (CompetitionRequest courseObj : courseList) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(courseObj.getCompetitionName());
            row.createCell(2).setCellValue(courseObj.getBranchMatch());
            row.createCell(3).setCellValue(courseObj.getDepartment());
            row.createCell(4).setCellValue(courseObj.getMajor());
            row.createCell(5).setCellValue(courseObj.getInstructor());
            row.createCell(6).setCellValue(courseObj.getCompetitionNature());
            row.createCell(7).setCellValue(courseObj.getTime());
            row.createCell(8).setCellValue(courseObj.getOrganizationUnit());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("竞赛申请信息表.xls", "utf-8"));
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

    @ResponseBody
    @RequestMapping("/competitionRequest/importCompetitionRequest")
    public Message importCompetitionRequest(@RequestParam(value = "file", required = false) CommonsMultipartFile file) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        List<Select2> xz = commonService.getSysDict("CSXZ","");
        TableDict tableDict1 = new TableDict();
        tableDict1.setId("major_code");
        tableDict1.setText("major_name");
        tableDict1.setTableName("t_xg_major");
        tableDict1.setWhere("where major_name is not null");
        List<Select2> xx = commonService.getTableDict(tableDict1);
        TableDict tableDict2 = new TableDict();
        tableDict2.setId("id");
        tableDict2.setText("COMPETITION_PROJECT");
        tableDict2.setTableName("T_JW_COMPETITION_PROJECT");
        List<Select2> jsm = commonService.getTableDict(tableDict2);
        int count = 0 ;
        try {
            HSSFWorkbook workbook1 = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook1.getSheetAt(0);
            int end = getRealLastRowNum1(workbook1);
            for (int i = 2; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                if(null == row && count == 0){
                    return new Message(0, "无数据，导入失败！", "error");
                }else if(null == row || row.getLastCellNum() == 1){
                    return new Message(1, "共计"+count+"条，导入成功！", "success");
                }
                CompetitionRequest competitionRequest = new CompetitionRequest();

                for (Select2 CompetitionName : jsm) {
                    if (CompetitionName.getText().equals(row.getCell(0).toString())) {
                        competitionRequest.setCompetitionName(CompetitionName.getId());
                    }
                }
                competitionRequest.setBranchMatch(row.getCell(1).toString());
                if ("".equals(CommonUtil.changeToString(row.getCell(2))) || null == CommonUtil.changeToString(row.getCell(2))) {
                    try {
                        competitionRequest.setDepartment("");
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }
                } else {
                    String department = majorService.getDeptIdByDeptName(row.getCell(2).toString());
                    competitionRequest.setDepartment(department);
                }
                if ("".equals(CommonUtil.changeToString(row.getCell(3))) || null == CommonUtil.changeToString(row.getCell(3))) {
                    try {
                        competitionRequest.setMajor("");
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }
                } else {
                    for (Select2 Major : xx) {
                        if (Major.getText().equals(row.getCell(3).toString())) {
                            competitionRequest.setMajor(Major.getId());
                        }
                    }
                }
                competitionRequest.setInstructor(row.getCell(4).toString());
                for (Select2 CompetitionNature : xz) {
                    if (CompetitionNature.getText().equals(row.getCell(5).toString())) {
                        competitionRequest.setCompetitionNature(CompetitionNature.getId());
                    }
                }
                competitionRequest.setTime(row.getCell(6).toString());
                competitionRequest.setOrganizationUnit(row.getCell(7).toString());
                competitionRequest.setCreator(CommonUtil.getPersonId());
                competitionRequest.setCreateDept(CommonUtil.getDefaultDept());
                competitionRequestService.insertCompetitionRequest(competitionRequest);
                count++;
            }
        } catch (Exception e) {
            e.printStackTrace();
            String msg = "导入"+count+"条成功，第"+(count+1)+"条数据异常。导入失败！" ;
            return new Message(0, msg, null);
        }

        return new Message(1, "共计"+count+"条，导入成功！", "success");
    }
    private int getRealLastRowNum1(Workbook workbook) {
        Sheet sheetAt = workbook.getSheetAt(0);
        int lastRowNum = sheetAt.getLastRowNum();
        Row row = sheetAt.getRow(0);
        int realLastRowNum = 0;
        error:
        for (int i = 0; i < lastRowNum; i++) {
            StringBuilder str = new StringBuilder();
            for (int j = 0; j < sheetAt.getRow(0).getPhysicalNumberOfCells(); j++) {
                Cell cell = sheetAt.getRow(i).getCell(j);
                try {
                    cell.setCellType(CellType.STRING);
                    str.append(cell.getStringCellValue());
                }
                catch (Exception e)
                {
                    break error;
                }

            }
            if (!"".equals(str.toString().replaceAll(" ", "")))
            {
                realLastRowNum = realLastRowNum + 1;
            }
        }
        System.err.println("----------------------> 真实行数 "+realLastRowNum);
        return realLastRowNum;

    }
   /**
     * 导出模板(新)
     * @return
     * @author
        */
    @ResponseBody
    @RequestMapping("/competitionRequest/getCompetitionRequestTemplate")
    public void getCompetitionRequestTemplate(HttpServletResponse response) {
        // 获取全部可选项
        List<Select2> courseTypeList = null; // 参赛性质表
        List<SelectGroupForExcel> selectionsList = null; // 系部-专业表
        List<SelectGroupForExcel> selectClassList = null;
        List<Select2> competitionProject = null;//竞赛项目
        try {
            courseTypeList = this.commonService.getSysDict("CSXZ", null);
            selectionsList = this.courseService.getDepartmentMajorList("8");
            competitionProject = this.competitionRequestService.getCompetitionProjectSelect();
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }

        // 创建excel文件
        Workbook wb = new HSSFWorkbook();
        Sheet sheet = wb.createSheet("参赛申请信息表");

        for(int i=0; i<8; ++i) { // 预置列宽
            sheet.setColumnWidth(i, 18*256);
        }

        // 提示必填的红字行(第1行)
        Row row0 = sheet.createRow(0);
        CellStyle style0 = wb.createCellStyle();
        Font font0 = wb.createFont();
        font0.setColor(HSSFColor.RED.index);
        font0.setFontHeightInPoints((short)10);
        font0.setFontName("宋体");
        style0.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style0.setFont(font0);
        for(int i=0; i<8; ++i) {
            Cell cell = row0.createCell(i);
            if(i==2 || i==3){
                cell.setCellValue("");
                cell.setCellStyle(style0);
            }else if(i==6){
                cell.setCellValue("说明：此项为必填项,格式2018-09");
                cell.setCellStyle(style0);
            }else{
                cell.setCellValue("说明：此项为必填项");
                cell.setCellStyle(style0);
            }

        }

        // 表头(第2行)
        Row row1 = sheet.createRow(1);
        CellStyle style1 = wb.createCellStyle();
        Font font1 = wb.createFont();
        font1.setFontHeightInPoints((short)10);
        font1.setFontName("宋体");
        font1.setBold(true);
        style1.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中
        style1.setFont(font1);
        style1.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        style1.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index); // 灰底
        style1.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 边框*4
        style1.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style1.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style1.setBorderTop(HSSFCellStyle.BORDER_THIN);
        String[] titles = {"竞赛名称","分赛项","系部","专业","指导教师","参赛性质","参赛时间","组织单位"};
        for(int i=0; i<8; ++i) {
            Cell cell = row1.createCell(i);
            cell.setCellStyle(style1);
            cell.setCellValue(titles[i]);
         }

        // 竞赛名称
        String[] competitionProjectList = new String[competitionProject.size()];
        for (int i=0; i<competitionProjectList.length; ++i) {
            competitionProjectList[i] = competitionProject.get(i).getText();
        }
        CellRangeAddressList courseNameRegions = new CellRangeAddressList(2, 65535, 0, 0);
        DVConstraint courseNameConstraint = DVConstraint.createExplicitListConstraint(competitionProjectList);
        HSSFDataValidation courseNameValidation = new HSSFDataValidation(courseNameRegions, courseNameConstraint);
        courseNameValidation.createErrorBox("错误", "请输入有效的参赛性质,或从下拉框中选择!");
        sheet.addValidationData(courseNameValidation);
        // 分赛项
        CellRangeAddressList courseNameRegions1 = new CellRangeAddressList(2, 65535, 1, 1);
        DVConstraint courseNameConstraint1 = DVConstraint.createNumericConstraint(DVConstraint.ValidationType.TEXT_LENGTH, DVConstraint.OperatorType.BETWEEN, "1", "30");
        HSSFDataValidation courseNameValidation1 = new HSSFDataValidation(courseNameRegions1, courseNameConstraint1);
        courseNameValidation.createErrorBox("错误", "输入的竞赛名称长度不得大于30字符!");
        sheet.addValidationData(courseNameValidation1);

        // 系部-专业
        String[] departmentArray = new String[selectionsList.size()];
        Map<String, String[]> selectionMap = new HashMap<>();
        for (int i=0; i<selectionsList.size(); ++i) { // 映射关系Map
            SelectGroupForExcel tempSelection = selectionsList.get(i);
            departmentArray[i] = tempSelection.getText();
            selectionMap.put(tempSelection.getText(), tempSelection.getMajor());
        }
        Sheet hideSheet = wb.createSheet("selection"); // 创建隐藏表,保存级联关系
        wb.setSheetHidden(wb.getSheetIndex(hideSheet), true);
        Iterator<String> keyIterator = selectionMap.keySet().iterator();
        int rowId = 0;
        while (keyIterator.hasNext()) {
            String key = keyIterator.next();
            String[] son = selectionMap.get(key);

            Row row = hideSheet.createRow(rowId++);
            row.createCell(0).setCellValue(key);
            for (int i=0; i<son.length; ++i) {
                Cell cell = row.createCell(i+1);
                cell.setCellValue(son[i]);
            }
            String range = this.getRange(1, rowId, son.length);
            Name name = wb.createName();
            name.setNameName(key);
            String formula = "selection!" + range;
            name.setRefersToFormula(formula);
        }

        HSSFDataValidationHelper departmentDataValidationHelper = new HSSFDataValidationHelper((HSSFSheet)sheet);
        DataValidationConstraint provConstraint = departmentDataValidationHelper.createExplicitListConstraint(departmentArray);
        CellRangeAddressList provRangeAddressList = new CellRangeAddressList(2, 65535, 2, 2);
        DataValidation departmentDataValidation = departmentDataValidationHelper.createValidation(provConstraint, provRangeAddressList);
        departmentDataValidation.createErrorBox("错误", "请输入有效的系部,或从下拉框中选择!");
        sheet.addValidationData(departmentDataValidation);

        DVConstraint formula = DVConstraint.createFormulaListConstraint("INDIRECT(INDIRECT(\"R\"&ROW()&\"C\"&COLUMN()-1,FALSE))"); // INDIRECT(INDIRECT("R"&ROW()&"C"&COLUMN()-1,FALSE)):取当前单元格左侧的单元格去名称管理器查询
        CellRangeAddressList rangeAddressList = new CellRangeAddressList(2, 65535, 3, 3);
        DataValidation majorDataValidation = new HSSFDataValidation(rangeAddressList, formula);
        majorDataValidation.createErrorBox("错误", "请输入有效的专业,或从下拉框中选择!");
        sheet.addValidationData(majorDataValidation);

        // 指导教师
        CellRangeAddressList courseNameRegions4 = new CellRangeAddressList(2, 65535, 4, 4);
        DVConstraint courseNameConstraint4 = DVConstraint.createNumericConstraint(DVConstraint.ValidationType.TEXT_LENGTH, DVConstraint.OperatorType.BETWEEN, "1", "30");
        HSSFDataValidation courseNameValidation4 = new HSSFDataValidation(courseNameRegions4, courseNameConstraint4);
        courseNameValidation.createErrorBox("错误", "输入的指导教师长度不得大于30字符!");
        sheet.addValidationData(courseNameValidation4);
        // 参赛性质
        String[] courseType = new String[courseTypeList.size()];
        for (int i=0; i<courseType.length; ++i) {
            courseType[i] = courseTypeList.get(i).getText();
        }
        CellRangeAddressList courseTypeRegions = new CellRangeAddressList(2, 65535, 5, 5);
        DVConstraint courseTypeConstraint = DVConstraint.createExplicitListConstraint(courseType);
        HSSFDataValidation courseTypeValidation = new HSSFDataValidation(courseTypeRegions, courseTypeConstraint);
        courseTypeValidation.createErrorBox("错误", "请输入有效的参赛性质,或从下拉框中选择!");
        sheet.addValidationData(courseTypeValidation);

        // 组织单位
        CellRangeAddressList courseNameRegions7 = new CellRangeAddressList(2, 65535, 7, 7);
        DVConstraint courseNameConstraint7 = DVConstraint.createNumericConstraint(DVConstraint.ValidationType.TEXT_LENGTH, DVConstraint.OperatorType.BETWEEN, "1", "30");
        HSSFDataValidation courseNameValidation7 = new HSSFDataValidation(courseNameRegions7, courseNameConstraint7);
        courseNameValidation.createErrorBox("错误", "输入的组织单位长度不得大于30字符!");
        sheet.addValidationData(courseNameValidation7);

        //设置参赛时间格式为string
        HSSFCellStyle cellStyle = (HSSFCellStyle) wb.createCellStyle();
        HSSFDataFormat format = ((HSSFWorkbook) wb).createDataFormat();
        cellStyle.setDataFormat(format.getFormat("@"));
        for(int i=2; i<10000; i++){
            Cell cell = sheet.createRow(i).createCell(6);
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(cellStyle);
        }
        // 导出
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("竞赛申请信息表模板.xls", "utf-8"));
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
     * 设置excel用名称管理器(计算formula)
     * @param offset 偏移量，如果给0，表示从A列开始，1，就是从B列
     * @param rowId 第几行
     * @param colCount 一共多少列
     * @return 如果给入参 1,1,10. 表示从B1-K1。最终返回 $B$1:$K$1
     * @author
     */
    private String getRange(int offset, int rowId, int colCount) {char start = (char)('A' + offset);
        if (colCount <= 25) {
            char end = (char)(start + colCount - 1);
            return "$" + start + "$" + rowId + ":$" + end + "$" + rowId;
        } else {
            char endPrefix = 'A';
            char endSuffix = 'A';
            if ((colCount-25)/26==0 || colCount==51) { // 26-51之间，包括边界（仅两次字母表计算）
                if ((colCount-25)%26 == 0) { // 边界值
                    endSuffix = (char)('A' + 25);
                } else {
                    endSuffix = (char)('A' + (colCount-25)%26 - 1);
                }
            } else { // 51以上
                if ((colCount-25)%26 == 0) {
                    endSuffix = (char)('A' + 25);
                    endPrefix = (char)(endPrefix + (colCount-25)/26 - 1);
                } else {
                    endSuffix = (char)('A' + (colCount-25)%26 - 1);
                    endPrefix = (char)(endPrefix + (colCount-25)/26);
                }
            }
            return "$" + start + "$" + rowId + ":$" + endPrefix + endSuffix + "$" + rowId;
        }
    }
    /**
     * 学生多选下拉内容查询
     */
    @ResponseBody
    @RequestMapping("/competitionRequest/getStuTree")
    public List<Tree> getEmpTree() {
        List<Tree> trees = commonService.getStuTreeNotClass();
        Tree root = new Tree();
        root.setId("0");
        root.setName("组织机构");
        root.setpId("root");
        root.setOpen(true);
        trees.add(root);
        return trees;
    }


    /**
     * 毕业班级,待毕业班级学生多选下拉内容查询
     */
    @ResponseBody
    @RequestMapping("/competitionRequest/getStuTreeGrad")
    public List<Tree> getStuTreeGrad() {
        List<Tree> trees = commonService.getStuTreeGrad();
        Tree root = new Tree();
        root.setId("0");
        root.setName("组织机构");
        root.setpId("root");
        root.setOpen(true);
        trees.add(root);
        return trees;
    }
}
