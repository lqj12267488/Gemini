package com.goisan.educational.skillappraisal.controller;

import com.goisan.educational.skillappraisal.bean.SkillAppraisal;
import com.goisan.educational.skillappraisal.service.SkillAppraisalService;
import com.goisan.system.bean.*;
import com.goisan.system.service.CommonService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class SkillAppraisalController {

    @Resource
    private SkillAppraisalService skillAppraisalService;

    @Resource
    private CommonService commonService;

    /**
     * 鉴定项目首页跳转
     *
     * @return
     */
    @RequestMapping("/skillAppraisal/skillAppraisalList")
    public ModelAndView skillList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/skillAppraisal/skillList");
        return mv;
    }

    /**
     * 鉴定项目首页查询数据
     *
     * @param skill
     * @return
     */
    @ResponseBody
    @RequestMapping("/skillAppraisal/getskillAppraisalList")
    public Map<String, List<SkillAppraisal>> getSkillList(SkillAppraisal skill) {
        Map<String, List<SkillAppraisal>> softInstallMap = new HashMap<String, List<SkillAppraisal>>();
        skill.setCreator(CommonUtil.getPersonId());
        skill.setChangeDept(CommonUtil.getDefaultDept());
        softInstallMap.put("data", skillAppraisalService.skillAppraisal(skill));
        return softInstallMap;
    }

    /**
     * 新增鉴定项目
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/skillAppraisal/addskillAppraisal")
    public ModelAndView addSkillInstall() {
        ModelAndView mv = new ModelAndView("/business/educational/skillAppraisal/editSkill");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String date = formatDate.format(new Date());
        SkillAppraisal skill = new SkillAppraisal();
        mv.addObject("head", "新增鉴定项目");
        mv.addObject("skill", skill);
        return mv;
    }

    /**
     * 鉴定项目修改跳转
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/skillAppraisal/getskillAppraisalById")
    public ModelAndView getSkillById(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/skillAppraisal/editSkill");
        SkillAppraisal skill = skillAppraisalService.getSkillAppraisalById(id);
        mv.addObject("head", "鉴定项目修改");
        mv.addObject("skill", skill);
        return mv;
    }

    /**
     * 新增和修改保存
     *
     * @param skill
     * @return
     */
    @ResponseBody
    @RequestMapping("/skillAppraisal/saveSkillAppraisal")
    public Message saveskill(SkillAppraisal skill) {
        if (skill.getId() == null || skill.equals("") || skill.getId() == "") {
            skill.setCreator(CommonUtil.getPersonId());
            skill.setCreateDept(CommonUtil.getDefaultDept());
            skillAppraisalService.insertSkillAppraisal(skill);
            return new Message(1, "新增成功！", null);
        } else {
            skill.setChanger(CommonUtil.getPersonId());
            skill.setChangeDept(CommonUtil.getDefaultDept());
            skillAppraisalService.updateSkillApprraisalById(skill);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 删除
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/skillAppraisal/deleteSkillAppraisalById")
    public Message deleteSkillById(String id) {
        skillAppraisalService.deleteSkillAppraisalById(id);
        return new Message(1, "删除成功！", null);
    }

    /**
     * 鉴定项目首页跳转
     *
     * @return
     */
    @RequestMapping("/skillAppraisal/skillAppraisalCount")
    public ModelAndView skillListCount() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/skillAppraisal/skillCount");
        return mv;
    }

    /**
     * 鉴定项目统计查询数据
     *
     * @param skill
     * @return
     */
    @ResponseBody
    @RequestMapping("/skillAppraisal/getskillAppraisalCount")
    public Map<String, List<SkillAppraisal>> getSkillCount(SkillAppraisal skill) {
        Map<String, List<SkillAppraisal>> softInstallMap = new HashMap<String, List<SkillAppraisal>>();
        skill.setCreator(CommonUtil.getPersonId());
        skill.setChangeDept(CommonUtil.getDefaultDept());
        softInstallMap.put("data", skillAppraisalService.skillAppraisalCount(skill));
        return softInstallMap;
    }


    /**
     * 鉴定项目首页跳转
     *
     * @return
     */
    @RequestMapping("/skillAppraisal/scoreSituation")
    public ModelAndView scoreSituation() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/skillAppraisal/scoreSituation");
        return mv;
    }

    /**
     * 鉴定项目首页查询数据
     *
     * @param skill
     * @return
     */
    @ResponseBody
    @RequestMapping("/skillAppraisal/getScoreSituation")
    public Map<String, List<SkillAppraisal>> getScoreSituation(SkillAppraisal skill) {
        Map<String, List<SkillAppraisal>> softInstallMap = new HashMap<String, List<SkillAppraisal>>();
        skill.setCreator(CommonUtil.getPersonId());
        skill.setChangeDept(CommonUtil.getDefaultDept());
        softInstallMap.put("data", skillAppraisalService.scoreSituation(skill));
        return softInstallMap;
    }


    @ResponseBody
    @RequestMapping("/saveSkillAppraisalScore")
    private Message saveLoginPwd(SkillAppraisal skillAppraisal) {
        String score = skillAppraisal.getScore();
        skillAppraisal.setChangeDept(CommonUtil.getDefaultDept());
        skillAppraisal.setChanger(CommonUtil.getPersonId());
        skillAppraisalService.updateScoreSituationById(skillAppraisal);
        return new Message(1, "成功！", null);
    }


    @RequestMapping("/toImportSkillAppraisal")
    public String toImportEmp() {
        return "/business/educational/skillAppraisal/imSkillAppraisal";
    }
    private int getRealLastRowNum(Workbook workbook) {
        Sheet sheetAt = workbook.getSheetAt(0);
        int lastRowNum = sheetAt.getLastRowNum();

        Row row = sheetAt.getRow(0);
        int realLastRowNum = 0;
        error:
        for (int i = 0; i < lastRowNum; i++) {
            StringBuilder str = new StringBuilder();
            for (int j = 0; j < sheetAt.getRow(0).getPhysicalNumberOfCells(); j++) {
                Cell cell = sheetAt.getRow(i).getCell(j);
                try {
                    cell.setCellType(CellType.STRING);
                    str.append(cell.getStringCellValue());
                }
                catch (Exception e)
                {
                    break error;
                }

            }
            if (!"".equals(str.toString().replaceAll(" ", "")))
            {
                realLastRowNum = realLastRowNum + 1;
            }
        }
        System.err.println("----------------------> 真实行数 "+realLastRowNum);
        return realLastRowNum;

    }

    /**
     * 导入数据 鉴定
     *
     * @param file
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("/skillAppraisal/importSkillAppraisal")
    public Message importSkillAppraisal(@RequestParam(value = "file", required = false) CommonsMultipartFile file
    ) {
        List<Select2> xzs = commonService.getSysDict("ZXZYXZ", "");
        TableDict tableDict1 = new TableDict();
        tableDict1.setId("major_code");
        tableDict1.setText("major_name");
        tableDict1.setTableName("T_XG_MAJOR");
        tableDict1.setWhere("  WHERE VALID_FLAG='1' ");
        List<Select2> zy = commonService.getTableDict(tableDict1);

        TableDict tableDict2 = new TableDict();
        tableDict2.setId("class_id");
        tableDict2.setText("class_name");
        tableDict2.setTableName("T_XG_ClASS");
        tableDict2.setWhere("  WHERE VALID_FLAG='1' ");
        List<Select2> bj = commonService.getTableDict(tableDict2);

        TableDict tableDict3 = new TableDict();
        tableDict3.setId("id");
        tableDict3.setText("PROJECT_NAME");
        tableDict3.setTableName("T_JW_SKILL");
        tableDict3.setWhere("  WHERE VALID_FLAG='1' ");
        List<Select2> xm = commonService.getTableDict(tableDict3);
        int count = 0;
        HSSFWorkbook workbook = null;
        try {
            workbook = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = getRealLastRowNum(workbook);
            for (int i = 2; i < end; i++) {
                HSSFRow row = sheet.getRow(i);
                SkillAppraisal skillAppraisal = new SkillAppraisal();
                for (Select2 major : zy) {
                    if (major.getText().equals(row.getCell(0).toString().substring(1, row.getCell(0).toString().length()))) {
                        skillAppraisal.setMajor(major.getId());
                    }
                }
                for (Select2 grade : bj) {
                    if (grade.getText().equals(CommonUtil.changeToString(row.getCell(1)))) {
                        skillAppraisal.setGrade(grade.getId());
                    }
                }
                if ("".equals(CommonUtil.changeToString(row.getCell(2))) || null == CommonUtil.changeToString(row.getCell(2))) {
                    try {
                        skillAppraisal.setEntranceDate("");
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }
                } else {
                    skillAppraisal.setEntranceDate(row.getCell(2).toString());
                }
                for (Select2 xz : xzs) {
                    if (xz.getText().equals(row.getCell(3).toString())) {
                        skillAppraisal.setSchoolSystem(xz.getId());
                    }
                }

                for (Select2 mc : xm) {
                    if (mc.getText().equals(row.getCell(4).toString())) {
                        skillAppraisal.setPreAppProfession(mc.getId());
                    }
                }

                //skillAppraisal.setPreAppProfession(row.getCell(4).toString());
                if ("".equals(CommonUtil.changeToString(row.getCell(5))) || null == CommonUtil.changeToString(row.getCell(5))) {
                    try {
                        skillAppraisal.setProfessionLevel("");
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }
                } else {
                    skillAppraisal.setProfessionLevel(row.getCell(5).toString());
                }
                // skillAppraisal.setProfessionLevel(row.getCell(5).toString());
                // skillAppraisal.setStudentName(row.getCell(6).toString());
                if ("".equals(CommonUtil.changeToString(row.getCell(6))) || null == CommonUtil.changeToString(row.getCell(6))) {
                    try {
                        skillAppraisal.setStudentName("");
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }
                } else {
                    skillAppraisal.setStudentName(row.getCell(6).toString());
                }

                if ("".equals(CommonUtil.changeToString(row.getCell(7))) || null == CommonUtil.changeToString(row.getCell(7))) {
                    try {
                        skillAppraisal.setPreAppDate("");
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }
                } else {
                    skillAppraisal.setPreAppDate(row.getCell(7).toString());
                }


                if ("".equals(CommonUtil.changeToString(row.getCell(8))) || null == CommonUtil.changeToString(row.getCell(8))) {
                    try {
                        skillAppraisal.setProjectLevel("");
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }
                } else {
                    skillAppraisal.setProjectLevel(row.getCell(8).toString());
                }

                if ("".equals(CommonUtil.changeToString(row.getCell(9))) || null == CommonUtil.changeToString(row.getCell(9))) {
                    try {
                        skillAppraisal.setIssuingOffice("");
                    } catch (NullPointerException e1) {
                        e1.printStackTrace();
                    }
                } else {
                    skillAppraisal.setIssuingOffice(row.getCell(9).toString());
                }
               /* skillAppraisal.setPreAppDate(row.getCell(6).toString());
                skillAppraisal.setProjectLevel(row.getCell(7).toString());
                skillAppraisal.setIssuingOffice(row.getCell(8).toString());*/
                skillAppraisalService.insertSkillAppraisal(skillAppraisal);
                count++;
            }
        } catch (Exception e) {
            e.printStackTrace();
            String msg = "导入" + count + "条成功，第" + (count + 1) + "条数据异常。导入失败！";
            return new Message(0, msg, null);
        }

        return new Message(1, "共计" + count + "条，导入成功！", "success");
    }

    /**
     * 判断是否可以符合导入条件
     */
    @ResponseBody
    @RequestMapping("/skillAppraisal/checkIsImport")
    public Message checkIsImport() {
       /* String result=this.skillAppraisalService.checkIsImport();
        if(result.length()!=0){
            return new Message(0, result+"，以上专业无班级信息，请进行维护！",null);
        }*/
        return new Message(1, null, null);
    }

    /**
     * 导出模板 鉴定项目
     *
     * @param response
     */
    @RequestMapping("/skillAppraisal/getSkillAppraisalExcelTemplate")
    public void getStudentExcelTemplate(HttpServletResponse response) {
        this.skillAppraisalService.getStudentExcelTemplate(response);
    }

    /**
     * 导出鉴定项目列表 导出数据
     *
     * @param request
     * @param response
     */
    @RequestMapping("/skillAppraisal/exportSkillAppraisalt")
    public void exportStudent(HttpServletRequest request, HttpServletResponse response) {
        SkillAppraisal skillAppraisal = new SkillAppraisal();
        List<SkillAppraisal> skillS = skillAppraisalService.skillAppraisal(skillAppraisal);

        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("sheet0");

        //创建HSSFRow对象
        int tmp = 0;
        HSSFRow row0 = sheet.createRow(tmp);
       /* //创建HSSFCell对象
        row0.createCell(0).setCellValue("说明：此项为必填项");
        row0.createCell(1).setCellValue("说明：此项为必填项");
        row0.createCell(2).setCellValue("说明：此项为必填项(格式1999-01)");
        row0.createCell(3).setCellValue("说明：此项为必填项");
        row0.createCell(4).setCellValue("说明：此项为必填项");
        row0.createCell(5).setCellValue("说明：此项为必填项");
        row0.createCell(6).setCellValue("说明：此项为必填项");
        row0.createCell(7).setCellValue("说明：此项为必填项(格式1999-01-01)");
        row0.createCell(8).setCellValue("说明：此项为必填项");
        row0.createCell(9).setCellValue("说明：此项为必填项");
        tmp++;
*/
        /*HSSFRow row1 = sheet.createRow(tmp);*/
        //创建HSSFCell对象
        row0.createCell(0).setCellValue("专业");
        row0.createCell(1).setCellValue("班级");
        row0.createCell(2).setCellValue("入学时间");
        row0.createCell(3).setCellValue("学制");
        row0.createCell(4).setCellValue("项目名称");
        row0.createCell(5).setCellValue("级别");
        row0.createCell(6).setCellValue("姓名");
        row0.createCell(7).setCellValue("拟鉴定时间");
        row0.createCell(8).setCellValue("项目级别");
        row0.createCell(9).setCellValue("发证机关");
        tmp++;

        for (SkillAppraisal skillAppraisalobj : skillS) {
            HSSFRow row = sheet.createRow(tmp);
            //创建HSSFCell对象
            row.createCell(0).setCellValue(skillAppraisalobj.getMajorShow());
            row.createCell(1).setCellValue(skillAppraisalobj.getGradeShow());
            row.createCell(2).setCellValue(skillAppraisalobj.getEntranceDate());
            row.createCell(3).setCellValue(skillAppraisalobj.getSchoolSystemShow());
            row.createCell(4).setCellValue(skillAppraisalobj.getPreAppProfessionShow());
            row.createCell(5).setCellValue(skillAppraisalobj.getProfessionLevel());
            row.createCell(6).setCellValue(skillAppraisalobj.getStudentNameShow());
            row.createCell(7).setCellValue(skillAppraisalobj.getPreAppDate());
            row.createCell(8).setCellValue(skillAppraisalobj.getProjectLevel());
            row.createCell(9).setCellValue(skillAppraisalobj.getIssuingOffice());
            tmp++;

            /*row.createCell(4).setCellValue(skillAppraisalobj.format(studentobj.getBirthday()));*/
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("鉴定项目申请信息.xls", "utf-8"));
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
     * 导出鉴定项目统计 导出数据
     *
     * @param request
     * @param response
     */
    @RequestMapping("/skillAppraisal/exportSkillAppraisaltCount")
    public void exportskillCount(HttpServletRequest request, HttpServletResponse response) {
        SkillAppraisal skillAppraisal = new SkillAppraisal();
        List<SkillAppraisal> skillS = skillAppraisalService.skillAppraisalCount(skillAppraisal);

        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("sheet0");

        //创建HSSFRow对象
        int tmp = 0;
        HSSFRow row0 = sheet.createRow(tmp);
     /*   //创建HSSFCell对象
        row0.createCell(0).setCellValue("说明：此项为必填项");
        row0.createCell(1).setCellValue("说明：此项为必填项(格式1999-01)");
        row0.createCell(2).setCellValue("说明：此项为必填项");
        row0.createCell(3).setCellValue("说明：此项为必填项");
        row0.createCell(4).setCellValue("说明：此项为必填项");
        row0.createCell(5).setCellValue("说明：此项为必填项");
        row0.createCell(6).setCellValue("说明：此项为必填项(格式1999-01-01)");
        row0.createCell(7).setCellValue("说明：此项为必填项");
        row0.createCell(8).setCellValue("说明：此项为必填项");
        tmp++;

        HSSFRow row1 = sheet.createRow(tmp);*/
        //创建HSSFCell对象
        row0.createCell(0).setCellValue("专业");
        row0.createCell(1).setCellValue("入学时间");
        row0.createCell(2).setCellValue("学制");
        row0.createCell(3).setCellValue("项目名称");
        row0.createCell(4).setCellValue("级别");
        row0.createCell(5).setCellValue("人数");
        row0.createCell(6).setCellValue("拟鉴定时间");
        row0.createCell(7).setCellValue("项目级别");
        row0.createCell(8).setCellValue("发证机关");
        tmp++;

        for (SkillAppraisal skillAppraisalobj : skillS) {
            HSSFRow row = sheet.createRow(tmp);
            //创建HSSFCell对象
            row.createCell(0).setCellValue(skillAppraisalobj.getMajor());
            row.createCell(1).setCellValue(skillAppraisalobj.getEntranceDate());
            row.createCell(2).setCellValue(skillAppraisalobj.getSchoolSystemShow());
            row.createCell(3).setCellValue(skillAppraisalobj.getPreAppProfession());
            row.createCell(4).setCellValue(skillAppraisalobj.getProfessionLevel());
            row.createCell(5).setCellValue(skillAppraisalobj.getPeopleNumber());
            row.createCell(6).setCellValue(skillAppraisalobj.getPreAppDate());
            row.createCell(7).setCellValue(skillAppraisalobj.getProjectLevel());
            row.createCell(8).setCellValue(skillAppraisalobj.getIssuingOffice());
            tmp++;

            /*row.createCell(4).setCellValue(skillAppraisalobj.format(studentobj.getBirthday()));*/
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("鉴定项目统计信息.xls", "utf-8"));
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
     * 导出鉴定项目列表 导出数据
     *
     * @param request
     * @param response
     */
    @RequestMapping("/skillAppraisal/exportScoreSituation")
    public void exportScoreSituation(HttpServletRequest request, HttpServletResponse response) {
        SkillAppraisal skillAppraisal = new SkillAppraisal();
        List<SkillAppraisal> skillS = skillAppraisalService.scoreSituation(skillAppraisal);

        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("sheet0");

        //创建HSSFRow对象
        int tmp = 0;
        HSSFRow row0 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row0.createCell(0).setCellValue("说明：此项为必填项");
        row0.createCell(1).setCellValue("说明：此项为必填项");
        row0.createCell(2).setCellValue("说明：此项为必填项(格式1999-01)");
        row0.createCell(3).setCellValue("说明：此项为必填项");
        row0.createCell(4).setCellValue("说明：此项为必填项");
        row0.createCell(5).setCellValue("说明：此项为必填项");
        row0.createCell(6).setCellValue("说明：此项为必填项");
        row0.createCell(7).setCellValue("说明：此项为必填项(格式1999-01-01)");
        row0.createCell(8).setCellValue("说明：此项为必填项");
        row0.createCell(9).setCellValue("说明：此项为必填项");
        row0.createCell(10).setCellValue("说明：此项为必填项");
        tmp++;

        HSSFRow row1 = sheet.createRow(tmp);
        //创建HSSFCell对象
        row1.createCell(0).setCellValue("专业");
        row1.createCell(1).setCellValue("班级");
        row1.createCell(2).setCellValue("入学时间");
        row1.createCell(3).setCellValue("学制");
        row1.createCell(4).setCellValue("项目名称");
        row1.createCell(5).setCellValue("级别");
        row1.createCell(6).setCellValue("姓名");
        row1.createCell(7).setCellValue("拟鉴定时间");
        row1.createCell(8).setCellValue("成绩");
        row1.createCell(9).setCellValue("项目级别");
        row1.createCell(10).setCellValue("发证机关");
        tmp++;

        for (SkillAppraisal skillAppraisalobj : skillS) {
            HSSFRow row = sheet.createRow(tmp);
            //创建HSSFCell对象
            row.createCell(0).setCellValue(skillAppraisalobj.getMajor());
            row.createCell(1).setCellValue(skillAppraisalobj.getGrade());
            row.createCell(2).setCellValue(skillAppraisalobj.getEntranceDate());
            row.createCell(3).setCellValue(skillAppraisalobj.getSchoolSystemShow());
            row.createCell(4).setCellValue(skillAppraisalobj.getPreAppProfession());
            row.createCell(5).setCellValue(skillAppraisalobj.getProfessionLevel());
            row.createCell(6).setCellValue(skillAppraisalobj.getStudentName());
            row.createCell(7).setCellValue(skillAppraisalobj.getPreAppDate());
            row.createCell(8).setCellValue(skillAppraisalobj.getScoreShow());
            row.createCell(9).setCellValue(skillAppraisalobj.getProjectLevel());
            row.createCell(10).setCellValue(skillAppraisalobj.getIssuingOffice());
            tmp++;

            /*row.createCell(4).setCellValue(skillAppraisalobj.format(studentobj.getBirthday()));*/
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("成绩情况信息.xls", "utf-8"));
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
