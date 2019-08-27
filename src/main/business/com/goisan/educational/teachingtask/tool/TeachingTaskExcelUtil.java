package com.goisan.educational.teachingtask.tool;

import com.goisan.educational.teachingtask.bean.TeachingTask;
import com.goisan.system.bean.Emp;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.util.CellRangeAddress;

import java.io.OutputStream;
import java.util.*;

/**
 * @function: 教学任务导出工具类
 * @author: ZhangHao
 * @date: 2018/10/24
 */
public class TeachingTaskExcelUtil {

    /**
     * @function: 导出模板主方法
     * @author: ZhangHao
     * @date: 2018/10/27
     */
    public boolean writeTeachingTaskExcelTemplate(OutputStream os, String deptName, Emp user, String semester){

        try {

            if(os != null && checkStringEmpty(deptName) && user != null && checkStringEmpty(semester)){

                HSSFWorkbook workbook = new HSSFWorkbook();
                workbook.createSheet("sheet1");

                HSSFSheet sheet = workbook.getSheet("sheet1");

                this.readTitle1(workbook, sheet, "系(部)教师落课一览表(汇总）");
                this.readTitle2(workbook, sheet, semester);
                this.readTitle3(workbook, sheet, deptName, user.getName(), user.getIdCard(),user.getStaffId());
                this.readExcelTr(workbook, sheet);

                HSSFCellStyle sheetStyle = workbook.createCellStyle();
                DataFormat format = workbook.createDataFormat();
                sheetStyle.setDataFormat(format.getFormat("@"));

                sheet.setDefaultColumnStyle(1,sheetStyle);
                sheet.setDefaultColumnStyle(2,sheetStyle);
                sheet.setDefaultColumnStyle(3,sheetStyle);
                sheet.setDefaultColumnStyle(4,sheetStyle);
                sheet.setDefaultColumnStyle(5,sheetStyle);
                sheet.setDefaultColumnStyle(6,sheetStyle);
                sheet.setDefaultColumnStyle(7,sheetStyle);
                sheet.setDefaultColumnStyle(8,sheetStyle);
                sheet.setDefaultColumnStyle(9,sheetStyle);

                workbook.write(os);
            }

        } catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }

    /**
     * @function: 模板第一行填充数据
     * @author: ZhangHao
     * @date: 2018/10/27
     */
    private boolean readTitle1(HSSFWorkbook workbook, HSSFSheet sheet, String titleName){

        try {

            sheet.addMergedRegion(new CellRangeAddress(0,0,0,11));//合并单元格

            HSSFRow row1= sheet.createRow(0);

            row1.setHeight((short) 510);

            HSSFCell cell1 = row1.createCell(0);
            HSSFCellStyle titleStyle = workbook.createCellStyle();
            titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

            HSSFFont titleFont  = workbook.createFont();
            titleFont.setFontName("宋体");
            titleFont.setFontHeightInPoints((short) 20);
            titleFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            titleStyle.setFont(titleFont);

            cell1.setCellStyle(titleStyle);
            cell1.setCellValue(titleName);

            return true;

        }catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }

    /**
     * @function: 模板第二行填充数据
     * @author: ZhangHao
     * @date: 2018/10/27
     */
    private boolean readTitle2(HSSFWorkbook workbook, HSSFSheet sheet, String semester){

        try {

            sheet.addMergedRegion(new CellRangeAddress(1,1,0,11));//合并单元格

            HSSFRow row1= sheet.createRow(1);

            row1.setHeight((short) 510);

            HSSFCell cell1 = row1.createCell(0);
            HSSFCellStyle titleStyle = workbook.createCellStyle();
            titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

            HSSFFont titleFont  = workbook.createFont();
            titleFont.setFontName("宋体");
            titleFont.setFontHeightInPoints((short) 12);
            titleFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            titleStyle.setFont(titleFont);

            cell1.setCellStyle(titleStyle);
            cell1.setCellValue(semester);

            return true;

        }catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }

