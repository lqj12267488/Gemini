package com.goisan.educational.major.service.impl;

import com.goisan.educational.major.bean.*;
import com.goisan.educational.major.dao.MajorLeaderDao;
import com.goisan.educational.major.service.MajorLeaderService;
import com.goisan.educational.teacher.bean.TeacherCondition;
import com.goisan.studentwork.employments.bean.Employments;
import com.goisan.system.bean.CommonBean;
import com.goisan.system.bean.EmpDeptTree;
import com.goisan.system.tools.CommonUtil;
import org.apache.poi.hssf.usermodel.HSSFPalette;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/5/18.
 */
@Service
public class MajorLeaderServiceImpl implements MajorLeaderService {
    @Resource
    private MajorLeaderDao majorLeaderDao;

    @Override
    public List<TalentTrain> getTalentTrainByPlanName(TalentTrain talentTrain) {

        return this.majorLeaderDao.getTalentTrainByPlanName(talentTrain);
    }

    public void majorLeaderExpertExcel(HttpServletResponse response, MajorLeader m){
        HSSFWorkbook workbook = new HSSFWorkbook();
        Sheet sheet = workbook.createSheet("专业带头人信息表");
        // 标题部分
        CellStyle titleStyle = workbook.createCellStyle();
        Font titleFont = workbook.createFont();
        titleFont.setFontName("宋体");
        titleFont.setFontHeightInPoints((short)26);
        titleStyle.setAlignment(CellStyle.ALIGN_CENTER);
        titleStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        titleStyle.setFont(titleFont);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 24));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 24));
        int rowNum = 0;
        Cell title1 = sheet.createRow(rowNum++).createCell(0);
        String xxmc = CommonBean.getParamValue("SZXXMC");
        title1.setCellValue(xxmc);
        title1.setCellStyle(titleStyle);
        Cell title2 = sheet.createRow(rowNum++).createCell(0);
        title2.setCellValue("专业带头人情况统计表");
        title2.setCellStyle(titleStyle);
        m.setPersonType("1");

        CellStyle cellStyle0 = workbook.createCellStyle();

        cellStyle0.setAlignment(HorizontalAlignment.CENTER);
        cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle0.setWrapText(true);
        Font contentFont=workbook.createFont();
        contentFont.setFontName("宋体");
        contentFont.setFontHeightInPoints((short)10);
        cellStyle0.setFont(contentFont);
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 0, 0));//序号
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 1, 1));//专业所属系部
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 2, 2));//专业代码
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 3, 3));//专业名称（全称）
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 4, 4));//教师性质
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 5, 5));//教工号
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 6, 6));//姓名
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 7, 7));//性别
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 8, 8));//出生日期
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 9, 9));//学历
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 10, 10));//学位
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 11, 11));//工作单位名称（全称）
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 12, 12));//职务
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 13, 13));//区号-单位电话号码
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 14, 14));//电子邮箱
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 15, 15));//担任专业带头人工作年限（年）
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 16, 19));//专业技术职务（最高）
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 20, 24));//代表性科研成果（最高）


        sheet.setColumnWidth(0, 18 * 256);
        sheet.setColumnWidth(1, 18 * 256);
        sheet.setColumnWidth(2, 18 * 256);
        sheet.setColumnWidth(3, 18 * 256);
        sheet.setColumnWidth(4, 18 * 256);
        sheet.setColumnWidth(5, 18 * 256);
        sheet.setColumnWidth(6, 18 * 256);
        sheet.setColumnWidth(7, 18 * 256);
        sheet.setColumnWidth(8, 18 * 256);
        sheet.setColumnWidth(9, 18 * 256);
        sheet.setColumnWidth(10, 18 * 256);
        sheet.setColumnWidth(11, 18 * 256);
        sheet.setColumnWidth(12, 18 * 256);
        sheet.setColumnWidth(13, 18 * 256);
        sheet.setColumnWidth(14, 18 * 256);
        sheet.setColumnWidth(15, 18 * 256);
        sheet.setColumnWidth(16, 18 * 256);
        sheet.setColumnWidth(17, 18 * 256);
        sheet.setColumnWidth(18, 18 * 256);
        sheet.setColumnWidth(19, 18 * 256);
        sheet.setColumnWidth(20, 18 * 256);
        sheet.setColumnWidth(21, 18 * 256);
        sheet.setColumnWidth(22, 18 * 256);
        sheet.setColumnWidth(23, 18 * 256);
        sheet.setColumnWidth(24, 18 * 256);

        Row row0 = sheet.createRow(2);
        Row row1 = sheet.createRow(3);

        Cell ce1 = row0.createCell(0);
        ce1.setCellValue("序号");
        ce1.setCellStyle(cellStyle0);

        Cell ce2 = row0.createCell(1);
        ce2.setCellValue("专业所属系部");
        ce2.setCellStyle(cellStyle0);

        Cell ce3 = row0.createCell(2);
        ce3.setCellValue("专业代码");
        ce3.setCellStyle(cellStyle0);

        Cell ce4 = row0.createCell(3);
        ce4.setCellValue("专业名称（全称）");
        ce4.setCellStyle(cellStyle0);

        Cell ce5 = row0.createCell(4);
        ce5.setCellValue("教师性质");
        ce5.setCellStyle(cellStyle0);

        Cell ce6 = row0.createCell(5);
        ce6.setCellValue("教工号");
        ce6.setCellStyle(cellStyle0);

        Cell ce7 = row0.createCell(6);
        ce7.setCellValue("姓名");
        ce7.setCellStyle(cellStyle0);

        Cell ce8 = row0.createCell(7);
        ce8.setCellValue("性别");
        ce8.setCellStyle(cellStyle0);

        Cell ce9 = row0.createCell(8);
        ce9.setCellValue("出生日期");
        ce9.setCellStyle(cellStyle0);

        Cell ce10 = row0.createCell(9);
        ce10.setCellValue("学历");
        ce10.setCellStyle(cellStyle0);

        Cell ce11 = row0.createCell(10);
        ce11.setCellValue("学位");
        ce11.setCellStyle(cellStyle0);

        Cell ce12 = row0.createCell(11);
        ce12.setCellValue("工作单位名称（全称）");
        ce12.setCellStyle(cellStyle0);

        Cell ce13 = row0.createCell(12);
        ce13.setCellValue("职务");
        ce13.setCellStyle(cellStyle0);

        Cell ce14 = row0.createCell(13);
        ce14.setCellValue("区号-单位电话号码");
        ce14.setCellStyle(cellStyle0);

        Cell ce15 = row0.createCell(14);
        ce15.setCellValue("电子邮箱");
        ce15.setCellStyle(cellStyle0);

        Cell ce17 = row0.createCell(15);
        ce17.setCellValue("担任专业带头人工作年限（年）");
        ce17.setCellStyle(cellStyle0);

        Cell ce18 = row0.createCell(16);
        ce18.setCellValue("专业技术职务（最高）");
        ce18.setCellStyle(cellStyle0);

        Cell ce19 = row1.createCell(16);
        ce19.setCellValue("等级");
        ce19.setCellStyle(cellStyle0);

        Cell ce20 = row1.createCell(17);
        ce20.setCellValue("名称（全称）");
        ce20.setCellStyle(cellStyle0);

        Cell ce21 = row1.createCell(18);
        ce21.setCellValue("发证单位（全称）");
        ce21.setCellStyle(cellStyle0);

        Cell ce22 = row1.createCell(19);
        ce22.setCellValue("获取日期（年月）");
        ce22.setCellStyle(cellStyle0);

        Cell ce23 = row0.createCell(20);
        ce23.setCellValue("代表性科研成果（最高）");
        ce23.setCellStyle(cellStyle0);

        Cell ce24 = row1.createCell(20);
        ce24.setCellValue("项目名称（全称）");
        ce24.setCellStyle(cellStyle0);

        Cell ce25 = row1.createCell(21);
        ce25.setCellValue("项目简介");
        ce25.setCellStyle(cellStyle0);

        Cell ce26 = row1.createCell(22);
        ce26.setCellValue("获奖等级");
        ce26.setCellStyle(cellStyle0);

        Cell ce27 = row1.createCell(23);
        ce27.setCellValue("获取日期（年月）");
        ce27.setCellStyle(cellStyle0);

        Cell ce28 = row1.createCell(24);
        ce28.setCellValue("合作情况");
        ce28.setCellStyle(cellStyle0);

        int i = 4;
        int dataNum=1;
        //获取总数据
        List<MajorLeader> majorLeaders = this.majorLeaderDao.getMajorLeaderList(m);
        for (MajorLeader majorLeader : majorLeaders) {
            //每条数据的所有科研成果
            List<ResearchResult> researchResults=this.majorLeaderDao.getResearchResultsByMajorLeaderId(majorLeader.getId());
            //每条数据的科研成果数,注：当每条的科研成果为空时此值为1
            int recordRowNum=researchResults.size()>=1?researchResults.size():1;

            //每条记录所在的行数，注：当每条数据的科研成果为空时此数组长度为1
            Row[] rows=new Row[recordRowNum];

            for(int k=0; k<recordRowNum; k++){
                rows[k] = sheet.createRow(i+k);
            }

            Cell cells0 = rows[0].createCell(0);
            cells0.setCellValue(dataNum++);
            cells0.setCellStyle(cellStyle0);

            Cell cells1 = rows[0].createCell(1);
            cells1.setCellValue(majorLeader.getDepartmentsIdShow());
            cells1.setCellStyle(cellStyle0);

            Cell cells2 = rows[0].createCell(2);
            cells2.setCellValue(majorLeader.getMajorCode());
            cells2.setCellStyle(cellStyle0);

            Cell cells3 = rows[0].createCell(3);
            cells3.setCellValue(majorLeader.getMajorIdShow());
            cells3.setCellStyle(cellStyle0);

            Cell cells4 = rows[0].createCell(4);
            cells4.setCellValue(majorLeader.getTeacherCategoryShow());
            cells4.setCellStyle(cellStyle0);

            Cell cells5 = rows[0].createCell(5);
            cells5.setCellValue(majorLeader.getTeacherNum());
            cells5.setCellStyle(cellStyle0);

            Cell cells6 = rows[0].createCell(6);
            cells6.setCellValue(majorLeader.getPersonIdShow());
            cells6.setCellStyle(cellStyle0);

            Cell cells7 = rows[0].createCell(7);
            cells7.setCellValue(majorLeader.getSexShow());
            cells7.setCellStyle(cellStyle0);

            Cell cells8 = rows[0].createCell(8);
            String bd=majorLeader.getBirthday().substring(0,10);
            cells8.setCellValue(bd);
            cells8.setCellStyle(cellStyle0);

            Cell cells9 = rows[0].createCell(9);
            cells9.setCellValue(majorLeader.getEducation());
            cells9.setCellStyle(cellStyle0);

            Cell cells10 = rows[0].createCell(10);
            cells10.setCellValue(majorLeader.getDegree());
            cells10.setCellStyle(cellStyle0);

            Cell cells11 = rows[0].createCell(11);
            cells11.setCellValue(majorLeader.getWorkDept());
            cells11.setCellStyle(cellStyle0);

            Cell cells12 = rows[0].createCell(12);
            cells12.setCellValue(majorLeader.getPosition());
            cells12.setCellStyle(cellStyle0);

            Cell cells13 = rows[0].createCell(13);
            cells13.setCellValue(majorLeader.getGuHua());
            cells13.setCellStyle(cellStyle0);

            Cell cells14 = rows[0].createCell(14);
            cells14.setCellValue(majorLeader.getEmail());
            cells14.setCellStyle(cellStyle0);

            Cell cells15 = rows[0].createCell(15);
            cells15.setCellValue(majorLeader.getZyWorkDate());
            cells15.setCellStyle(cellStyle0);

            Cell cells16 = rows[0].createCell(16);
            cells16.setCellValue(majorLeader.getPositionLeave());
            cells16.setCellStyle(cellStyle0);

            Cell cells17 = rows[0].createCell(17);
            cells17.setCellValue(majorLeader.getPositionName());
            cells17.setCellStyle(cellStyle0);

            Cell cells18 = rows[0].createCell(18);
            cells18.setCellValue(majorLeader.getOffice());
            cells18.setCellStyle(cellStyle0);

            Cell cells19 = rows[0].createCell(19);
            cells19.setCellValue(majorLeader.getPositionDate());
            cells19.setCellStyle(cellStyle0);

            if(recordRowNum >= 2){ //如果科研成果大于2个时合并单元格
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 0, 0));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 1, 1));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 2, 2));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 3, 3));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 4, 4));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 5, 5));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 6, 6));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 7, 7));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 8, 8));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 9, 9));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 10, 10));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 11, 11));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 12, 12));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 13, 13));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 14, 14));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 15, 15));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 16, 16));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 17, 17));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 18, 18));
                sheet.addMergedRegion(new CellRangeAddress(i, i+recordRowNum-1, 19, 19));
            }

            //循环输出科研成果
            for(int j=0; j<researchResults.size(); j++){
                ResearchResult researchResult=researchResults.get(j);
                Cell cells20 = rows[j].createCell(20);
                cells20.setCellValue(researchResult.getName());
                cells20.setCellStyle(cellStyle0);

                Cell cells21 = rows[j].createCell(21);
                cells21.setCellValue(researchResult.getDetail());
                cells21.setCellStyle(cellStyle0);

                Cell cells22 = rows[j].createCell(22);
                cells22.setCellValue(researchResult.getGetPrizeClass());
                cells22.setCellStyle(cellStyle0);

                Cell cells23 = rows[j].createCell(23);
                cells23.setCellValue(researchResult.getGetDate());
                cells23.setCellStyle(cellStyle0);

                Cell cells24 = rows[j].createCell(24);
                cells24.setCellValue(researchResult.getCooperationDetail());
                cells24.setCellStyle(cellStyle0);
            }
            i = i + recordRowNum;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ( "专业带头人信息表.xls", "utf-8"));
            os = response.getOutputStream();
            workbook.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                }
                workbook.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    public void deleteResearchResultByMajorLeaderId(String majorLeaderId){

        this.majorLeaderDao.deleteResearchResultByMajorLeaderId(majorLeaderId);
    }
    public List<ResearchResult> getResearchResultsByMajorLeaderId(String majorLeaderId){

        return this.majorLeaderDao.getResearchResultsByMajorLeaderId(majorLeaderId);
    }
    public void insertResearchResult(ResearchResult researchResult){

        this.majorLeaderDao.insertResearchResult(researchResult);
    }
    public void expertExcel(HttpServletResponse response, TalentTrain m){
        HSSFWorkbook workbook = new HSSFWorkbook();
        Sheet sheet = workbook.createSheet("专业教学团队情况统计表");
        // 标题部分
        CellStyle titleStyle = workbook.createCellStyle();
        Font titleFont = workbook.createFont();
        titleFont.setFontName("楷体");
        titleFont.setFontHeightInPoints((short) 20);
        titleStyle.setAlignment(CellStyle.ALIGN_CENTER);
        titleStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        titleStyle.setFont(titleFont);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 16));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 16));
        int rowNum = 0;
        Cell title1 = sheet.createRow(rowNum++).createCell(0);
        String xxmc= CommonBean.getParamValue("SZXXMC");
        title1.setCellValue(xxmc);
        title1.setCellStyle(titleStyle);
        Cell title2 = sheet.createRow(rowNum++).createCell(0);
        title2.setCellValue("专业教学团队情况统计表");
        title2.setCellStyle(titleStyle);
        List<TalentTrain> talentTrains = majorLeaderDao.getTeachingTeamList(m);
        CellStyle cellStyle0 = workbook.createCellStyle();
        String tablename = "";


        cellStyle0.setAlignment(HorizontalAlignment.CENTER);
        cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle0.setWrapText(true);
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 0, 0));//团队名称
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 1, 1));//所属专业
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 2, 2));//专业代码

        //sheet.addMergedRegion(new CellRangeAddress(2, 2, 3, 3));//级别
        //sheet.addMergedRegion(new CellRangeAddress(3, 3, 3, 3));//级别描述信息
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 4, 4));//获批时间

        sheet.addMergedRegion(new CellRangeAddress(2, 2, 5, 10));//团队负责人
