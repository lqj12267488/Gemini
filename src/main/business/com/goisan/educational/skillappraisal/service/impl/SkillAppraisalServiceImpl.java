package com.goisan.educational.skillappraisal.service.impl;

import com.goisan.educational.skillappraisal.bean.SkillAppraisal;
import com.goisan.educational.skillappraisal.dao.SkillAppraisalDao;
import com.goisan.educational.skillappraisal.service.SkillAppraisalService;
import com.goisan.system.bean.*;
import com.goisan.system.dao.CommonDao;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class SkillAppraisalServiceImpl implements SkillAppraisalService {

    @Resource
    private SkillAppraisalDao skillAppraisalDao;
    @Resource
    private CommonDao commonDao;

    public List<SkillAppraisal> skillAppraisal(SkillAppraisal skill){
        return skillAppraisalDao.skillAppraisal(skill);
    }
    public void deleteSkillAppraisalById(String id){
        skillAppraisalDao.deleteSkillAppraisalById(id);
    }
    public SkillAppraisal getSkillAppraisalById(String id){
        return skillAppraisalDao.getSkillAppraisalById(id);
    }
    public void updateSkillApprraisalById(SkillAppraisal skill){
        skillAppraisalDao.updateSkillApprraisalById(skill);
    }
    public void insertSkillAppraisal(SkillAppraisal skill){
        skillAppraisalDao.insertSkillAppraisal(skill);
    }
    public List<SkillAppraisal> skillAppraisalCount(SkillAppraisal skill){ return  skillAppraisalDao.skillAppraisalCount(skill); }
    public List<SkillAppraisal> scoreSituation (SkillAppraisal skill){ return skillAppraisalDao.scoreSituation(skill); };
    public void updateScoreSituationById(SkillAppraisal skill){ skillAppraisalDao.updateScoreSituationById(skill);};

    @Override
    public void getStudentExcelTemplate(HttpServletResponse response) {
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建sheet
        HSSFSheet sheet=wb.createSheet();
        //创建一行提示性文字
       this.createTipContent(wb, sheet);
       //创建一行标题
        this.createHeaderContent(wb, sheet);
        //创建模板数据
        this.createTemplateContent(wb, sheet, response);
    }
    //创建模板数据
    void createTemplateContent(HSSFWorkbook  wb,HSSFSheet sheet, HttpServletResponse response){
        //专业-班级-学生数据
        List<SelectGroupForExcel> cascades=this.skillAppraisalDao.getMajorClassesName();
        //学制数据
        List<String> schoolSystem=this.skillAppraisalDao.getSchoolSystem();

        String[] schoolSystemArr=new String[schoolSystem.size()];
        schoolSystemArr=schoolSystem.toArray(schoolSystemArr);

        //学制
        CellRangeAddressList schoolSystemRegions = new CellRangeAddressList(2, 65535, 3, 3);
        DVConstraint schoolSystemConstraint = DVConstraint.createExplicitListConstraint(schoolSystemArr);
        HSSFDataValidation courseNameValidation = new HSSFDataValidation(schoolSystemRegions, schoolSystemConstraint);
        courseNameValidation.createErrorBox("错误", "请输入有效的学制,或从下拉框中选择!");
        sheet.addValidationData(courseNameValidation);
        HSSFCellStyle textS = wb.createCellStyle();
        HSSFDataFormat form = wb.createDataFormat();
        textS.setDataFormat(form.getFormat("@"));
        for (int i = 2; i < 10000; i++) {
            HSSFRow row = sheet.createRow(i);
            for (int j = 0; j <9; j++) {
                row.createCell(j).setCellStyle(textS);
            }
        }
        //技能鉴定项目名称
        TableDict tableDict = new TableDict();
        tableDict.setText("PROJECT_NAME");
        tableDict.setTableName("T_JW_SKILL");
        tableDict.setWhere("  WHERE VALID_FLAG='1' ");
        List<String> list5 = commonDao.getTableDictNameBy(tableDict);
        String[] strs5 = new String[list5.size()];

        int end5 = list5.size();
        for (int i = 0; i < end5; i++) {
            strs5[i] = list5.get(i);
        }
        CellRangeAddressList regions5 = new CellRangeAddressList(2, 65535, 4, 4);
        DVConstraint constraint5 = DVConstraint.createExplicitListConstraint(strs5);
        HSSFDataValidation dataValidation5 = new HSSFDataValidation(regions5, constraint5);
        sheet.addValidationData(dataValidation5);


        //专业-班级Map
        Map<String,String[]> majorsMap=new HashMap<>();
        String[] majorsArray=new String[cascades.size()];

        //班级-学生Map
        Map<String, String[]> classesMap=new HashMap<>();
        String[] classesesArray=new String[cascades.size()];

        for(int i=0; i<cascades.size();i++){
            //单个专业
            SelectGroupForExcel tempMajor=cascades.get(i);
            majorsArray[i]="_"+tempMajor.getText();
            //单专业所有班级
            String[] classesArray=new String[tempMajor.getMajor().length];
            //单个专业下的所有班级
            String[] classes=tempMajor.getMajor();

            //生成map->key:专业 val:班级数组
            String key=tempMajor.getText();
            if(key.contains("+")){
                key=key.replace("+","_");
            }
            majorsMap.put(key, classes);


        }

        //专业班级隐藏sheet
        HSSFSheet major_classes_sheet=wb.createSheet("major_classes");
        wb.setSheetHidden(wb.getSheetIndex(major_classes_sheet), true);
        sheet.setForceFormulaRecalculation(true);
        Iterator<String> majorIterator=majorsMap.keySet().iterator();
        int index=0;
        while (majorIterator.hasNext()){
            String key=majorIterator.next();

            Row row=major_classes_sheet.createRow(index);
            if(key.contains("+")){
                key=key.replace("+","_");
            }
            row.createCell(0).setCellValue("_"+key);

            String[] classes=majorsMap.get(key);

            for(int i=0;i<classes.length;i++){
                row.createCell(i+1).setCellValue(classes[i]);
            }

            String range = this.getRange(1, index+1, classes.length);
            Name name=this.validateLetter(wb, key);
            String formula = "major_classes!" + range;
            name.setRefersToFormula(formula);
            index++;
        }


        //专业验证
        HSSFDataValidationHelper majorsDataValidationHelper = new HSSFDataValidationHelper((HSSFSheet)sheet);
        DataValidationConstraint provConstraint = majorsDataValidationHelper.createExplicitListConstraint(majorsArray);
        CellRangeAddressList provRangeAddressList = new CellRangeAddressList(2, 65535, 0, 0);
        DataValidation majorsDataValidation = majorsDataValidationHelper.createValidation(provConstraint, provRangeAddressList);
        majorsDataValidation.createErrorBox("错误", "请输入有效的专业,或从下拉框中选择!");
        sheet.addValidationData(majorsDataValidation);

        //班级验证
        // INDIRECT(INDIRECT("R"&ROW()&"C"&COLUMN()-1,FALSE)):取当前单元格左侧的单元格去名称管理器查询
        DVConstraint formula = DVConstraint.createFormulaListConstraint("INDIRECT(INDIRECT(\"R\"&ROW()&\"C\"&COLUMN()-1,FALSE))");
        CellRangeAddressList rangeAddressList = new CellRangeAddressList(2, 65535, 1, 1);
        DataValidation classesDataValidation = new HSSFDataValidation(rangeAddressList, formula);
        classesDataValidation.createErrorBox("错误", "请输入有效的班级,或从下拉框中选择!");
        sheet.addValidationData(classesDataValidation);

        // 导出
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("鉴定项目申请模板.xls", "utf-8"));
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

    //验证字符串
    Name validateLetter(HSSFWorkbook wb, String key){
        Name name = wb.createName();
        try {
            name.setNameName("_"+key);
        }catch (Exception e){
            if(e instanceof IllegalArgumentException){
                String regEx = "[ `~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#%……&*（）+|{}【】‘；：”“’。，、？]|\n|\r|\t";
                Pattern pattern=Pattern.compile(regEx);
                Matcher matcher=pattern.matcher(key);
                while(matcher.find()){
                    String letter=matcher.group();
                    key=key.replace(letter, "_");
                }
                key="_"+key;
            }
            name.setNameName(key);
        }
        return name;
    }

    //创建一行提示性文字
    void createTipContent(HSSFWorkbook wb, HSSFSheet sheet){
        //创建提示文字样式
        HSSFCellStyle tipStyle=wb.createCellStyle();
        //创建提示文字
        HSSFFont tipFont=wb.createFont();
        tipFont.setFontHeightInPoints((short)10);
        tipFont.setColor(HSSFColor.RED.index);

        tipStyle.setFont(tipFont);
        tipStyle.setWrapText(true);

        //提示文字的行对象
        Row row=sheet.createRow(0);
        row.setHeightInPoints(50f);
        row.setRowStyle(tipStyle);

        //提示文字行添加文字
        Cell tipCell_0=row.createCell(0);
        tipCell_0.setCellValue("说明：此项为必填项");
        Cell tipCell_1=row.createCell(1);
        tipCell_1.setCellValue("说明：此项为必填项");
        Cell tipCell_2=row.createCell(2);
        tipCell_2.setCellValue("说明：此项为必填项\n(格式1999-01)");
        Cell tipCell_3=row.createCell(3);
        tipCell_3.setCellValue("说明：此项为必填项");
        Cell tipCell_4=row.createCell(4);
        tipCell_4.setCellValue("说明：此项为必填项");
        Cell tipCell_5=row.createCell(5);
        tipCell_5.setCellValue("说明：此项为必填项");
        Cell tipCell_6=row.createCell(6);
        tipCell_6.setCellValue("说明：此项为必填项");
        Cell tipCell_7=row.createCell(7);
        tipCell_7.setCellValue("说明：此项为必填项\n(格式1999-01-01)");
        Cell tipCell_8=row.createCell(8);
        tipCell_8.setCellValue("说明：此项为必填项");
        Cell tipCell_9=row.createCell(9);
        tipCell_9.setCellValue("说明：此项为必填项");
    }
    //创建一行标题
    void createHeaderContent(HSSFWorkbook wb, HSSFSheet sheet){
        //创建列头文字对象
        HSSFFont headerFont=wb.createFont();
        headerFont.setBold(true);
        headerFont.setFontHeightInPoints((short)10);
        //创建列头样式
        HSSFCellStyle headerStyle=wb.createCellStyle();
        headerStyle.setFont(headerFont);
        headerStyle.setAlignment(HSSFCellStyle.ALIGN_GENERAL);
        headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        headerStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);  //填充单元格
        headerStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
        //创建列头行对象
        Row row=sheet.createRow(1);
        //填充列标题
        Cell cell_0=row.createCell(0);
        cell_0.setCellStyle(headerStyle);
        cell_0.setCellValue("专业");
        Cell cell_1=row.createCell(1);
        cell_1.setCellStyle(headerStyle);
        cell_1.setCellValue("班级");
        Cell cell_2=row.createCell(2);
        cell_2.setCellStyle(headerStyle);
        cell_2.setCellValue("入学时间");
        Cell cell_3=row.createCell(3);
        cell_3.setCellStyle(headerStyle);
        cell_3.setCellValue("学制");
        Cell cell_4=row.createCell(4);
        cell_4.setCellStyle(headerStyle);
        cell_4.setCellValue("项目名称");
        Cell cell_5=row.createCell(5);
        cell_5.setCellStyle(headerStyle);
        cell_5.setCellValue("级别");
        Cell cell_6=row.createCell(6);
        cell_6.setCellStyle(headerStyle);
        cell_6.setCellValue("姓名");
        Cell cell_7=row.createCell(7);
        cell_7.setCellStyle(headerStyle);
        cell_7.setCellValue("拟鉴定时间");
        Cell cell_8=row.createCell(8);
        cell_8.setCellStyle(headerStyle);
        cell_8.setCellValue("项目级别");
        Cell cell_9=row.createCell(9);
        cell_9.setCellStyle(headerStyle);
        cell_9.setCellValue("发证机关");
    }
    /**
     * 设置excel用名称管理器(计算formula)
     * @param offset 偏移量，如果给0，表示从A列开始，1，就是从B列
     * @param rowId 第几行
     * @param colCount 一共多少列
     * @return 如果给入参 1,1,10. 表示从B1-K1。最终返回 $B$1:$K$1
     * @author
     */
    private String getRange(int offset, int rowId, int colCount) {
        char start = (char)('A' + offset);
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

    @Override
    public String checkIsImport() {
        return this.skillAppraisalDao.checkIsImport();
    }
}
