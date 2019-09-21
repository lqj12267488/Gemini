package com.goisan.tabular.service.impl;

import com.goisan.educational.course.bean.Course;
import com.goisan.educational.course.service.CourseService;
import com.goisan.educational.major.bean.*;
import com.goisan.educational.major.service.MajorLeaderService;
import com.goisan.educational.major.service.MajorService;
import com.goisan.educational.skillappraisal.bean.SkillAppraisal;
import com.goisan.evaluation.bean.EvaluationTask;
import com.goisan.studentwork.studentrewardpunish.bean.SchoolBurse;
import com.goisan.system.bean.CommonBean;
import com.goisan.system.bean.Dept;
import com.goisan.system.bean.Emp;
import com.goisan.system.dao.EmpDao;
import com.goisan.system.dao.ParameterDao;
import com.goisan.tabular.bean.TabularFile;
import com.goisan.tabular.bean.export.Export;
import com.goisan.tabular.dao.TableAttributeDao;
import com.goisan.tabular.service.TableAttributeService;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.NumberFormat;
import java.util.List;

import static com.goisan.tabular.controller.TabularController.COM_REPORT_PATH;

@Service
public class TableAttributeServiceImpl implements TableAttributeService {
    @Resource
    private TableAttributeDao tableAttributeDao;
    @Resource
    private ParameterDao parameterDao;
    @Resource
    private MajorService majorService;
    @Resource
    private MajorLeaderService majorLeaderService;
    @Resource
    private EmpDao empDao;
    @Resource
    private CourseService courseService;

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

    public void expertExcel_A4_3(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            List<SkillAppraisal> list = tableAttributeDao.getExpertExcel_A4_3();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getIssuingOffice());
                row.getCell(3).setCellValue(list.get(i).getPreAppProfession());
                row.getCell(4).setCellValue("");
                row.getCell(5).setCellValue("");
                row.getCell(6).setCellValue("");
                row.getCell(7).setCellValue("");
                row.getCell(8).setCellValue("");
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public List<SkillAppraisal> getExpertExcel_A4_3() {
        return tableAttributeDao.getExpertExcel_A4_3();
    }

