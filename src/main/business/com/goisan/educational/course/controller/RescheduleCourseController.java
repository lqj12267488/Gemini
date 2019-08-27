package com.goisan.educational.course.controller;

import com.goisan.educational.course.bean.RescheduleCourse;
import com.goisan.educational.course.service.RescheduleCourseService;
import com.goisan.system.bean.Role;
import com.goisan.system.service.RoleService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.*;

@Controller
public class RescheduleCourseController {

    @Resource
    private RescheduleCourseService rescheduleCourseService;

    @Autowired
    private RoleService roleService;

    @RequestMapping("/rescheduleCourse/rescheduleCourseList")
    public ModelAndView rescheduleCourseList(String tTKcode) {
        String requester = CommonUtil.getPersonId();
        String requesterDept = CommonUtil.getDefaultDept();
        String tTKSPId = rescheduleCourseService.getTTKSPId(tTKcode);
        ModelAndView mv = new ModelAndView();
        mv.addObject("requester", requester);
        mv.addObject("requesterDept", requesterDept);
        mv.addObject("tTKSPId",tTKSPId);
//        添加是否是系部审批人，审批权限。
//        获取系部主任角色
        Set<String> userRole = CommonUtil.getUserRole();
        Role role = new Role();
        role.setRolename("%系部主任%");
        List<Role> roleList = roleService.getRoleList(role);
        String isDeptBoss = "0";
        for (String roleId:userRole) {
            if (roleId.equals(roleList.get(0).getRoleid())){
                isDeptBoss = "1";
                break;
            }
        }
        mv.addObject("isDeptBoss",isDeptBoss);
        mv.setViewName("/business/educational/course/rescheduleCourseList");
        return mv;
    }

    /**
     * 调停课查询，
     * 根据系部查询
     *
     * @param rescheduleCourse
     * @return
     */
    @ResponseBody
    @RequestMapping("/rescheduleCourse/getRescheduleCourseList")
    public Map<String, List<RescheduleCourse>> getRescheduleCourseList(RescheduleCourse rescheduleCourse) {
        rescheduleCourse.setRequester(CommonUtil.getPersonId());
        rescheduleCourse.setRequesterDept(CommonUtil.getDefaultDept());
        Set<String> userRole = CommonUtil.getUserRole();
//        获取系部主任角色
        Role role = new Role();
        role.setRolename("%系部主任%");
        List<Role> roleList = roleService.getRoleList(role);
        Boolean isDeptBoss = false;
        for (String roleId:userRole) {
            if (roleId.equals(roleList.get(0).getRoleid())){
                isDeptBoss = true;
            }
        }
        rescheduleCourse.setDeptBoss(isDeptBoss);
        Map<String, List<RescheduleCourse>> map = new HashMap<>();
        map.put("data", rescheduleCourseService.getRescheduleCourseList(rescheduleCourse));
        return map;
    }

