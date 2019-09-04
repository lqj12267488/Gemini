package com.goisan.studentwork.graduatearchivesaddress.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.studentwork.graduatearchivesaddress.bean.Arcad;
import com.goisan.studentwork.graduatearchivesaddress.service.ArcadServcie;
import com.goisan.studentwork.studentinsurance.bean.StudentInsurance;
import com.goisan.system.bean.Student;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
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
import java.util.*;


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
//            检查是否详情是否存在
          return  arcadServcie.insertArcad(arcad);
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

        setHSSFPrompt(sheet, "", "", 1, 65535, 0, 0);
        setHSSFPrompt(sheet, "", "", 1, 65535, 1, 1);
        setHSSFPrompt(sheet, "", "", 1, 65535, 2, 2);
        setHSSFPrompt(sheet, "", "", 1, 65535, 3, 3);
        setHSSFPrompt(sheet, "", "", 1, 65535, 4, 4);

        //查询所有省列表
       List<String> list =  arcadServcie.findProvince();
       //查询所有市
       List<String> listCity =  arcadServcie.findAllCity();
        //保存各省的市 各市的县
        HashMap<String, List<String>> hashMap = new HashMap<>();

        //保存所有省市数据
        List<String> linkedList = new LinkedList<>();
        int num4 = 0;
        int num5 = 0;
        int num6 = 0;

        List<String> cityList = null;
        List<String> countyList = null;
        //查询省对应市列表
        for (String str : list) {
            List<String> list1 =   arcadServcie.select(str);
            if (list1.size()==1) {
                cityList =  arcadServcie.findCity(str);
                //保存省市对应关系
                hashMap.put(str,cityList);
            }else{
                for (String s : list1) {
                    cityList =   arcadServcie.findCity1(s);
                    hashMap.put(str,cityList);
                }
            }
        }

        for (String str : listCity) {
            List<String> list1 =   arcadServcie.find(str);
            if (list1.size()==1) {
                countyList =  arcadServcie.findCounty(str);
                hashMap.put(str,countyList);
            }else{
                for (String s : list1) {
                    if (str.equals("县")) {
                        countyList =  arcadServcie.findCounty1(s);
                        if (num4==0)
                            hashMap.put("上海市"+str,countyList);
                        else if (num4==1)
                            hashMap.put("天津市"+str,countyList);
                        else if (num4==2)
                            hashMap.put("北京市"+str,countyList);
                        else if (num4==3){
                            hashMap.put("重庆市"+str,countyList);
                            num4=0;
                        }
                        num4++;
                    }
                    else if (str.equals("省直辖县级行政区划")){
                        if (num5==0)
                            hashMap.put("海南省"+str,countyList);
                        if (num5==1)
                            hashMap.put("河南省"+str,countyList);
                        if (num5==2){
                            hashMap.put("湖北省"+str,countyList);
                            num5=0;
                        }
                        num5++;
                    }
                    else if (str.equals("市辖区")){

                        if (num6==0){
                           List<String> listBj =  arcadServcie.findBj();
                            hashMap.put("北京市"+str,listBj);
                        }
                        if (num6==1){
                            List<String> listTj =  arcadServcie.findTj();
                            hashMap.put("天津市"+str,listTj);
                        }
                        if (num6==2){
                            List<String> listSh =  arcadServcie.findSh();
                            hashMap.put("上海市"+str,listSh);
                        }
                        if (num6==3){
                            List<String> listCq =  arcadServcie.findCq();
                            hashMap.put("重庆市"+str,listCq);
                            num6=0;
                        }
                        num6++;
                    }else {
                        countyList =  arcadServcie.findCounty1(s);
                        hashMap.put(str,countyList);
                    }

                }
            }
        }

        linkedList.addAll(list);
        for (int i = 0; i < linkedList.size(); i++) {
            List<String> list1 =   arcadServcie.select(linkedList.get(i));
            if (list1.size()==1) {
                List<String> city = arcadServcie.findCity(linkedList.get(i));
                linkedList.addAll(city);
            }else{
                for (String s : list1) {
                    List<String> county1 = arcadServcie.findCity1(s);
                    linkedList.addAll(county1);
                }
            }

        }
        linkedList.add("北京市县");
        linkedList.add("上海市县");
        linkedList.add("天津市县");
        linkedList.add("重庆市县");
        linkedList.add("北京市市辖区");
        linkedList.add("上海市市辖区");
        linkedList.add("天津市市辖区");
        linkedList.add("重庆市市辖区");
        linkedList.add("海南省省直辖县级行政区划");
        linkedList.add("河南省省直辖县级行政区划");
        linkedList.add("湖北省省直辖县级行政区划");

        String[] listArray = list.toArray(new String[list.size()]);

        HSSFSheet sheet3 = wb.createSheet("Sheet3");
        wb.setSheetHidden(1, 1);
        int rowId = 0;
        String formula1 = "";
        String range = "";
        for (int i = 0; i < linkedList.size(); i++) {
            String key = linkedList.get(i);
            List<String> son = hashMap.get(key);
            Row row = sheet3.createRow(rowId++);
            row.createCell(0).setCellValue(key);
            if (son==null || son.size()==0) {
                Cell cell = row.createCell(0);
                cell.setCellValue("");
                // 添加名称管理器
                range = getRange(1, rowId, 0);
            }else{
                for (int j = 0; j < son.size(); j++) {
                    Cell cell = row.createCell(j + 1);
                    if (son.get(j).equals("县")|| son.get(j).equals("市辖区")) {
                        cell.setCellValue(key+son.get(j));
                    }
                    else if (son.get(j).equals("省直辖县级行政区划")) {
                        cell.setCellValue(key+son.get(j));
                    }
                    else{
                        cell.setCellValue(son.get(j));
                    }

                }
                // 添加名称管理器
                 range = getRange(1, rowId, son.size());
            }



            Name name = wb.createName();
            //name.setNameName(key);
            //key不可重复

            if (key.equals("县")||key.equals("市辖区")||key.equals("省直辖县级行政区划")){

            }else{
                name.setNameName(key);
            }
            formula1 = "Sheet3!" + range;
            name.setRefersToFormula(formula1);
        }

        setHSSFValidation(sheet, listArray, 2, 65535, 1, 1);

        DVConstraint formula = DVConstraint.createFormulaListConstraint("INDIRECT(INDIRECT(\"R\"&ROW()&\"C\"&COLUMN()-1,FALSE))"); // INDIRECT(INDIRECT("R"&ROW()&"C"&COLUMN()-1,FALSE)):取当前单元格左侧的单元格去名称管理器查询
        CellRangeAddressList rangeAddressList = new CellRangeAddressList(2, 65535, 2 , 3);
        DataValidation majorDataValidation = new HSSFDataValidation(rangeAddressList, formula);
        majorDataValidation.createErrorBox("错误", "请输入有效的专业,或从下拉框中选择!");
        sheet.addValidationData(majorDataValidation);



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

    public static void setHSSFValidation(HSSFSheet sheet, String[] textlist, int firstRow, int endRow, int firstCol, int endCol) {
        // 加载下拉列表内容
        DVConstraint constraint = DVConstraint.createExplicitListConstraint(textlist);
        // 设置数据有效性加载在哪个单元格上,四个参数分别是：起始行、终止行、起始列、终止列
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        // 数据有效性对象
        HSSFDataValidation hssfDataValidation = new HSSFDataValidation(regions, constraint);
        sheet.addValidationData(hssfDataValidation);

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

    public static String getRange(int offset, int rowId, int colCount) {
        char start = (char)('A' + offset);
        if (colCount <= 25) {
            char end = (char)(start + colCount - 1);
            return "$" + start + "$" + rowId + ":$" + end + "$" + rowId;
        } else {
            char endPrefix = 'A';
            char endSuffix = 'A';
            if ((colCount - 25) / 26 == 0 || colCount == 51) {// 26-51之间，包括边界（仅两次字母表计算）
                if ((colCount - 25) % 26 == 0) {// 边界值
                    endSuffix = (char)('A' + 25);
                } else {
                    endSuffix = (char)('A' + (colCount - 25) % 26 - 1);
                }
            } else {// 51以上
                if ((colCount - 25) % 26 == 0) {
                    endSuffix = (char)('A' + 25);
                    endPrefix = (char)(endPrefix + (colCount - 25) / 26 - 1);
                } else {
                    endSuffix = (char)('A' + (colCount - 25) % 26 - 1);
                    endPrefix = (char)(endPrefix + (colCount - 25) / 26);
                }
            }
            return "$" + start + "$" + rowId + ":$" + endPrefix + endSuffix + "$" + rowId;
        }
    }
}
