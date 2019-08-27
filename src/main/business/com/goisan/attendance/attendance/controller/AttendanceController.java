package com.goisan.attendance.attendance.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.attendance.attendance.bean.AttendanceImplog;
import com.goisan.attendance.attendance.bean.AttendanceInfo;
import com.goisan.system.bean.Emp;
import com.goisan.system.bean.LoginUser;
import com.goisan.attendance.attendance.service.AttendanceService;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/7/7.
 */
@Controller
public class AttendanceController {
    @Resource
    private AttendanceService attendanceService;

    @Resource
    private EmpService empService;

    @RequestMapping("/attendance/infoList")
    public ModelAndView infoList() {
        ModelAndView mv = new ModelAndView("/business/attendance/attendance/infoList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/attendance/getInfoList")
    public Map<String, Object> getInfoList(String nameSel, String yearSel, String monthSel, String idCard, int draw, int start, int length) {
        AttendanceInfo attendanceInfo = new AttendanceInfo();
        if (null != nameSel && !nameSel.equals("") && !nameSel.equals("undefined"))
            attendanceInfo.setName("%" + nameSel + "%");
        if (null != yearSel && !yearSel.equals("") && !yearSel.equals("undefined"))
            attendanceInfo.setYear(Integer.parseInt(yearSel));
        if (null != monthSel && !monthSel.equals("") && !monthSel.equals("undefined"))
            attendanceInfo.setMonth(Integer.parseInt(monthSel));
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> attendance = new HashMap();
        attendanceInfo.setCreateDept(CommonUtil.getDefaultDept());
        attendanceInfo.setLevel(CommonUtil.getLoginUser().getLevel());
        List<AttendanceInfo> attendanceList = attendanceService.getInfoList(attendanceInfo);
        PageInfo<List<AttendanceInfo>> info = new PageInfo(attendanceList);
        attendance.put("draw", draw);
        attendance.put("recordsTotal", info.getTotal());
        attendance.put("recordsFiltered", info.getTotal());
        attendance.put("data", attendanceList);
        return attendance;
    }

    @RequestMapping("/attendance/editInfo")
    public ModelAndView editInfo(String id) {
        ModelAndView mv = new ModelAndView("/business/attendance/attendance/editInfo");
        AttendanceInfo attendanceInfo = attendanceService.getInfoById(id);
        mv.addObject("info", attendanceInfo);
        return mv;
    }

    @RequestMapping("/attendance/toImportInfo")
    public ModelAndView toImportInfo(String id) {
        ModelAndView mv = new ModelAndView("/business/attendance/attendance/importInfo");
        return mv;
    }


    /**
     * 导出表数据
     *
     * @param request
     * @param response
     */
    @RequestMapping("/attendance/exportInfo")
    public void exportStudent(HttpServletRequest request, HttpServletResponse response) {
        String idCard = request.getParameter("idCard");
        String yearSel = request.getParameter("yearSel");
        String monthSel = request.getParameter("monthSel");
        AttendanceInfo attendanceInfo = new AttendanceInfo();
        if (null != idCard && !idCard.equals("") && !idCard.equals("undefined"))
            attendanceInfo.setIdcard(idCard);
        if (null != yearSel && !yearSel.equals("") && !yearSel.equals("undefined"))
            attendanceInfo.setYear(Integer.parseInt(yearSel));
        if (null != monthSel && !monthSel.equals("") && !monthSel.equals("undefined"))
            attendanceInfo.setMonth(Integer.parseInt(monthSel));
        attendanceInfo.setCreateDept(CommonUtil.getDefaultDept());
        attendanceInfo.setLevel(CommonUtil.getLoginUser().getLevel());
        List<AttendanceInfo> infoList = attendanceService.getInfoList(attendanceInfo);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("考勤基本信息");

        //创建HSSFRow对象
        int tmp = 0;
        HSSFRow row0 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row0.createCell(0).setCellValue("说明：此项为必填项,请输入数字,请输入4位年份数字");
        row0.createCell(1).setCellValue("说明：此项为必填项,请输入数字,请输入1-2位月份数字");
        row0.createCell(2).setCellValue("说明：此项为必填项");
        row0.createCell(3).setCellValue("说明：请输入身份证号");
        row0.createCell(4).setCellValue("说明：请输入数字,字段长度为0-3位");
        row0.createCell(5).setCellValue("说明：请输入数字");
        row0.createCell(6).setCellValue("说明：请输入数字");
        row0.createCell(7).setCellValue("说明：请输入数字");
        row0.createCell(8).setCellValue("说明：请输入数字");
        row0.createCell(9).setCellValue("说明：请输入数字");
        row0.createCell(10).setCellValue("说明：请输入数字");
        row0.createCell(11).setCellValue("说明：请输入数字");
        tmp++;

        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row1.createCell(0).setCellValue("年");
        row1.createCell(1).setCellValue("月");
        row1.createCell(2).setCellValue("人员姓名");
        row1.createCell(3).setCellValue("证件号码");
        row1.createCell(4).setCellValue("应签到次数（次）");
        row1.createCell(5).setCellValue("未签到次数（次）");
        row1.createCell(6).setCellValue("最新未签到（次）");
        row1.createCell(7).setCellValue("调休未签到（次）");
        row1.createCell(8).setCellValue("公假（天）");
        row1.createCell(9).setCellValue("事假（次）");
        row1.createCell(10).setCellValue("病假（次）");
        row1.createCell(11).setCellValue("因公（因故）误签（次）");
        tmp++;

        for (AttendanceInfo info : infoList) {
            HSSFRow row = sheet.createRow(tmp);
            //创建HSSFCell对象
            row.createCell(0).setCellValue(info.getYear());
            row.createCell(1).setCellValue(info.getMonth());
            row.createCell(2).setCellValue(info.getName());
            row.createCell(3).setCellValue(info.getIdcard());
            row.createCell(4).setCellValue(info.getBasicFrequency());
            row.createCell(5).setCellValue(info.getNoSignInFrequency());
            row.createCell(6).setCellValue(info.getLatestOutOfSignIn());
            row.createCell(7).setCellValue(info.getLeaveNoSign());
            row.createCell(8).setCellValue(info.getPublicHolidays());
            row.createCell(9).setCellValue(info.getCompassionateLeave());
            row.createCell(10).setCellValue(info.getSickLeave());
            row.createCell(11).setCellValue(info.getWrongSignOnBusiness());
            tmp++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("考勤基本信息.xls", "utf-8"));
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
     * 导出模板
     *
     * @param response
     */
    @RequestMapping("/attendance/getInfoExcelTemplate")
    public void getInfoExcelTemplate(HttpServletResponse response) {
        String rootPath = new File(getClass().getResource("/").getPath()).getParentFile().getParent().toString();
        rootPath = rootPath.replaceAll("%20", " ");
        String fileName = rootPath + "/template/infoTemplate.xls";
        File file = FileUtils.getFile(fileName);
        OutputStream os = null;

        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("考勤基本信息模板.xls", "utf-8"));
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

    /**
     * 导入数据
     *
     * @param file
     * @return
     */
    @ResponseBody
    @RequestMapping("/attendance/importInfo")
    public Message importStudent(@RequestParam(value = "file", required = false) CommonsMultipartFile file) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        String coding = CommonUtil.getUUID();
        try {
            HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            for (int i = 2; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                AttendanceInfo attendanceInfo = new AttendanceInfo();
                attendanceInfo.setYear(CommonUtil.changeToInteger(row.getCell(0)));
                attendanceInfo.setMonth(CommonUtil.changeToInteger(row.getCell(1)));
                attendanceInfo.setName(row.getCell(2).toString());
                attendanceInfo.setIdcard(row.getCell(3).toString());
                attendanceInfo.setBasicFrequency(CommonUtil.changeToInteger(row.getCell(4)));
                attendanceInfo.setNoSignInFrequency(CommonUtil.changeToInteger(row.getCell(5)));
                attendanceInfo.setLatestOutOfSignIn(CommonUtil.changeToInteger(row.getCell(6)));
                attendanceInfo.setLeaveNoSign(CommonUtil.changeToInteger(row.getCell(7)));
                attendanceInfo.setPublicHolidays(CommonUtil.changeToInteger(row.getCell(8)));
                attendanceInfo.setCompassionateLeave(CommonUtil.changeToInteger(row.getCell(9)));
                attendanceInfo.setSickLeave(CommonUtil.changeToInteger(row.getCell(10)));
                attendanceInfo.setWrongSignOnBusiness(CommonUtil.changeToInteger(row.getCell(11)));
                attendanceInfo.setId(CommonUtil.getUUID());
                attendanceInfo.setCoding(coding);
                attendanceInfo.setCreateDept(loginUser.getDefaultDeptId());
                attendanceInfo.setCreator(loginUser.getPersonId());
                attendanceService.insertInfo(attendanceInfo);
            }
            AttendanceImplog attendanceImplog = new AttendanceImplog();
            attendanceImplog.setId(CommonUtil.getUUID());
            attendanceImplog.setCoding(coding);
            attendanceImplog.setOperator(loginUser.getPersonId());
            attendanceImplog.setImportNumber(end - 1 + "");
            attendanceImplog.setImportFileName(file.getOriginalFilename());
            attendanceImplog.setCreateDept(loginUser.getDefaultDeptId());
            attendanceImplog.setCreator(loginUser.getPersonId());
            attendanceService.insertImplog(attendanceImplog);
        } catch (Exception e) {
            e.printStackTrace();
            return new Message(1, "导入成功！", null);
        }

        return new Message(1, "导入成功！", null);
    }

    @RequestMapping("/attendance/impLogList")
    public ModelAndView impLogList() {
        ModelAndView mv = new ModelAndView("/business/attendance/attendance/impLogList");
        return mv;
    }

    @RequestMapping("/attendance/infoListBySelf")
    public ModelAndView infoListBySelf() {
        ModelAndView mv = new ModelAndView("/business/attendance/attendance/infoListBySelf");
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (!loginUser.getPersonId().equals("sa")) {
            Emp emp = empService.getEmpByDeptIdAndPersonId(
                    loginUser.getPersonId(), loginUser.getDefaultDeptId());
            mv.addObject("idCard", emp.getIdCard());
        }
        return mv;
    }


    @ResponseBody
    @RequestMapping("/attendance/getImpLogList")
    public Map<String, Object> getInfoLogList(AttendanceImplog implog, int draw, int start, int length) {
        AttendanceInfo attendanceInfo = new AttendanceInfo();
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> implogList = new HashMap();
        implog.setCreateDept(CommonUtil.getDefaultDept());
        implog.setLevel(CommonUtil.getLoginUser().getLevel());
        List<AttendanceImplog> salaryList1 = attendanceService.getImplogList(implog);
        PageInfo<List<AttendanceImplog>> info = new PageInfo(salaryList1);
        implogList.put("draw", draw);
        implogList.put("recordsTotal", info.getTotal());
        implogList.put("recordsFiltered", info.getTotal());
        implogList.put("data", salaryList1);
        // implogMap.put("data", attendanceService.getImplogList(implog));
        return implogList;
    }

    @ResponseBody
    @RequestMapping("/attendance/delImplogList")
    public Message delImplogList(String coding) {
        attendanceService.deleteImplogByCoding(coding);
        attendanceService.deleteInfoByCoding(coding);
        return new Message(1, "删除成功！", null);
    }

    @RequestMapping("/attendance/impLogInfo")
    public ModelAndView impLogInfo(String bm, String coding) {
        ModelAndView mv = new ModelAndView("/business/attendance/attendance/impLogInfo");
        mv.addObject("bm", bm);
        mv.addObject("coding", coding);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/attendance/getInfoByCoding")
    public Map<String, List<AttendanceInfo>> getInfoByBm(String coding) {
        AttendanceInfo attendanceInfo = new AttendanceInfo();
        attendanceInfo.setCoding(coding);
        Map<String, List<AttendanceInfo>> attendanceInfoMap = new HashMap<String, List<AttendanceInfo>>();
        attendanceInfoMap.put("data", attendanceService.getInfoList(attendanceInfo));
        return attendanceInfoMap;
    }


}