    @RequestMapping("/rescheduleCourse/editRescheduleCourse")
    public ModelAndView editRescheduleCourse(RescheduleCourse rescheduleCourse) {
        ModelAndView mv = new ModelAndView();
        if (null == rescheduleCourse.getId() || "".equals(rescheduleCourse.getId())) {
            rescheduleCourse.setApplicantPersonId(CommonUtil.getUserAccount());
            rescheduleCourse.setCreator(CommonUtil.getPersonId());
            rescheduleCourse.setCreateDept(CommonUtil.getDefaultDept());
            rescheduleCourse.setRequesterDept(CommonUtil.getDefaultDept());
            if (null != CommonUtil.getDefaultDept()&&!"".equals(CommonUtil.getDefaultDept())) {
                RescheduleCourse majorSchoolInfo = rescheduleCourseService.getMajorSchoolByDeptId(rescheduleCourse);
                rescheduleCourse.setMajorSchool(majorSchoolInfo.getMajorSchool());
                rescheduleCourse.setMajorSchoolShow(majorSchoolInfo.getMajorSchoolShow());
                rescheduleCourse.setDeptId(CommonUtil.getDefaultDept());
            }
            mv.addObject("head", "新增调串课申请");
            mv.setViewName("/business/educational/course/editRescheduleCourse");
            mv.addObject("RescheduleCourse", rescheduleCourse);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/rescheduleCourse/saveRescheduleCourse")
    public Message saveRescheduleCourse(RescheduleCourse rescheduleCourse) {
        if (null == rescheduleCourse.getId() || "".equals(rescheduleCourse.getId())) {
            rescheduleCourse.setCreator(CommonUtil.getPersonId());
            rescheduleCourse.setCreateDept(CommonUtil.getDefaultDept());
            rescheduleCourseService.insertRescheduleCourse(rescheduleCourse);
            return new Message(1, "新增成功", null);
        } else {
            rescheduleCourse.setChanger(CommonUtil.getPersonId());
            rescheduleCourse.setChangeDept(CommonUtil.getDefaultDept());
            rescheduleCourse.setRescheduleTeacher(CommonUtil.getPersonId());
            rescheduleCourseService.updRescheduleCourseById(rescheduleCourse);
            return new Message(1, "修改成功", null);
        }
    }

    @RequestMapping("/rescheduleCourse/updReschedule")
    public ModelAndView updReschedule(RescheduleCourse selRC) {
        ModelAndView mv = new ModelAndView();
//        根据id查询。
        RescheduleCourse rescheduleCourse = rescheduleCourseService.getRescheduleCourseById(selRC);
        rescheduleCourse.setCreator(CommonUtil.getPersonId());
        mv.addObject("rescheduleCourse", rescheduleCourse);
        mv.addObject("head", "修改申请");
        mv.setViewName("/business/educational/course/editRescheduleCourse");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/rescheduleCourse/delRescheduleCourse")
    public Message delRescheduleCourse(RescheduleCourse rescheduleCourse) {
        if (null == rescheduleCourse.getId() || "".equals(rescheduleCourse.getId())) {
            return new Message(1, "删除失败", "error");
        } else {
            rescheduleCourse.setChanger(CommonUtil.getPersonId());
            rescheduleCourse.setChangeDept(CommonUtil.getDefaultDept());
            rescheduleCourseService.delRescheduleCourseById(rescheduleCourse);
            return new Message(1, "删除成功", "success");
        }
    }

    @ResponseBody
    @RequestMapping("/rescheduleCourse/updRCWithSubmit")
    public Message updRCWithSubmit(RescheduleCourse rescheduleCourse) {
            if (CommonUtil.getDefaultDept().equals(rescheduleCourse.gettTKSPId())){
                rescheduleCourseService.updRCWithOfficeSubmit(rescheduleCourse);
                return new Message(1, "提交成功", "success");
            }else {
                rescheduleCourseService.updRCWithSubmit(rescheduleCourse);
                return new Message(1, "提交成功", "success");
            }
    }

    @RequestMapping("/rescheduleCourse/approveRC")
    public ModelAndView approveRC(RescheduleCourse approveRC) {
        RescheduleCourse rescheduleCourse = rescheduleCourseService.getApproveRCById(approveRC);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/course/ApproveRescheduleCourse");
        mv.addObject("head", "审批");
        mv.addObject("rescheduleCourse", rescheduleCourse);
        mv.addObject("createDept",approveRC.getCreateDept());
        mv.addObject("tTKSPId",approveRC.gettTKSPId());
        return mv;
    }


    /**
     * 系部批准
     */
    @ResponseBody
    @RequestMapping("/rescheduleCourse/approveRCWithDept")
    public Message approveRCWithDept(RescheduleCourse rescheduleCourse) {
        rescheduleCourse.setChanger(CommonUtil.getPersonId());
        rescheduleCourse.setChangeDept(CommonUtil.getDefaultDept());
        if (!"001007".equals(CommonUtil.getDefaultDept())) {
            rescheduleCourse.setApproveDptPersonId(CommonUtil.getPersonId());
            rescheduleCourseService.updRCWithDeptApprove(rescheduleCourse);
            return new Message(1, "批准成功", "success");
        } else {
            rescheduleCourse.setApproveOfficePersonId(CommonUtil.getPersonId());
            rescheduleCourseService.updRCWithOfficeApprove(rescheduleCourse);
            return new Message(1, "批准成功", "success");
        }
    }

    @ResponseBody
    @RequestMapping("/rescheduleCourse/overruleRCWithDept")
    public Message overruleRCWithDept(RescheduleCourse rescheduleCourse) {
        rescheduleCourse.setChanger(CommonUtil.getPersonId());
        rescheduleCourse.setChangeDept(CommonUtil.getDefaultDept());
        if (!rescheduleCourse.gettTKSPId().equals(CommonUtil.getDefaultDept())) {
            rescheduleCourse.setApproveDptPersonId(CommonUtil.getPersonId());
            if ("0".equals(rescheduleCourse.getOverruleStatus())){
                rescheduleCourseService.updRCWithDeptOverrule(rescheduleCourse);
                return new Message(1, "驳回成功", "success");
            }
            else {
                rescheduleCourseService.updRCWithOfficeAndDeptOverrule(rescheduleCourse);
                return new Message(1, "驳回成功", "success");
            }
        }
        else {
                rescheduleCourse.setApproveOfficePersonId(CommonUtil.getPersonId());
            if (rescheduleCourse.getCreateDept().equals(CommonUtil.getDefaultDept())){
                rescheduleCourseService.updRCWithOffOverNoDept(rescheduleCourse);
                return new Message(1, "驳回成功", "success");
            }else {
                rescheduleCourseService.updRCWithOfficeOverrule(rescheduleCourse);
                return new Message(1, "驳回成功", "success");
            }
        }
    }

    @RequestMapping("/rescheduleCourse/rescheduleCourseQueryList")
    public String rCQueryList(){
        return "/business/educational/course/rescheduleCourseQueryList";
    }


    @ResponseBody
    @RequestMapping("/rescheduleCourse/getRCQueryList")
    public Map<String, List<RescheduleCourse>> getRCQueryList(RescheduleCourse rescheduleCourse) {
        Map<String, List<RescheduleCourse>> map = new HashMap<>();
        map.put("data", rescheduleCourseService.getRCQueryList(rescheduleCourse));
        return map;
    }

    @RequestMapping("/rescheduleCourse/toExportRC")
    public void toExportRC(HttpServletResponse response, String id){
//        查询导出数据
        RescheduleCourse rescheduleCourse = new RescheduleCourse();
        rescheduleCourse.setId(id);
        RescheduleCourse rcExcel = rescheduleCourseService.toExcelRCById(rescheduleCourse);
//        创建Excel表
        HSSFWorkbook workbook = new HSSFWorkbook();
        Sheet sheet = workbook.createSheet("调串课通知单");

//        设置字体
        HSSFFont titleFont =workbook.createFont();
        titleFont.setBold(true);
        titleFont.setFontName("宋体");
        titleFont.setFontHeightInPoints((short)16);


        HSSFFont font12 =workbook.createFont();
        font12.setFontName("宋体");
        font12.setFontHeightInPoints((short)12);

        HSSFFont font14 =workbook.createFont();
        font14.setFontName("宋体");
        font14.setFontHeightInPoints((short)14);

        HSSFFont fontBlod14 =workbook.createFont();
        fontBlod14.setBold(true);
        fontBlod14.setFontName("宋体");
        fontBlod14.setFontHeightInPoints((short)14);

        CellStyle titleCS = workbook.createCellStyle();
        titleCS.setFont(titleFont);
        titleCS.setAlignment(HorizontalAlignment.CENTER);
        titleCS.setVerticalAlignment(VerticalAlignment.CENTER);

        CellStyle cs12 = workbook.createCellStyle();
        cs12.setAlignment(HorizontalAlignment.CENTER);
        cs12.setVerticalAlignment(VerticalAlignment.CENTER);
        cs12.setWrapText(true);
        cs12.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cs12.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cs12.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cs12.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cs12.setFont(font12);

        CellStyle cs12NoBorLeft = workbook.createCellStyle();
        cs12NoBorLeft.setAlignment(HorizontalAlignment.LEFT);
        cs12NoBorLeft.setVerticalAlignment(VerticalAlignment.CENTER);
        cs12NoBorLeft.setWrapText(true);
        cs12NoBorLeft.setFont(font14);

        CellStyle cs14 = workbook.createCellStyle();
        cs14.setAlignment(HorizontalAlignment.CENTER);
        cs14.setVerticalAlignment(VerticalAlignment.CENTER);
        cs14.setWrapText(true);
        cs14.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cs14.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cs14.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cs14.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cs14.setFont(font14);
//

//       样式靠右
        CellStyle csRight = workbook.createCellStyle();
        csRight.setVerticalAlignment(VerticalAlignment.CENTER);
        csRight.setAlignment(HorizontalAlignment.RIGHT);
        csRight.setFont(font14);
//
        CellStyle csFontBlod14 = workbook.createCellStyle();
        csFontBlod14.setAlignment(HorizontalAlignment.CENTER);
        csFontBlod14.setVerticalAlignment(VerticalAlignment.CENTER);
        csFontBlod14.setWrapText(true);
        csFontBlod14.setFont(fontBlod14);
//
////        样式靠左
        CellStyle csLeft = workbook.createCellStyle();
        csLeft.setVerticalAlignment(VerticalAlignment.CENTER);
        csLeft.setAlignment(HorizontalAlignment.LEFT);
        csLeft.setBorderTop(HSSFCellStyle.BORDER_THIN);
        csLeft.setBorderRight(HSSFCellStyle.BORDER_THIN);
        csLeft.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        csLeft.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        csLeft.setFont(font12);

        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 9));
        //设置合并单元格
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 2, 5));//原定
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 6, 9));
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 0, 0));
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 1, 1));
        sheet.addMergedRegion(new CellRangeAddress(7, 7, 2, 3));
        sheet.addMergedRegion(new CellRangeAddress(7, 7, 4, 9));
        sheet.addMergedRegion(new CellRangeAddress(8, 8, 3, 4));
        sheet.addMergedRegion(new CellRangeAddress(8, 8, 1, 2));
        sheet.addMergedRegion(new CellRangeAddress(8, 8, 5, 6));

        //数据开始 统一设置宽度
        sheet.setColumnWidth(0, 10 * 256);
        sheet.setColumnWidth(1, 14 * 256);
        sheet.setColumnWidth(2, 8* 256);
        sheet.setColumnWidth(3, 10* 256);
        sheet.setColumnWidth(4, 8* 256);
        sheet.setColumnWidth(5, 7* 256);
        sheet.setColumnWidth(6, 8* 256);
        sheet.setColumnWidth(7, 10 * 256);
        sheet.setColumnWidth(8, 8 * 256);
        sheet.setColumnWidth(9, 7 * 256);