/*        sheet.addMergedRegion(new CellRangeAddress(3, 3, 5, 10));//团队负责人姓名
        sheet.addMergedRegion(new CellRangeAddress(3, 3, 5, 10));//团队负责人性别
        sheet.addMergedRegion(new CellRangeAddress(3, 3, 5, 10));//团队负责人出生日期
        sheet.addMergedRegion(new CellRangeAddress(3, 3, 5, 10));//团队负责人工作单位
        sheet.addMergedRegion(new CellRangeAddress(3, 3, 5, 10));//团队负责人职务
        sheet.addMergedRegion(new CellRangeAddress(3, 3, 5, 10));//团队负责人职称*/

        sheet.addMergedRegion(new CellRangeAddress(2, 2, 11, 16));//成员
        /*sheet.addMergedRegion(new CellRangeAddress(3, 3, 11, 16));//成员姓名
        sheet.addMergedRegion(new CellRangeAddress(3, 3, 11, 16));//成员性别
        sheet.addMergedRegion(new CellRangeAddress(3, 3, 11, 16));//成员出生日期
        sheet.addMergedRegion(new CellRangeAddress(3, 3, 11, 16));//成员工作单位
        sheet.addMergedRegion(new CellRangeAddress(3, 3, 11, 16));//成员职务
        sheet.addMergedRegion(new CellRangeAddress(3, 3, 11, 16));//成员职称*/

        sheet.setColumnWidth(0, 15 * 256);
        sheet.setColumnWidth(1, 15 * 256);
        sheet.setColumnWidth(2, 15 * 256);
        //级别
        sheet.setColumnWidth(3, 25 * 256);
        sheet.setColumnWidth(4, 15 * 256);
        sheet.setColumnWidth(5, 15 * 256);
        sheet.setColumnWidth(6, 15 * 256);
        sheet.setColumnWidth(7, 15 * 256);
        sheet.setColumnWidth(8, 15 * 256);
        sheet.setColumnWidth(9, 15 * 256);
        sheet.setColumnWidth(10, 15 * 256);
        sheet.setColumnWidth(11, 15 * 256);
        sheet.setColumnWidth(12, 15 * 256);
        sheet.setColumnWidth(13, 15 * 256);
        sheet.setColumnWidth(14, 15 * 256);
        sheet.setColumnWidth(15, 15 * 256);
        sheet.setColumnWidth(16, 15 * 256);

        Row row0 = sheet.createRow(2);
        Row row1 = sheet.createRow(3);

        Cell ce1 = row0.createCell(0);
        ce1.setCellValue("团队名称");
        ce1.setCellStyle(cellStyle0);

        Cell ce2 = row0.createCell(1);
        ce2.setCellValue("所属专业");
        ce2.setCellStyle(cellStyle0);

        Cell ce3 = row0.createCell(2);
        ce3.setCellValue("专业代码");
        ce3.setCellStyle(cellStyle0);

        Cell ce4 = row0.createCell(3);
        ce4.setCellValue("级别");
        ce4.setCellStyle(cellStyle0);

        Cell ce5 = row0.createCell(4);
        ce5.setCellValue("获批时间");
        ce5.setCellStyle(cellStyle0);

        Cell ce16 = row0.createCell(5);
        ce16.setCellValue("团队负责人");
        ce16.setCellStyle(cellStyle0);

        //负责人信息
        Cell ce17 = row1.createCell(5);
        ce17.setCellValue("姓名");
        ce17.setCellStyle(cellStyle0);

        Cell cel8 = row1.createCell(6);
        cel8.setCellValue("性别");
        cel8.setCellStyle(cellStyle0);

        Cell cel9 = row1.createCell(7);
        cel9.setCellValue("出生日期");
        cel9.setCellStyle(cellStyle0);

        Cell cel10 = row1.createCell(8);
        cel10.setCellValue("工作单位");
        cel10.setCellStyle(cellStyle0);

        Cell cel11 = row1.createCell(9);
        cel11.setCellValue("职务");
        cel11.setCellStyle(cellStyle0);

        Cell cel12 = row1.createCell(10);
        cel12.setCellValue("职称");
        cel12.setCellStyle(cellStyle0);


        Cell cel13 = row0.createCell(11);
        cel13.setCellValue("成员");
        cel13.setCellStyle(cellStyle0);
        //成员信息
        Cell cel14 = row1.createCell(11);
        cel14.setCellValue("姓名");
        cel14.setCellStyle(cellStyle0);

        Cell cel15 = row1.createCell(12);
        cel15.setCellValue("性别");
        cel15.setCellStyle(cellStyle0);

        Cell cel16 = row1.createCell(13);
        cel16.setCellValue("出生日期");
        cel16.setCellStyle(cellStyle0);

        Cell cel17 = row1.createCell(14);
        cel17.setCellValue("工作单位");
        cel17.setCellStyle(cellStyle0);

        Cell cel18 = row1.createCell(15);
        cel18.setCellValue("职务");
        cel18.setCellStyle(cellStyle0);

        Cell cel19 = row1.createCell(16);
        cel19.setCellValue("职称");
        cel19.setCellStyle(cellStyle0);

        Cell cel20 = row1.createCell(3);
        cel20.setCellValue("国家级、省级、市级、校级");
        cel20.setCellStyle(cellStyle0);

        int i = 4;

        //记录一条数据工合并多少行单元格
        int lastRowNum=3;
        for (TalentTrain talentTrain : talentTrains) { //每条数据
            //每条数据的所有成员
            List<TeachingTeamMember> members=this.majorLeaderDao.getTeachingTeamMemberById(talentTrain.getId());
            lastRowNum=lastRowNum+1;
            //每条数据的成员占用行数组，第一条数据的行数组索引为
            Row[] rows=new Row[members.size()];

            for(int k=1;k<=members.size();k++){
                rows[k-1]=sheet.createRow(lastRowNum+k-1);
            }

            //团队名单元格添加数据并合并行
            Cell cells0 = rows[0].createCell(0);
            cells0.setCellValue(talentTrain.getPlanName());
            cells0.setCellStyle(cellStyle0);
            if(lastRowNum+rows.length-1>lastRowNum)
                sheet.addMergedRegion(new CellRangeAddress(lastRowNum,lastRowNum+rows.length-1,0,0));

            //专业名单元格添加数据并合并行
            Cell cells1 = rows[0].createCell(1);
            cells1.setCellValue(talentTrain.getMajorIdShow());
            cells1.setCellStyle(cellStyle0);
            if(lastRowNum+rows.length-1>lastRowNum)
                sheet.addMergedRegion(new CellRangeAddress(lastRowNum,lastRowNum+rows.length-1,1,1));

            //专业代码单元格添加数据并合并行
            Cell cells2 = rows[0].createCell(2);
            cells2.setCellValue(talentTrain.getMajorCode());
            cells2.setCellStyle(cellStyle0);
            if(lastRowNum+rows.length-1>lastRowNum)
                sheet.addMergedRegion(new CellRangeAddress(lastRowNum,lastRowNum+rows.length-1,2,2));

            //级别单元格添加数据并合并行
            Cell cells3 = rows[0].createCell(3);
            cells3.setCellValue(talentTrain.getTeamLevelShow());
            cells3.setCellStyle(cellStyle0);
            if(lastRowNum+rows.length-1>lastRowNum)
                sheet.addMergedRegion(new CellRangeAddress(lastRowNum,lastRowNum+rows.length-1,3,3));

            //获批时间单元格添加数据并合并行
            Cell cells4 = rows[0].createCell(4);
            cells4.setCellValue(talentTrain.getGetDate().replace("-",""));
            cells4.setCellStyle(cellStyle0);
            if(lastRowNum+rows.length-1>lastRowNum)
                sheet.addMergedRegion(new CellRangeAddress(lastRowNum,lastRowNum+rows.length-1,4,4));

           //添加负责人并设值
            TeachingTeamMember teamTeacher=this.majorLeaderDao.getTeamTeachByTeamId(talentTrain.getId());
            //负责人姓名单元格添加数据并合并
            Cell cel_teamTeacher_name=rows[0].createCell(5);
            cel_teamTeacher_name.setCellValue(teamTeacher.getName());
            cel_teamTeacher_name.setCellStyle(cellStyle0);
            if(lastRowNum+rows.length-1>lastRowNum)
                sheet.addMergedRegion(new CellRangeAddress(lastRowNum, lastRowNum+rows.length-1, 5, 5));

            //负责人性别单元格添加数据并合并
            Cell cel_teamTeacher_sex=rows[0].createCell(6);
            if(null!=teamTeacher.getSex()&&!"".equals(teamTeacher.getSex()))
                cel_teamTeacher_sex.setCellValue(teamTeacher.getSex().equals("1")?"男":"女");
            else
                cel_teamTeacher_sex.setCellValue("");
            cel_teamTeacher_sex.setCellStyle(cellStyle0);
            if(lastRowNum+rows.length-1>lastRowNum)
                sheet.addMergedRegion(new CellRangeAddress(lastRowNum, lastRowNum+rows.length-1, 6, 6));

            //负责人生日单元格添加数据并合并
            Cell cel_teamTeacher_birth=rows[0].createCell(7);
            cel_teamTeacher_birth.setCellValue(teamTeacher.getBirth());
            cel_teamTeacher_birth.setCellStyle(cellStyle0);
            if(lastRowNum+rows.length-1>lastRowNum)
                sheet.addMergedRegion(new CellRangeAddress(lastRowNum, lastRowNum+rows.length-1, 7, 7));

            //负责人工作单位单元格添加数据并合并
            Cell cel_teamTeacher_workWhere=rows[0].createCell(8);
            cel_teamTeacher_workWhere.setCellValue(teamTeacher.getWorkUnit());
            cel_teamTeacher_workWhere.setCellStyle(cellStyle0);
            if(lastRowNum+rows.length-1>lastRowNum)
                sheet.addMergedRegion(new CellRangeAddress(lastRowNum, lastRowNum+rows.length-1, 8, 8));

            //负责人职务单元格添加数据并合并
            Cell cel_teamTeacher_post=rows[0].createCell(9);
            cel_teamTeacher_post.setCellValue(teamTeacher.getPost());
            cel_teamTeacher_post.setCellStyle(cellStyle0);
            if(lastRowNum+rows.length-1>lastRowNum)
                sheet.addMergedRegion(new CellRangeAddress(lastRowNum, lastRowNum+rows.length-1, 9, 9));

            //负责人职称单元格添加数据并合并
            Cell cel_teamTeacher_title=rows[0].createCell(10);
            cel_teamTeacher_title.setCellValue(teamTeacher.getTitle());
            cel_teamTeacher_title.setCellStyle(cellStyle0);
            if(lastRowNum+rows.length-1>lastRowNum)
                sheet.addMergedRegion(new CellRangeAddress(lastRowNum, lastRowNum+rows.length-1, 10, 10));

            //添加成员列并设值
            for(int j=0;j<rows.length;j++){
                TeachingTeamMember teachingTeamMember=members.get(j);
                //成员姓名单元格添加数据
                Cell cel_member_name=rows[j].createCell(11);
                cel_member_name.setCellValue(teachingTeamMember.getName());
                cel_member_name.setCellStyle(cellStyle0);
                //成员性别单元格添加数据
                Cell cel_member_sex=rows[j].createCell(12);
               // cel_member_sex.setCellValue(teachingTeamMember.getSex());
                if(null!=teachingTeamMember.getSex()&&!"".equals(teachingTeamMember.getSex()))
                    cel_member_sex.setCellValue(teachingTeamMember.getSex().equals("1")?"男":"女");
                else
                    cel_member_sex.setCellValue("");
                cel_member_sex.setCellStyle(cellStyle0);
                //成员生日单元格添加数据
                Cell cel_member_birth=rows[j].createCell(13);
                String birth=teachingTeamMember.getBirth();
                if(birth!=null){
                    birth=birth.split(" ")[0].replace("-","");
                }
                cel_member_birth.setCellValue(birth);
                cel_member_birth.setCellStyle(cellStyle0);
                //成员工作地点单元格添加数据
                Cell cel_member_workWhere=rows[j].createCell(14);
                cel_member_workWhere.setCellValue(teachingTeamMember.getWorkUnit());
                cel_member_workWhere.setCellStyle(cellStyle0);
                //成员职务单元格添加数据
                Cell cel_member_post=rows[j].createCell(15);
                cel_member_post.setCellValue(teachingTeamMember.getPost());
                cel_member_post.setCellStyle(cellStyle0);
                //成员职称单元格添加数据
                Cell cel_member_title=rows[j].createCell(16);
                cel_member_title.setCellValue(teachingTeamMember.getTitle());
                cel_member_title.setCellStyle(cellStyle0);

            }
            lastRowNum=lastRowNum+rows.length-1;
            i = i + 1;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("专业教学团队情况统计表.xls", "utf-8"));
            os = response.getOutputStream();
            workbook.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                }
                workbook.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public void deleteAllMembersByTeamId(String teamId){

        this.majorLeaderDao.deleteAllMembersByTeamId(teamId);
    }
    public TeachingTeamMember getTeamTeachByTeamId(String teamId){

        return this.majorLeaderDao.getTeamTeachByTeamId(teamId);
    }

    public List<TeachingTeamMember> findTeachingTeamMemberByTeamId(String teamId){

        return this.majorLeaderDao.findTeachingTeamMemberByTeamId(teamId);
    }

    public Integer getTableMembersColumn(String planName){

        return this.majorLeaderDao.getTableMembersColumn(planName);
    }

    @Override
    public Map<String, String> getTeacherById(String tid) {

        return this.majorLeaderDao.getTeacherById(tid);
    }

    public MajorLeader getMajorLeaderById(String majorId){
        return majorLeaderDao.getMajorLeaderById(majorId);
    }

    @Override
    public MajorResponsible getMajorResponsibleById(String id) {
        return majorLeaderDao.getMajorResponsibleById(id);
    }

    public List<MajorLeader> getMajorLeaderList(MajorLeader m){
        return majorLeaderDao.getMajorLeaderList(m);
    }

    public void insertLeaderEmpDept(TeachingTeamMember teachingTeamMember){
        this.majorLeaderDao.insertLeaderEmpDept(teachingTeamMember);
    }

    //插入已有id的数据
    public void insertTeachTeam(TalentTrain tt){

        this.majorLeaderDao.insertTeachTeam(tt);
    }

    public void insertMajorLeader(MajorLeader m){
        majorLeaderDao.insertMajorLeader(m);
    }

    public void insertMajorResponsible(MajorResponsible m) {
        majorLeaderDao.insertMajorResponsible(m);
    }

    @Override
    public void updateMajorResponsible(MajorResponsible m) {
        majorLeaderDao.updateMajorResponsible(m);
    }

    @Override
    public List<MajorResponsible> getMajorResponsibleList(MajorResponsible m) {
        return majorLeaderDao.getMajorResponsibleList(m);
    }

    @Override
    public void deleteMajorResponsible(String id) {
        majorLeaderDao.deleteMajorResponsible(id);
    }

    @Override
    public List<TalentTrain> getDaoChu(TalentTrain tt) {
        return majorLeaderDao.getDaoChu(tt);
    }

    public void updateMajorLeader(MajorLeader m){
        majorLeaderDao.updateMajorLeader(m);
    }

    public void deleteMajorLeader(String id){
        majorLeaderDao.deleteMajorLeader(id);
    }

    @Override
    public TalentTrain getTeachingTeamById(String id) {
        return majorLeaderDao.getTeachingTeamById(id);
    }
    public List<Map<String, String>> getTeachingTeamMemberByTeamId(String memberId){

        return this.majorLeaderDao.getTeachingTeamMemberByTeamId(memberId);
    }

    public List<TeachingTeamMember> getTeachingTeamMemberById(String teamId){

        return this.majorLeaderDao.getTeachingTeamMemberById(teamId);
    }

    @Override
    public List<TalentTrain> getTeachingTeamList(TalentTrain tt) {
        return majorLeaderDao.getTeachingTeamList(tt);
    }

    public List<Map<String, String>> getTeachingTeamMap(TalentTrain tt){
        return this.majorLeaderDao.getTeachingTeamMap(tt);
    }

    @Override
    public void insertTeachingTeam(TalentTrain tt) {
        majorLeaderDao.insertTeachingTeam(tt);
    }

    @Override
    public void updateTeachingTeam(TalentTrain tt) {
        majorLeaderDao.updateTeachingTeam(tt);
    }

    @Override
    public void deleteTeachingTeam(String id) {
        majorLeaderDao.deleteTeachingTeam(id);
    }

    @Override
    public List<EmpDeptTree> getDeptAndPersonTree(TeachingTeamMember tt) {
        return majorLeaderDao.getDeptAndPersonTree(tt);
    }

    @Override
    public void delRoleEmpDeptByArchivesIdAndInsertRoleEmpDept(String teamId,String memberType, String checkList) {
        TeachingTeamMember tt= new TeachingTeamMember();
        tt.setMemberType(memberType);
        tt.setTeamId(teamId);
        majorLeaderDao.delLeaderEmpDeptByArchivesId(tt);
        if (checkList.length() > 0) {
            String[] check = checkList.split("@@@");
            for (int i = 0; i < check.length; i++) {
                TeachingTeamMember ar = new TeachingTeamMember();
                ar.setTeamId(teamId);
                String a = check[i];
                String[] b = a.split("@");
                ar.setDeptId(b[0].toString());
                ar.setPersonId(b[1].toString());
                ar.setMemberType(memberType);
                ar.setCreator(CommonUtil.getPersonId());
                ar.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
                ar.setCreateTime(CommonUtil.getDate());
                majorLeaderDao.insertLeaderEmpDept(ar);
            }
        }
    }



}