    public void expertExcel_A5_1(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
           /* List<SkillAppraisal> list = tableAttributeDao.getExpertExcel_A4_3();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex+i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getIssuingOffice());
                row.getCell(3).setCellValue(list.get(i).getPreAppProfession());
                row.getCell(4).setCellValue("");
                row.getCell(5).setCellValue("");
                row.getCell(6).setCellValue("");
                row.getCell(7).setCellValue("");
                row.getCell(8).setCellValue("");
                count++;
            }*/
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public void expertExcel_A5_2(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
           /* List<SkillAppraisal> list = tableAttributeDao.getExpertExcel_A4_3();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex+i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getIssuingOffice());
                row.getCell(3).setCellValue(list.get(i).getPreAppProfession());
                row.getCell(4).setCellValue("");
                row.getCell(5).setCellValue("");
                row.getCell(6).setCellValue("");
                row.getCell(7).setCellValue("");
                row.getCell(8).setCellValue("");
                count++;
            }*/
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public void expertExcel_A1_6(HttpServletResponse response, TabularFile tabularFile) {//A1-6机构设置表
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            List<Dept> list = tableAttributeDao.getExpertExcel_A1_6();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getDeptId());
                row.getCell(3).setCellValue(list.get(i).getDeptName());
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public List<Dept> getExpertExcel_A1_6() {
        return tableAttributeDao.getExpertExcel_A1_6();
    }

    public void expertExcel_A2(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            List<Emp> list = tableAttributeDao.getExpertExcel_A2();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getStaffId());
                row.getCell(3).setCellValue(list.get(i).getName());
                row.getCell(4).setCellValue(list.get(i).getNation());
                row.getCell(5).setCellValue(list.get(i).getPost());
                row.getCell(6).setCellValue(list.get(i).getPositionalTitles());
                row.getCell(7).setCellValue(list.get(i).getEducationalLevel());
                row.getCell(8).setCellValue(list.get(i).getSex());
                row.getCell(9).setCellValue(list.get(i).getBirthday());
                row.getCell(10).setCellValue(list.get(i).getTel());
                row.getCell(11).setCellValue("");
                row.getCell(12).setCellValue("");
                row.getCell(13).setCellValue(list.get(i).getEducationalResearch());
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public List<Emp> getExpertExcel_A2() {
        return tableAttributeDao.getExpertExcel_A2();
    }

    public void expertExcel_A3(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
           /* List<Emp> list = tableAttributeDao.getExpertExcel_A2();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex+i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getStaffId());
                row.getCell(3).setCellValue(list.get(i).getName());
                row.getCell(4).setCellValue(list.get(i).getNation());
                row.getCell(5).setCellValue(list.get(i).getPost());
                row.getCell(6).setCellValue(list.get(i).getPositionalTitles());
                row.getCell(7).setCellValue(list.get(i).getEducationalLevel());
                row.getCell(8).setCellValue(list.get(i).getSex());
                row.getCell(9).setCellValue(list.get(i).getBirthday());
                row.getCell(10).setCellValue(list.get(i).getTel());
                row.getCell(11).setCellValue("");
                row.getCell(12).setCellValue("");
                row.getCell(13).setCellValue(list.get(i).getEducationalResearch());
                count++;
            }*/
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public void expertExcel_A4_1(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
           /* List<Emp> list = tableAttributeDao.getExpertExcel_A2();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex+i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getStaffId());
                row.getCell(3).setCellValue(list.get(i).getName());
                row.getCell(4).setCellValue(list.get(i).getNation());
                row.getCell(5).setCellValue(list.get(i).getPost());
                row.getCell(6).setCellValue(list.get(i).getPositionalTitles());
                row.getCell(7).setCellValue(list.get(i).getEducationalLevel());
                row.getCell(8).setCellValue(list.get(i).getSex());
                row.getCell(9).setCellValue(list.get(i).getBirthday());
                row.getCell(10).setCellValue(list.get(i).getTel());
                row.getCell(11).setCellValue("");
                row.getCell(12).setCellValue("");
                row.getCell(13).setCellValue(list.get(i).getEducationalResearch());
                count++;
            }*/
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public void expertExcel_A4_2(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
           /* List<Emp> list = tableAttributeDao.getExpertExcel_A2();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex+i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getStaffId());
                row.getCell(3).setCellValue(list.get(i).getName());
                row.getCell(4).setCellValue(list.get(i).getNation());
                row.getCell(5).setCellValue(list.get(i).getPost());
                row.getCell(6).setCellValue(list.get(i).getPositionalTitles());
                row.getCell(7).setCellValue(list.get(i).getEducationalLevel());
                row.getCell(8).setCellValue(list.get(i).getSex());
                row.getCell(9).setCellValue(list.get(i).getBirthday());
                row.getCell(10).setCellValue(list.get(i).getTel());
                row.getCell(11).setCellValue("");
                row.getCell(12).setCellValue("");
                row.getCell(13).setCellValue(list.get(i).getEducationalResearch());
                count++;
            }*/
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public void expertExcel_A8_1(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public void expertExcel_A8_2(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            List<Emp> list = tableAttributeDao.getExpertExcel_A8_2();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(list.get(i).getStaffId());
                row.getCell(2).setCellValue(list.get(i).getName());
                row.getCell(3).setCellValue(list.get(i).getStaffFlag());
                row.getCell(4).setCellValue(list.get(i).getSex());
                row.getCell(5).setCellValue(list.get(i).getBirthdayShow());
                row.getCell(6).setCellValue(list.get(i).getNation());
                row.getCell(7).setCellValue(list.get(i).getDeptName());
                row.getCell(8).setCellValue(list.get(i).getEducationalLevel());
                row.getCell(9).setCellValue(list.get(i).getAcademicDegree());
                row.getCell(10).setCellValue(list.get(i).getPositionalLevel());
                row.getCell(11).setCellValue(list.get(i).getPositionalTitles());
                row.getCell(12).setCellValue("");
                row.getCell(13).setCellValue("");
                row.getCell(14).setCellValue(list.get(i).getPost());
                row.getCell(15).setCellValue("");
                row.getCell(16).setCellValue("");
                row.getCell(17).setCellValue("");
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public List<Emp> getExpertExcel_A8_2() {
        return tableAttributeDao.getExpertExcel_A8_2();
    }

    public void expertExcel_A8_3(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            List<Emp> list = tableAttributeDao.getExpertExcel_A8_3();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                //row.getCell(0).setCellValue(count);
                row.getCell(1).setCellValue(list.get(i).getStaffId());
                row.getCell(2).setCellValue(list.get(i).getName());
                row.getCell(3).setCellValue(list.get(i).getStaffFlag());
                row.getCell(4).setCellValue(list.get(i).getSex());
                row.getCell(5).setCellValue(list.get(i).getBirthdayShow());
                row.getCell(6).setCellValue(list.get(i).getNation());
                row.getCell(7).setCellValue(list.get(i).getDeptName());
                row.getCell(8).setCellValue(list.get(i).getEducationalLevel());
                row.getCell(9).setCellValue(list.get(i).getAcademicDegree());
                row.getCell(10).setCellValue(list.get(i).getPositionalLevel());
                row.getCell(11).setCellValue(list.get(i).getPositionalTitles());
                row.getCell(12).setCellValue("");
                row.getCell(13).setCellValue("");
                row.getCell(14).setCellValue("");
                row.getCell(15).setCellValue("");
                row.getCell(16).setCellValue("");
                row.getCell(17).setCellValue("");
                row.getCell(18).setCellValue("");
                row.getCell(19).setCellValue("");
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public List<Emp> getExpertExcel_A8_3() {
        return tableAttributeDao.getExpertExcel_A8_3();
    }

    public void expertExcel_A8_4(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            List<Emp> list = tableAttributeDao.getExpertExcel_A8_4();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                //row.getCell(0).setCellValue(count);
                row.getCell(1).setCellValue(list.get(i).getStaffId());
                row.getCell(2).setCellValue(list.get(i).getName());
                row.getCell(3).setCellValue(list.get(i).getStaffFlag());
                row.getCell(4).setCellValue(list.get(i).getSex());
                row.getCell(5).setCellValue(list.get(i).getBirthdayShow());
                row.getCell(6).setCellValue(list.get(i).getNation());
                row.getCell(7).setCellValue(list.get(i).getDeptName());
                row.getCell(8).setCellValue(list.get(i).getEducationalLevel());
                row.getCell(9).setCellValue(list.get(i).getAcademicDegree());
                row.getCell(10).setCellValue(list.get(i).getPositionalLevel());
                row.getCell(11).setCellValue(list.get(i).getPositionalTitles());
                row.getCell(12).setCellValue("");
                row.getCell(13).setCellValue("");
                row.getCell(14).setCellValue(list.get(i).getPost());
                row.getCell(15).setCellValue("");
                row.getCell(16).setCellValue("");
                row.getCell(17).setCellValue("");
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public List<Emp> getExpertExcel_A8_4() {
        return tableAttributeDao.getExpertExcel_A8_4();
    }

    public void expertExcel_A8_5(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            List<Emp> list = tableAttributeDao.getExpertExcel_A8_5();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                //row.getCell(0).setCellValue(count);
                row.getCell(1).setCellValue(list.get(i).getStaffId());
                row.getCell(2).setCellValue(list.get(i).getName());
                //row.getCell(3).setCellValue(list.get(i).getStaffFlag());
                row.getCell(3).setCellValue(list.get(i).getSex());
                row.getCell(4).setCellValue(list.get(i).getBirthdayShow());
                row.getCell(5).setCellValue(list.get(i).getNation());
                row.getCell(6).setCellValue(list.get(i).getEducationalLevel());
                row.getCell(7).setCellValue(list.get(i).getAcademicDegree());
                row.getCell(8).setCellValue("");
                row.getCell(9).setCellValue(list.get(i).getPositionalLevel());
                row.getCell(10).setCellValue(list.get(i).getPositionalTitles());
                row.getCell(11).setCellValue("");
                row.getCell(12).setCellValue("");
                row.getCell(13).setCellValue("");
                row.getCell(14).setCellValue("");
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public List<Emp> getExpertExcel_A8_5() {
        return tableAttributeDao.getExpertExcel_A8_5();
    }

    public void expertExcel_A8_6(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            List<Emp> list = tableAttributeDao.getExpertExcel_A8_6();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                //row.getCell(0).setCellValue(count);
                row.getCell(1).setCellValue(list.get(i).getStaffId());
                row.getCell(2).setCellValue(list.get(i).getName());
                row.getCell(3).setCellValue(list.get(i).getStaffFlag());
                row.getCell(4).setCellValue(list.get(i).getSex());
                row.getCell(5).setCellValue(list.get(i).getBirthdayShow());
                row.getCell(6).setCellValue(list.get(i).getNation());
                row.getCell(7).setCellValue(list.get(i).getEducationalLevel());
                row.getCell(8).setCellValue(list.get(i).getAcademicDegree());
                row.getCell(9).setCellValue("");
                row.getCell(10).setCellValue(list.get(i).getPositionalLevel());
                row.getCell(11).setCellValue(list.get(i).getPositionalTitles());
                row.getCell(12).setCellValue("");
                row.getCell(13).setCellValue("");
                row.getCell(14).setCellValue("");
                row.getCell(15).setCellValue("");
                row.getCell(16).setCellValue("");
                row.getCell(17).setCellValue("");
                row.getCell(18).setCellValue("");
                row.getCell(19).setCellValue("");
                row.getCell(20).setCellValue("");
                row.getCell(21).setCellValue("");
                row.getCell(22).setCellValue("");
                row.getCell(23).setCellValue("");
                row.getCell(24).setCellValue("");
                row.getCell(25).setCellValue("");
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public List<Emp> getExpertExcel_A8_6() {
        return tableAttributeDao.getExpertExcel_A8_6();
    }

    public void expertExcel_A8_7(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            String term = parameterDao.getParameterValue();
            List<EvaluationTask> evaluationTaskList = tableAttributeDao.getExpertExcel_A8_7(term);
            int i = 10;
            String oldFlag = "";
            try {
                oldFlag = evaluationTaskList.get(0).getTerm();
            } catch (Exception e) {

            }
            NumberFormat format = NumberFormat.getPercentInstance();
            format.setMaximumFractionDigits(2);//设置保留几位小数
            Row row;
            if ((row = sheet.getRow(i)) == null) row = sheet.createRow(i);
            for (EvaluationTask evaluationTask : evaluationTaskList) {
                row.getCell(1).setCellValue(evaluationTask.getStarts());
                row.getCell(2).setCellValue(evaluationTask.getEnd());
                row.getCell(3).setCellValue(evaluationTask.getNumberEmp());
                row.getCell(4).setCellValue(evaluationTask.getTotalNumberEmp());
                row.getCell(5).setCellValue(format.format(Double.parseDouble(evaluationTask.getNumberEmp()) / Double.parseDouble(evaluationTask.getTotalNumberEmp())));
                switch (evaluationTask.getTaskType()) {
                    case "1":
                        row.getCell(6).setCellValue(evaluationTask.getNumber());
                        row.getCell(7).setCellValue(evaluationTask.getTotalNumber());
                        row.getCell(8).setCellValue(format.format(Double.parseDouble(evaluationTask.getNumber()) / Double.parseDouble(evaluationTask.getTotalNumber())));
                        break;
                    case "4":
                        row.getCell(9).setCellValue(evaluationTask.getNumber());
                        row.getCell(10).setCellValue(evaluationTask.getTotalNumber());
                        row.getCell(11).setCellValue(format.format(Double.parseDouble(evaluationTask.getNumber()) / Double.parseDouble(evaluationTask.getTotalNumber())));
                        break;
                    case "3":
                        row.getCell(12).setCellValue(evaluationTask.getNumber());
                        row.getCell(13).setCellValue(evaluationTask.getTotalNumber());
                        row.getCell(14).setCellValue(format.format(Double.parseDouble(evaluationTask.getNumber()) / Double.parseDouble(evaluationTask.getTotalNumber())));
                        break;
                    case "2":
                        row.getCell(15).setCellValue(evaluationTask.getNumber());
                        row.getCell(16).setCellValue(evaluationTask.getTotalNumber());
                        row.getCell(17).setCellValue(format.format(Double.parseDouble(evaluationTask.getNumber()) / Double.parseDouble(evaluationTask.getTotalNumber())));
                        break;
                    default:
                        break;
                }
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public List<EvaluationTask> getExpertExcel_A8_7(String term) {
        return tableAttributeDao.getExpertExcel_A8_7(term);
    }

    public void expertExcel_A8_8(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            List<SchoolBurse> list = tableAttributeDao.getExpertExcel_A8_8();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getName());
                row.getCell(3).setCellValue(list.get(i).getType());
                row.getCell(4).setCellValue("");
                row.getCell(5).setCellValue(list.get(i).getNums());
                row.getCell(6).setCellValue(list.get(i).getBurseSum());
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public List<SchoolBurse> getExpertExcel_A8_8() {
        return tableAttributeDao.getExpertExcel_A8_8();
    }

    public void expertExcel_A8_9(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
           /* List<SkillAppraisal> list = tableAttributeDao.getExpertExcel_A4_3();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex+i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getIssuingOffice());
                row.getCell(3).setCellValue(list.get(i).getPreAppProfession());
                row.getCell(4).setCellValue("");
                row.getCell(5).setCellValue("");
                row.getCell(6).setCellValue("");
                row.getCell(7).setCellValue("");
                row.getCell(8).setCellValue("");
                count++;
            }*/
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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
     * modify by lihanyue end
     */

    /**
     * modify by yinzijian start
     * 点下载出的模板
     */
    public void expertExcel_A7_6_1(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        List<Major> list = tableAttributeDao.getZhaoshengList();//查
        try {
//           读入文件
            FileInputStream in = new FileInputStream(file);
//           判断文件后缀名是xls,还是xlsx
//           如果是xls,使用HSSFWorkbook,如果是xlsx,使用XSSFWorkbook
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getMajorSchool());
                row.getCell(3).setCellValue(list.get(i).getMajorCode());
                row.getCell(4).setCellValue(list.get(i).getMajorName());
                row.getCell(5).setCellValue(list.get(i).getMajorDirectionCode());
                row.getCell(6).setCellValue(list.get(i).getMajorDirection());
                row.getCell(7).setCellValue(list.get(i).getPlanNumber());
                row.getCell(8).setCellValue(list.get(i).getRealNumber());
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public List<Major> getZhaoshengList() {
        return tableAttributeDao.getZhaoshengList();
    }

    @Override
    public void expertExcel_A7_6_2(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        List<Major> list1 = tableAttributeDao.getGraduationList();//查
        try {
            FileInputStream in = new FileInputStream(file);
////            判断文件后缀名是xls,还是xlsx
////            如果是xls,使用HSSFWorkbook,如果是xlsx,使用XSSFWorkbook
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list1.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list1.get(i).getMajorSchool());
                row.getCell(3).setCellValue(list1.get(i).getMajorCode());
                row.getCell(4).setCellValue(list1.get(i).getMajorName());
                row.getCell(5).setCellValue(list1.get(i).getMajorDirectionCode());
                row.getCell(6).setCellValue(list1.get(i).getMajorDirection());
                row.getCell(7).setCellValue(list1.get(i).getGraduationNumber());
                row.getCell(8).setCellValue(list1.get(i).getEmploymentNumber());
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    @Override
    public List<Major> getGraduationList() {
        return tableAttributeDao.getGraduationList();
    }

    @Override
    public void expertExcel_A7_6_3(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        List<Major> list2 = tableAttributeDao.getPastgraduationList();//查
        try {
            FileInputStream in = new FileInputStream(file);
////            判断文件后缀名是xls,还是xlsx
////            如果是xls,使用HSSFWorkbook,如果是xlsx,使用XSSFWorkbook
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list2.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list2.get(i).getMajorSchool());
                row.getCell(3).setCellValue(list2.get(i).getMajorCode());
                row.getCell(4).setCellValue(list2.get(i).getMajorName());
                row.getCell(5).setCellValue(list2.get(i).getMajorDirectionCode());
                row.getCell(6).setCellValue(list2.get(i).getMajorDirection());
                row.getCell(7).setCellValue(list2.get(i).getGraduationNumber());
                row.getCell(8).setCellValue(list2.get(i).getEmploymentNumber());
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName + ".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    @Override
    public List<Major> getPastgraduationList() {
        return tableAttributeDao.getPastgraduationList();
    }


    /**
     * modify by yinzijian end
     */

    /**
     * modify by lizhipeng start
     */
    public void expertExcel_A7_1_1(HttpServletResponse response,TabularFile tabularFile){
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        List<Major> getMajorListExport = majorService.getMajorListExport(new Major());

        OutputStream os = null;
        try {
            FileInputStream in  = new FileInputStream(file);
            //      判断文件后缀名是xls,还是xlsx
            //    如果是xls,使用HSSFWorkbook,如果是xlsx,使用XSSFWorkbook
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            int rowIndex = 10 ;
            int end = 2+getMajorListExport.size();
            int count = 1;
            for (int i = 0; i < getMajorListExport.size(); i++) {
                Major major = new Major();
                major.setMajorCode(getMajorListExport.get(i).getMajorCode());
                Major major1 = majorService.getStudentNumberList(major);
                Major major2 = majorService.getSourceTypeList(major);
                Row row = sheet.getRow(rowIndex+i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(getMajorListExport.get(i).getDepartmentsIdShow());
                row.getCell(3).setCellValue(getMajorListExport.get(i).getSpringAutumnFlagShow());
                row.getCell(4).setCellValue(getMajorListExport.get(i).getMajorCode());
                row.getCell(5).setCellValue(getMajorListExport.get(i).getMajorName());
                row.getCell(6).setCellValue(getMajorListExport.get(i).getMajorDirectionCode());
                row.getCell(7).setCellValue(getMajorListExport.get(i).getMajorDirectionShow());
                row.getCell(8).setCellValue(getMajorListExport.get(i).getApprovalTime());
                row.getCell(9).setCellValue(getMajorListExport.get(i).getFirstRecruitTime());
                row.getCell(10).setCellValue(getMajorListExport.get(i).getMaxYearShow());
                if (major1!=null) {
                    row.getCell(11).setCellValue(major1.getStudentNumber());
                }
                row.getCell(12).setCellValue("");
                row.getCell(13).setCellValue("");
                row.getCell(14).setCellValue("");
                if (major2!=null) {
                    row.getCell(15).setCellValue(major2.getSourceNumberOne());
                    row.getCell(16).setCellValue(major2.getSourceNumberTwo());
                    row.getCell(18).setCellValue(major2.getSourceNumberThree());
                }
                row.getCell(17).setCellValue("");
                row.getCell(19).setCellValue(getMajorListExport.get(i).getFocusTypeShow());
                row.getCell(20).setCellValue(getMajorListExport.get(i).getUniqueTypeShow());
                row.getCell(21).setCellValue(getMajorListExport.get(i).getMajorNow());
                row.getCell(22).setCellValue(getMajorListExport.get(i).getMajorGlobal());
                row.getCell(23).setCellValue(getMajorListExport.get(i).getClassNum());
                row.getCell(24).setCellValue(getMajorListExport.get(i).getOrdersClassnum());
                row.getCell(25).setCellValue(getMajorListExport.get(i).getOrdersStudentnum());
                row.getCell(26).setCellValue("");
                row.getCell(27).setCellValue("");
                count++;


            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName+".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public void expertExcel_A7_1_2(HttpServletResponse response,TabularFile tabularFile){
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        MajorLeader majorLeader = new MajorLeader();
        majorLeader.setPersonType("1");
        List<MajorLeader> list =  majorLeaderService.getMajorLeaderList(majorLeader);

        OutputStream os = null;
        try {
            FileInputStream in  = new FileInputStream(file);
            //      判断文件后缀名是xls,还是xlsx
            //    如果是xls,使用HSSFWorkbook,如果是xlsx,使用XSSFWorkbook
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            int rowIndex = 10 ;
            int end = 2+list.size();
            int count = 1;
            for (int i = 0; i < list.size(); i++) {

                Row row = sheet.getRow(rowIndex+i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getDepartmentsIdShow());
                row.getCell(3).setCellValue(list.get(i).getMajorCode());
                row.getCell(4).setCellValue(list.get(i).getMajorIdShow());
                row.getCell(5).setCellValue(list.get(i).getTeacherCategoryShow());
                row.getCell(6).setCellValue(list.get(i).getTeacherNum());
                row.getCell(7).setCellValue(list.get(i).getPersonIdShow());
                row.getCell(8).setCellValue(list.get(i).getSexShow());
                row.getCell(9).setCellValue(list.get(i).getBirthdayShow());
                row.getCell(10).setCellValue(list.get(i).getEducation());
                row.getCell(11).setCellValue(list.get(i).getDegree());
                row.getCell(12).setCellValue(list.get(i).getWorkDept());
                row.getCell(13).setCellValue(list.get(i).getPosition());
                row.getCell(14).setCellValue(list.get(i).getGuHua());
                row.getCell(15).setCellValue(list.get(i).getEmail());
                row.getCell(16).setCellValue(list.get(i).getZyWorkDate());
                row.getCell(17).setCellValue(list.get(i).getPositionLeave());
                row.getCell(18).setCellValue(list.get(i).getPositionName());
                row.getCell(19).setCellValue(list.get(i).getOffice());
                row.getCell(20).setCellValue(list.get(i).getPositionDate());
                row.getCell(21).setCellValue("");
                row.getCell(22).setCellValue("");
                row.getCell(23).setCellValue("");
                row.getCell(24).setCellValue("");
                row.getCell(25).setCellValue("");
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName+".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    public void expertExcel_A7_1_3(HttpServletResponse response,TabularFile tabularFile){
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        MajorResponsible majorResponsible = new MajorResponsible();
        majorResponsible.setPersonType("2");
        List<MajorResponsible> list =  majorLeaderService.getMajorResponsibleList(majorResponsible);
        OutputStream os = null;
        try {
            FileInputStream in  = new FileInputStream(file);
            //      判断文件后缀名是xls,还是xlsx
            //    如果是xls,使用HSSFWorkbook,如果是xlsx,使用XSSFWorkbook
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            int rowIndex = 10 ;
            int end = 2+list.size();
            int count = 1;
            for (int i = 0; i < list.size(); i++) {

                Row row = sheet.getRow(rowIndex+i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getDepartmentsIdShow());
                row.getCell(3).setCellValue(list.get(i).getMajorCode());
                row.getCell(4).setCellValue(list.get(i).getMajorIdShow());
                row.getCell(5).setCellValue(list.get(i).getTeacherCategoryShow());
                row.getCell(6).setCellValue(list.get(i).getTeacherNum());
                row.getCell(7).setCellValue(list.get(i).getPersonIdShow());
                row.getCell(8).setCellValue(list.get(i).getSexShow());
                row.getCell(9).setCellValue(list.get(i).getBirthdayShow());
                row.getCell(10).setCellValue(list.get(i).getEducationShow());
                row.getCell(11).setCellValue(list.get(i).getDegreeShow());
                row.getCell(12).setCellValue(list.get(i).getWorkDept());
                row.getCell(13).setCellValue(list.get(i).getPosition());
                row.getCell(14).setCellValue(list.get(i).getGuhua());
                row.getCell(15).setCellValue(list.get(i).getEmail());
                row.getCell(16).setCellValue(list.get(i).getZyWorkdate());
                row.getCell(17).setCellValue(list.get(i).getPositionLeave());
                row.getCell(18).setCellValue(list.get(i).getPositionName());
                row.getCell(19).setCellValue(list.get(i).getOffice());
                row.getCell(20).setCellValue(list.get(i).getPositionDate());
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName+".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    @Override
    public void expertExcel_A7_2(HttpServletResponse response,TabularFile tabularFile){
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        List<Course> selectCourseList = courseService.selectCourseList(new Course());
        OutputStream os = null;
        try {
            FileInputStream in  = new FileInputStream(file);
            //      判断文件后缀名是xls,还是xlsx
            //    如果是xls,使用HSSFWorkbook,如果是xlsx,使用XSSFWorkbook
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            Workbook wb = null;
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            int rowIndex = 10 ;
            int end = 2+selectCourseList.size();
            int count = 1;
            for (int i = 0; i < selectCourseList.size(); i++) {

                Row row = sheet.getRow(rowIndex+i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(selectCourseList.get(i).getDepartmentsIdShow());
                row.getCell(3).setCellValue(selectCourseList.get(i).getMajorCode());
                row.getCell(4).setCellValue(selectCourseList.get(i).getMajorName());
                row.getCell(5).setCellValue(selectCourseList.get(i).getMajorDirection());
                row.getCell(6).setCellValue(selectCourseList.get(i).getMajorDirectionShow());
                row.getCell(7).setCellValue(selectCourseList.get(i).getCourseCode());
                row.getCell(8).setCellValue(selectCourseList.get(i).getCourseName());
                row.getCell(9).setCellValue(selectCourseList.get(i).getCourseType());
                row.getCell(10).setCellValue(selectCourseList.get(i).getCourseProperties());
                row.getCell(11).setCellValue("");
                row.getCell(12).setCellValue(selectCourseList.get(i).getPrescribedPeriods());
                row.getCell(13).setCellValue(selectCourseList.get(i).getPracticeClass());
                row.getCell(14).setCellValue("");
                row.getCell(15).setCellValue(selectCourseList.get(i).getCoreCurriculum());
                row.getCell(16).setCellValue(selectCourseList.get(i).getSchoolEnterpriseCooperation());
                row.getCell(17).setCellValue(selectCourseList.get(i).getExcellentCourse());
                row.getCell(18).setCellValue("");
                row.getCell(19).setCellValue("");
                row.getCell(20).setCellValue("");
                row.getCell(21).setCellValue("");
                row.getCell(22).setCellValue("");
                row.getCell(23).setCellValue("");
                row.getCell(24).setCellValue("");
                row.getCell(25).setCellValue("");
                row.getCell(26).setCellValue("");
                row.getCell(27).setCellValue("");
                row.getCell(28).setCellValue("");
                row.getCell(29).setCellValue("");
                row.getCell(30).setCellValue(selectCourseList.get(i).getVenue());
                row.getCell(31).setCellValue(selectCourseList.get(i).getTeachingMethod());
                row.getCell(32).setCellValue(selectCourseList.get(i).getTestMethod());
                row.getCell(33).setCellValue(selectCourseList.get(i).getClassCertifiate());

                count++;


            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(sheetName+".xlsx",
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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
     * modify by lizhipeng end
     */

    /**
     * modify by hanjie start
     */
    @Override
    public void expertExcel_A6_1_1(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;
        List<Emp> empList = empDao.getEmpList(new Emp());
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            int rowIndex = 10;
            for (int i = 0; i < empList.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(empList.get(i).getDeptName());
                row.getCell(2).setCellValue(empList.get(i).getPersonId());
                row.getCell(3).setCellValue(empList.get(i).getName());
                row.getCell(4).setCellValue(empList.get(i).getSexShow());
                String idCard = empList.get(i).getIdCard();
                String birthday = idCard.substring(6, 14);
                row.getCell(5).setCellValue(birthday);
                row.getCell(6).setCellValue(empList.get(i).getNationShow());
                row.getCell(7).setCellValue(empList.get(i).getEducationalLevelShow());
                row.getCell(8).setCellValue(empList.get(i).getAcademicDegreeShow());

            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    @Override
    public void expertExcel_A6_1_2_1(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;
        List<Export> list = tableAttributeDao.expertExcel_A6_1_2_1();
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            int rowIndex = 10;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(list.get(i).getDepartmentName());
                row.getCell(2).setCellValue(list.get(i).getStaffId());
                row.getCell(3).setCellValue(list.get(i).getTeacherName());
                row.getCell(4).setCellValue(list.get(i).getSchoolYear());
                row.getCell(5).setCellValue(list.get(i).getMajorCode());
                row.getCell(6).setCellValue(list.get(i).getMajorName());
                row.getCell(7).setCellValue(list.get(i).getMajorDirection());
                row.getCell(8).setCellValue(list.get(i).getMajorDirectionShow());
                row.getCell(10).setCellValue(list.get(i).getCourseName());
                row.getCell(12).setCellValue(list.get(i).getCourseType());
                row.getCell(17).setCellValue(list.get(i).getSemester());
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    @Override
    public void expertExcel_A6_1_3(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;
        List<Export> list = tableAttributeDao.expertExcel_A6_1_3();
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            int rowIndex = 10;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(list.get(i).getStaffId());
                row.getCell(2).setCellValue(list.get(i).getTeacherName());
                row.getCell(3).setCellValue(list.get(i).getTrainingContent());
                row.getCell(4).setCellValue(list.get(i).getTrainingDay());
                row.getCell(5).setCellValue(list.get(i).getTrainingPlace());
                row.getCell(13).setCellValue(list.get(i).getRewordTime());
                row.getCell(14).setCellValue(list.get(i).getRewordName());
                row.getCell(15).setCellValue(list.get(i).getRewordLevel());
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    @Override
    public void expertExcel_A6_2_1(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;
        List<Export> list = tableAttributeDao.expertExcel_A6_2_1();
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            int rowIndex = 10;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(list.get(i).getDepartmentName());
                row.getCell(2).setCellValue(list.get(i).getStaffId());
                row.getCell(3).setCellValue(list.get(i).getTeacherName());
                row.getCell(4).setCellValue(list.get(i).getTeacherSex());
                row.getCell(5).setCellValue(list.get(i).getBirthday());
                row.getCell(6).setCellValue(list.get(i).getNationShow());
                row.getCell(7).setCellValue(list.get(i).getFinalEducation());
                row.getCell(8).setCellValue(list.get(i).getDegee());
                row.getCell(9).setCellValue(list.get(i).getMajorField());
                row.getCell(10).setCellValue(list.get(i).getMajorSpecialty());
                row.getCell(11).setCellValue(list.get(i).getWorkYear());
                row.getCell(12).setCellValue(list.get(i).getMajorYear());
                row.getCell(13).setCellValue(list.get(i).getMajorGrade());
                row.getCell(14).setCellValue(list.get(i).getMajorName2());
                row.getCell(15).setCellValue(list.get(i).getMajorDept());
                row.getCell(16).setCellValue(list.get(i).getMajorDate());
                row.getCell(17).setCellValue(list.get(i).getLicence());
                row.getCell(18).setCellValue(list.get(i).getGetTime());
                row.getCell(19).setCellValue(list.get(i).getExpertWork());
                row.getCell(19).setCellValue(list.get(i).getSfggTeacher());
                row.getCell(20).setCellValue(list.get(i).getSfssTeacher());
                row.getCell(21).setCellValue(list.get(i).getSfmsTeacher());
                row.getCell(22).setCellValue(list.get(i).getPoliticsMajorCode());
                row.getCell(23).setCellValue(list.get(i).getPoliticsMajorName());
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    @Override
    public void expertExcel_A6_2_2_1(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;
        List<Export> list = tableAttributeDao.expertExcel_A6_2_2_1();
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            int rowIndex = 10;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(list.get(i).getDepartmentName());
                row.getCell(2).setCellValue(list.get(i).getStaffId());
                row.getCell(3).setCellValue(list.get(i).getTeacherName());
                row.getCell(4).setCellValue(list.get(i).getSchoolYear());
                row.getCell(5).setCellValue(list.get(i).getMajorCode());
                row.getCell(6).setCellValue(list.get(i).getMajorName());
                row.getCell(7).setCellValue(list.get(i).getMajorDirection());
                row.getCell(8).setCellValue(list.get(i).getMajorDirectionShow());
                row.getCell(10).setCellValue(list.get(i).getCourseName());
                row.getCell(12).setCellValue(list.get(i).getCourseType());
                row.getCell(17).setCellValue(list.get(i).getSemester());
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    @Override
    public void expertExcel_A6_2_3(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;
        List<Export> list = tableAttributeDao.expertExcel_A6_2_3();
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            int rowIndex = 10;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(list.get(i).getStaffId());
                row.getCell(2).setCellValue(list.get(i).getTeacherName());
                row.getCell(3).setCellValue(list.get(i).getTrainingContent());
                row.getCell(4).setCellValue(list.get(i).getTrainingDay());
                row.getCell(5).setCellValue(list.get(i).getTrainingPlace());
                row.getCell(13).setCellValue(list.get(i).getRewordTime());
                row.getCell(14).setCellValue(list.get(i).getRewordName());
                row.getCell(15).setCellValue(list.get(i).getRewordLevel());
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    @Override
    public void expertExcel_A6_3_1(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;
        List<Export> list = tableAttributeDao.expertExcel_A6_3_1();
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            int rowIndex = 10;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(list.get(i).getDepartmentName());
                row.getCell(2).setCellValue(list.get(i).getStaffId());
                row.getCell(3).setCellValue(list.get(i).getTeacherName());
                row.getCell(4).setCellValue(list.get(i).getTeacherSex());
                row.getCell(5).setCellValue(list.get(i).getBirthday());
                row.getCell(6).setCellValue(list.get(i).getNationShow());
                row.getCell(7).setCellValue(list.get(i).getWorkDate());
                row.getCell(8).setCellValue(list.get(i).getFinalEducation());
                row.getCell(9).setCellValue(list.get(i).getDegee());
                row.getCell(10).setCellValue(list.get(i).getSinging());

                row.getCell(11).setCellValue(list.get(i).getMajorGrade());
                row.getCell(12).setCellValue(list.get(i).getMajorName2());
                row.getCell(13).setCellValue(list.get(i).getMajorDept());
                row.getCell(14).setCellValue(list.get(i).getMajorDate());

                row.getCell(15).setCellValue(list.get(i).getCareerGrade());
                row.getCell(16).setCellValue(list.get(i).getCareerName());
                row.getCell(17).setCellValue(list.get(i).getCareerDept());
                row.getCell(18).setCellValue(list.get(i).getCareerGettime());

                row.getCell(19).setCellValue(list.get(i).getExpertDept());
                row.getCell(20).setCellValue(list.get(i).getExpertWork());
                row.getCell(21).setCellValue(list.get(i).getExpertDate());

                row.getCell(22).setCellValue(list.get(i).getTrainingName());
                row.getCell(23).setCellValue(list.get(i).getTrainingDay());
                row.getCell(24).setCellValue(list.get(i).getTrainingPlace());

                row.getCell(25).setCellValue(list.get(i).getPoliticsMajorCode());
                row.getCell(26).setCellValue(list.get(i).getPoliticsMajorName());
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    @Override
    public void expertExcel_A6_3_2_1(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;
        List<Export> list = tableAttributeDao.expertExcel_A6_3_2_1();
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            int rowIndex = 10;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(list.get(i).getDepartmentName());
                row.getCell(2).setCellValue(list.get(i).getStaffId());
                row.getCell(3).setCellValue(list.get(i).getTeacherName());
                row.getCell(4).setCellValue(list.get(i).getSchoolYear());
                row.getCell(5).setCellValue(list.get(i).getMajorCode());
                row.getCell(6).setCellValue(list.get(i).getMajorName());
                row.getCell(7).setCellValue(list.get(i).getMajorDirection());
                row.getCell(8).setCellValue(list.get(i).getMajorDirectionShow());
                row.getCell(10).setCellValue(list.get(i).getCourseName());
                row.getCell(12).setCellValue(list.get(i).getCourseType());
                row.getCell(17).setCellValue(list.get(i).getSemester());
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    @Override
    public void expertExcel_A6_4_1(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;
        List<Export> list = tableAttributeDao.expertExcel_A6_4_1();
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            int rowIndex = 10;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(list.get(i).getDepartmentName());
                row.getCell(2).setCellValue(list.get(i).getStaffId());
                row.getCell(3).setCellValue(list.get(i).getTeacherName());
                row.getCell(4).setCellValue(list.get(i).getTeacherSex());
                row.getCell(5).setCellValue(list.get(i).getBirthday());
                row.getCell(6).setCellValue(list.get(i).getNationShow());
                row.getCell(7).setCellValue(list.get(i).getWorkDate());
                row.getCell(8).setCellValue(list.get(i).getFinalEducation());
                row.getCell(9).setCellValue(list.get(i).getDegee());
                row.getCell(10).setCellValue(list.get(i).getSinging());

                row.getCell(11).setCellValue(list.get(i).getMajorGrade());
                row.getCell(12).setCellValue(list.get(i).getMajorName2());
                row.getCell(13).setCellValue(list.get(i).getMajorDept());
                row.getCell(14).setCellValue(list.get(i).getMajorDate());

                row.getCell(15).setCellValue(list.get(i).getCareerGrade());
                row.getCell(16).setCellValue(list.get(i).getCareerName());
                row.getCell(17).setCellValue(list.get(i).getCareerDept());
                row.getCell(18).setCellValue(list.get(i).getCareerGettime());

                row.getCell(19).setCellValue(list.get(i).getExpertDept());
                row.getCell(20).setCellValue(list.get(i).getExpertWork());
                row.getCell(21).setCellValue(list.get(i).getExpertDate());

                row.getCell(22).setCellValue(list.get(i).getTrainingName());
                row.getCell(23).setCellValue(list.get(i).getTrainingDay());
                row.getCell(24).setCellValue(list.get(i).getTrainingPlace());

                row.getCell(25).setCellValue(list.get(i).getPoliticsMajorCode());
                row.getCell(26).setCellValue(list.get(i).getPoliticsMajorName());
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    @Override
    public void expertExcel_A6_4_2_1(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;
        List<Export> list = tableAttributeDao.expertExcel_A6_4_2_1();
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            int rowIndex = 10;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(list.get(i).getDepartmentName());
                row.getCell(2).setCellValue(list.get(i).getStaffId());
                row.getCell(3).setCellValue(list.get(i).getTeacherName());
                row.getCell(4).setCellValue(list.get(i).getSchoolYear());
                row.getCell(5).setCellValue(list.get(i).getMajorCode());
                row.getCell(6).setCellValue(list.get(i).getMajorName());
                row.getCell(7).setCellValue(list.get(i).getMajorDirection());
                row.getCell(8).setCellValue(list.get(i).getMajorDirectionShow());
                row.getCell(10).setCellValue(list.get(i).getCourseName());
                row.getCell(12).setCellValue(list.get(i).getCourseType());
                row.getCell(17).setCellValue(list.get(i).getSemester());
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    @Override
    public void expertExcel_A9_4(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;
        List<Export> list = tableAttributeDao.expertExcel_A9_4();
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getInternshipUnitName());
                row.getCell(4).setCellValue(list.get(i).getContactPerson());
                row.getCell(6).setCellValue(list.get(i).getContactNumber());
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    @Override
    public void expertExcel_A9_6_1(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;
        List<Export> list = tableAttributeDao.expertExcel_A9_6_1();
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getCompetitionName());
                row.getCell(4).setCellValue(list.get(i).getCompetitionLevel());
                row.getCell(6).setCellValue(list.get(i).getAwardTime());
                row.getCell(6).setCellValue(list.get(i).getStudentName());
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    @Override
    public void expertExcel_A9_6_2(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;
        List<Export> list = tableAttributeDao.expertExcel_A9_6_1();
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getCompetitionName());
                row.getCell(3).setCellValue(list.get(i).getCompetitionLevel());
                row.getCell(4).setCellValue(list.get(i).getAwardTime());
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    @Override
    public void expertExcel_A7_5(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;
        List<Export> list = tableAttributeDao.expertExcel_A7_5();
        try {
            FileInputStream in = new FileInputStream(file);
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getDepartmentName());
                row.getCell(3).setCellValue(list.get(i).getMajorCode());
                row.getCell(4).setCellValue(list.get(i).getMajorName());
                row.getCell(5).setCellValue(list.get(i).getMajorDirection());
                row.getCell(6).setCellValue(list.get(i).getMajorDirectionShow());
                row.getCell(8).setCellValue(list.get(i).getOrdersStudentNum());
                row.getCell(12).setCellValue(list.get(i).getInternshipNum());
                row.getCell(15).setCellValue(list.get(i).getEmploymentNum());
                row.getCell(28).setCellValue(list.get(i).getNowMajor());
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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
     * modify by hanjie end
     */

    /**
     * modify by wangxue start
     */
    public void expertExcel_A7_3_1(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        List<Major> majorList = tableAttributeDao.expertExcel_A7_3_1(new Major());

        Workbook wb = null;

        try {
            //读入文件
            FileInputStream in = new FileInputStream(file);
//            判断文件后缀名是xls,还是xlsx
//            如果是xls,使用HSSFWorkbook,如果是xlsx,使用XSSFWorkbook
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);

            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            int rowIndex = 10;
            int end = 2 + majorList.size();
            int count = 1;
            for (int i = 0; i < majorList.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(majorList.get(i).getDepartmentsId());
                row.getCell(3).setCellValue(majorList.get(i).getMajorCode());
                row.getCell(4).setCellValue(majorList.get(i).getMajorName());
                row.getCell(5).setCellValue(majorList.get(i).getMajorDirectionCode());
                row.getCell(6).setCellValue(majorList.get(i).getMajorDirection());
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);

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


    public void expertExcel_A7_3_2(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        List<Major> majorList = tableAttributeDao.expertExcel_A7_3_2(new Major());

        Workbook wb = null;

        try {
            //读入文件
            FileInputStream in = new FileInputStream(file);
//            判断文件后缀名是xls,还是xlsx
//            如果是xls,使用HSSFWorkbook,如果是xlsx,使用XSSFWorkbook
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);

            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            int rowIndex = 10;
            int end = 2 + majorList.size();
            int count = 1;
            for (int i = 0; i < majorList.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(majorList.get(i).getDepartmentsId());
                row.getCell(3).setCellValue(majorList.get(i).getMajorCode());
                row.getCell(4).setCellValue(majorList.get(i).getMajorName());
                row.getCell(5).setCellValue(majorList.get(i).getMajorDirectionCode());
                row.getCell(6).setCellValue(majorList.get(i).getMajorDirection());
                count++;
            }
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);

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


    public void expertExcel_A7_4(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        List<Major> majorList = tableAttributeDao.expertExcel_A7_4(new Major());
        //List<InternshipManage> internshipManageList= tableAttributeDao.expertExcel_A7(new InternshipManage());
        Workbook wb = null;

        try {
            //读入文件
            FileInputStream in = new FileInputStream(file);
//            判断文件后缀名是xls,还是xlsx
//            如果是xls,使用HSSFWorkbook,如果是xlsx,使用XSSFWorkbook
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);

            if ("xls".equals(suffix)) {
                wb = new HSSFWorkbook(in);
            }
            if ("xlsx".equals(suffix)) {
                wb = new XSSFWorkbook(in);
            }
            Sheet sheet = wb.getSheetAt(0);
            String sheetName = sheet.getSheetName();
            int rowIndex = 10;
            int end = 2 + majorList.size();

            int count = 1;
            for (int i = 0; i < majorList.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(majorList.get(i).getDepartmentsId());
                row.getCell(3).setCellValue(majorList.get(i).getMajorCode());
                row.getCell(4).setCellValue(majorList.get(i).getMajorName());
                row.getCell(5).setCellValue(majorList.get(i).getMajorDirectionCode());
                row.getCell(6).setCellValue(majorList.get(i).getMajorDirection());
                row.getCell(17).setCellValue(majorList.get(i).getInternshipPositions());
                row.getCell(18).setCellValue(majorList.get(i).getInternshipUnitIdShow());
                row.getCell(20).setCellValue(majorList.get(i).getPostsTime());
                count++;
            }

            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            wb.write(os);

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
     * modify by wangxue end
     */


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