    /**
     * @function: 模板第三行填充数据
     * @author: ZhangHao
     * @date: 2018/10/27
     */
    private boolean readTitle3(HSSFWorkbook workbook, HSSFSheet sheet, String deptName, String userName, String userIdCard,String staffd){

        try {

            HSSFRow row1= sheet.createRow(2);

            row1.setHeight((short) 510);

            HSSFCellStyle titleStyle = workbook.createCellStyle();
            titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

            HSSFFont titleFont  = workbook.createFont();
            titleFont.setFontName("宋体");
            titleFont.setFontHeightInPoints((short) 12);
            titleFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            titleStyle.setFont(titleFont);

            DataFormat format = workbook.createDataFormat();
            titleStyle.setDataFormat(format.getFormat("@"));

            HSSFCell cell1 = row1.createCell(0);
            cell1.setCellStyle(titleStyle);
            cell1.setCellValue("系（部）名称：");

            cell1 = row1.createCell(1);
            cell1.setCellStyle(titleStyle);
            cell1.setCellValue(deptName);

            cell1 = row1.createCell(2);
            cell1.setCellStyle(titleStyle);
            cell1.setCellValue("填表人：");

            cell1 = row1.createCell(3);
            cell1.setCellStyle(titleStyle);
            cell1.setCellValue(userName);

            cell1 = row1.createCell(4);
            cell1.setCellStyle(titleStyle);
            cell1.setCellValue("填表人身份证号：");

            cell1 = row1.createCell(5);
            cell1.setCellStyle(titleStyle);
            cell1.setCellValue(userIdCard);

            cell1 = row1.createCell(6);
            cell1.setCellStyle(titleStyle);
            cell1.setCellValue("填表人编号：");

            cell1 = row1.createCell(7);
            cell1.setCellStyle(titleStyle);
            cell1.setCellValue(staffd);

            cell1 = row1.createCell(8);
            cell1.setCellStyle(titleStyle);
            cell1.setCellValue("填表时间：");

            cell1 = row1.createCell(9);
            cell1.setCellStyle(titleStyle);
            cell1.setCellValue("20 年 月 日");

            return true;

        }catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }

    /**
     * @function: 模板表头填充
     * @author: ZhangHao
     * @date: 2018/10/27
     */
    private boolean readExcelTr(HSSFWorkbook workbook, HSSFSheet sheet){

        try {

            HSSFCellStyle trStyle = workbook.createCellStyle();//生成样式

            trStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
            trStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中

            trStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
            trStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
            trStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
            trStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框

            HSSFFont trFont  = workbook.createFont();//生成字体

            trFont.setFontName("宋体");//字体样式
            trFont.setFontHeightInPoints((short) 10);//字体大小
            trFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
            trStyle.setFont(trFont);//装配字体

            HSSFRow row3 = sheet.createRow(3);

            row3.setHeight((short) 420);

            List<String> title_cn_list = this.getCnTrList();

            for(int i = 0; i < title_cn_list.size(); i++){

                HSSFCell cell3= row3.createCell(i);

                cell3.setCellStyle(trStyle);
                cell3.setCellValue(title_cn_list.get(i));

                sheet.autoSizeColumn(i);
            }

        } catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }

    /**
     * @function: 模板固定表头
     * @author: ZhangHao
     * @date: 2018/10/27
     */
    private List<String> getCnTrList(){

        List<String> title_cn_list = new LinkedList<>();

        title_cn_list.add("序号");
        title_cn_list.add("教师姓名");
        title_cn_list.add("身份证号");
        title_cn_list.add("任课班级");
        title_cn_list.add("班级人数");
        title_cn_list.add("课程名称");
        title_cn_list.add("周学时");
        title_cn_list.add("已聘职称");
        title_cn_list.add("非本系（部）注明部门或单位");
        title_cn_list.add("备注");
        title_cn_list.add("考核方式");
        title_cn_list.add("教师编号");

        return title_cn_list;
    }