//        创建行
        Row headRow1 = sheet.createRow(0);
        Row headRow2 = sheet.createRow(1);
        Row headRow3 = sheet.createRow(2);
        Row headRow4 = sheet.createRow(3);
        Row headRow8 = sheet.createRow(7);
        Row headRow9 = sheet.createRow(8);

//        统一设置行高度
        headRow1.setHeightInPoints(30);
        headRow2.setHeightInPoints(30);
        headRow3.setHeightInPoints(30);
        headRow4.setHeightInPoints(30);
        headRow8.setHeightInPoints(30);
        headRow9.setHeightInPoints(30);

        Cell cell00 = headRow1.createCell(0);
        cell00.setCellStyle(titleCS);
        cell00.setCellValue(" 调 串 课 通 知 单");
        for (int j=1;j<=9;j++) {
            Cell cell = headRow1.createCell(j);
            cell.setCellStyle(titleCS);
        }


//        // 创建锚点
//        //第一个锚点 用于绘制第一条斜线
        HSSFPatriarch drawingPatriarch =  (HSSFPatriarch) sheet.createDrawingPatriarch();//创建画图对象
        HSSFClientAnchor a1 = new HSSFClientAnchor(0, 0,1023, 255, (short) 3, 2, (short) 3, 2);
        HSSFSimpleShape line1 = drawingPatriarch.createSimpleShape(a1);
        line1.setShapeType(HSSFSimpleShape.OBJECT_TYPE_LINE);
        line1.setLineStyle(HSSFSimpleShape.LINESTYLE_SOLID) ;

        HSSFClientAnchor a2 = new HSSFClientAnchor(0, 0,1023, 255, (short) 7, 2, (short) 7, 2);
        HSSFSimpleShape line2 = drawingPatriarch.createSimpleShape(a2);
        line2.setShapeType(HSSFSimpleShape.OBJECT_TYPE_LINE);
        line2.setLineStyle(HSSFSimpleShape.LINESTYLE_SOLID) ;


