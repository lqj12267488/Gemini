package com.goisan.tabular.service.impl;

import com.goisan.educational.course.bean.Course;
import com.goisan.educational.course.service.CourseService;
import com.goisan.educational.major.bean.*;
import com.goisan.educational.major.service.MajorLeaderService;
import com.goisan.educational.major.service.MajorService;
import com.goisan.educational.skillappraisal.bean.SkillAppraisal;
import com.goisan.educational.teacher.bean.TeacherCondition;
import com.goisan.educational.teacher.dao.TeacherInfoDao;
import com.goisan.evaluation.bean.EvaluationTask;
import com.goisan.studentwork.employments.bean.EmploymentManage;
import com.goisan.studentwork.studentrewardpunish.bean.SchoolBurse;
import com.goisan.system.bean.*;
import com.goisan.system.dao.EmpDao;
import com.goisan.system.dao.ParameterDao;
import com.goisan.system.tools.PoiUtils;
import com.goisan.table.bean.*;
import com.goisan.table.dao.*;
import com.goisan.table.bean.*;
import com.goisan.table.dao.ClubRewardDao;
import com.goisan.tabular.bean.TabularFile;
import com.goisan.tabular.bean.export.Export;
import com.goisan.tabular.dao.TableAttributeDao;
import com.goisan.tabular.service.TableAttributeService;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

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
    @Resource
    private ClubRewardDao clubRewardDao;
    @Resource
    private InCampusPraDao inCampusPraDao;
    @Resource
    private OutCampusPraDao outCampusPraDao;
    @Resource
    private ProEvaAgencyDao proEvaAgencyDao;
    @Resource
    private SchIncomeDao schIncomeDao;
    @Resource
    private SchExpendDao schExpendDao;
    @Resource
    private ScholarshipMgeDao scholarshipMgeDao;
    @Resource
    private SchAwardDao schAwardDao;

    @Resource
    private StuAwardInfoDao stuAwardInfoDao;
    @Resource
    private CourtyardNameDao courtyardNameDao;
    @Resource
    private ContactInformationDao contactInformationDao;
    @Resource
    private InstitutionalAreaDao institutionalAreaDao;
    @Resource
    private TeacherInfoDao teacherInfoDao;
    /**
     * 导出带有数据得表格 命名expertExcel_A加上数字
     * 例
     * * @param response
     */
    public List<ContactInformation> getContactInformationList(){
        return tableAttributeDao.getContactInformationList();
    }
    public void expertExcel_A1(HttpServletResponse response, TabularFile tabularFile) {
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
            List<CourtyardName> list =  courtyardNameDao.getCourtyardNameList(new CourtyardName());
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(list.get(i).getSchoolIdcode());
                row.getCell(2).setCellValue(list.get(i).getSchoolName());
                row.getCell(3).setCellValue(list.get(i).getProvince());
                row.getCell(4).setCellValue(list.get(i).getCity());
                row.getCell(5).setCellValue(list.get(i).getEnableTime());
                row.getCell(6).setCellValue(list.get(i).getEstablishTime());
                row.getCell(7).setCellValue(list.get(i).getEstablishBasics());
                row.getCell(8).setCellValue(list.get(i).getNatureShow());
                row.getCell(9).setCellValue(list.get(i).getHoldLevelShow());
                row.getCell(10).setCellValue(list.get(i).getSchoolTypeShow());
                row.getCell(11).setCellValue(list.get(i).getSchoolMotto());
                row.getCell(12).setCellValue(list.get(i).getExemplaryNatureShow());
                row.getCell(13).setCellValue(list.get(i).getExemplaryLevelShow());
                row.getCell(14).setCellValue(list.get(i).getEstablishmentDept());
                row.getCell(15).setCellValue(list.get(i).getEstablishmentTime());
                row.getCell(16).setCellValue(list.get(i).getAssessmentOneTime());
                row.getCell(17).setCellValue(list.get(i).getEvaluationConclusionOne());
                row.getCell(18).setCellValue(list.get(i).getAssessmentTwoTime());
                row.getCell(19).setCellValue(list.get(i).getEvaluationConclusionTwo());
                row.getCell(20).setCellValue(list.get(i).getUnassessedShow());
                count++;
            }

            int rowIndex2 = 17;
            List<ContactInformation> list1 = tableAttributeDao.getContactInformationList();
            for (int i = 0; i < list1.size(); i++) {
                Row row = sheet.getRow(rowIndex2 + i);
                row.getCell(1).setCellValue(list1.get(i).getMailingAddress());
                row.getCell(2).setCellValue(list1.get(i).getPostalCode());
                row.getCell(3).setCellValue(list1.get(i).getSchoolWebsite());
                row.getCell(4).setCellValue(list1.get(i).getAreaStaff());
                row.getCell(5).setCellValue(list1.get(i).getAreaPersonName());
                row.getCell(6).setCellValue(list1.get(i).getAreaPost());
                row.getCell(7).setCellValue(list1.get(i).getAreaNumber());
                row.getCell(8).setCellValue(list1.get(i).getAreaFax());
                row.getCell(9).setCellValue(list1.get(i).getMailBox());
                row.getCell(10).setCellValue(list1.get(i).getAreaContactsStaff());
                row.getCell(11).setCellValue(list1.get(i).getContactsPersonName());
                row.getCell(12).setCellValue(list1.get(i).getAreaContactsPost());
                row.getCell(13).setCellValue(list1.get(i).getContactsAreaNumber());
                row.getCell(14).setCellValue(list1.get(i).getContactsAreaFax());
                row.getCell(15).setCellValue(list1.get(i).getAreaContactsPost());
                row.getCell(16).setCellValue(list1.get(i).getContactsMailBox());
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
            List<BaseBean> list = proEvaAgencyDao.getProEvaAgencyList(null);
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
               ProEvaAgency pea = (ProEvaAgency) list.get(i);
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(pea.getEvaName());
                row.getCell(3).setCellValue(pea.getCertName());
                row.getCell(4).setCellValue(pea.getEvaLevelShow());
                row.getCell(5).setCellValue(pea.getBuildDepLevShow());
                row.getCell(6).setCellValue(pea.getDepart());
                row.getCell(7).setCellValue(pea.getSsEvaNum());
                row.getCell(8).setCellValue(pea.getSchEvaNum());
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
            List<BaseBean> list = schIncomeDao.getSchIncomeList(null);
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                SchIncome si = (SchIncome) list.get(i);
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(3).setCellValue(count);
                row.getCell(4).setCellValue(si.getSfStuType());
                row.getCell(5).setCellValue(si.getSfStd());
                row.getCell(6).setCellValue(si.getSfMoney());
                row.getCell(8).setCellValue(count);
                row.getCell(9).setCellValue(si.getAwProName());
                row.getCell(10).setCellValue(si.getAwStd());
                row.getCell(11).setCellValue(si.getAwProMoney());
                row.getCell(13).setCellValue(count);
                row.getCell(14).setCellValue(si.getFinProName());
                row.getCell(15).setCellValue(si.getFinProMoney());
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

            List<BaseBean> list = schExpendDao.getSchExpendList(null);
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                SchExpend se = (SchExpend) list.get(i);
                Row row = sheet.getRow(rowIndex + i);
                setValue(row,2,se.getLand());
                setValue(row,3,se.getExpInf());
                setValue(row,4,se.getExpDevAll());
                setValue(row,5,se.getExpTeachDev());

                setValue(row,7,se.getTrainCost());
                setValue(row,8,se.getTrainPro());
                setValue(row,9,se.getHirePtTeach());
                setValue(row,10,se.getSport());
                setValue(row,11,se.getDailyOth());

                setValue(row,13,String.valueOf(count));
                setValue(row,14,se.getRsProName());
                setValue(row,15,se.getRsProMoney());

                setValue(row,17,String.valueOf(count));
                setValue(row,18,se.getTcProName());
                setValue(row,19,se.getTcProMoney());
                setValue(row,20,se.getLibCost());
                setValue(row,21,se.getOthCost());
                setValue(row,22,se.getPayLoan());
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

    public void setValue(Row row,int col,String value){
        Cell cell = row.getCell(col) == null ? row.createCell(col) : row.getCell(col);
        cell.setCellValue(value);
        CellStyle cellStyle = cell.getCellStyle();
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
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
//            List<Emp> list = tableAttributeDao.getExpertExcel_A2();
            int rowIndex = 10;
            int count = 1;
            Row row;
            /*for (int i = 0; i < list.size(); i++) {
                System.out.println(i);
                row = sheet.getRow(rowIndex + i);
                if(row == null) row = sheet.createRow(rowIndex + i);
                if(row.getCell(1) == null){
                    row.createCell(1).setCellValue(count);
                    row.createCell(2).setCellValue(list.get(i).getStaffId());
                    row.createCell(3).setCellValue(list.get(i).getName());
                    row.createCell(4).setCellValue(list.get(i).getNation());
                    row.createCell(5).setCellValue(list.get(i).getPost());
                    row.createCell(6).setCellValue(list.get(i).getPositionalTitles());
                    row.createCell(7).setCellValue(list.get(i).getEducationalLevel());
                    row.createCell(8).setCellValue(list.get(i).getSex());
                    row.createCell(9).setCellValue(list.get(i).getBirthday());
                    row.createCell(10).setCellValue(list.get(i).getTel());
                    row.createCell(11).setCellValue("");
                    row.createCell(12).setCellValue("");
                    row.createCell(13).setCellValue(list.get(i).getEducationalResearch());
                }else {
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
                }
                count++;
            }*/

            List<TeachContact> teachContactList = tableAttributeDao.getExpertExcel_A2_2();
//            rowIndex = 14 + list.size();
            rowIndex = 32;
            count = 1;
            Cell cell;
            for (int i = 0; i < teachContactList.size(); i++) {
                row = sheet.getRow(rowIndex + i);
                if(row == null) row = sheet.createRow(rowIndex + i);
                cell = row.getCell(1);
                if (cell == null ) cell = row.createCell(1);
                cell.setCellValue(count);
                cell = row.getCell(2);
                if (cell == null ) cell = row.createCell(2);
                cell.setCellValue(teachContactList.get(i).getStaffId());
                cell = row.getCell(3);
                if (cell == null ) cell = row.createCell(3);
                cell.setCellValue(teachContactList.get(i).getPersonIdShow());
                cell = row.getCell(4);
                if (cell == null ) cell = row.createCell(4);
                cell.setCellValue(teachContactList.get(i).getResponsibilities());
                cell = row.getCell(5);
                if (cell == null ) cell = row.createCell(5);
                cell.setCellValue(teachContactList.get(i).getAttendLectures());
                cell = row.getCell(6);
                if (cell == null ) cell = row.createCell(6);
                cell.setCellValue(teachContactList.get(i).getStudentDorm());
                cell = row.getCell(7);
                if (cell == null ) cell = row.createCell(7);
                cell.setCellValue(teachContactList.get(i).getOutsidePractice());
                cell = row.getCell(8);
                if (cell == null ) cell = row.createCell(8);
                cell.setCellValue(teachContactList.get(i).getStudentClubActivities());
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
            List<InstitutionalArea> list =  tableAttributeDao.getInstitutionalAreaList();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex+i);
                row.getCell(1).setCellValue(list.get(i).getAreaCovered());
                row.getCell(2).setCellValue(list.get(i).getGreenLandArea());
                row.getCell(3).setCellValue(list.get(i).getBuildingArea());
                row.getCell(4).setCellValue(list.get(i).getSchoolPropertyArea());
                row.getCell(5).setCellValue(list.get(i).getSchoolBuilding());
                row.getCell(6).setCellValue(list.get(i).getWrongSchoolProperty());
                row.getCell(7).setCellValue(list.get(i).getScientificAuxiliary());
                row.getCell(8).setCellValue(list.get(i).getClassroom());
                row.getCell(9).setCellValue(list.get(i).getLibrary());
                row.getCell(10).setCellValue(list.get(i).getLaboratoriesPlaces());
                row.getCell(11).setCellValue(list.get(i).getResearchRoom());
                row.getCell(12).setCellValue(list.get(i).getGymnasium());
                row.getCell(13).setCellValue(list.get(i).getHall());
                row.getCell(14).setCellValue(list.get(i).getAdministrativeOffice());
                row.getCell(15).setCellValue(list.get(i).getCollegeAreaRoom());
                row.getCell(16).setCellValue(list.get(i).getStudentDormitory());
                row.getCell(17).setCellValue(list.get(i).getStudentCanteen());
                row.getCell(18).setCellValue(list.get(i).getTeachingDormitory());
                row.getCell(19).setCellValue(list.get(i).getStaffCan());
                row.getCell(20).setCellValue(list.get(i).getLifeWelfare());
                row.getCell(21).setCellValue(list.get(i).getFacultyHousing());
                row.getCell(22).setCellValue(list.get(i).getOtherRooms());
                count++;
            }
            int rowIndex2 = 17;
            List<BookCollection> list2 =  tableAttributeDao.getBookCollectionList();
            for (int i = 0; i < list2.size(); i++) {
                Row row = sheet.getRow(rowIndex2+i);
                row.getCell(1).setCellValue(list2.get(i).getTotalNumber());
                row.getCell(2).setCellValue(list2.get(i).getSchoolYearAdd());
                row.getCell(3).setCellValue(list2.get(i).getChinesePaperJournal());
                row.getCell(4).setCellValue(list2.get(i).getForeignPaperJournals());
                row.getCell(5).setCellValue(list2.get(i).getElectronicJournal());
                count++;
            }

            int rowIndex3 = 24;
            List<MachineClassroom> list3 =  tableAttributeDao.getMachineClassroomList();
            for (int i = 0; i < list3.size(); i++) {
                Row row = sheet.getRow(rowIndex3+i);
                row.getCell(1).setCellValue(list3.get(i).getReadingRoomSeat());
                row.getCell(2).setCellValue(list3.get(i).getComputerNumber());
                row.getCell(3).setCellValue(list3.get(i).getTeachingComputer());
                row.getCell(4).setCellValue(list3.get(i).getTabletPc());
                row.getCell(5).setCellValue(list3.get(i).getPublicComputerRoom());
                row.getCell(6).setCellValue(list3.get(i).getProfessionalComputer());
                row.getCell(7).setCellValue(list3.get(i).getClassroom());
                row.getCell(8).setCellValue(list3.get(i).getMultimediaClassroom());
                count++;
            }
            int rowIndex4 = 34;
            List<GeneralConstruction> list4 = tableAttributeDao.getGeneralConstructionList();
            for (int i = 0; i < list4.size(); i++) {
                Row row = sheet.getRow(rowIndex4+i);
                row.getCell(1).setCellValue(list4.get(i).getInternetBandwidth());
                row.getCell(2).setCellValue(list4.get(i).getNetworkBandwidth());
                row.getCell(3).setCellValue(list4.get(i).getOneCardUseShow());
                row.getCell(4).setCellValue(list4.get(i).getWirelessCoverageShow());
                row.getCell(5).setCellValue(list4.get(i).getNetworkInformation());
                row.getCell(6).setCellValue(list4.get(i).getManagementInformation());
                row.getCell(7).setCellValue(list4.get(i).getSystemMailNumber());
                row.getCell(8).setCellValue(list4.get(i).getOnlineCourses());
                row.getCell(9).setCellValue(list4.get(i).getDigitalResources());
                row.getCell(10).setCellValue(list4.get(i).getElectronicsBook());
                count++;
            }
            int rowIndex5 = 40;
            List<ManagementInformation> list5 = tableAttributeDao.getManagementInformationList();
            int count5 = 1;
            for (int i = 0; i < list5.size(); i++) {
                Row row = sheet.getRow(rowIndex5+i);
                row.getCell(1).setCellValue(count5);
                row.getCell(2).setCellValue(list5.get(i).getTypeShow());
                row.getCell(3).setCellValue(list5.get(i).getSystemName());
                row.getCell(4).setCellValue(list5.get(i).getSourcesShow());
                row.getCell(5).setCellValue(list5.get(i).getUnitName());
                count5++;
            }



            int rowIndex6 = 68;
            int count6 = 1;
            List<InformationPersonnel>  list6 = tableAttributeDao.getInformationPersonnelList();
            for (int i = 0; i < list6.size(); i++) {
                Row row = sheet.getRow(rowIndex6+i);
                row.getCell(1).setCellValue(count6);
                row.getCell(2).setCellValue(list6.get(i).getOrganizationCode());
                row.getCell(3).setCellValue(list6.get(i).getOrganizationName());
                row.getCell(4).setCellValue(list6.get(i).getPersonStaff());
                row.getCell(5).setCellValue(list6.get(i).getPersonName());
                row.getCell(6).setCellValue(list6.get(i).getStaffNumber());
                row.getCell(7).setCellValue(list6.get(i).getEmployeNumber());
                count6++;
            }

            int rowIndex7 = 75;
            List<FixedAssets>  list7 = tableAttributeDao.getFixedAssetsList();
            for (int i = 0; i < list7.size(); i++) {
                Row row = sheet.getRow(rowIndex7+i);
                row.getCell(1).setCellValue(list7.get(i).getTotalSchoolValue());
                row.getCell(2).setCellValue(list7.get(i).getTotalAssets());
                row.getCell(3).setCellValue(list7.get(i).getAssetsAdd());
                count6++;
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

    public List<InstitutionalArea> getInstitutionalAreaList(){
        return tableAttributeDao.getInstitutionalAreaList();
    }

    public  List<BookCollection> getBookCollectionList(){
        return tableAttributeDao.getBookCollectionList();
    }

    public List<MachineClassroom> getMachineClassroomList(){
        return tableAttributeDao.getMachineClassroomList();
    }

    public List<GeneralConstruction> getGeneralConstructionList(){
        return tableAttributeDao.getGeneralConstructionList();
    }

    public List<ManagementInformation> getManagementInformationList(){
        return tableAttributeDao.getManagementInformationList();
    }

    public List<InformationPersonnel> getInformationPersonnelList(){
        return tableAttributeDao.getInformationPersonnelList();
    }

    public List<FixedAssets> getFixedAssetsList(){
        return tableAttributeDao.getFixedAssetsList();
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
            List<BaseBean> list = inCampusPraDao.getInCampusPraList(null);
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                InCampusPra inCampusPra = (InCampusPra) list.get(i);
                Row row = sheet.getRow(rowIndex+i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(inCampusPra.getPraName());
                row.getCell(3).setCellValue(inCampusPra.getParTotal());
                row.getCell(4).setCellValue(inCampusPra.getParMajor());
                row.getCell(5).setCellValue(inCampusPra.getParSupDept());
                String time = inCampusPra.getParSupTime();
                if (!StringUtils.isEmpty(time)){
                    time = time.substring(0,4);
                }
                row.getCell(6).setCellValue(time);

                row.getCell(7).setCellValue(inCampusPra.getParArea());
                row.getCell(8).setCellValue(inCampusPra.getParDevAllvalue());
                row.getCell(9).setCellValue(inCampusPra.getParDevNewvalue());
                row.getCell(10).setCellValue(inCampusPra.getSelfDevValue());
                row.getCell(11).setCellValue(inCampusPra.getSsDevValue());
                row.getCell(12).setCellValue(inCampusPra.getSswDevValue());
                row.getCell(13).setCellValue(inCampusPra.getDevNum());
                row.getCell(14).setCellValue(inCampusPra.getDevBigNum());
                row.getCell(15).setCellValue(inCampusPra.getParProNum());
                row.getCell(16).setCellValue(inCampusPra.getMainParPro());
                row.getCell(17).setCellValue(inCampusPra.getSchUseFre());
                row.getCell(18).setCellValue(inCampusPra.getSsUseFre());
                row.getCell(19).setCellValue(inCampusPra.getWorkNum());
                row.getCell(20).setCellValue(inCampusPra.getMaterCost());
                row.getCell(21).setCellValue(inCampusPra.getDevMaintCost());
                row.getCell(22).setCellValue(inCampusPra.getMgeNum());
                row.getCell(23).setCellValue(inCampusPra.getPartMgeNum());
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
            List<BaseBean> list =  outCampusPraDao.getOutCampusPraList(null);
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                OutCampusPra ocp = (OutCampusPra) list.get(i);
                Row row = sheet.getRow(rowIndex+i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(ocp.getOpraName());
                row.getCell(3).setCellValue(ocp.getOpraUnit());
                row.getCell(4).setCellValue(ocp.getOpraEmpNum());
                String time = toDateString(ocp.getBuildTime());
                if (null!=time){
                    time=time.substring(0,6);
                }
                row.getCell(5).setCellValue(time);
                row.getCell(6).setCellValue(ocp.getOpraMajorNum());
                row.getCell(7).setCellValue(ocp.getMainOpraMajor());
                row.getCell(8).setCellValue(ocp.getOpraProNum());
                row.getCell(9).setCellValue(ocp.getOpraProName());
                row.getCell(10).setCellValue(ocp.getOpraStdNum());
                row.getCell(11).setCellValue(ocp.getBaseUseDay());
                row.getCell(12).setCellValue(ocp.getInternNum());
                row.getCell(13).setCellValue(ocp.getSfDorm());
                row.getCell(14).setCellValue(ocp.getSfSub());
                row.getCell(15).setCellValue(ocp.getItnCost());
                row.getCell(16).setCellValue(ocp.getSendMge());
                row.getCell(17).setCellValue(ocp.getAccGrad());
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

            List<StudentDocuments> list = tableAttributeDao.getExpertExcel_A8_1();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);

                row.getCell(1).setCellValue(list.get(i).getOrdernumber());
                row.getCell(2).setCellValue(list.get(i).getFilename());
                row.getCell(3).setCellValue(list.get(i).getReleasedateStr());
                row.getCell(4).setCellValue(list.get(i).getReleasedept());
                row.getCell(5).setCellValue(list.get(i).getAlteration());
                row.getCell(6).setCellValue(list.get(i).getAlterationdateStr());
                row.getCell(7).setCellValue(list.get(i).getResponsibledept());

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
                String staffId = list.get(i).getStaffId();
                row.getCell(1).setCellValue(staffId);
                String name = list.get(i).getName();
                row.getCell(2).setCellValue(name);
                row.getCell(3).setCellValue(list.get(i).getStaffFlag());
                row.getCell(4).setCellValue(list.get(i).getSex());
                row.getCell(5).setCellValue(list.get(i).getBirthdayShow());
                row.getCell(6).setCellValue(list.get(i).getNation());
                row.getCell(7).setCellValue(list.get(i).getDeptName());
                row.getCell(8).setCellValue(list.get(i).getEducationalLevel());
                row.getCell(9).setCellValue(list.get(i).getAcademicDegree());
                row.getCell(10).setCellValue(list.get(i).getGRADE());
                row.getCell(11).setCellValue(list.get(i).getGIVENNAME());
                row.getCell(12).setCellValue(list.get(i).getISSUER());
                row.getCell(13).setCellValue(list.get(i).getGetDateShow());
                row.getCell(14).setCellValue(list.get(i).getPost());
                row.getCell(15).setCellValue(list.get(i).getPostfunction());
                row.getCell(16).setCellValue(list.get(i).getWorkingyears());
                row.getCell(17).setCellValue(list.get(i).getTEACHINGMANAGEMENT());
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
                row.getCell(10).setCellValue(list.get(i).getGRADE());
                row.getCell(11).setCellValue(list.get(i).getGIVENNAME());
                row.getCell(12).setCellValue(list.get(i).getISSUER());
                row.getCell(13).setCellValue(list.get(i).getGetDateShow());
                row.getCell(14).setCellValue(list.get(i).getStaffSource());
                row.getCell(15).setCellValue(list.get(i).getPostfunction());
                row.getCell(16).setCellValue(list.get(i).getWorkingyears());
                row.getCell(17).setCellValue(list.get(i).getSTUDENTMANAGEMENT());

                row.getCell(18).setCellValue("0".equals(list.get(i).getPOLITICALCOUNSELOR())?"否":"是");
                row.getCell(19).setCellValue("0".equals(list.get(i).getPSYCHOLOGICALCONSULTANT())?"否":"是");
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
                row.getCell(10).setCellValue(list.get(i).getGRADE());
                row.getCell(11).setCellValue(list.get(i).getGIVENNAME());
                row.getCell(12).setCellValue(list.get(i).getISSUER());
                row.getCell(13).setCellValue(list.get(i).getGetDateShow());
                row.getCell(14).setCellValue(list.get(i).getStaffSource());
                row.getCell(15).setCellValue(list.get(i).getPostfunction());
                row.getCell(16).setCellValue(list.get(i).getWorkingyears());
                row.getCell(17).setCellValue(list.get(i).getEMPLOYMENTOFFICE());
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
                row.getCell(8).setCellValue(list.get(i).getEXPERTISE());
                row.getCell(9).setCellValue(list.get(i).getGRADE());
                row.getCell(10).setCellValue(list.get(i).getGIVENNAME());
                row.getCell(11).setCellValue(list.get(i).getISSUER());
                row.getCell(12).setCellValue(list.get(i).getGetDateShow());
                row.getCell(13).setCellValue(list.get(i).getStaffSourceShow());
                row.getCell(14).setCellValue(list.get(i).getWORKINGHOURS());
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
                row.getCell(9).setCellValue(list.get(i).getEXPERTISE());
                row.getCell(10).setCellValue(list.get(i).getGRADE());
                row.getCell(11).setCellValue(list.get(i).getGIVENNAME());
                row.getCell(12).setCellValue(list.get(i).getISSUER());
                row.getCell(13).setCellValue(list.get(i).getGetDateShow());
                row.getCell(14).setCellValue(list.get(i).getTOPICNATURE());
                row.getCell(15).setCellValue(list.get(i).getSUBJECTCLASSIFICATION());
                row.getCell(16).setCellValue(list.get(i).getSUBJECTNAME());
                row.getCell(17).setCellValue("0".equals(list.get(i).getHORIZONTALTOPIC())?"否":"是");
                row.getCell(18).setCellValue(list.get(i).getSUBJECTGRADE());
                row.getCell(19).setCellValue(list.get(i).getPROJECTDATESHOW());
                row.getCell(20).setCellValue(list.get(i).getSOURCEOFFUNDING());
                row.getCell(21).setCellValue(list.get(i).getSOURCEOFFUNDING());
                row.getCell(22).setCellValue(list.get(i).getMONEY());
                row.getCell(23).setCellValue(list.get(i).getCOMPLETORORDER());
                row.getCell(24).setCellValue(list.get(i).getNUM());
                String str = list.get(i).getCOOPERATION();
                row.getCell(25).setCellValue(list.get(i).getHIGHESTGRADE());
                row.getCell(26).setCellValue(str);
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
//            List<SchoolBurse> list = tableAttributeDao.getExpertExcel_A8_8();
            List<BaseBean> list = scholarshipMgeDao.getScholarshipMgeList(null);
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                ScholarshipMge ssm = (ScholarshipMge) list.get(i);
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(ssm.getSmProName());
                row.getCell(3).setCellValue(ssm.getSmProTypeShow());
                row.getCell(4).setCellValue(ssm.getAidRge());
                row.getCell(5).setCellValue(ssm.getAidCounts());
                row.getCell(6).setCellValue(ssm.getAidMoney());
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

    @Transactional
    public void expertExcel_A10_1_2(HttpServletResponse response, TabularFile tabularFile) {
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
            List<EmploymentManage> list = tableAttributeDao.getExpertExcel_A10_1_2();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getStudentNumber());
                row.getCell(3).setCellValue(list.get(i).getStudentId());
                row.getCell(4).setCellValue("");
                row.getCell(5).setCellValue(list.get(i).getEmploymentUnitIdShow());
                row.getCell(6).setCellValue(list.get(i).getUnitProperty());
                row.getCell(7).setCellValue(list.get(i).getEnterpriseScale());
                row.getCell(8).setCellValue(list.get(i).getSalary());
                row.getCell(9).setCellValue(list.get(i).getMajorMatchFlag());
                row.getCell(10).setCellValue(list.get(i).getEmploymentPlace());
                row.getCell(11).setCellValue(list.get(i).getEmploymentPlace());
                row.getCell(12).setCellValue("");
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

    public List<EmploymentManage> getExpertExcel_A10_1_2() {
        return tableAttributeDao.getExpertExcel_A10_1_2();
    }

    @Transactional
    public void expertExcel_A10_1(HttpServletResponse response, TabularFile tabularFile) {
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
            List<Student> list = tableAttributeDao.getExpertExcel_A10_1();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getStudentNumber());
                row.getCell(3).setCellValue(list.get(i).getName());
                row.getCell(4).setCellValue(list.get(i).getSex());
                row.getCell(5).setCellValue(list.get(i).getNation());
                row.getCell(6).setCellValue(list.get(i).getStudentStatus());
                row.getCell(7).setCellValue("");
                row.getCell(8).setCellValue(list.get(i).getSourcePlaceDivisionCode());
                row.getCell(9).setCellValue(list.get(i).getFromArmy());
                row.getCell(10).setCellValue(list.get(i).getAdmissionsWay());
                row.getCell(11).setCellValue(list.get(i).getStudentSource());
                row.getCell(12).setCellValue(list.get(i).getRuralHouseholdRegistratio());
                row.getCell(13).setCellValue(list.get(i).getOrderTraining());
                row.getCell(14).setCellValue(list.get(i).getDocumentaryLikaPoorFamilie());
                row.getCell(15).setCellValue("");
                row.getCell(16).setCellValue(list.get(i).getSchoolSystem());
                row.getCell(17).setCellValue(list.get(i).getYears());
                row.getCell(18).setCellValue(list.get(i).getTestScores());
                row.getCell(19).setCellValue(list.get(i).getDeptId());
                row.getCell(20).setCellValue("");
                row.getCell(21).setCellValue(list.get(i).getClassName());
                row.getCell(22).setCellValue(list.get(i).getMajorCode());
                row.getCell(23).setCellValue(list.get(i).getMajorName());
                row.getCell(24).setCellValue(list.get(i).getMajorDirection());
                row.getCell(25).setCellValue(list.get(i).getMajorDirectionShow());
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

    public List<Student> getExpertExcel_A10_1() {
        return tableAttributeDao.getExpertExcel_A10_1();
    }

    public void expertExcel_A10_2_1(HttpServletResponse response, TabularFile tabularFile) {
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
            List<Student> list = tableAttributeDao.getExpertExcel_A10_2_1();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(list.get(i).getMajorCode());
                row.getCell(3).setCellValue(list.get(i).getMajorName());
                row.getCell(4).setCellValue(list.get(i).getMajorDirection());
                row.getCell(5).setCellValue(list.get(i).getMajorDirectionShow());
                row.getCell(6).setCellValue("");
                row.getCell(7).setCellValue(list.get(i).getClassName());
                row.getCell(8).setCellValue(list.get(i).getStudentNumber());
                row.getCell(9).setCellValue(list.get(i).getName());
                row.getCell(10).setCellValue(list.get(i).getSex());
                row.getCell(11).setCellValue("");
                row.getCell(12).setCellValue("");
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

    public List<Student> getExpertExcel_A10_2_1() {
        return tableAttributeDao.getExpertExcel_A10_2_1();
    }

    public void expertExcel_A10_3(HttpServletResponse response, TabularFile tabularFile) {
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
            List<Associations> list = tableAttributeDao.getExpertExcel_A10_3();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex+i);
                row.getCell(1).setCellValue(list.get(i).getOrdernumber());
                row.getCell(2).setCellValue(list.get(i).getCommunitycode());
                row.getCell(3).setCellValue(list.get(i).getCommunityname());
                row.getCell(4).setCellValue(list.get(i).getCommunitycategory());
                row.getCell(5).setCellValue(list.get(i).getRegistrationdateStr());
                row.getCell(6).setCellValue(list.get(i).getApprovaldepartment());
                row.getCell(7).setCellValue(list.get(i).getRegistrantorganization());
                row.getCell(8).setCellValue(list.get(i).getExistingmember());
                row.getCell(9).setCellValue(list.get(i).getName());
                row.getCell(10).setCellValue(list.get(i).getGrade());
                row.getCell(11).setCellValue(list.get(i).getMoney());
                row.getCell(12).setCellValue(list.get(i).getCredit());
                row.getCell(13).setCellValue(list.get(i).getAwards());
                row.getCell(14).setCellValue(list.get(i).getGuidancedepartment());
                row.getCell(15).setCellValue(list.get(i).getInstructors());
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

    public void expertExcel_A10_4(HttpServletResponse response, TabularFile tabularFile) {
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
            RedCross redCross = tableAttributeDao.getExpertExcel_A4_4();
            int rowIndex = 10;
            int count = 1;

                Row row = sheet.getRow(rowIndex+0);
                row.getCell(1).setCellValue(redCross.getDepartment());
                row.getCell(2).setCellValue(redCross.getCommunitycode());
                row.getCell(3).setCellValue(redCross.getCommunityname());
                row.getCell(4).setCellValue(redCross.getFounddateStr());
                row.getCell(5).setCellValue(redCross.getSum());
                row.getCell(6).setCellValue(redCross.getTeachingstaffnumber());
                row.getCell(7).setCellValue(redCross.getStudentnumber());
                row.getCell(8).setCellValue(redCross.getMoneynum());
                row.getCell(9).setCellValue(redCross.getHandin());
                row.getCell(10).setCellValue(redCross.getSelf());
                row.getCell(11).setCellValue(redCross.getName());
                row.getCell(12).setCellValue(redCross.getJob());
                row.getCell(13).setCellValue(redCross.getFundssum());
                row.getCell(14).setCellValue(redCross.getMembershipdues());
                row.getCell(15).setCellValue(redCross.getAppropriatefunds());
                row.getCell(16).setCellValue(redCross.getContributemoney());
                row.getCell(17).setCellValue(redCross.getOther());
                row.getCell(18).setCellValue(redCross.getContributesum());
                row.getCell(19).setCellValue(redCross.getGoverningbody());
                row.getCell(20).setCellValue(redCross.getSelfpreservation());
                row.getCell(21).setCellValue(redCross.getActivitycontent());
                row.getCell(22).setCellValue(redCross.getPersonsum());
                row.getCell(23).setCellValue(redCross.getCertificatenumber());
                row.getCell(24).setCellValue(redCross.getCollectionnumber());
                row.getCell(25).setCellValue(redCross.getPairingnumber());
                count++;

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

    public void expertExcel_A10_5(HttpServletResponse response, TabularFile tabularFile) {
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
            List<Volunteers> list = tableAttributeDao.getExpertExcel_A4_5();
            int rowIndex = 10;
            int count = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex+i);
                row.getCell(1).setCellValue(list.get(i).getDepartment());
                row.getCell(2).setCellValue(list.get(i).getCommunitycode());
                row.getCell(3).setCellValue(list.get(i).getCommunityname());
                row.getCell(4).setCellValue(list.get(i).getFounddateStr());
                row.getCell(5).setCellValue(list.get(i).getSum());
                row.getCell(6).setCellValue(list.get(i).getTeachingstaffnumber());
                row.getCell(7).setCellValue(list.get(i).getStudentnumber());
                row.getCell(8).setCellValue(list.get(i).getName());
                row.getCell(9).setCellValue(list.get(i).getJob());
                row.getCell(10).setCellValue(list.get(i).getActivitycontent());
                row.getCell(11).setCellValue(list.get(i).getPersonsum());
                row.getCell(12).setCellValue(list.get(i).getCertificatenumber());
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
    public void expertExcel_A7_1_1(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        List<Major> getMajorListExport = majorService.getMajorListExport(new Major());

        OutputStream os = null;
        try {
            FileInputStream in = new FileInputStream(file);
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
            int rowIndex = 10;
            int end = 2 + getMajorListExport.size();
            int count = 1;
            for (int i = 0; i < getMajorListExport.size(); i++) {
                Major major = new Major();
                major.setMajorCode(getMajorListExport.get(i).getMajorCode());
                Major major1 = majorService.getStudentNumberList(major);
                Major major2 = majorService.getSourceTypeList(major);
                Row row = sheet.getRow(rowIndex + i);
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
                if (major1 != null) {
                    row.getCell(11).setCellValue(major1.getStudentNumber());
                }
                row.getCell(12).setCellValue("");
                row.getCell(13).setCellValue("");
                row.getCell(14).setCellValue("");
                if (major2 != null) {
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

    public void expertExcel_A7_1_2(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        MajorLeader majorLeader = new MajorLeader();
        majorLeader.setPersonType("1");
        List<MajorLeader> list = majorLeaderService.getMajorLeaderList(majorLeader);

        OutputStream os = null;
        try {
            FileInputStream in = new FileInputStream(file);
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
            int rowIndex = 10;
            int end = 2 + list.size();
            int count = 1;
            for (int i = 0; i < list.size(); i++) {

                Row row = sheet.getRow(rowIndex + i);
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

    public void expertExcel_A7_1_3(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        MajorResponsible majorResponsible = new MajorResponsible();
        majorResponsible.setPersonType("2");
        List<MajorResponsible> list = majorLeaderService.getMajorResponsibleList(majorResponsible);
        OutputStream os = null;
        try {
            FileInputStream in = new FileInputStream(file);
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
            int rowIndex = 10;
            int end = 2 + list.size();
            int count = 1;
            for (int i = 0; i < list.size(); i++) {

                Row row = sheet.getRow(rowIndex + i);
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
    public void expertExcel_A7_2(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        List<Course> selectCourseList = courseService.selectCourseList(new Course());
        OutputStream os = null;
        try {
            FileInputStream in = new FileInputStream(file);
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
            int rowIndex = 10;
            int end = 2 + selectCourseList.size();
            int count = 1;
            for (int i = 0; i < selectCourseList.size(); i++) {

                Row row = sheet.getRow(rowIndex + i);
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

    public void expertExcel_A11_5(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        List<Major> getMajorListExport = majorService.getMajorListExport(new Major());

        OutputStream os = null;
        try {
            FileInputStream in = new FileInputStream(file);
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
            int rowIndex = 10;
            int end = 2 + getMajorListExport.size();
            int count = 1;
            for (int i = 0; i < getMajorListExport.size(); i++) {
                Major major = new Major();
                major.setMajorCode(getMajorListExport.get(i).getMajorCode());
                Major major2 = majorService.getSourceTypeList(major);
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(getMajorListExport.get(i).getDepartmentsIdShow());
                row.getCell(3).setCellValue(getMajorListExport.get(i).getMajorCode());
                row.getCell(4).setCellValue(getMajorListExport.get(i).getMajorName());
                row.getCell(5).setCellValue(getMajorListExport.get(i).getMajorDirectionCode());
                row.getCell(6).setCellValue(getMajorListExport.get(i).getMajorDirectionShow());
                row.getCell(7).setCellValue(getMajorListExport.get(i).getApprovalTime());
                row.getCell(8).setCellValue(getMajorListExport.get(i).getFirstRecruitTime());
                row.getCell(9).setCellValue(getMajorListExport.get(i).getMaxYearShow());
                row.getCell(10).setCellValue("");
                if (major2 != null) {
                    row.getCell(11).setCellValue(major2.getSourceNumberOne());
                    row.getCell(12).setCellValue(major2.getSourceNumberTwo());
                    row.getCell(14).setCellValue(major2.getSourceNumberThree());
                }
                row.getCell(13).setCellValue("");
                row.getCell(15).setCellValue(getMajorListExport.get(i).getFocusTypeShow());
                row.getCell(16).setCellValue(getMajorListExport.get(i).getUniqueTypeShow());
                row.getCell(17).setCellValue(getMajorListExport.get(i).getMajorNow());
                row.getCell(18).setCellValue(getMajorListExport.get(i).getMajorGlobal());
                row.getCell(19).setCellValue(getMajorListExport.get(i).getClassNum());
                row.getCell(20).setCellValue(getMajorListExport.get(i).getOrdersClassnum());
                row.getCell(21).setCellValue(getMajorListExport.get(i).getOrdersStudentnum());
                row.getCell(22).setCellValue("");
                row.getCell(23).setCellValue("");
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
        String teacherType="1";
        List<TeacherCondition> teacherConditionsList = teacherInfoDao.getTeacherTypeToExp(teacherType);
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
            for (int i = 0; i < teacherConditionsList.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(teacherConditionsList.get(i).getDepartmentId());//教师所属系部
                row.getCell(2).setCellValue(teacherConditionsList.get(i).getTeacherNum());//教工号
                row.getCell(3).setCellValue(teacherConditionsList.get(i).getTeacherName());//姓名
                row.getCell(4).setCellValue(teacherConditionsList.get(i).getTeacherSex());//性别
                row.getCell(5).setCellValue( teacherConditionsList.get(i).getBirthday());//出生日期
                row.getCell(6).setCellValue(teacherConditionsList.get(i).getNationShow());//民族
                row.getCell(7).setCellValue(teacherConditionsList.get(i).getFinalEducation());//学历
                row.getCell(8).setCellValue(teacherConditionsList.get(i).getDegee());//学位
                row.getCell(9).setCellValue(teacherConditionsList.get(i).getMajorField());//专业领域
                row.getCell(10).setCellValue(teacherConditionsList.get(i).getMajorSpecialty());//专业特长
                row.getCell(11).setCellValue(teacherConditionsList.get(i).getLicence());//高校教资发证单位
                row.getCell(12).setCellValue(teacherConditionsList.get(i).getGetTime());//高校教资获取日期
                row.getCell(13).setCellValue( teacherConditionsList.get(i).getQiyeYear());//一线工作历年!
                row.getCell(14).setCellValue(teacherConditionsList.get(i).getQiyeDate());//一线工作本学年!  天
                row.getCell(15).setCellValue(teacherConditionsList.get(i).getMajorGrade());//专业技术职务等级
                row.getCell(16).setCellValue(teacherConditionsList.get(i).getMajorName());//专业技术职务名称

                row.getCell(17).setCellValue(teacherConditionsList.get(i).getMajorDept());//专业技术职务发证单位全称
                row.getCell(18).setCellValue(teacherConditionsList.get(i).getMajorYear());//专业技术职务获取日期年月
                row.getCell(19).setCellValue(teacherConditionsList.get(i).getCareerGrade());//职业资格证书等级
                row.getCell(20).setCellValue( teacherConditionsList.get(i).getCareerName());//职业资格证书名称
                row.getCell(21).setCellValue(teacherConditionsList.get(i).getCareerDept());//职业资格证书发证单位全称
                row.getCell(22).setCellValue(teacherConditionsList.get(i).getCareerGettime());//职业资格证书获取日期年月
                row.getCell(23).setCellValue(teacherConditionsList.get(i).getSfzyTeacher());//是否专业教师
                row.getCell(24).setCellValue( teacherConditionsList.get(i).getSfggTeacher());//是否骨干教师
                row.getCell(25).setCellValue(teacherConditionsList.get(i).getSfssTeacher());//是否双师素质教师
                row.getCell(26).setCellValue(teacherConditionsList.get(i).getSfmsTeacher());//教学名师
                row.getCell(27).setCellValue(teacherConditionsList.get(i).getPoliticsMajorCode());//行政所属专业专业代码
                row.getCell(28).setCellValue( teacherConditionsList.get(i).getPoliticsMajorName());//行政所属专业专业名称



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
                row.getCell(17).setCellValue("0".equals(list.get(i).getWHETHERHOST())?"否":"是");
                row.getCell(20).setCellValue(list.get(i).getINVENTNUMBER());
                row.getCell(21).setCellValue("0".equals(list.get(i).getWHETHERHOST())?"否":"是");
                row.getCell(22).setCellValue(list.get(i).getTOPICNATURE());
                row.getCell(23).setCellValue(list.get(i).getSUBJECTCLASSIFICATION());
                row.getCell(24).setCellValue(list.get(i).getSUBJECTNAME());
                row.getCell(25).setCellValue("0".equals(list.get(i).getHORIZONTALTOPIC())?"否":"是");
                row.getCell(26).setCellValue(list.get(i).getSUBJECTGRADE());
                row.getCell(27).setCellValue(list.get(i).getPROJECTDATE());
                row.getCell(28).setCellValue(list.get(i).getSOURCEOFFUNDING());
                row.getCell(29).setCellValue(list.get(i).getMONEY());
                row.getCell(30).setCellValue(list.get(i).getCOMPLETORORDER());
                row.getCell(32).setCellValue(list.get(i).getCLASSIFICATION());
                row.getCell(35).setCellValue(list.get(i).getAUTHORORDER());
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
        String teacherType="4";
        List<TeacherCondition> teacherConditionsList = teacherInfoDao.getTeacherTypeToExp(teacherType);
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
            for (int i = 0; i < teacherConditionsList.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(teacherConditionsList.get(i).getWorkDept());//任职部门
                row.getCell(2).setCellValue(teacherConditionsList.get(i).getTeacherNum());//教工号
                row.getCell(3).setCellValue(teacherConditionsList.get(i).getTeacherName());//姓名
                row.getCell(4).setCellValue(teacherConditionsList.get(i).getTeacherSex());//性别
                row.getCell(5).setCellValue( teacherConditionsList.get(i).getBirthday());//出生日期
                row.getCell(6).setCellValue(teacherConditionsList.get(i).getNationShow());//民族
                row.getCell(7).setCellValue(teacherConditionsList.get(i).getFinalEducation());//学历
                row.getCell(8).setCellValue(teacherConditionsList.get(i).getDegee());//学位
                row.getCell(9).setCellValue(teacherConditionsList.get(i).getMajorField());//专业领域
                row.getCell(10).setCellValue(teacherConditionsList.get(i).getMajorSpecialty());//专业特长
                row.getCell(11).setCellValue( teacherConditionsList.get(i).getQiyeYear());//一线工作历年
                row.getCell(12).setCellValue(teacherConditionsList.get(i).getQiyeDate());//一线工作本学年  天
                row.getCell(13).setCellValue(teacherConditionsList.get(i).getMajorGrade());//专业技术职务等级
                row.getCell(14).setCellValue(teacherConditionsList.get(i).getMajorName());//专业技术职务名称
                row.getCell(15).setCellValue(teacherConditionsList.get(i).getMajorDept());//专业技术职务发证单位全称
                row.getCell(16).setCellValue(teacherConditionsList.get(i).getMajorYear());//专业技术职务获取日期年月
                row.getCell(17).setCellValue(teacherConditionsList.get(i).getLicence());//高校教资发证单位
                row.getCell(18).setCellValue(teacherConditionsList.get(i).getGetTime());//高校教资获取日期
                row.getCell(19).setCellValue(teacherConditionsList.get(i).getSrPosition());//所任职务
                row.getCell(20).setCellValue( teacherConditionsList.get(i).getSfggTeacher());//是否骨干教师
                row.getCell(21).setCellValue(teacherConditionsList.get(i).getSfssTeacher());//是否双师素质教师
                row.getCell(22).setCellValue(teacherConditionsList.get(i).getSfmsTeacher());//教学名师
                row.getCell(23).setCellValue(teacherConditionsList.get(i).getPoliticsMajorCode());//行政所属专业专业代码
                row.getCell(24).setCellValue( teacherConditionsList.get(i).getPoliticsMajorName());//行政所属专业专业名称
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
                row.getCell(17).setCellValue("0".equals(list.get(i).getWHETHERHOST())?"否":"是");
                row.getCell(20).setCellValue(list.get(i).getINVENTNUMBER());
                row.getCell(21).setCellValue("0".equals(list.get(i).getWHETHERHOST())?"否":"是");
                row.getCell(22).setCellValue(list.get(i).getTOPICNATURE());
                row.getCell(23).setCellValue(list.get(i).getSUBJECTCLASSIFICATION());
                row.getCell(24).setCellValue(list.get(i).getSUBJECTNAME());
                row.getCell(25).setCellValue("0".equals(list.get(i).getHORIZONTALTOPIC())?"否":"是");
                row.getCell(26).setCellValue(list.get(i).getSUBJECTGRADE());
                row.getCell(27).setCellValue(list.get(i).getPROJECTDATE());
                row.getCell(28).setCellValue(list.get(i).getSOURCEOFFUNDING());
                row.getCell(29).setCellValue(list.get(i).getMONEY());
                row.getCell(30).setCellValue(list.get(i).getCOMPLETORORDER());
                row.getCell(32).setCellValue(list.get(i).getCLASSIFICATION());
                row.getCell(35).setCellValue(list.get(i).getAUTHORORDER());
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
        String teacherType="3";
        List<TeacherCondition> teacherConditionsList = teacherInfoDao.getTeacherTypeToExp(teacherType);
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
            for (int i = 0; i < teacherConditionsList.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(teacherConditionsList.get(i).getDepartmentId());//聘职系部
                row.getCell(2).setCellValue(teacherConditionsList.get(i).getTeacherNum());//教工号
                row.getCell(3).setCellValue(teacherConditionsList.get(i).getTeacherName());//姓名
                row.getCell(4).setCellValue(teacherConditionsList.get(i).getTeacherSex());//性别
                row.getCell(5).setCellValue( teacherConditionsList.get(i).getBirthday());//出生日期
                row.getCell(6).setCellValue(teacherConditionsList.get(i).getNationShow());//民族
                row.getCell(7).setCellValue(teacherConditionsList.get(i).getWorkDate());//参加工作日期
                row.getCell(8).setCellValue(teacherConditionsList.get(i).getFinalEducation());//学历
                row.getCell(9).setCellValue(teacherConditionsList.get(i).getDegee());//学位
                row.getCell(10).setCellValue(teacherConditionsList.get(i).getSigning());//签约情况

                row.getCell(11).setCellValue(teacherConditionsList.get(i).getMajorGrade());//专业技术职务等级
                row.getCell(12).setCellValue(teacherConditionsList.get(i).getMajorName());//专业技术职务名称
                row.getCell(13).setCellValue(teacherConditionsList.get(i).getMajorDept());//专业技术职务发证单位全称
                row.getCell(14).setCellValue(teacherConditionsList.get(i).getMajorYear());//专业技术职务获取日期年月

                row.getCell(15).setCellValue(teacherConditionsList.get(i).getCareerGrade());//职业资格证书等级
                row.getCell(16).setCellValue( teacherConditionsList.get(i).getCareerName());//职业资格证书名称
                row.getCell(17).setCellValue(teacherConditionsList.get(i).getCareerDept());//职业资格证书发证单位全称
                row.getCell(18).setCellValue(teacherConditionsList.get(i).getCareerGettime());//职业资格证书获取日期年月

                row.getCell(19).setCellValue(teacherConditionsList.get(i).getExpertDept());//当前专职工作背景 单位名称
                row.getCell(20).setCellValue(teacherConditionsList.get(i).getExpertWork());//当前专职工作背景 职务
                row.getCell(21).setCellValue(teacherConditionsList.get(i).getExpertDate());//当前专职工作背景 任职日期

                row.getCell(22).setCellValue( teacherConditionsList.get(i).getTrainingName());//教学进修 项目名称
                row.getCell(23).setCellValue(teacherConditionsList.get(i).getTrainingDay());//教学进修 时间
                row.getCell(24).setCellValue(teacherConditionsList.get(i).getTrainingPlace());//教学进修 地点
                row.getCell(25).setCellValue(teacherConditionsList.get(i).getSendDept());//教学进修 派出部门

                row.getCell(26).setCellValue(teacherConditionsList.get(i).getPoliticsMajorCode());//行政所属专业专业代码
                row.getCell(27).setCellValue( teacherConditionsList.get(i).getPoliticsMajorName());//行政所属专业专业名称
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
        String teacherType="2";
        List<TeacherCondition> teacherConditionsList = teacherInfoDao.getTeacherTypeToExp(teacherType);
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
            for (int i = 0; i < teacherConditionsList.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(teacherConditionsList.get(i).getDepartmentId());//聘职系部!
                row.getCell(2).setCellValue(teacherConditionsList.get(i).getTeacherNum());//教工号
                row.getCell(3).setCellValue(teacherConditionsList.get(i).getTeacherName());//姓名
                row.getCell(4).setCellValue(teacherConditionsList.get(i).getTeacherSex());//性别
                row.getCell(5).setCellValue( teacherConditionsList.get(i).getBirthday());//出生日期
                row.getCell(6).setCellValue(teacherConditionsList.get(i).getNationShow());//民族
                row.getCell(7).setCellValue(teacherConditionsList.get(i).getWorkDate());//参加工作日期
                row.getCell(8).setCellValue(teacherConditionsList.get(i).getFinalEducation());//学历
                row.getCell(9).setCellValue(teacherConditionsList.get(i).getDegee());//学位
                row.getCell(10).setCellValue(teacherConditionsList.get(i).getSigning());//签约情况

                row.getCell(11).setCellValue(teacherConditionsList.get(i).getMajorGrade());//专业技术职务等级
                row.getCell(12).setCellValue(teacherConditionsList.get(i).getMajorName());//专业技术职务名称
                row.getCell(13).setCellValue(teacherConditionsList.get(i).getMajorDept());//专业技术职务发证单位全称
                row.getCell(14).setCellValue(teacherConditionsList.get(i).getMajorYear());//专业技术职务获取日期年月

                row.getCell(15).setCellValue(teacherConditionsList.get(i).getCareerGrade());//职业资格证书等级
                row.getCell(16).setCellValue( teacherConditionsList.get(i).getCareerName());//职业资格证书名称
                row.getCell(17).setCellValue(teacherConditionsList.get(i).getCareerDept());//职业资格证书发证单位全称
                row.getCell(18).setCellValue(teacherConditionsList.get(i).getCareerGettime());//职业资格证书获取日期年月

                row.getCell(19).setCellValue(teacherConditionsList.get(i).getExpertDept());//当前专职工作背景 单位名称
                row.getCell(20).setCellValue(teacherConditionsList.get(i).getExpertWork());//当前专职工作背景 职务
                row.getCell(21).setCellValue(teacherConditionsList.get(i).getExpertDate());//当前专职工作背景 任职日期

                row.getCell(22).setCellValue( teacherConditionsList.get(i).getTrainingName());//教学进修 项目名称
                row.getCell(23).setCellValue(teacherConditionsList.get(i).getTrainingDay());//教学进修 时间
                row.getCell(24).setCellValue(teacherConditionsList.get(i).getTrainingPlace());//教学进修 地点
                row.getCell(25).setCellValue(teacherConditionsList.get(i).getSendDept());//教学进修 派出部门

                row.getCell(26).setCellValue(teacherConditionsList.get(i).getPoliticsMajorCode());//行政所属专业专业代码
                row.getCell(27).setCellValue( teacherConditionsList.get(i).getPoliticsMajorName());//行政所属专业专业名称

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
    public void expertExcel_A9_5(HttpServletResponse response, TabularFile tabularFile) {
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
            List<Programme> list = tableAttributeDao.getExpertExcel_A9_5();
            int rowIndex = 10;
            int count = 1;
            Row row = null;
            for (int i = 0; i < list.size(); i++) {
                row = sheet.getRow(rowIndex + i);
                String ordernumber = list.get(i).getOrdernumber();
                row.getCell(1).setCellValue(ordernumber);
                row.getCell(2).setCellValue(list.get(i).getProjectname());
                row.getCell(3).setCellValue(list.get(i).getProjectprogramme());
                row.getCell(4).setCellValue(list.get(i).getGrade());
                row.getCell(5).setCellValue(list.get(i).getRatifydateStr());
                row.getCell(6).setCellValue(list.get(i).getStaff());
                row.getCell(7).setCellValue(list.get(i).getRemarks());
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
    public List<Programme> getExpertExcel_A9_5() {
        return tableAttributeDao.getExpertExcel_A9_5();
    }

    @Override
    public void expertExcel_A9_6_1(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;
        List<BaseBean> list = stuAwardInfoDao.getStuAwardInfoList(null);
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
                StuAwardInfo sai = (StuAwardInfo) list.get(i);
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(sai.getSaiProName());
                row.getCell(3).setCellValue(sai.getSaiProTypeShow());
                row.getCell(4).setCellValue(sai.getSaiLevelShow());
                row.getCell(5).setCellValue(toDateString(sai.getAwardTime()));
                row.getCell(6).setCellValue(sai.getStudentList());
                row.getCell(7).setCellValue(sai.getCoach());
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
            List<BaseBean> list = schAwardDao.getSchAwardList(null);

            for (int i = 0; i < list.size(); i++) {
                SchAward schAward = (SchAward) list.get(i);
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(schAward.getSaProName());
                row.getCell(3).setCellValue(schAward.getSaProLev());
                row.getCell(4).setCellValue(toDateString(schAward.getSaTime()));
                row.getCell(5).setCellValue(schAward.getRemark());
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

                row.getCell(9).setCellValue(list.get(i).getDEVELOPMENTCOURSENUM());
                row.getCell(10).setCellValue(list.get(i).getDEVELOPMENTTEACHINGNUM());
                row.getCell(11).setCellValue(list.get(i).getPARTTIMETEACHERNUM());
                row.getCell(12).setCellValue(list.get(i).getTRAINEENUM());
                row.getCell(13).setCellValue(list.get(i).getEQUIPMENTMONEY());
                row.getCell(14).setCellValue(list.get(i).getQUASIDONATIONMONEY());
                row.getCell(15).setCellValue(list.get(i).getEMPLOYMENTNUMBER());
                row.getCell(16).setCellValue(list.get(i).getANNUALINCOME());
                row.getCell(17).setCellValue(list.get(i).getEMPLOYEESNUM());
                row.getCell(19).setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(list.get(i).getBUSINESS1STARTTIME()));
                row.getCell(21).setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(list.get(i).getBUSINESS2STARTTIME()));
                row.getCell(23).setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(list.get(i).getBUSINESS3STARTTIME()));
                row.getCell(25).setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(list.get(i).getBUSINESS4STARTTIME()));
                row.getCell(27).setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(list.get(i).getBUSINESS5STARTTIME()));

                row.getCell(28).setCellValue(list.get(i).getAPPRENTICESHIP());
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
        List<Map> list = tableAttributeDao.expertExcel_A7_3_1();

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
            int end = 2 + list.size();
            int count = 1;
            Map map;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                map = list.get(i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(map.get("DEPARTMENTSIDSHOW").toString());
                row.getCell(3).setCellValue(map.get("MAJOR_CODE").toString());
                row.getCell(4).setCellValue(map.get("MAJOR_NAME").toString());
                row.getCell(5).setCellValue(map.get("MAJOR_DIRECTION_CODE").toString());
                row.getCell(6).setCellValue(map.get("MAJOR_DIRECTION").toString());
                row.getCell(7).setCellValue(map.get("QUALIFICATION_NAME").toString());
                row.getCell(8).setCellValue(map.get("DIC_NAME").toString());
                row.getCell(9).setCellValue(map.get("STUDENTNUM").toString());
                row.getCell(10).setCellValue(map.get("QUALIFICATION_AUTHORITY").toString());
                row.getCell(11).setCellValue(map.get("IDENTIFICATION_SITE").toString());
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
        List<Map> list = tableAttributeDao.expertExcel_A7_3_2();

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
            int end = 2 + list.size();
            int count = 1;
            Map map;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.getRow(rowIndex + i);
                map = list.get(i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(map.get("DEPARTMENTSIDSHOW").toString());
                row.getCell(3).setCellValue(map.get("MAJOR_CODE").toString());
                row.getCell(4).setCellValue(map.get("MAJOR_NAME").toString());
                row.getCell(5).setCellValue(map.get("MAJOR_DIRECTION_CODE").toString());
                row.getCell(6).setCellValue(map.get("MAJOR_DIRECTION").toString());
                row.getCell(7).setCellValue(map.get("STUDENTNUM").toString());
                row.getCell(8).setCellValue(map.get("P3").toString());
                row.getCell(10).setCellValue(map.get("P2").toString());
                row.getCell(12).setCellValue(map.get("P1").toString());
                row.getCell(14).setCellValue(map.get("P4").toString());
                row.getCell(16).setCellValue(map.get("TDAY").toString());
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


    @Override
    public void expertExcel_A9_6_3(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;
        List<BaseBean> list = clubRewardDao.getClubRewardList(new ClubReward());
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
            ClubReward clubReward;
            for (int i = 0; i < list.size(); i++) {
                clubReward = (ClubReward)list.get(i);
                Row row = sheet.getRow(rowIndex + i);
                row.getCell(1).setCellValue(count);
                row.getCell(2).setCellValue(clubReward.getName());
                row.getCell(3).setCellValue(clubReward.getProjectName());
                row.getCell(4).setCellValue(clubReward.getRewardLevelShow());
                row.getCell(5).setCellValue(clubReward.getRewardDate().replace("-", ""));
                row.getCell(6).setCellValue(clubReward.getAwardUnit());
                row.getCell(7).setCellValue(clubReward.getGuidanceTeacher());
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


    public String toDateString(String date){
           return !StringUtils.isEmpty(date)?date.replace("-",""):null;
    }

    /**
     * 高级表
     */

    @Override
    public void expertExcel_GJ(HttpServletResponse response, TabularFile tabularFile) {
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        Workbook wb = null;

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

            this.expertExcel_GJ_311(sheet);

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

    private void expertExcel_GJ_311(Sheet sheet) {
//        List<BaseBean> list = clubRewardDao.getClubRewardList(new ClubReward());
//        int rowIndex = 10;
//        int end = 2 + majorList.size();
//
//        int count = 1;
//        for (int i = 0; i < majorList.size(); i++) {
//            Row row = sheet.getRow(rowIndex + i);
//            row.getCell(1).setCellValue(count);
//            row.getCell(2).setCellValue(majorList.get(i).getDepartmentsId());
//            row.getCell(3).setCellValue(majorList.get(i).getMajorCode());
//            row.getCell(4).setCellValue(majorList.get(i).getMajorName());
//            row.getCell(5).setCellValue(majorList.get(i).getMajorDirectionCode());
//            row.getCell(6).setCellValue(majorList.get(i).getMajorDirection());
//            row.getCell(17).setCellValue(majorList.get(i).getInternshipPositions());
//            row.getCell(18).setCellValue(majorList.get(i).getInternshipUnitIdShow());
//            row.getCell(20).setCellValue(majorList.get(i).getPostsTime());
//            count++;
//        }

    }

    private void expertExcel_GJ_313(Sheet sheet) {

    }

    private void expertExcel_GJ_321(Sheet sheet) {

    }

    private void expertExcel_GJ_322(Sheet sheet) {

    }

    private void expertExcel_GJ_331(Sheet sheet) {

    }

    private void expertExcel_GJ_332(Sheet sheet) {

    }

    private void expertExcel_GJ_341(Sheet sheet) {

    }

    private void expertExcel_GJ_411(Sheet sheet) {

    }

    private void expertExcel_GJ_421(Sheet sheet) {

    }

    private void expertExcel_GJ_422(Sheet sheet) {

    }

    private void expertExcel_GJ_423(Sheet sheet) {

    }

    private void expertExcel_GJ_424(Sheet sheet) {

    }

    private void expertExcel_GJ_461(Sheet sheet) {

    }

    private void expertExcel_GJ_811(Sheet sheet) {

    }

    private void expertExcel_GJ_812(Sheet sheet) {

    }
}
