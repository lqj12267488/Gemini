package com.goisan.personnel.salary.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.personnel.salary.bean.Salary;
import com.goisan.personnel.salary.service.SalaryService;
import com.goisan.system.bean.Emp;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.google.inject.matcher.Matcher;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.activation.MimetypesFileTypeMap;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * Created by admin on 2017/6/30.
 */
@Controller
public class SalaryController {
    @Resource
    private SalaryService salaryService;

    @Resource
    private EmpService empService;

    @RequestMapping("/salary/getList")
    public ModelAndView getList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/salary/salaryGrid");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/salary/getSalaryList")
    public Map<String, Object> getGroupList(Salary salary,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        LoginUser login = CommonUtil.getLoginUser();
        salary.setStaffId(login.getPersonId());
        Map<String, Object> salaryList = new HashMap();
        List<Salary> salaryList1 = salaryService.getSalaryList(salary);
        PageInfo<List<Salary>> info = new PageInfo(salaryList1);
        salaryList.put("draw", draw);
        salaryList.put("recordsTotal", info.getTotal());
        salaryList.put("recordsFiltered", info.getTotal());
        salaryList.put("data", salaryList1);
        return salaryList;
    }

    @RequestMapping("/salary/getAddSalary")
    public ModelAndView getAddSalary() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/salary/editSalary");
        mv.addObject("head","新增工资单");
        return mv;
    }

    @RequestMapping("/salary/getUpdateSalary")
    public ModelAndView updateList(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/salary/editSalary");
        mv.addObject("head","修改工资单");
        Salary salary = salaryService.getSalaryById(id);
        mv.addObject("salary",salary);
        return mv;
    }

    @RequestMapping("/salary/viewList")
    public ModelAndView viewList(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/salary/viewSalary");
        mv.addObject("head","工资单详细");
        Salary salary = salaryService.getSalaryById(id);
        mv.addObject("salary",salary);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/salary/saveSalary")
    public Message saveSalary(Salary salary){
        LoginUser login = CommonUtil.getLoginUser();
        if(null ==salary.getId() || salary.getId().equals("")){
            salary.setCreator(login.getPersonId());
            salary.setCreateDept(login.getDefaultDeptId());
            salary.setStaffId(login.getPersonId());
            salaryService.insertSalary(salary);
            return new Message(1, "新增成功！", null);
        }else{
            salary.setChanger(login.getPersonId());
            salary.setChangeDept(login.getDefaultDeptId());
            salaryService.updateSalary(salary);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/salary/deleteSalary")
    public Message deleteSalary(String id){
        LoginUser login = CommonUtil.getLoginUser();
        Salary salary = new Salary();
        salary.setId(id);
        salary.setChanger(login.getPersonId());
        salary.setChangeDept(login.getDefaultDeptId());
        salaryService.delectSalaryById(salary);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/salary/checkSalary")
    public Message checkSalary(Salary salary) {
        List<Salary> list = salaryService.checkSalary(salary);
        if(list.size()>0){
            return new Message(1, "", null);
        }else{
            return new Message(0, "", null);
        }
    }



    @RequestMapping("/salary/toImportSalary")
    public ModelAndView toImportStudent(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/salary/import");
        return mv;
    }

    /**
     * 导出模板
     * @param response
     */
    @ResponseBody
    @RequestMapping("/salary/getSalaryExcelTemplate")
    public void getSalaryExcelTemplate(HttpServletResponse response) {
        String rootPath = new File(getClass().getResource("/").getPath()).getParentFile().getParent().toString();
        rootPath = rootPath.replaceAll("%20"," ");
        String fileName = rootPath + "/template/salaryTemplate.xls";
        File file = FileUtils.getFile(fileName);
        OutputStream os = null;

        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("工资基本信息表模板.xls", "utf-8"));
            os = response.getOutputStream();
            os.write(FileUtils.readFileToByteArray(file));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static int getStringLength(String str,String encoding) throws UnsupportedEncodingException{
        if(isNullOrEmpty(str))
            return 0;
        else
            return str.getBytes(encoding).length;
    }
    /**
     * 判断字段是否为空
     * @return true 为空， false 不为空
     */
    public static boolean isNullOrEmpty(String str){
        return null == str || "".equals(str);
    }
    /**
     * 导入数据
     * @param file
     * @return
     */
    @ResponseBody
    @RequestMapping("/salary/importSalary")
    public Message importStudent(@RequestParam(value = "file", required = false) CommonsMultipartFile file) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        LoginUser login = CommonUtil.getLoginUser();
        int count =0;
        HSSFWorkbook workbook = null;
        try {
            workbook = new HSSFWorkbook(file.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        Salary salary = new Salary();
        HSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            for (int i = 2; i <= end; i++) {
                try {
                    HSSFRow row = sheet.getRow(i);
                    if(null == row && count == 0){
                        return new Message(0, "无数据，导入失败！", "error");
                    }else if(null == row || row.getLastCellNum() == 1){
                        return new Message(1, "共计"+count+"条，导入成功！", "success");
                    }
                    salary.setIdcard(CommonUtil.toIdcardCheck(row.getCell(0).toString()));
                    salary.setName(row.getCell(1).toString());
                    HSSFCell hssef1 = row.getCell(2);
                    hssef1.setCellType(hssef1.CELL_TYPE_STRING);
                    salary.setYear(CommonUtil.changeToInteger(hssef1) + "");
                    HSSFCell hssef2 = row.getCell(3);
                    hssef2.setCellType(hssef2.CELL_TYPE_STRING);
                    salary.setMonth(CommonUtil.changeToInteger(hssef2) + "");
                    if(CommonUtil.changeToInteger(hssef2)>12 || CommonUtil.changeToInteger(hssef2)<0){
                        return new Message(0, "请输入有效的月数！", "error");
                    }
                    salary.setPostSalary(CommonUtil.toStringHSSFRowObj(row.getCell(4)));
                    salary.setWagePay(CommonUtil.toStringHSSFRowObj(row.getCell(5)));
                    salary.setBfzs(CommonUtil.toStringHSSFRowObj(row.getCell(6)));
                    salary.setBasicPerformance(CommonUtil.toStringHSSFRowObj(row.getCell(7)));
                    salary.setRewardPerformance(CommonUtil.toStringHSSFRowObj(row.getCell(8)));
                    salary.setChildAllowance(CommonUtil.toStringHSSFRowObj(row.getCell(9)));
                    salary.setSeniorityAllowance(CommonUtil.toStringHSSFRowObj(row.getCell(10)));
                    salary.setRentSubsidies(CommonUtil.toStringHSSFRowObj(row.getCell(11)));
                    salary.setPostAllowance(CommonUtil.toStringHSSFRowObj(row.getCell(12)));
                    salary.setReissueAllowance(CommonUtil.toStringHSSFRowObj(row.getCell(13)));
                    salary.setLcPv(CommonUtil.toStringHSSFRowObj(row.getCell(14)));
                    salary.setLcAcademicSalary(CommonUtil.toStringHSSFRowObj(row.getCell(15)));
                    salary.setLcTitleAllowance(CommonUtil.toStringHSSFRowObj(row.getCell(16)));
                    salary.setLcAgeSalary(CommonUtil.toStringHSSFRowObj(row.getCell(17)));
                    salary.setLcAdjustmentAllowance(CommonUtil.toStringHSSFRowObj(row.getCell(18)));
                    salary.setLcMeritPay(CommonUtil.toStringHSSFRowObj(row.getCell(19)));
                    salary.setLcChildAllowance(CommonUtil.toStringHSSFRowObj(row.getCell(20)));
                    salary.setHeatingFee(CommonUtil.toStringHSSFRowObj(row.getCell(21)));
                    salary.setLectureFee(CommonUtil.toStringHSSFRowObj(row.getCell(22)));
                    salary.setLectureFeeSecond(CommonUtil.toStringHSSFRowObj(row.getCell(23)));
                    salary.setPolytechnicHeadmasterFee(CommonUtil.toStringHSSFRowObj(row.getCell(24)));
                    salary.setJuniorHeadmasterFee(CommonUtil.toStringHSSFRowObj(row.getCell(25)));
                    salary.setPerformanceAppraisalReturn(CommonUtil.toStringHSSFRowObj(row.getCell(26)));
                    salary.setAccountabilityPerformance(CommonUtil.toStringHSSFRowObj(row.getCell(27)));
                    salary.setManagementPerformance(CommonUtil.toStringHSSFRowObj(row.getCell(28)));
                    salary.setInternalAllowance(CommonUtil.toStringHSSFRowObj(row.getCell(29)));
                    salary.setZdbfzs(CommonUtil.toStringHSSFRowObj(row.getCell(30)));
                    salary.setTitleDifference(CommonUtil.toStringHSSFRowObj(row.getCell(31)));
                    salary.setReplacementWage(CommonUtil.toStringHSSFRowObj(row.getCell(32)));
                    salary.setReplacementWageSecond(CommonUtil.toStringHSSFRowObj(row.getCell(33)));
                    salary.setRecruitStudentsAchievements(CommonUtil.toStringHSSFRowObj(row.getCell(34)));
                    salary.setContestAchievements(CommonUtil.toStringHSSFRowObj(row.getCell(35)));
                    salary.setScientificAchievements(CommonUtil.toStringHSSFRowObj(row.getCell(36)));
                    salary.setOthers(CommonUtil.toStringHSSFRowObj(row.getCell(37)));
                    salary.setPerformanceAppraisalAward(CommonUtil.toStringHSSFRowObj(row.getCell(38)));
                    salary.setTotalPayable(CommonUtil.toStringHSSFRowObj(row.getCell(39)));
                    salary.setIndividualIncomeTax(CommonUtil.toStringHSSFRowObj(row.getCell(40)));
                    salary.setEndowmentInsurance(CommonUtil.toStringHSSFRowObj(row.getCell(41)));
                    salary.setMedicalInsurance(CommonUtil.toStringHSSFRowObj(row.getCell(42)));
                    salary.setHousingFund(CommonUtil.toStringHSSFRowObj(row.getCell(43)));
                    salary.setOccupationalPension(CommonUtil.toStringHSSFRowObj(row.getCell(44)));
                    salary.setSupplementaryEi(CommonUtil.toStringHSSFRowObj(row.getCell(45)));
                    salary.setSupplementaryMi(CommonUtil.toStringHSSFRowObj(row.getCell(46)));
                    salary.setSupplementaryHf(CommonUtil.toStringHSSFRowObj(row.getCell(47)));
                    salary.setSupplementaryOp(CommonUtil.toStringHSSFRowObj(row.getCell(48)));
                    salary.setSupplementaryTax(CommonUtil.toStringHSSFRowObj(row.getCell(49)));
                    salary.setDebit(CommonUtil.toStringHSSFRowObj(row.getCell(50)));
                    salary.setMembershipDues(CommonUtil.toStringHSSFRowObj(row.getCell(51)));
                    salary.setRealSalary(CommonUtil.toStringHSSFRowObj(row.getCell(52)));
                    salary.setCreator(login.getPersonId());
                    salary.setCreateDept(login.getDefaultDeptId());
                }

                catch (Exception e) {
                    e.printStackTrace();
                    String s=getTrace(e);
                    String[] ss = s.split("SalaryController.java:");
                    s=ss[1].substring(0,3);
                    String salaryAllName=salaryService.getNameBySalaryAll(s);
                    String msg = "导入"+count+"条成功，第"+(count+1)+"条数据异常。导入失败！第"+(count+3)+"行"+salaryAllName;
                    return new Message(0, msg, null);

                }
                salaryService.insertSalary(salary);
                count ++;

        }
        return new Message(1, "共计"+count+"条，导入成功！", null);
    }
    public String getTrace(Throwable throwable) {
        StringWriter stringWriter = new StringWriter();
        PrintWriter writer = new PrintWriter(stringWriter);
        throwable.printStackTrace(writer);
        StringBuffer buffer = stringWriter.getBuffer();
        return buffer.toString();
    }
    /**
     * 导出数据
     * @param response
     */
    @ResponseBody
    @RequestMapping("/salary/exportSalary")
    public void exportStudent(String idcard,String year,String month,String staffId, HttpServletResponse response) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//        String year = request.getParameter("year");
//        String month = request.getParameter("month");
//        String idcard = request.getParameter("idcard");
//        String staffId = request.getParameter("staffId");
        Salary salary = new Salary();
        salary.setYear(year);
        salary.setMonth(month);
        if (!"".equals(idcard)){
            idcard = "%"+ idcard +"%";
        }
        salary.setIdcard(idcard);
        salary.setStaffId(staffId);
        List<Salary> salaryList =  salaryService.getSalaryList(salary);

        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("工资基本信息表");

        //创建HSSFRow对象
        int tmp = 0;
     /*   HSSFRow row2 = sheet.createRow(tmp);
        row2.createCell(0).setCellValue("说明：此项为必填项");
        row2.createCell(2).setCellValue("");
        row2.createCell(3).setCellValue("说明：此项为必填项,请输入数字,请输入4位年份数字");
        row2.createCell(4).setCellValue("说明：此项为必填项,请输入数字,请输入1-2位月份数字");
        row2.createCell(5).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(6).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(7).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(8).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(9).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(10).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(11).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(12).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(13).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(14).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(15).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(16).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(17).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(18).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(19).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(20).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(21).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(22).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(23).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(24).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(25).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(26).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(27).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(28).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(29).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(30).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(31).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(32).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(33).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(34).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(35).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(36).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(37).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(38).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(39).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(40).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(41).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(42).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(43).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(44).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(45).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(46).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(47).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(48).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(49).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(50).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(51).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(52).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        row2.createCell(53).setCellValue("说明：请输入数字,请输入1-12位长度字符");
        tmp++;*/

        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象   身份证号	姓名	年份	月份	岗位工资	薪级工资	五险一金	百分之十	基本工资	基础性绩效	国家奖励性绩效	独子补贴	教护龄	房租补贴	特殊岗位津贴	补发津贴	劳动合同岗位工资	劳动合同学历工资	劳动合同职称津贴	劳动合同校龄工资	劳动合同调整津贴	劳动合同绩效工资	劳动合同独子补贴	采暖费	讲课费1	讲课费2	中专班主任费	大专班主任费	绩效考核返还	责任绩效	管理、教辅效益绩效	内聘津贴	职大百分之十	职大商校职称差额	补发工资1	补发工资2	招生项目绩效	大赛项目绩效	科研项目绩效	其他	应发合计	个人所得税	养老保险	医疗保险	住房基金	职业年金	补扣养老保险	补扣医疗保险	补扣房基金	补扣职业年金	补扣税	扣款	会费	实发合计
        row1.createCell(0).setCellValue("序号");
        row1.createCell(1).setCellValue("身份证号");
        row1.createCell(2).setCellValue("姓名");
        row1.createCell(3).setCellValue("年份");
        row1.createCell(4).setCellValue("月份");
        row1.createCell(5).setCellValue("岗位工资");
        row1.createCell(6).setCellValue("薪级工资");
        row1.createCell(7).setCellValue("百分之十");
        row1.createCell(8).setCellValue("绩效考核奖");
        row1.createCell(9).setCellValue("基础性绩效");
        row1.createCell(10).setCellValue("国家奖励性绩效");
        row1.createCell(11).setCellValue("独子补贴");
        row1.createCell(12).setCellValue("教护龄");
        row1.createCell(13).setCellValue("房租补贴");
        row1.createCell(14).setCellValue("特殊岗位津贴");
        row1.createCell(15).setCellValue("补发津贴");
        row1.createCell(16).setCellValue("劳动合同岗位工资");
        row1.createCell(17).setCellValue("劳动合同学历工资");
        row1.createCell(18).setCellValue("劳动合同职称津贴");
        row1.createCell(19).setCellValue("劳动合同校龄工资");
        row1.createCell(20).setCellValue("劳动合同调整津贴");
        row1.createCell(21).setCellValue("劳动合同绩效工资");
        row1.createCell(22).setCellValue("劳动合同独子补贴");
        row1.createCell(23).setCellValue("采暖费");
        row1.createCell(24).setCellValue("讲课费1");
        row1.createCell(25).setCellValue("讲课费2");
        row1.createCell(26).setCellValue("中专班主任费");
        row1.createCell(27).setCellValue("大专班主任费");
        row1.createCell(28).setCellValue("绩效考核返还");
        row1.createCell(29).setCellValue("责任绩效");
        row1.createCell(30).setCellValue("管理、教辅效益绩效");
        row1.createCell(31).setCellValue("内聘津贴");
        row1.createCell(32).setCellValue("职大百分之十");
        row1.createCell(33).setCellValue("职大商校职称差额");
        row1.createCell(34).setCellValue("补发工资1");
        row1.createCell(35).setCellValue("补发工资2");
        row1.createCell(36).setCellValue("招生项目绩效");
        row1.createCell(37).setCellValue("大赛项目绩效");
        row1.createCell(38).setCellValue("科研项目绩效");
        row1.createCell(39).setCellValue("其他");
        row1.createCell(40).setCellValue("应发合计");
        row1.createCell(41).setCellValue("个人所得税");
        row1.createCell(42).setCellValue("养老保险");
        row1.createCell(43).setCellValue("医疗保险");
        row1.createCell(44).setCellValue("住房基金");
        row1.createCell(45).setCellValue("职业年金");
        row1.createCell(46).setCellValue("补扣养老保险");
        row1.createCell(47).setCellValue("补扣医疗保险");
        row1.createCell(48).setCellValue("补扣房基金");
        row1.createCell(49).setCellValue("补扣职业年金");
        row1.createCell(50).setCellValue("补扣税");
        row1.createCell(51).setCellValue("扣款");
        row1.createCell(52).setCellValue("会费");
        row1.createCell(53).setCellValue("实发合计");
        tmp++;
        int i=1;
        for (Salary salaryObj :salaryList ) {
            HSSFRow row = sheet.createRow(tmp);
            //创建HSSFCell对象
            row.createCell(0).setCellValue(i);
            row.createCell(1).setCellValue(salaryObj.getIdcard());
            row.createCell(2).setCellValue(salaryObj.getName());
            row.createCell(3).setCellValue(salaryObj.getYear());
            row.createCell(4).setCellValue(salaryObj.getMonth());
            row.createCell(5).setCellValue(salaryObj.getPostSalary());
            row.createCell(6).setCellValue(salaryObj.getWagePay());
            row.createCell(7).setCellValue(salaryObj.getBfzs());


            row.createCell(8).setCellValue(salaryObj.getBasicPerformance());
            row.createCell(9).setCellValue(salaryObj.getRewardPerformance());
            row.createCell(10).setCellValue(salaryObj.getChildAllowance());
            row.createCell(11).setCellValue(salaryObj.getSeniorityAllowance());
            row.createCell(12).setCellValue(salaryObj.getRentSubsidies());
            row.createCell(13).setCellValue(salaryObj.getPostAllowance());
            row.createCell(14).setCellValue(salaryObj.getReissueAllowance());
            row.createCell(15).setCellValue(salaryObj.getLcPv());
            row.createCell(16).setCellValue(salaryObj.getLcAcademicSalary());
            row.createCell(17).setCellValue(salaryObj.getLcTitleAllowance());
            row.createCell(18).setCellValue(salaryObj.getLcAgeSalary());
            row.createCell(19).setCellValue(salaryObj.getLcAdjustmentAllowance());
            row.createCell(20).setCellValue(salaryObj.getLcMeritPay());
            row.createCell(21).setCellValue(salaryObj.getLcChildAllowance());
            row.createCell(22).setCellValue(salaryObj.getHeatingFee());
            row.createCell(23).setCellValue(salaryObj.getLectureFee());
            row.createCell(24).setCellValue(salaryObj.getLectureFeeSecond());
            row.createCell(25).setCellValue(salaryObj.getPolytechnicHeadmasterFee());
            row.createCell(26).setCellValue(salaryObj.getJuniorHeadmasterFee());
            row.createCell(27).setCellValue(salaryObj.getPerformanceAppraisalReturn());
            row.createCell(28).setCellValue(salaryObj.getAccountabilityPerformance());
            row.createCell(29).setCellValue(salaryObj.getManagementPerformance());
            row.createCell(30).setCellValue(salaryObj.getInternalAllowance());
            row.createCell(31).setCellValue(salaryObj.getZdbfzs());
            row.createCell(32).setCellValue(salaryObj.getTitleDifference());
            row.createCell(33).setCellValue(salaryObj.getReplacementWage());
            row.createCell(34).setCellValue(salaryObj.getReplacementWageSecond());
            row.createCell(35).setCellValue(salaryObj.getRecruitStudentsAchievements());
            row.createCell(36).setCellValue(salaryObj.getContestAchievements());
            row.createCell(37).setCellValue(salaryObj.getScientificAchievements());
            row.createCell(38).setCellValue(salaryObj.getOthers());

            row.createCell(39).setCellValue(salaryObj.getPerformanceAppraisalAward());
            row.createCell(40).setCellValue(salaryObj.getTotalPayable());
            row.createCell(41).setCellValue(salaryObj.getIndividualIncomeTax());
            row.createCell(42).setCellValue(salaryObj.getEndowmentInsurance());
            row.createCell(43).setCellValue(salaryObj.getMedicalInsurance());
            row.createCell(44).setCellValue(salaryObj.getHousingFund());
            row.createCell(45).setCellValue(salaryObj.getOccupationalPension());
            row.createCell(46).setCellValue(salaryObj.getSupplementaryEi());
            row.createCell(47).setCellValue(salaryObj.getSupplementaryMi());
            row.createCell(48).setCellValue(salaryObj.getSupplementaryHf());
            row.createCell(49).setCellValue(salaryObj.getSupplementaryOp());
            row.createCell(50).setCellValue(salaryObj.getSupplementaryTax());
            row.createCell(51).setCellValue(salaryObj.getDebit());
            row.createCell(52).setCellValue(salaryObj.getMembershipDues());
            row.createCell(53).setCellValue(salaryObj.getRealSalary());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("工资基本信息表.xls", "utf-8"));
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

    @RequestMapping("/salary/salaryListByPerson")
    public ModelAndView salaryListByPerson() {
        LoginUser login = CommonUtil.getLoginUser();
        ModelAndView mv = new ModelAndView();
        if( null != login.getUserType() && login.getUserType().equals("0")){
            String personid = login.getPersonId();
            Emp emp =  empService.getEmpByEmpId("",personid);
            mv.addObject("idCard",emp.getIdCard());
        }
        mv.setViewName("/core/salary/salaryListByPerson");
        mv.addObject("head","个人工资单");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/salary/getNameByIdCard")
    public String getNameByIdCard(String idCard) {
        String name=salaryService.getNameByIdCard(idCard);
        return name;
    }
    @ResponseBody
    @RequestMapping("/salary/getIdCardByName")
    public String getIdCardByName(String name){
        String idCard=salaryService.getIdCardByName(name);
        return idCard;
    }

}