//
        Cell cell10 = headRow2.createCell(0);
        cell10.setCellValue("班 级");
        cell10.setCellStyle(cs14);
        Cell cell11 = headRow2.createCell(1);
        cell11.setCellValue("课 程");
        cell11.setCellStyle(cs14);
//
        Cell cell12 = headRow2.createCell(2);
        cell12.setCellValue("原  定");
        cell12.setCellStyle(cs14);

            for (int j=3;j<=5;j++){
                Cell cell = headRow2.createCell(j);
                cell.setCellStyle(cs14);
            }
        Cell cell13 = headRow2.createCell(6);
        cell13.setCellValue("改  调");
        cell13.setCellStyle(cs14);
        for (int j=7;j<=9;j++){
            Cell cell = headRow2.createCell(j);
            cell.setCellStyle(cs14);
        }

//        第三行
        for (int j=0;j<2;j++){
            Cell cell = headRow3.createCell(j);
            cell.setCellStyle(cs14);
        }
        Cell cell22 = headRow3.createCell(2);
        cell22.setCellValue("周次");
        cell22.setCellStyle(cs14);
        Cell cell23 = headRow3.createCell(3);
        cell23.setCellValue("月  日");
        cell23.setCellStyle(cs14);
        Cell cell24 = headRow3.createCell(4);
        cell24.setCellValue("星期");
        cell24.setCellStyle(cs14);
        Cell cell25 = headRow3.createCell(5);
        cell25.setCellValue("节次");
        cell25.setCellStyle(cs14);
        Cell cell26 = headRow3.createCell(6);
        cell26.setCellValue("周次");
        cell26.setCellStyle(cs14);
        Cell cell27 = headRow3.createCell(7);
        cell27.setCellValue("月  日");
        cell27.setCellStyle(cs14);
        Cell cell28 = headRow3.createCell(8);
        cell28.setCellValue("星期");
        cell28.setCellStyle(cs14);
        Cell cell129 = headRow3.createCell(9);
        cell129.setCellValue("节次");
        cell129.setCellStyle(cs14);

        Cell cell80 =headRow8.createCell(0);
        cell80.setCellValue("申请人");
        cell80.setCellStyle(cs14);

        Cell cell81 = headRow8.createCell(1);
        cell81.setCellValue(rcExcel.getApplicantPersonId());
        cell81.setCellStyle(cs12);

        Cell cell82 =headRow8.createCell(2);
        cell82.setCellValue("理 由");
        cell82.setCellStyle(cs14);

            Cell cell83 = headRow8.createCell(3);
        cell83.setCellStyle(cs12);

        Cell cell84 = headRow8.createCell(4);
        cell84.setCellValue(rcExcel.getApplicantReason());
        cell84.setCellStyle(csLeft);

        for (int j=5;j<=9;j++){
            Cell cell = headRow8.createCell(j);
            cell.setCellStyle(cs12);
        }

        Cell cell90 = headRow9.createCell(0);
        cell90.setCellValue("系部：");
        cell90.setCellStyle(csFontBlod14);


        Cell cellData91 = headRow9.createCell(1);
        cellData91.setCellValue(rcExcel.getApproveDptPersonId());
        cellData91.setCellStyle(cs12NoBorLeft);

        Cell cell93 = headRow9.createCell(3);
        cell93.setCellValue("  教务处：");
        cell93.setCellStyle(csFontBlod14);

        Cell cellData95 = headRow9.createCell(5);
        cellData95.setCellValue(rcExcel.getApproveOfficePersonId());
        cellData95.setCellStyle(cs12NoBorLeft);

        Cell cell97 = headRow9.createCell(7);
        Cell cell98 = headRow9.createCell(8);
        Cell cell99 = headRow9.createCell(9);

        cell97.setCellStyle(csRight);
        cell98.setCellStyle(csRight);
        cell99.setCellStyle(csRight);

        if (null!=rcExcel.getApproveOfficeDate() && !"" .equals(rcExcel.getApproveOfficeDate())) {
            String[] officeDate = rcExcel.getApproveOfficeDate().split("-");
            cell97.setCellValue(officeDate[0] + "年");
            cell98.setCellValue(officeDate[1]+"月");
            cell99.setCellValue(officeDate[2]+"日");
        }else {
            cell97.setCellValue(""+ "年");
            cell98.setCellValue("月");
            cell99.setCellValue("日");
        }


        Cell cellData0 = headRow4.createCell(0);
        cellData0.setCellValue(rcExcel.getClassId());
        cellData0.setCellStyle(cs12);

        Cell cellData1 = headRow4.createCell(1);
        cellData1.setCellValue(rcExcel.getCourseId());
        cellData1.setCellStyle(cs12);
        Cell cellData2 = headRow4.createCell(2);
        cellData2.setCellValue(rcExcel.getOringalWeek());
        cellData2.setCellStyle(cs12);

        Cell cellData3 = headRow4.createCell(3);
        cellData3.setCellValue(rcExcel.getOringalDate());
        cellData3.setCellStyle(cs12);


        Cell cellData4 = headRow4.createCell(4);
        cellData4.setCellValue(rcExcel.getOringalWeekday());
        cellData4.setCellStyle(cs12);
        Cell cellData5 = headRow4.createCell(5);
        cellData5.setCellValue(rcExcel.getOringalClassTime());
        cellData5.setCellStyle(cs12);

        Cell cellData6 = headRow4.createCell(6);
        cellData6.setCellValue(rcExcel.getRescheduleWeek());
        cellData6.setCellStyle(cs12);

        Cell cellData7 = headRow4.createCell(7);
        cellData7.setCellValue(rcExcel.getRescheduleDate());
        cellData7.setCellStyle(cs12);
        Cell cellData8 = headRow4.createCell(8);
        cellData8.setCellValue(rcExcel.getRescheduleWeekday());
        cellData8.setCellStyle(cs12);
        Cell cellData9 = headRow4.createCell(9);
        cellData9.setCellValue(rcExcel.getRescheduleClassTime());
        cellData9.setCellStyle(cs12);
//      空白行
         for (int i=4;i<=6;i++){
             Row row = sheet.createRow(i);
             row.setHeightInPoints(30);
             for (int j=0;j<=9;j++){
                 Cell cell = row.createCell(j);
                 cell.setCellStyle(cs12);
            }
        }

//        导出
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ( "调串课表.xlsx", "utf-8"));
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


}
