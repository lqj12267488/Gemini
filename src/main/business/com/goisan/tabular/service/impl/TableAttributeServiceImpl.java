package com.goisan.tabular.service.impl;

import com.goisan.educational.major.bean.TalentTrain;
import com.goisan.educational.major.bean.TeachingTeamMember;
import com.goisan.system.bean.CommonBean;
import com.goisan.tabular.bean.TabularFile;
import com.goisan.tabular.dao.TableAttributeDao;
import com.goisan.tabular.service.TableAttributeService;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import static com.goisan.tabular.controller.TabularController.COM_REPORT_PATH;

@Service
public class TableAttributeServiceImpl implements TableAttributeService {
    @Resource
    private TableAttributeDao tableAttributeDao;

    /**
     * 导出带有数据得表格 命名expertExcel_A加上数字
     * 例
     * * @param response
     */
    public void expertExcel_A1(HttpServletResponse response,TabularFile tabularFile){
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;

        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
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


    /**
     * 导出带有数据得表格 命名expertExcel_A加上数字
     * 例
     * * @param response
     */
    public void expertExcel_A711(HttpServletResponse response,TabularFile tabularFile){
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
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

    /**
     * 例子
     */
    //    private void  AnalysisExcelUtil (File file,HttpServletResponse response){
//        OutputStream os = null;
//        List<EmploymentManage> employmentManages = employmentManageService.EmploymentManageAction(new EmploymentManage());
//        try {
//            //        读入文件
//            FileInputStream in  = new FileInputStream(file);
////            判断文件后缀名是xls,还是xlsx
////            如果是xls,使用HSSFWorkbook,如果是xlsx,使用XSSFWorkbook
//            String fileName = file.getName();
//            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
//            Workbook wb = null;
//            if ("xls".equals(suffix)) {
//                wb = new HSSFWorkbook(in);
//            }
//            if ("xlsx".equals(suffix)) {
//                wb = new XSSFWorkbook(in);
//            }
//                Sheet sheet = wb.getSheetAt(0);
//                String sheetName = sheet.getSheetName();
//                int rowIndex = 10 ;
//                int end = 2+employmentManages.size();
//                int count = 1;
//                for (int i = 0; i < employmentManages.size(); i++) {
//                    Row row = sheet.getRow(rowIndex+i);
//                    row.getCell(1).setCellValue(count);
//                    row.getCell(2).setCellValue(employmentManages.get(i).getEmploymentUnitIdShow());
//                    row.getCell(3).setCellValue("1");
//                    row.getCell(4).setCellValue(employmentManages.get(i).getStudentIdShow());
//                    row.getCell(5).setCellValue(employmentManages.get(i).getEmploymentPositions());
//                    row.getCell(6).setCellValue(employmentManages.get(i).getTel());
//                    count++;
//                }
//                response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName+".xlsx",
//                        "utf-8"));
//                os = response.getOutputStream();
//                wb.write(os);
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            try {
//                if (os != null) {
//                    os.flush();
//                    os.close();
//                }
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//        }
//    }
}
