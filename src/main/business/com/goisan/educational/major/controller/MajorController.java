package com.goisan.educational.major.controller;

import com.alibaba.druid.support.json.JSONParser;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.courseplan.bean.CoursePlan;
import com.goisan.educational.major.bean.Major;
import com.goisan.educational.major.bean.TalentTrain;
import com.goisan.educational.major.bean.TeachingTeamMember;
import com.goisan.educational.major.service.MajorLeaderService;
import com.goisan.educational.major.service.MajorService;
import com.goisan.system.bean.*;
import com.goisan.system.service.ClassService;
import com.goisan.system.service.FilesService;
import com.goisan.system.service.RoleService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.google.gson.Gson;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * Created by admin on 2017/5/18.
 */
@Controller
public class MajorController {

    @Resource
    private MajorService majorService;
    @Resource
    private ClassService classService;
    @Resource
    private MajorLeaderService majorLeaderService;
    //
    @Resource
    private RoleService roleService;

    @Resource
    private FilesService filesService;

    @RequestMapping("/major/majorList")
    public ModelAndView majorList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/majorList");
        return mv;
    }


    @ResponseBody
    @RequestMapping("/major/getMajorList")
    public Map<String, Object> getMajorList(Major sel, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> selList = new HashMap<String, Object>();
        List<Major> list = majorService.getMajorList(sel);
        //major.put("data", majorService.getMajorList(sel));
        PageInfo<List<Major>> info = new PageInfo(list);
        selList.put("draw", draw);
        selList.put("recordsTotal", info.getTotal());
        selList.put("recordsFiltered", info.getTotal());
        selList.put("data", list);
        return selList;
    }

    @ResponseBody
    @RequestMapping("/major/addMajor")
    public ModelAndView addMajor() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/editMajor");
        mv.addObject("head", "新增专业");
        return mv;
    }

    // +miaodian
    @ResponseBody
    @RequestMapping("/major/updateMajor")
    public ModelAndView updateMajor(String majorId) {
        Major major = majorService.getMajorByMajorId(majorId);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/editMajor");
        mv.addObject("head", "专业修改");
        mv.addObject("major", major);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/major/saveMajor")
    public Message saveMajor(Major major, @RequestParam(value = "file", required = false) CommonsMultipartFile file) {
//        String fileUrl = null;
//        try {
//            String name = file.getFileItem().getName();
//            InputStream in = file.getInputStream();
//            if (file.getSize() > 0) {
//                String root = new File(getClass().getResource("/").getPath()).getParentFile().getParent();
//                String filePath = root + "/files/major/";
//                File f = new File(filePath);
//                f.mkdirs();
//                fileUrl = "/files/major/" + name;
//                FileOutputStream fos = new FileOutputStream(root + fileUrl);
//                byte[] buffer = new byte[8192];
//                int count = 0;
//                while ((count = in.read(buffer)) > 0) {
//                    fos.write(buffer, 0, count);
//                }
//                fos.close();
//                in.close();
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        if (fileUrl != null) {
//            major.setFileUrl(fileUrl);
//        }
        if (null == major.getMajorId() || major.getMajorId().equals("")) {
            major.setCreator(CommonUtil.getPersonId());
            major.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            majorService.insertMajor(major);
            return new Message(1, "新增成功！", null);
        } else {
            major.setChanger(CommonUtil.getPersonId());
            major.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            majorService.updateMajor(major);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/major/checkMajorName")
    public Message checkMajorName(Major major) {
        Major checkMajor = majorService.checkMajorName(major);
        if (checkMajor != null) {
            if (checkMajor.getMajorId().equals(major.getMajorId())) {

            } else {

                String re = "，请重新填写！";
                if (major.getTrainingLevel().equals(checkMajor.getTrainingLevel())
                        && major.getMajorDirection().equals(checkMajor.getMajorDirection())) {
                    re = "此 " + major.getMajorName() + "专业 - " +
                            major.getTrainingLevelShow() + "培养层次  - " + major.getMajorDirectionShow() + "方向已存在!" + re;
                } else if (major.getMajorName().equals(checkMajor.getMajorName())) {
                    re = "此专业代码在 " + major.getMajorName() + "专业 的其他培养层次中已存在" + re;
                } else {
                    re = "此专业代码在其他专业中已存在" + re;
                }
                return new Message(1, re, null);
            }

        } else {
            return new Message(0, "", null);
        }
        return new Message(0, "", null);

    }

    @ResponseBody
    @RequestMapping("/major/checkMajorCode")
    public Message checkMajorCode(Major major) {
        List<Major> list = majorService.checkMajorCode(major);
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                if (major.getMajorId().equals(list.get(i).getMajorId())) {
                    return new Message(0, "", null);
                } else {
                    return new Message(1, "，请重新填写！", null);
                }
            }
        }
        return new Message(0, "", null);
    }


    @ResponseBody
    @RequestMapping("/major/delMajor")
    public Message delMajor(String majorId) {
        Major major = majorService.getMajorByMajorId(majorId);
        String departmentsId = major.getDepartmentsId();
        String majorCode = major.getMajorCode();
        String trainingLevel = major.getTrainingLevel();

        //判断次专业下是否有班级
        List<ClassBean> classList = classService.findClassListByMajorCons(departmentsId, majorCode, trainingLevel);
        if (classList.size() > 0) {
            return new Message(0, "该专业存在班级,不可删除！", null);
        } else {
            majorService.delectMajorByMajorId(majorId);
            return new Message(1, "删除成功！", null);
        }
    }
    /**
     * 导出表数据
     *
     * @param response
     */
   /* @RequestMapping("/major/exportInfo")
    public void exportStudent(HttpServletResponse response) {
        Major ma=new Major();
        List<Major> infoList = majorService.getMajorList(ma);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("专业信息");

        //创建HSSFRow对象
        int tmp = 0;
        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row1.createCell(0).setCellValue("所属学院");
        row1.createCell(1).setCellValue("专业名称");
        row1.createCell(2).setCellValue("培养层次");
        row1.createCell(3).setCellValue("专业代码");
        row1.createCell(4).setCellValue("专业方向");
        row1.createCell(5).setCellValue("专业方向代码");
        row1.createCell(6).setCellValue("系部");
        tmp++;

        for (Major major : infoList) {
            HSSFRow row = sheet.createRow(tmp);
            //创建HSSFCell对象
            row.createCell(0).setCellValue(major.getMajorSchoolShow());
            row.createCell(1).setCellValue(major.getMajorName());
            row.createCell(2).setCellValue(major.getTrainingLevelShow());
            row.createCell(3).setCellValue(major.getMajorCode());
            row.createCell(4).setCellValue(major.getMajorDirectionShow());
            row.createCell(5).setCellValue(major.getMajorDirectionCode());
            row.createCell(6).setCellValue(major.getDepartmentsIdShow());
            tmp++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("专业信息.xls", "utf-8"));
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
    }*/


    /**
     * 专业导出
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/major/exportInfo")
    public void getCmteListGroupByMajor(HttpServletResponse response) {
        HSSFWorkbook workbook = new HSSFWorkbook();
        Sheet sheet = workbook.createSheet("专业信息表");
        // 标题部分
        CellStyle titleStyle = workbook.createCellStyle();
        Font titleFont = workbook.createFont();
        titleFont.setFontName("楷体");
        titleFont.setFontHeightInPoints((short) 20);
        titleStyle.setAlignment(CellStyle.ALIGN_CENTER);
        titleStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        titleStyle.setFont(titleFont);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 24));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 24));
        int rowNum = 0;
        Cell title1 = sheet.createRow(rowNum++).createCell(0);
        String xxmc= CommonBean.getParamValue("SZXXMC");
        title1.setCellValue(xxmc);
        title1.setCellStyle(titleStyle);
        Cell title2 = sheet.createRow(rowNum++).createCell(0);
        title2.setCellValue("专业表");
        title2.setCellStyle(titleStyle);
        Major ma = new Major();
        List<Major> infoList = majorService.getMajorListExport(ma);
        CellStyle cellStyle0 = workbook.createCellStyle();
        String tablename = "";


        cellStyle0.setAlignment(HorizontalAlignment.CENTER);
        cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle0.setWrapText(true);
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 0, 0));//序号
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 1, 1));//专业所属系部
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 2, 2));//是否招生
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 3, 3));//专业代码
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 4, 4));//专业名称（全称）
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 5, 5));//专业方向代码
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 6, 6));//专业方向名称（全称）
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 7, 7));//批准设置日期
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 8, 8));//首次招生日期
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 9, 9));//修业年限
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 10, 13));//在校生数
        sheet.addMergedRegion(new CellRangeAddress(3, 4, 10, 10));//
        sheet.addMergedRegion(new CellRangeAddress(3, 4, 11, 11));//
        sheet.addMergedRegion(new CellRangeAddress(3, 4, 12, 12));//
        sheet.addMergedRegion(new CellRangeAddress(3, 4, 13, 13));//
        sheet.addMergedRegion(new CellRangeAddress(3, 4, 14, 14));//
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 14, 17));//生源类型
        sheet.addMergedRegion(new CellRangeAddress(3, 3, 15, 16));//中职起点
        /*  sheet.addMergedRegion(new CellRangeAddress(4, 4, 15, 15));//合计
        sheet.addMergedRegion(new CellRangeAddress(4, 4, 16, 16));//其中：五年制后二年*/
        sheet.addMergedRegion(new CellRangeAddress(3, 4, 17, 17));//其他
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 18, 18));//重点专业
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 19, 19));//特色专业
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 20, 20));//是否现代学徒制试点专业
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 21, 21));//是否国际合作专业
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 22, 22));//班级总数（个）
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 23, 24));//订单(定向)培养情况
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 25, 25));//专业所获荣誉1
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 26, 26));//专业所获荣誉2
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 27, 27));//专业特点
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 28, 28));//校内实习实训基地数
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 29, 29));//产学合作企业数
        sheet.addMergedRegion(new CellRangeAddress(2, 4, 30, 30));//专业其他情况


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
        sheet.setColumnWidth(25, 18 * 256);
        sheet.setColumnWidth(26, 18 * 256);
        sheet.setColumnWidth(27, 18 * 256);
        sheet.setColumnWidth(28, 18 * 256);
        sheet.setColumnWidth(29, 18 * 256);
        sheet.setColumnWidth(30, 18 * 256);

        Row row0 = sheet.createRow(2);
        Row row1 = sheet.createRow(3);
        Row row2 = sheet.createRow(4);

        Cell ce1 = row0.createCell(0);
        ce1.setCellValue("序号");
        ce1.setCellStyle(cellStyle0);

        Cell ce2 = row0.createCell(1);
        ce2.setCellValue("专业所属系部");
        ce2.setCellStyle(cellStyle0);

        Cell ce3 = row0.createCell(2);
        ce3.setCellValue("是否招生");
        ce3.setCellStyle(cellStyle0);

        Cell ce4 = row0.createCell(3);
        ce4.setCellValue("专业代码");
        ce4.setCellStyle(cellStyle0);

        Cell ce5 = row0.createCell(4);
        ce5.setCellValue("专业名称（全称）");
        ce5.setCellStyle(cellStyle0);

        Cell ce6 = row0.createCell(5);
        ce6.setCellValue("专业方向代码");
        ce6.setCellStyle(cellStyle0);

        Cell ce7 = row0.createCell(6);
        ce7.setCellValue("专业方向名称（全称）");
        ce7.setCellStyle(cellStyle0);

        Cell ce8 = row0.createCell(7);
        ce8.setCellValue("批准设置日期");
        ce8.setCellStyle(cellStyle0);

        Cell ce9 = row0.createCell(8);
        ce9.setCellValue("首次招生日期");
        ce9.setCellStyle(cellStyle0);

        Cell ce10 = row0.createCell(9);
        ce10.setCellValue("修业年限");
        ce10.setCellStyle(cellStyle0);

        Cell ce11 = row0.createCell(10);
        ce11.setCellValue("在校生数");
        ce11.setCellStyle(cellStyle0);

        Cell ce12 = row1.createCell(10);
        ce12.setCellValue("总人数");
        ce12.setCellStyle(cellStyle0);

        Cell ce13 = row1.createCell(11);
        ce13.setCellValue("一年级");
        ce13.setCellStyle(cellStyle0);

        Cell ce14 = row1.createCell(12);
        ce14.setCellValue("二年级");
        ce14.setCellStyle(cellStyle0);

        Cell ce15 = row1.createCell(13);
        ce15.setCellValue("三年级");
        ce15.setCellStyle(cellStyle0);

        Cell ce17 = row0.createCell(14);
        ce17.setCellValue("生源类型");
        ce17.setCellStyle(cellStyle0);

        Cell ce18 = row1.createCell(14);
        ce18.setCellValue("普通高中起点");
        ce18.setCellStyle(cellStyle0);

        Cell ce19 = row1.createCell(15);
        ce19.setCellValue("中职起点");
        ce19.setCellStyle(cellStyle0);

        Cell ce20 = row2.createCell(15);
        ce20.setCellValue("合计");
        ce20.setCellStyle(cellStyle0);

        Cell ce21 = row2.createCell(16);
        ce21.setCellValue("其中：五年制后二年");
        ce21.setCellStyle(cellStyle0);

        Cell ce22 = row1.createCell(17);
        ce22.setCellValue("其他");
        ce22.setCellStyle(cellStyle0);

        Cell ce23 = row0.createCell(18);
        ce23.setCellValue("重点专业");
        ce23.setCellStyle(cellStyle0);

        Cell ce24 = row0.createCell(19);
        ce24.setCellValue("特色专业");
        ce24.setCellStyle(cellStyle0);

        Cell ce25 = row0.createCell(20);
        ce25.setCellValue("是否现代学徒制试点专业");
        ce25.setCellStyle(cellStyle0);

        Cell ce26 = row0.createCell(21);
        ce26.setCellValue("是否国际合作专业");
        ce26.setCellStyle(cellStyle0);

        Cell ce27 = row0.createCell(22);
        ce27.setCellValue("班级总数（个）");
        ce27.setCellStyle(cellStyle0);

        Cell ce28 = row0.createCell(23);
        ce28.setCellValue("订单(定向)培养情况");
        ce28.setCellStyle(cellStyle0);

        Cell ce29 = row2.createCell(23);
        ce29.setCellValue("班级数");
        ce29.setCellStyle(cellStyle0);

        Cell ce30 = row2.createCell(24);
        ce30.setCellValue("学生数");
        ce30.setCellStyle(cellStyle0);

        Cell ce31 = row0.createCell(25);
        ce31.setCellValue("是否有上届毕业生");
        ce31.setCellStyle(cellStyle0);
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH);
        List<Major> list0;
        if (month < 8) {
            list0 = majorService.getStudentNumber();
        } else {
            list0 = majorService.getStudentNumberOrder();
        }

        List<Major> list1 = majorService.getSourceType();
        List<Major> list2 = majorService.getMajorCodeNumber();

        int i = 5;
        int dataNum = 1;
        for (Major majorLeader : infoList) {
            Row row = sheet.createRow(i);
            Cell cells0 = row.createCell(0);
            cells0.setCellValue(dataNum++);

            cells0.setCellStyle(cellStyle0);

            Cell cells1 = row.createCell(1);
            cells1.setCellValue(majorLeader.getDepartmentsIdShow());
            cells1.setCellStyle(cellStyle0);

            Cell cells2 = row.createCell(2);
            cells2.setCellValue(majorLeader.getSpringAutumnFlagShow());
            cells2.setCellStyle(cellStyle0);

            Cell cells3 = row.createCell(3);
            cells3.setCellValue(majorLeader.getMajorCode());
            cells3.setCellStyle(cellStyle0);

            Cell cells4 = row.createCell(4);
            cells4.setCellValue(majorLeader.getMajorName());
            cells4.setCellStyle(cellStyle0);

            Cell cells5 = row.createCell(5);
            cells5.setCellValue(majorLeader.getMajorDirectionCode());
            cells5.setCellStyle(cellStyle0);

            Cell cells6 = row.createCell(6);
            cells6.setCellValue(majorLeader.getMajorDirectionShow());
            cells6.setCellStyle(cellStyle0);

            Cell cells7 = row.createCell(7);
            cells7.setCellValue(majorLeader.getApprovalTime());
            cells7.setCellStyle(cellStyle0);

            Cell cells8 = row.createCell(8);
            cells8.setCellValue(majorLeader.getFirstRecruitTime());
            cells8.setCellStyle(cellStyle0);

            Cell cells9 = row.createCell(9);
            cells9.setCellValue(majorLeader.getMaxYearShow());
            cells9.setCellStyle(cellStyle0);

            for (Major majorCodeNumber : list2) {
                if (majorLeader.getMajorCode().equals(majorCodeNumber.getMajorCode())) {
                    Cell cells11 = row.createCell(10);
                    cells11.setCellValue(majorCodeNumber.getMajorNumber());
                    cells11.setCellStyle(cellStyle0);
                }
            }
            for (Major sourceType : list1) {
                if (majorLeader.getMajorCode().equals(sourceType.getMajorCode())) {
                    Cell cells14 = row.createCell(14);
                    cells14.setCellValue(sourceType.getSourceNumberOne());
                    cells14.setCellStyle(cellStyle0);

                    Cell cells15 = row.createCell(15);
                    cells15.setCellValue(sourceType.getSourceNumberTwo());
                    cells15.setCellStyle(cellStyle0);

                    Cell cells17 = row.createCell(17);
                    cells17.setCellValue(sourceType.getSourceNumberThree());
                    cells17.setCellStyle(cellStyle0);
                }
            }
            for (Major studentNumber : list0) {

                if (majorLeader.getMajorCode().equals(studentNumber.getMajorCode())) {
                    switch (studentNumber.getClassNumber()) {
                        case "1":
                            Cell cells11 = row.createCell(11);
                            cells11.setCellValue("");
                            cells11.setCellStyle(cellStyle0);
                            break;
                        case "2":
                            Cell cells12 = row.createCell(12);
                            cells12.setCellValue("");
                            cells12.setCellStyle(cellStyle0);
                            break;
                        case "3":
                            Cell cells13 = row.createCell(13);
                            cells13.setCellValue("");
                            cells13.setCellStyle(cellStyle0);
                            break;
                        default:
                            break;
                    }
                }
            }


            Cell cells18 = row.createCell(18);
            cells18.setCellValue(majorLeader.getFocusTypeShow());
            cells18.setCellStyle(cellStyle0);

            Cell cells19 = row.createCell(19);
            cells19.setCellValue(majorLeader.getUniqueTypeShow());
            cells19.setCellStyle(cellStyle0);

            Cell cells20 = row.createCell(20);
            cells20.setCellValue(majorLeader.getMajorNow());
            cells20.setCellStyle(cellStyle0);

            Cell cells21 = row.createCell(21);
            cells21.setCellValue(majorLeader.getMajorGlobal());
            cells21.setCellStyle(cellStyle0);

            Cell cells22 = row.createCell(22);
            cells22.setCellValue(majorLeader.getClassNum());
            cells22.setCellStyle(cellStyle0);

            Cell cells23 = row.createCell(23);
            cells23.setCellValue(majorLeader.getOrdersClassnum());
            cells23.setCellStyle(cellStyle0);

            Cell cells24 = row.createCell(24);
            cells24.setCellValue(majorLeader.getOrdersStudentnum());
            cells24.setCellStyle(cellStyle0);

            Cell cells25 = row.createCell(25);
            cells25.setCellValue("");
            cells25.setCellStyle(cellStyle0);

            i = i + 1;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("专业信息表.xls", "utf-8"));
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


    /**
     * 人才培养方案
     */
    @RequestMapping("/major/talentTrain")
    public ModelAndView talentTrainList() {
        ModelAndView mv = new ModelAndView();

        //判断登录人是否有人才培养审核权限
        String loginId = CommonUtil.getPersonId();

        String roleId = "1cf3168f-7238-4646-85f5-96ec41fe6a37";  //登录人是否有权限的id
        RoleEmpDeptRelation roleEmpDeptRelation = roleService.getEmpDeptByRoleIdAndPersonId(roleId, loginId);
        String uid=CommonUtil.getPersonId();
        mv.addObject("roleEmpDeptRelation", roleEmpDeptRelation);
        mv.addObject("uid", uid);
        mv.setViewName("/core/major/talentList");
        return mv;
    }

    /**
     * 列表sql
     */
    @ResponseBody
    @RequestMapping("/major/talentTrainList")
    public Map<String, Object> talentTrainList(TalentTrain tt, int draw, int start, int length) {
        if (tt.getPlanName() != null && tt.getPlanName() != "") {
            try {
                tt.setPlanName(URLDecoder.decode(tt.getPlanName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        PageHelper.startPage(start / length + 1, length);
        //Map<String, List<TalentTrain>> tmap = new HashMap<String, List<TalentTrain>>();
        Map<String, Object> tmapList = new HashMap<String, Object>();


        String dept=CommonUtil.getDefaultDept();
        String uid=null;
        //其中001007为教务部门的id
        if(!"001007".equals(dept)){
            uid=CommonUtil.getPersonId();
        }
        List<TalentTrain> list = majorService.getTalentTrainList(tt, uid);
        for (int i = 0; i < list.size(); i++) {
            Date teachFileTime, practiceFileTime, distributeFileTime;
            teachFileTime = list.get(i).getTeachFileTime();
            practiceFileTime = list.get(i).getPracticeFileTime();
            distributeFileTime = list.get(i).getDistributeFileTime();
            ArrayList<Date> dates = new ArrayList<Date>();
            if (teachFileTime != null) {
                dates.add(teachFileTime);
            }
            if (practiceFileTime != null) {
                dates.add(practiceFileTime);
            }
            if (distributeFileTime != null) {
                dates.add(distributeFileTime);
            }
            ComparatorDate c = new ComparatorDate();
            Collections.sort(dates, c);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            if (dates.size() >= 1)
                list.get(i).setUploadTime(sdf.format(dates.get(0)));
        }
        //tmap.put("data", majorService.getTalentTrainList(tt));
        PageInfo<List<TalentTrain>> info = new PageInfo(list);
        tmapList.put("draw", draw);
        tmapList.put("recordsTotal", info.getTotal());
        tmapList.put("recordsFiltered", info.getTotal());
        tmapList.put("data", list);

        return tmapList;
    }

    /**
     * 新增修改页
     */
    @ResponseBody
    @RequestMapping("/major/editTalent")
    public ModelAndView editTalent(String id) {
        ModelAndView mv = new ModelAndView();
        if (id != null || id != "") {
            TalentTrain tt = majorService.getTalentTrainById(id);
            mv.addObject("tt", tt);
        }
        mv.setViewName("/core/major/editTalent");
        mv.addObject("head", "新增培养方案");
        return mv;
    }

    /**
     * 得到所有的专业
     */
    @ResponseBody
    @RequestMapping("/major/getAllMajor")
    public List<Major> getAllMajor() {

        return this.majorService.getAllMajor();
    }

    /**
     * 人才培养保存方法
     */
    public static String COM_REPORT_PATH = null;

    @ResponseBody
    @RequestMapping("/major/saveTalent")
    public Message saveTalent(@RequestParam("id") String id,
                              @RequestParam(value = "majorId") String majorId,
                              @RequestParam(value = "yearType") String yearType,
                              @RequestParam(value = "departmentsId") String departmentsId,
                              @RequestParam(value = "trainMode") String trainMode,
                              @RequestParam(value = "trainPlan") String trainPlan,
                              @RequestParam(value = "suitSchool") String suitSchool,
                              @RequestParam(value = "actionGrade") String actionGrade,
                              @RequestParam(value = "teachFile", required = false) CommonsMultipartFile teachFile,
                              @RequestParam(value = "practiceFile", required = false) CommonsMultipartFile practiceFile,
                              @RequestParam(value = "distributeFile", required = false) CommonsMultipartFile distributeFile) {

        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String urlParten = "/files/%s";

        String teachFileUrl = null;
        String practiceFileUrl = null;
        String distributeFileUrl = null;

        FileOutputStream fos1 = null;
        FileOutputStream fos2 = null;
        FileOutputStream fos3 = null;

        Files teachFiles = null;
        Files practiceFiles = null;
        Files distributeFiles = null;


        String path = String.format(urlParten, sdf.format(new Date()));

        File f1 = null;
        File f2 = null;
        File f3 = null;

        TalentTrain talentTrain = new TalentTrain();

        try {
            if (teachFile != null && !(teachFile.getOriginalFilename().equals(""))) {
                String teachFileName = teachFile.getOriginalFilename();
                String teachFileUuid = CommonUtil.getUUID();
                talentTrain.setTeachFile11(teachFileUuid);
                teachFileUrl = path + "/" + teachFileUuid + teachFileName.substring(teachFileName.lastIndexOf("."));
                teachFiles = new Files();
                teachFiles.setFileId(teachFileUuid);
                teachFiles.setFileUrl(teachFileUrl);
                teachFiles.setFileName(teachFileName);
                teachFiles.setFileType(teachFileName.substring(teachFileName.lastIndexOf(".") + 1));
                teachFiles.setBusinessType("TEST");
                teachFiles.setTableName("T_JW_TALENTTRAIN");
                teachFiles.setCreator(CommonUtil.getPersonId());
                teachFiles.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
                f1 = new File(COM_REPORT_PATH + path);
                f1.mkdirs();
                fos1 = new FileOutputStream(new File(COM_REPORT_PATH + teachFileUrl));
                fos1.write(teachFile.getBytes());
            }
            if (practiceFile != null && !(practiceFile.getOriginalFilename().equals(""))) {
                String practiceFileName = practiceFile.getOriginalFilename();
                String practiceFileUuid = CommonUtil.getUUID();
                talentTrain.setPracticeFile(practiceFileUuid);
                practiceFileUrl = path + "/" + practiceFileUuid + practiceFileName.substring(practiceFileName.lastIndexOf("."));
                practiceFiles = new Files();
                practiceFiles.setFileId(practiceFileUuid);
                practiceFiles.setFileUrl(practiceFileUrl);
                practiceFiles.setFileName(practiceFileName);
                practiceFiles.setFileType(practiceFileName.substring(practiceFileName.lastIndexOf(".") + 1));
                practiceFiles.setBusinessType("TEST");
                practiceFiles.setTableName("T_JW_TALENTTRAIN");
                practiceFiles.setCreator(CommonUtil.getPersonId());
                practiceFiles.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
                f2 = new File(COM_REPORT_PATH + path);
                f2.mkdirs();
                fos2 = new FileOutputStream(new File(COM_REPORT_PATH + practiceFileUrl));
                fos2.write(practiceFile.getBytes());

            }
            if (distributeFile != null && !(distributeFile.getOriginalFilename().equals(""))) {
                String distributeFileName = distributeFile.getOriginalFilename();
                String distributeFileNameUuid = CommonUtil.getUUID();
                talentTrain.setDistributeFile(distributeFileNameUuid);
                distributeFileUrl = path + "/" + distributeFileNameUuid + distributeFileName.substring(distributeFileName.lastIndexOf("."));
                distributeFiles = new Files();
                distributeFiles.setFileId(distributeFileNameUuid);
                distributeFiles.setFileUrl(distributeFileUrl);
                distributeFiles.setFileName(distributeFileName);
                distributeFiles.setFileType(distributeFileName.substring(distributeFileName.lastIndexOf(".") + 1));
                distributeFiles.setBusinessType("TEST");
                distributeFiles.setTableName("T_JW_TALENTTRAIN");
                distributeFiles.setCreator(CommonUtil.getPersonId());
                distributeFiles.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
                f3 = new File(COM_REPORT_PATH + path);
                f3.mkdirs();
                fos3 = new FileOutputStream(new File(COM_REPORT_PATH + distributeFileUrl));
                fos3.write(distributeFile.getBytes());
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (fos1 != null)
                    fos1.close();
                if (fos2 != null)
                    fos2.close();
                if (fos3 != null)
                    fos3.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        TalentTrain talentTrainData=null;
        //判断为修改数据操作
        if (id != null && (!("").equals(id))) {
             talentTrainData= this.majorService.getTalentTrainById(id);
            String uid=CommonUtil.getPersonId();
            String creatorId=talentTrainData.getCreator();
            if(!uid.equals(creatorId)){
                return new Message(0,"您没有当前数据的权限！",null);
            }
            String teachFileId = null;
            String practiceFileId = null;
            String distributeFileId = null;

            //判断是否要更新已上传的文件
            if (!teachFile.getOriginalFilename().equals("")&&talentTrainData!=null) {
                talentTrainData.getTeachFile11();
            }
            if (!practiceFile.getOriginalFilename().equals("")&&talentTrainData!=null) {
               talentTrainData.getPracticeFile();
            }
            if (!distributeFile.getOriginalFilename().equals("")&&talentTrainData!=null) {
                distributeFileId = talentTrainData.getDistributeFile();
            }
            if (teachFileId != null) {
                //删除磁盘文件
                new File(COM_REPORT_PATH + this.filesService.getFilesByFilesId(teachFileId).get(0).getFileUrl()).delete();
                //删除文件表
                this.filesService.delFilesById(teachFileId);
            }
            if (practiceFileId != null) {
                //删除磁盘文件
                new File(COM_REPORT_PATH + this.filesService.getFilesByFilesId(practiceFileId).get(0).getFileUrl()).delete();
                //删除文件表
                this.filesService.delFilesById(practiceFileId);
            }
            if (distributeFileId != null) {
                //删除磁盘文件
                new File(COM_REPORT_PATH + this.filesService.getFilesByFilesId(distributeFileId).get(0).getFileUrl()).delete();
                //删除文件表
                this.filesService.delFilesById(distributeFileId);
            }
        }


        //保存上传文件数据
        if (teachFile != null && !(teachFile.getOriginalFilename().equals("")))
            filesService.insertFiles(teachFiles);
        if (practiceFile != null && !(practiceFile.getOriginalFilename().equals("")))
            filesService.insertFiles(practiceFiles);
        if (distributeFile != null && !(distributeFile.getOriginalFilename().equals("")))
            filesService.insertFiles(distributeFiles);
        //保存人才培养方案数据
        talentTrain.setActionGrade(actionGrade);
        talentTrain.setDepartmentsId(departmentsId);
        talentTrain.setMajorId(majorId);
        talentTrain.setYearType(yearType);
        talentTrain.setTrainMode(trainMode);
        talentTrain.setTrainPlan(trainPlan);
        talentTrain.setSuitSchool(suitSchool);
        talentTrain.setId(id);
        if (null == talentTrain.getId() || talentTrain.getId().equals("")) {
            talentTrain.setCreator(CommonUtil.getPersonId());
            talentTrain.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            majorService.insertTalentTrain(talentTrain);
            return new Message(1, "新增成功！", null);
        } else {
            talentTrain.setChanger(CommonUtil.getPersonId());
            talentTrain.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            if(teachFile.getOriginalFilename().equals("")){
                talentTrain.setTeachFile11(talentTrainData.getTeachFile11());
            }
            if(practiceFile.getOriginalFilename().equals("")){
                talentTrain.setPracticeFile(talentTrainData.getPracticeFile());
            }
            if(distributeFile.getOriginalFilename().equals("")){
                talentTrain.setDistributeFile(talentTrainData.getDistributeFile());
            }
            majorService.updateTalentTrain(talentTrain);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 删除方法
     */
    @ResponseBody
    @RequestMapping("/major/delTalent")
    public Message delTalent(String id) {
        TalentTrain talentTrain = majorService.getTalentTrainById(id);
        //删除人才培养方案
        majorService.deleteTalenTrain(id);
        //删除上传的文件
        filesService.delFilesById(talentTrain.getTeachFile11());
        filesService.delFilesById(talentTrain.getPracticeFile());
        filesService.delFilesById(talentTrain.getDistributeFile());

        return new Message(1, "删除成功！", null);
    }

    /**
     * 提交审核方法
     */
    @ResponseBody
    @RequestMapping("/major/submitTalent")
    public Message submitTalent(String id) {
        TalentTrain tt=this.majorService.getTalentTrainById(id);
        if(tt==null){
            return new Message(0, "未查询到数据！", "warning");
        }else {
            String lastStatus="1";
            if(!"".equals(tt.getRemark())){
                lastStatus="0";
            }
            majorService.submitTalent(id, lastStatus);
            return new Message(1, "提交成功！", null);
        }

    }

    /**
     * 关联教学计划
     */
    @ResponseBody
    @RequestMapping("/major/relateCoursePlanToArrayClass")
    public ModelAndView relateCoursePlanToArrayClass(String id, String trainName) {
        ModelAndView mv = new ModelAndView("/core/major/relationCourseTalent");
        mv.addObject("head", "关联教学计划");
        mv.addObject("tid", id);
        mv.addObject("tname", trainName);
        return mv;
    }

    /**
     * 查询指定人才培养方案的状态
     */
    @ResponseBody
    @RequestMapping("/major/getStatusByTid")
    public Map<String, String> getStatusByTid(String tid, HttpServletResponse response){
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json;charset=utf-8");
        String res=this.majorService.getStatusByTid(tid);
        Map<String,String> map=new HashMap<>();
        map.put("res", res);
        return map;
    }

    /**
     * 关联页sql
     */
    @ResponseBody
    @RequestMapping("/major/getrelationCT")
    public Map<String, List<CoursePlan>> getrelationCT(String id) {
        Map<String, List<CoursePlan>> tmap = new HashMap<String, List<CoursePlan>>();
        List<CoursePlan> list = majorService.getCoursePlan(id);
        for (int i = 0; i < list.size(); i++) {
            String flag = majorService.sfRelation(id, list.get(i).getPlanId());
            if (flag == null) {
                list.get(i).setTrainingLevel("否");
            } else {
                list.get(i).setTrainingLevel("是");
            }
        }
        tmap.put("data", list);
        return tmap;
    }

    /**
     * 保存关联方法
     */
    @ResponseBody
    @RequestMapping("/major/saveRelationTalent")
    public Message saveRelationTalent(TalentTrain tt) {
        tt.setCreator(CommonUtil.getPersonId());
        tt.setCreateDept(CommonUtil.getDefaultDept());
        majorService.saveRelationTalent(tt);
        return new Message(1, "提交成功！", null);
    }

    /**
     * 撤销关联方法
     */
    @ResponseBody
    @RequestMapping("/major/delRelationTalent")
    public Message delRelationTalent(String pid, String tid) {
        majorService.delRelationTalent(pid, tid);
        return new Message(1, "撤销成功！", null);
    }

    /**
     * 人才培养方案审核
     */
    @RequestMapping("/major/talentTrainProcess")
    public ModelAndView talentTrainProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/talentListProcess");
        return mv;
    }

    /**
     * 审核列表sql
     */
    @ResponseBody
    @RequestMapping("/major/talentTrainListProcess")
    public Map<String, Object> talentTrainListProcess(TalentTrain tt, int draw, int start, int length) {
        if (tt.getPlanName() != null && tt.getPlanName() != "") {
            try {
                tt.setPlanName(URLDecoder.decode(tt.getPlanName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        PageHelper.startPage(start / length + 1, length);
        //Map<String, List<TalentTrain>> tmap = new HashMap<String, List<TalentTrain>>();
        Map<String, Object> tmapList = new HashMap<String, Object>();
        List<TalentTrain> list = majorService.getTalentTrainListProcess(tt);
        PageInfo<List<TalentTrain>> info = new PageInfo(list);
        tmapList.put("draw", draw);
        tmapList.put("recordsTotal", info.getTotal());
        tmapList.put("recordsFiltered", info.getTotal());
        tmapList.put("data", list);
        // tmap.put("data", majorService.getTalentTrainListProcess(tt));
        return tmapList;
    }

    /**
     * 教学团队建设
     */
    private int columnNum=0;
    @RequestMapping("/major/TeachingTeam")
    public ModelAndView TeachingTeam(String planName) {
        ModelAndView mv = new ModelAndView();
        Integer columnNum=this.majorLeaderService.getTableMembersColumn(planName);
        mv.addObject("column", columnNum);
        mv.addObject("planName",planName);
        mv.setViewName("/core/major/teachingTeamList");
        return mv;
    }

    /**
     * 列表sql
     */
    @ResponseBody
    @RequestMapping("/major/teachingTeamList")
    public Map<String, Object> teachingTeamList(TalentTrain tt, int draw, int start, int length) {
        if (tt.getPlanName() != null && tt.getPlanName() != "") {
            try {
                tt.setPlanName(URLDecoder.decode(tt.getPlanName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        if (tt.getMemberNum() != null){
            columnNum = tt.getMemberNum();
        }
        PageHelper.startPage(start / length + 1, length);
        // Map<String, List<TalentTrain>> tmap = new HashMap<String, List<TalentTrain>>();
        Map<String, Object> tmapList = new HashMap<String, Object>();
        //tmap.put("data", majorLeaderService.getTeachingTeamList(tt));
        //查询除了成员数据的其他信息
        List<Map<String, String>> list = majorLeaderService.getTeachingTeamMap(tt);
        //最终的数据
        List<Map<String, String>> dataList=new ArrayList<Map<String, String>>();
        //遍历并添加每条数据的所有成员
        for(int i=0;i<list.size();i++){
            Map<String, String> map=list.get(i);
            //一条数据的所有成员list
            List<Map<String, String>> membersList=this.majorLeaderService.getTeachingTeamMemberByTeamId(map.get("ID"));
            //一条数据的所有成员map
            Map<String, String> membersMap=new HashMap<String, String>();
            for(int j=0;j<membersList.size();j++){
                membersMap.put("name"+j, membersList.get(j).get("NAME"));
            }
            //把每条数据的所有成员放到每条数据中
            if(membersList==null){
                //如果某条数据为空，为此条数据添加空数据
                for(int l=0; l<columnNum; l++){
                    membersMap.put("name"+l,"");
                }
                map.putAll(membersMap);
            }else if(membersMap.size()<columnNum){
                //如果某条数据不到最大成员数，补上空数据
                for(int k=membersMap.size();k<columnNum;k++){
                    membersMap.put("name"+k, "");
                }
                map.putAll(membersMap);
            }else{
                map.putAll(membersMap);
            }
            //并把每条完整得数据放到最终的数据中
            dataList.add(map);
        }


        PageInfo<List<TalentTrain>> info = new PageInfo(dataList);
        tmapList.put("draw", draw);
        tmapList.put("recordsTotal", info.getTotal());
        tmapList.put("recordsFiltered", info.getTotal());
        tmapList.put("data", list);
        return tmapList;
    }
    /**
     * 新增修改页
     */
    @ResponseBody
    @RequestMapping("/major/editTeachingTeam")
    public ModelAndView editTeachingTeam(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/editTeachingTeam");
        if(id==""||id==null){
            mv.addObject("head","新增");
        }else{
            TalentTrain tt = majorLeaderService.getTeachingTeamById(id);
            List<TeachingTeamMember> members=this.majorLeaderService.findTeachingTeamMemberByTeamId(id);
            TeachingTeamMember teamTeacher=this.majorLeaderService.getTeamTeachByTeamId(id);
            mv.addObject("tt", tt);
            //队成员bean的list集合转化成json数组
            Gson gson=new Gson();
            String json=gson.toJson(members);
            mv.addObject("members", json);
            mv.addObject("teamTeacher", teamTeacher);
            mv.addObject("head", "修改");
        }
        return mv;
    }

    /**
     * 教学团队保存方法
     */

    @ResponseBody
    @RequestMapping("/major/saveTeachingTeam")
    public Message saveTeachingTeam(TalentTrain tt) {
        List<TalentTrain> list=this.majorLeaderService.getTalentTrainByPlanName(tt);
        if(list.size()>0){
            return new Message(0, "已有相同团队名称！",null);
        }
        if (null == tt.getId() || tt.getId().equals("")) {
            tt.setCreator(CommonUtil.getPersonId());
            tt.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            String id=CommonUtil.getUUID();
            tt.setId(id);

            String[] membersDataArr=tt.getTeamPerson().split(";");
            String  membersId="";
            String deptId="";
            //分割成存储数据库形式类型的数据
            for(String memberData : membersDataArr){
                //index：1 部门id index：2 一个成员id
                String[] memberDataArr=memberData.split(",");
                TeachingTeamMember teachTeam=new TeachingTeamMember();
                teachTeam.setTeamId(id);
                teachTeam.setMemberType("2");
                deptId=memberDataArr[0];
                teachTeam.setDeptId(deptId);
                teachTeam.setPersonId(memberDataArr[1]);
                teachTeam.setCreator(CommonUtil.getPersonId());
                teachTeam.setCreateDept(CommonUtil.getDefaultDept());
                teachTeam.setId(CommonUtil.getUUID());
                //插入成员数据
                this.majorLeaderService.insertLeaderEmpDept(teachTeam);

            }
            //插入团队负责人数据
            TeachingTeamMember teachingTeamMember=new TeachingTeamMember();
            teachingTeamMember.setPersonId(tt.getTeamTeacher().split(",")[1]);
            teachingTeamMember.setMemberType("1");
            teachingTeamMember.setTeamId(id);
            teachingTeamMember.setDeptId(tt.getTeamTeacher().split(",")[0]);
            teachingTeamMember.setCreator(CommonUtil.getPersonId());
            teachingTeamMember.setDeptId(CommonUtil.getDefaultDept());
            teachingTeamMember.setId(CommonUtil.getUUID());
            majorLeaderService.insertLeaderEmpDept(teachingTeamMember);

            //插入团队信息
            majorLeaderService.insertTeachTeam(tt);
            return new Message(1, "新增成功！", null);
        } else {

            //删除所有的成员与负责人
            this.majorLeaderService.deleteAllMembersByTeamId(tt.getId());


            String[] membersDataArr=tt.getTeamPerson().split(";");
            String  membersId="";
            String deptId="";
            //分割成存储数据库形式类型的数据
            for(String memberData : membersDataArr){
                //index：1 部门id index：2 一个成员id
                String[] memberDataArr=memberData.split(",");
                TeachingTeamMember teachTeam=new TeachingTeamMember();
                teachTeam.setTeamId(tt.getId());
                teachTeam.setMemberType("2");
                deptId=memberDataArr[0];
                teachTeam.setDeptId(deptId);
                teachTeam.setPersonId(memberDataArr[1]);
                teachTeam.setCreator(CommonUtil.getPersonId());
                teachTeam.setCreateDept(CommonUtil.getDefaultDept());
                teachTeam.setId(CommonUtil.getUUID());
                //插入成员数据
                this.majorLeaderService.insertLeaderEmpDept(teachTeam);
            }
            //插入团队负责人数据
            TeachingTeamMember teachingTeamMember=new TeachingTeamMember();
            teachingTeamMember.setPersonId(tt.getTeamTeacher().split(",")[1]);
            teachingTeamMember.setMemberType("1");
            teachingTeamMember.setTeamId(tt.getId());
            teachingTeamMember.setDeptId(tt.getTeamTeacher().split(",")[0]);
            teachingTeamMember.setChanger(CommonUtil.getPersonId());
            teachingTeamMember.setId(CommonUtil.getUUID());
            majorLeaderService.insertLeaderEmpDept(teachingTeamMember);

            tt.setChanger(CommonUtil.getPersonId());
            tt.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            majorLeaderService.updateTeachingTeam(tt);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 删除方法
     */
    @ResponseBody
    @RequestMapping("/major/delTeachingTeam")
    public Message delTeachingTeam(String id) {
        majorLeaderService.deleteTeachingTeam(id);
        return new Message(1, "删除成功！", null);
    }

    /**
     * 审核页面
     */
    @ResponseBody
    @RequestMapping("/major/talentProcess")
    public ModelAndView talentProcess(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/talentProcess");
        mv.addObject("id", id);
        mv.addObject("head", "新增培养方案");
        return mv;
    }

    /**
     * 保存审核
     */
    @ResponseBody
    @RequestMapping("/major/saveTalentProcess")
    public Message saveTalentProcess(TalentTrain tt) {

        //判断登录人是否有人才培养审核权限
        String loginId = CommonUtil.getPersonId();
        String roleId = "1cf3168f-7238-4646-85f5-96ec41fe6a37";  //人才培养方案权限的id
        RoleEmpDeptRelation roleEmpDeptRelation = roleService.getEmpDeptByRoleIdAndPersonId(roleId, loginId);
        if (roleEmpDeptRelation != null) {
            tt.setChanger(CommonUtil.getPersonId());
            tt.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            majorService.saveTalentProcess(tt);
            return new Message(1, "审核通过", 1);
        } else {
            return new Message(0, "对不起，您没有审核权限！", 0);
        }
    }

    /**
     * 国家专业目录(内嵌页面)
     *
     * @return
     */
    @RequestMapping("/major/nationalMenuPage")
    public ModelAndView nationalMenuPage() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/nationalMenuPage");
        return mv;
    }

    @RequestMapping("/major/studentPractice")
    public ModelAndView studentPractice() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/studentPractice");
        return mv;
    }

    @RequestMapping("/major/adminPractice")
    public ModelAndView adminPractice() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/nationalMenuPage");
        return mv;
    }

    /**
     * 专业申报(内嵌页面)
     *
     * @return
     */
    @RequestMapping("/major/declareSystemPage")
    public ModelAndView declareSystemPage() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/declareSystemPage");
        return mv;
    }

    /**
     * 查询专业表
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/major/getMajorCodeIdList")
    public List<AutoComplete> getMajorCodeIdList() {
        return this.majorService.getMajorCodeIdList();
    }

    /**
     * 查询专业表
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/major/getMajorById")
    public Major getMajorById(String id) {
        return this.majorService.getMajorByMajorId(id);
    }

    /**
     * 专业教学团队导出数据
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/major/daochuData")
    public void getCmteListGroupByMajor(HttpServletResponse response, TalentTrain m) {

        this.majorLeaderService.expertExcel(response, m);
    }

    /**
     * 查看关联教学计划页
     */
    @ResponseBody
    @RequestMapping("/major/searchRelation")
    public ModelAndView searchRelation(String id) {
        ModelAndView mv = new ModelAndView("/core/major/searchRelationMajor");
        mv.addObject("head", "关联教学计划");
        mv.addObject("tid", id);
        //mv.addObject("tname",trainName);
        return mv;
    }

    /**
     * 查询关联sql
     */
    @ResponseBody
    @RequestMapping("/major/getrelationMajor")
    public Map<String, List<CoursePlan>> getrelationMajor(String id) {
        Map<String, List<CoursePlan>> tmap = new HashMap<String, List<CoursePlan>>();
        List<CoursePlan> list = majorService.getrelationMajor(id);
        tmap.put("data", list);
        return tmap;
    }

    /**
     * 到驳回页面
     */
    @RequestMapping("/major/toAgainst")
    public ModelAndView toAgainst(String id) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("talentTrainId", id);
        mv.setViewName("/core/major/talentAgainst");
        return mv;
    }


    /**
     * 保存驳回
     *
     * @param tt
     * @return
     */
    @ResponseBody
    @RequestMapping("/major/saveTalentAgainst")
    public Message saveTalentAgainst(TalentTrain tt) {
        tt.setChanger(CommonUtil.getPersonId());
        tt.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        majorService.saveTalentAgainst(tt);
        return new Message(1, "", null);
    }

    //内部排序类
    class ComparatorDate implements Comparator {
        public int compare(Object obj1, Object obj2) {
            Date begin = (Date) obj1;
            Date end = (Date) obj2;
            if (begin.after(end)) {
                return 1;
            } else {
                return -1;
            }
        }
    }


    @ResponseBody
    @RequestMapping("/major/getFilesByFileId")
    public Map getFilesByFileId(String fileId) {
        return CommonUtil.tableMap(majorService.getFilesByFileId(fileId));
    }
}