    /**
     * @function: 数据导出主方法
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    public boolean writeTeachingTaskExcelData(OutputStream os, String semester, TeachingTask firstTeachingTask, List<TeachingTask> dataList,String fileName){

        try {

            if(os != null && checkStringEmpty(semester) && firstTeachingTask != null){

                HSSFWorkbook workbook = new HSSFWorkbook();
                workbook.createSheet("sheet1");

                HSSFSheet sheet = workbook.getSheet("sheet1");
                if("".equals(fileName) || null == fileName){
                    this.readTitleForData1(workbook, sheet, "系(部)教师落课一览表(汇总）");
                }else{
                    this.readTitleForData1(workbook, sheet, fileName);
                }
                this.readTitleForData2(workbook, sheet, semester);
                this.readTitleForData3(workbook, sheet, firstTeachingTask.getDepartmentName(), firstTeachingTask.getPreparedByName(), firstTeachingTask.getPreparedTime());
                this.readExcelTrForData(workbook, sheet);
                this.outData(workbook, sheet, dataList);

                HSSFCellStyle sheetStyle = workbook.createCellStyle();
                DataFormat format = workbook.createDataFormat();
                sheetStyle.setDataFormat(format.getFormat("@"));

                sheet.setDefaultColumnStyle(1,sheetStyle);
                sheet.setDefaultColumnStyle(2,sheetStyle);
                sheet.setDefaultColumnStyle(3,sheetStyle);
                sheet.setDefaultColumnStyle(4,sheetStyle);
                sheet.setDefaultColumnStyle(5,sheetStyle);
                sheet.setDefaultColumnStyle(6,sheetStyle);
                sheet.setDefaultColumnStyle(7,sheetStyle);
                sheet.setDefaultColumnStyle(8,sheetStyle);
                sheet.setDefaultColumnStyle(9,sheetStyle);
                workbook.write(os);
            }

        } catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }

    /**
     * @function: 准备导出Excel第一行表头
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    private boolean readTitleForData1(HSSFWorkbook workbook, HSSFSheet sheet, String titleName){

        try {

            sheet.addMergedRegion(new CellRangeAddress(0,0,0,9));//合并单元格

            HSSFRow row1= sheet.createRow(0);

            row1.setHeight((short) 510);

            HSSFCell cell1 = row1.createCell(0);
            HSSFCellStyle titleStyle = workbook.createCellStyle();
            titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

            HSSFFont titleFont  = workbook.createFont();
            titleFont.setFontName("宋体");
            titleFont.setFontHeightInPoints((short) 20);
            titleFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            titleStyle.setFont(titleFont);

            cell1.setCellStyle(titleStyle);
            cell1.setCellValue(titleName);

            return true;

        }catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }

    /**
     * @function: 准备导出Excel第二行表头
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    private boolean readTitleForData2(HSSFWorkbook workbook, HSSFSheet sheet, String semester){

        try {

            sheet.addMergedRegion(new CellRangeAddress(1,1,0,9));//合并单元格

            HSSFRow row1= sheet.createRow(1);

            row1.setHeight((short) 300);

            HSSFCell cell1 = row1.createCell(0);
            HSSFCellStyle titleStyle = workbook.createCellStyle();
            titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

            HSSFFont titleFont  = workbook.createFont();
            titleFont.setFontName("宋体");
            titleFont.setFontHeightInPoints((short) 12);
            titleStyle.setFont(titleFont);

            cell1.setCellStyle(titleStyle);
            cell1.setCellValue(semester);

            return true;

        }catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }

    /**
     * @function: 准备导出Excel第三行表头
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    private boolean readTitleForData3(HSSFWorkbook workbook, HSSFSheet sheet, String deptName, String preparedByName, String preparedTime){

        try {

            sheet.addMergedRegion(new CellRangeAddress(2,2,0,9));//合并单元格

            HSSFRow row1= sheet.createRow(2);

            row1.setHeight((short) 300);

            HSSFCell cell1 = row1.createCell(0);
            HSSFCellStyle titleStyle = workbook.createCellStyle();
            titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

            HSSFFont titleFont  = workbook.createFont();
            titleFont.setFontName("宋体");
            titleFont.setFontHeightInPoints((short) 12);
            titleFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            titleStyle.setFont(titleFont);

            cell1.setCellStyle(titleStyle);
            cell1.setCellValue("系（部）名称："+deptName+" 填表人："+preparedByName+" 填表时间："+preparedTime);

            return true;

        }catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }

    /**
     * @function: 准备导出Excel列头
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    private boolean readExcelTrForData(HSSFWorkbook workbook, HSSFSheet sheet){

        try {

            HSSFCellStyle trStyle = workbook.createCellStyle();//生成样式

            trStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
            trStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中

            trStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
            trStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
            trStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
            trStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框

            HSSFFont trFont  = workbook.createFont();//生成字体

            trFont.setFontName("宋体");//字体样式
            trFont.setFontHeightInPoints((short) 10);//字体大小
            trFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
            trStyle.setFont(trFont);//装配字体

            HSSFRow row3 = sheet.createRow(3);

            row3.setHeight((short) 420);

            List<String> title_cn_list = this.getCnTrListForData();

            for(int i = 0; i < title_cn_list.size(); i++){

                HSSFCell cell3= row3.createCell(i);

                cell3.setCellStyle(trStyle);
                cell3.setCellValue(title_cn_list.get(i));
            }

        } catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }

    /**
     * @function: 数据导出
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    private boolean outData(HSSFWorkbook workbook, HSSFSheet sheet, List<TeachingTask> dataList){

        try {
            if(dataList != null && dataList.size() > 0){
                Map<String,List<TeachingTask>> dataMap = new HashMap<>();
                for(TeachingTask teachingTask : dataList){
                    if(teachingTask != null){
                        List<TeachingTask> tempList = dataMap.get(teachingTask.getTeacherId());
                        if(tempList == null){
                            tempList = new ArrayList<>();
                        }
                        tempList.add(teachingTask);
                        dataMap.put(teachingTask.getTeacherId(),tempList);
                    }
                }

                if(dataMap.size() > 0){

                    HSSFCellStyle trStyle = workbook.createCellStyle();//生成样式

                    trStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
                    trStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中

                    trStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
                    trStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
                    trStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
                    trStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框

                    HSSFFont trFont  = workbook.createFont();//生成字体

                    trFont.setFontName("宋体");//字体样式
                    trFont.setFontHeightInPoints((short) 10);//字体大小
                    trStyle.setFont(trFont);//装配字体

                    int i = 1;

                    for (String teacherId : dataMap.keySet()){
                        List<TeachingTask> tempList = dataMap.get(teacherId);
                        if(tempList != null && tempList.size() > 0){

                            int j = i+3;
                            int allTime = 0;

                            for(TeachingTask teachingTask : tempList){

                                if(teachingTask != null){

                                    HSSFRow row = sheet.createRow(i+3);

                                    HSSFCell cell= row.createCell(0);
                                    cell.setCellStyle(trStyle);
                                    cell.setCellValue(i);

                                    cell= row.createCell(1);
                                    cell.setCellStyle(trStyle);
                                    cell.setCellValue(teachingTask.getTeacherName());

//                                    cell= row.createCell(2);
//                                    cell.setCellStyle(trStyle);
//                                    cell.setCellValue(teachingTask.getClassName());

                                    cell= row.createCell(2);
                                    cell.setCellStyle(trStyle);
                                    if("".equals(teachingTask.getStudentNum()) || null == teachingTask.getStudentNum()){
                                        cell.setCellValue(teachingTask.getClassName()+"(0人)");
                                    }else{
                                        cell.setCellValue(teachingTask.getClassName()+"("+teachingTask.getStudentNum()+"人)");
                                    }

                                    cell= row.createCell(3);
                                    cell.setCellStyle(trStyle);
                                    cell.setCellValue(teachingTask.getCourseName());

                                    cell= row.createCell(4);
                                    cell.setCellStyle(trStyle);
                                    cell.setCellValue(teachingTask.getWeekTime());
                                    if (null!=teachingTask.getWeekTime()&&!"".equals(teachingTask.getWeekTime())) {
                                        allTime += Integer.parseInt(teachingTask.getWeekTime());
                                    }
                                    cell= row.createCell(5);
                                    cell.setCellStyle(trStyle);

                                    cell= row.createCell(6);
                                    cell.setCellStyle(trStyle);
                                    cell.setCellValue(teachingTask.getEmployedTitle());

                                    cell= row.createCell(7);
                                    cell.setCellStyle(trStyle);
                                    cell.setCellValue(teachingTask.getOtherDept());

                                    cell= row.createCell(8);
                                    cell.setCellStyle(trStyle);
                                    cell.setCellValue(teachingTask.getRemarks());

                                    cell= row.createCell(9);
                                    cell.setCellStyle(trStyle);
                                    cell.setCellValue(teachingTask.getStaffId());

                                    i++;
                                }
                            }

                            HSSFRow row = sheet.getRow(j);
                            HSSFCell cell= row.getCell(5);
                            cell.setCellValue(allTime);

                            if(tempList.size() > 1){

                                sheet.addMergedRegion(new CellRangeAddress(j,j+tempList.size()-1,0,0));
                                sheet.addMergedRegion(new CellRangeAddress(j,j+tempList.size()-1,1,1));
                                sheet.addMergedRegion(new CellRangeAddress(j,j+tempList.size()-1,5,5));
                                sheet.addMergedRegion(new CellRangeAddress(j,j+tempList.size()-1,6,6));
                                sheet.addMergedRegion(new CellRangeAddress(j,j+tempList.size()-1,7,7));
                                sheet.addMergedRegion(new CellRangeAddress(j,j+tempList.size()-1,8,8));
                            }

                            sheet.autoSizeColumn(0);
                            sheet.autoSizeColumn(1);
                            sheet.autoSizeColumn(2);
                            sheet.autoSizeColumn(3);
                            sheet.autoSizeColumn(4);
                            sheet.autoSizeColumn(5);
                            sheet.autoSizeColumn(6);
                            sheet.autoSizeColumn(7);
                            sheet.autoSizeColumn(8);
                            sheet.autoSizeColumn(9);
                            sheet.autoSizeColumn(10);
                        }
                    }
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }

    /**
     * @function: Excel导出列头数据
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    private List<String> getCnTrListForData(){

        List<String> title_cn_list = new LinkedList<>();

        title_cn_list.add("序号");
        title_cn_list.add("教师姓名");
//        title_cn_list.add("班级");
        title_cn_list.add("任课班级及人数");
        title_cn_list.add("课程名称");
        title_cn_list.add("周学时");
        title_cn_list.add("周学时合计");
        title_cn_list.add("已聘职称");
        title_cn_list.add("非本系（部）注明部门或单位");
        title_cn_list.add("备注");
        title_cn_list.add("编号");

        return title_cn_list;
    }

    /**
     * @function: 自用非空字符串验证方法
     * @author: ZhangHao
     * @date: 2018/10/27
     */
    private boolean checkStringEmpty(String str){

        return str!=null && !"".equals(str);
    }
}
