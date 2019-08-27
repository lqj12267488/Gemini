package com.goisan.educational.major.service.impl;

import com.goisan.educational.major.bean.MajorBuildingCmte;
import com.goisan.educational.major.bean.MajorBuliedingExcel;
import com.goisan.educational.major.dao.MajorBuildingCmteDao;
import com.goisan.educational.major.service.MajorBuildingCmteService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.CommonBean;
import com.goisan.system.bean.Result;
import com.sun.xml.internal.ws.resources.HttpserverMessages;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xwpf.usermodel.XWPFComment;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;

/**
 * @author 郭千恺
 * @version v1.0
 * @descroption 专业建设指导委员会
 * @date 2018/9/30 10:08
 */
@Service
public class MajorBuildingCmteServiceImpl implements MajorBuildingCmteService {
// Field ----------------------------------------
    @Resource
    private MajorBuildingCmteDao majorBuildingCmteDao;
// Method ----------------------------------------
    /**
     * 保存成员
     * @param majorBuildingCmte
     */
    public Result save(MajorBuildingCmte majorBuildingCmte) {
        Result result=null;
        try {
            String id = majorBuildingCmte.getId();
            if (id==null || "".equals(id)) {
                //判断是否有重复数据
                List<MajorBuildingCmte> hasList=this.majorBuildingCmteDao.getMajorIdByUnContainId(majorBuildingCmte);
                if(hasList==null||hasList.size()==0) {

                    this.majorBuildingCmteDao.insert(majorBuildingCmte);
                    result=new Result(1, "添加成功");
                    return result;
                }else {
                    result=new Result(0,"已有相同数据！");
                    return result;
                }
            } else {
                this.majorBuildingCmteDao.update(majorBuildingCmte);
                result=new Result(1,"修改成功！");
                return result;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return result=new Result(-1,"添加或修改数据失败！");
        }
    }

    /**
     * 删除成员
     * @param id
     */
    public boolean delete(String id) {
        try {
            this.majorBuildingCmteDao.delete(id);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 按id查找成员
     * @param id
     * @return
     */
    public MajorBuildingCmte getById(String id) {
        try {
            return this.majorBuildingCmteDao.getById(id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 按条件查找成员表
     * @param majorBuildingCmte
     * @return
     */
    public List<MajorBuildingCmte> getList(MajorBuildingCmte majorBuildingCmte) {
        try {
            return this.majorBuildingCmteDao.getList(majorBuildingCmte);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 按人员id匹配部分信息
     * @param personId
     * @return
     */
    public MajorBuildingCmte matchingInfoByPersonId(String personId) {
        try {
            return this.majorBuildingCmteDao.matchingInfoByPersonId(personId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 查询专业表
     * @return
     */
    public List<AutoComplete> getMajorList() {
        try {
            return this.majorBuildingCmteDao.getMajorList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 查询教师人员表
     * @return
     */
    public List<AutoComplete> getTeacherList() {
        try {
            return this.majorBuildingCmteDao.getTeacherList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 每个专业导出一个成员表
     * @return
     */
    public List<MajorBuliedingExcel> getCmteListGroupByMajor() {
        try {
            return this.majorBuildingCmteDao.getCmteListGroupByMajor();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 由专业名获取专业id
     * @param majorName
     * @return
     */
    public List<String> getMajorIdByMajorName(String majorName) {
        try {
            return this.majorBuildingCmteDao.getMajorIdByMajorName(majorName);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 由姓名获取人员id
     * @param name
     * @return
     */
    public List<String> getPersonIdByName(String name) {
        try {
            return this.majorBuildingCmteDao.getPersonIdByName(name);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 导出excel
     */
    public void expertExcel(HttpServletResponse response){
        List<MajorBuliedingExcel> majorList = this.majorBuildingCmteDao.getCmteListGroupByMajor();
        Iterator<MajorBuliedingExcel> mIterator = majorList.iterator();

        HSSFWorkbook wb = new HSSFWorkbook();
        if (mIterator.hasNext()) {

            MajorBuliedingExcel majorTemp = mIterator.next();
            if (majorTemp.getMajorName().equals("") || majorTemp.getMajorName() == null) {
                HSSFSheet sheet = wb.createSheet();
            }
            HSSFSheet sheet = wb.createSheet(majorTemp.getMajorName());


            PrintSetup printSetup = sheet.getPrintSetup();
            printSetup.setScale((short)71.99);
            printSetup.setPaperSize(HSSFPrintSetup.A4_PAPERSIZE); //纸张类型
            printSetup.setFitWidth((short)1);
            printSetup.setLandscape(true);
            printSetup.setHeaderMargin(10d);
            printSetup.setHeaderMargin(0.32f);

            sheet.setMargin(HSSFSheet.TopMargin, 0.32f ); // 上边距
            sheet.setMargin(HSSFSheet.BottomMargin, 0.3f ); // 下边距
            sheet.setMargin(HSSFSheet.LeftMargin,0.3f ); // 左边距
            sheet.setMargin(HSSFSheet.RightMargin, 0.3f ); // 右边距
            sheet.setPrintRowAndColumnHeadings(false);

            // 样式设置
            // 全部列宽
            int[] columnWidthArray = {9, 30, 40, 16, 28, 30, 30, 20};
            int columnNums = columnWidthArray.length;
            for (int i = 0; i < columnNums; ++i) { // 预置列宽
                sheet.setColumnWidth(i, columnWidthArray[i] * 256);
            }

            // 全局行高
            sheet.setDefaultRowHeightInPoints(27.75f);

            Font font = wb.createFont();
            font.setFontName("仿宋");
            font.setBold(false);
            font.setFontHeightInPoints((short) 16);
            //数据格子
            HSSFCellStyle styleDataC = wb.createCellStyle();
            styleDataC.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            styleDataC.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            styleDataC.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            styleDataC.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            styleDataC.setBorderRight(HSSFCellStyle.BORDER_THIN);
            styleDataC.setBorderTop(HSSFCellStyle.BORDER_THIN);

            // 标题
            HSSFCellStyle titleStyle = wb.createCellStyle();
            titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            titleStyle.setBorderBottom(HSSFCellStyle.BORDER_NONE);
            titleStyle.setBorderLeft(HSSFCellStyle.BORDER_NONE);
            titleStyle.setBorderRight(HSSFCellStyle.BORDER_NONE);
            titleStyle.setBorderTop(HSSFCellStyle.BORDER_NONE);

            Font titleFont = wb.createFont();
            titleFont.setFontName("楷体");
            titleFont.setFontHeightInPoints((short) 22);
            titleStyle.setAlignment(CellStyle.ALIGN_CENTER);
            titleStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
            titleStyle.setFont(titleFont);
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 7));
            sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 7));
            int rowNum = 0;
            Cell title1 = sheet.createRow(rowNum++).createCell(0);
            String xxmc= CommonBean.getParamValue("SZXXMC");
            title1.setCellValue(xxmc);
            title1.setCellStyle(titleStyle);
            Cell title2 = sheet.createRow(rowNum++).createCell(0);
            title2.setCellValue("专业建设指导委员会");
            title2.setCellStyle(titleStyle);

            HSSFRow headRow = sheet.createRow(rowNum++);
            Font headFont = wb.createFont();
            headFont.setFontName("仿宋");
            headFont.setBold(true);
            headFont.setFontHeightInPoints((short) 16);

            String[] titles = {"序号", "专业名称", "专业建设指导委员会职务", "姓名", "工作单位", "职务", "职称", "联系电话"};
            styleDataC.setFont(headFont);
            for (int i = 0; i < titles.length; ++i) {
                Cell cellTemp = headRow.createCell(i);
                cellTemp.setCellValue(titles[i]);
                cellTemp.setCellStyle(styleDataC);
            }

            // 成员数据
            Iterator<MajorBuildingCmte> dataIterator = majorTemp.getCmteList().iterator();
            int dataNum = 1;
            styleDataC.setFont(font);
            while (dataIterator.hasNext()) {
                MajorBuildingCmte dataTemp = dataIterator.next();
                HSSFRow dataRow = sheet.createRow(rowNum++);
                Cell cell1=dataRow.createCell(0);
                cell1.setCellValue(dataNum++);
                cell1.setCellStyle(styleDataC);
                Cell cell2=dataRow.createCell(1);
                cell2.setCellValue(dataTemp.getMajorShow());
                cell2.setCellStyle(styleDataC);
                Cell cell3=dataRow.createCell(2);
                cell3.setCellValue(dataTemp.getCmtePost());
                cell3.setCellStyle(styleDataC);
                Cell cell4=dataRow.createCell(3);
                cell4.setCellValue(dataTemp.getTeacherName());
                cell4.setCellStyle(styleDataC);
                Cell cell5=dataRow.createCell(4);
                cell5.setCellValue(dataTemp.getWorkUnit());
                cell5.setCellStyle(styleDataC);
                Cell cell6=dataRow.createCell(5);
                cell6.setCellValue(dataTemp.getTeacherPost());
                cell6.setCellStyle(styleDataC);
                Cell cell7=dataRow.createCell(6);
                cell7.setCellValue(dataTemp.getTeacherTitle());
                cell7.setCellStyle(styleDataC);
                Cell cell8=dataRow.createCell(7);
                cell8.setCellValue(dataTemp.getTelephone());
                cell8.setCellStyle(styleDataC);
            }
        } else {
            HSSFSheet sheet = wb.createSheet("专业建设指导委员会");
            // 样式设置
            // 全部列宽
            int[] columnWidthArray = {11, 30, 40, 16, 20, 30, 30, 20};
            int columnNums = columnWidthArray.length;
            for (int i = 0; i < columnNums; ++i) { // 预置列宽
                sheet.setColumnWidth(i, columnWidthArray[i] * 256);
            }
            // 全局行高
            sheet.setDefaultRowHeightInPoints(27.75f);

            //标题格子
            HSSFCellStyle titleStyle = wb.createCellStyle();
            titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            titleStyle.setBorderBottom(HSSFCellStyle.BORDER_NONE);
            titleStyle.setBorderLeft(HSSFCellStyle.BORDER_NONE);
            titleStyle.setBorderRight(HSSFCellStyle.BORDER_NONE);
            titleStyle.setBorderTop(HSSFCellStyle.BORDER_NONE);


            //数据格子
            HSSFCellStyle styleDataC = wb.createCellStyle();
            styleDataC.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            styleDataC.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            styleDataC.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            styleDataC.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            styleDataC.setBorderRight(HSSFCellStyle.BORDER_THIN);
            styleDataC.setBorderTop(HSSFCellStyle.BORDER_THIN);

            Font font = wb.createFont();
            font.setFontName("仿宋");
            font.setBold(false);
            font.setFontHeightInPoints((short) 16);
            titleStyle.setFont(font);
            Font titleFont = wb.createFont();
            titleFont.setFontName("楷体");
            titleFont.setFontHeightInPoints((short) 20);
            titleStyle.setAlignment(CellStyle.ALIGN_CENTER);
            titleStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
            titleStyle.setFont(titleFont);
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 7));
            sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 7));
            int rowNum = 0;
            Cell title1 = sheet.createRow(rowNum++).createCell(0);
            String xxmc= CommonBean.getParamValue("SZXXMC");
            title1.setCellValue(xxmc);
            title1.setCellStyle(titleStyle);
            Cell title2 = sheet.createRow(rowNum++).createCell(0);
            title2.setCellValue("专业建设指导委员会");
            title2.setCellStyle(titleStyle);

            HSSFRow headRow = sheet.createRow(rowNum++);
            Font headFont = wb.createFont();
            headFont.setFontName("仿宋");
            headFont.setBold(true);
            headFont.setFontHeightInPoints((short) 16);
            styleDataC.setFont(headFont);
            String[] titles = {"序号", "专业名称", "专业建设指导委员会职务", "姓名", "工作单位", "职务", "职称", "联系电话"};
            for (int i = 0; i < titles.length; ++i) {
                Cell cellTemp = headRow.createCell(i);
                cellTemp.setCellValue(titles[i]);
                cellTemp.setCellStyle(styleDataC);
            }

        }
        // 导出
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("专业建设指导委员会.xls", "utf-8"));
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
