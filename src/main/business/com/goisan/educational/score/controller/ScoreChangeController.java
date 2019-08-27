package com.goisan.educational.score.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.score.bean.ScoreChange;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.score.service.ScoreChangeService;
import com.goisan.evaluation.bean.EvaluationTask;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.EmpDeptRelation;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.service.WorkflowService;
import org.apache.ibatis.annotations.Param;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ScoreChangeController {

    @Resource
    private ScoreChangeService scoreChangeService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;

    /**
     * 成绩更改申请申请跳转
     * request by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/scoreChange/request")
    public ModelAndView scoreChangeList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreChange/scoreChange");
        return mv;
    }

    /**
     * 成绩更改申请URL
     * url by hanyue
     * modify by hanyue
     *
     * @param scoreChange
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreChange/getScoreChangeList")
    public Map<String, Object> getScoreChangeList(ScoreChange scoreChange, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> scoreChanges = new HashMap();
        scoreChange.setCreator(CommonUtil.getPersonId());
        scoreChange.setCreateDept(CommonUtil.getDefaultDept());
        List<ScoreChange> list = scoreChangeService.getScoreChangeList(scoreChange);
        PageInfo<List<ScoreChange>> info = new PageInfo(list);
        scoreChanges.put("draw", draw);
        scoreChanges.put("recordsTotal", info.getTotal());
        scoreChanges.put("recordsFiltered", info.getTotal());
        scoreChanges.put("data", list);
        return scoreChanges;
    }

    /**
     * 成绩更改申请新增
     * add by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/scoreChange/editScoreChange")
    public ModelAndView addScoreChange(String id) {
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date + 'T' + time;
        String personName = scoreChangeService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = scoreChangeService.getDeptNameById(CommonUtil.getDefaultDept());
        ScoreChange scoreChange = new ScoreChange();
        scoreChange.setRequester(personName);
        scoreChange.setRequestDate(datetime);
        scoreChange.setRequestDept(deptName);
        scoreChange.setTime(datetime);
//        ScoreImport scoreImport = scoreChangeService.getScoreImportById(id);
        ScoreImport scoreImport = scoreChangeService.getScoreImportById2(id);
        scoreChange.setExamTypes(scoreImport.getExamTypes());
        scoreChange.setDepartmentsId(scoreImport.getDepartmentsId());
        scoreChange.setMajorCode(scoreImport.getMajorCode());
        scoreChange.setCourseId(scoreImport.getCourseId());
        scoreChange.setClassId(scoreImport.getClassId());
        scoreChange.setStudentId(scoreImport.getStudentId());
        scoreChange.setTerm(scoreImport.getTermId());
        scoreChange.setScoreId(scoreImport.getId());
        scoreChange.setOriginalScore(scoreImport.getScore());
        scoreChange.setStudentNumber(scoreImport.getStudentId());
        scoreChange.setExaminationStatus(scoreImport.getExaminationStatus());

        ModelAndView mv = null;
        if ("1".equals(scoreImport.getExamTypes())) {
            mv = new ModelAndView("/business/educational/score/scoreChange/editScoreChange");
        } else {
            mv = new ModelAndView("/business/educational/score/scoreChange/editScoreChange2");
        }
        mv.addObject("head", "成绩更改申请新增");
        mv.addObject("scoreChange", scoreChange);
        mv.addObject("examMethod",scoreImport.getExamMethod());
        return mv;
    }

    /**
     * 成绩更改申请修改
     * update by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreChange/getScoreChangeById")
    public ModelAndView getScoreChangeById(String id) {
        ScoreChange scoreChange = scoreChangeService.getScoreChangeById(id);
        ScoreImport scoreImport = scoreChangeService.getScoreImportById2(scoreChange.getScoreId());
        scoreChange.setExamTypes(scoreImport.getExamTypes());
        if ("1".equals(scoreImport.getExamTypes())) {
            ModelAndView mv = new ModelAndView("/business/educational/score/scoreChange/editScoreChange");
            mv.addObject("head", "成绩更改申请修改");
            mv.addObject("scoreChange", scoreChange);
            return mv;
        } else {
            ModelAndView mv = new ModelAndView("/business/educational/score/scoreChange/editScoreChange2");
            mv.addObject("head", "成绩更改申请修改");
            mv.addObject("scoreChange", scoreChange);
            return mv;
        }
    }

    /**
     * 保存成绩更改申请
     * save by hanyue
     * modify by hanyue
     *
     * @param scoreChange
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreChange/saveScoreChange")
    public Message saveScoreChange(ScoreChange scoreChange) {
        if (scoreChange.getId() == null || scoreChange.getId().equals("")) {
            scoreChange.setCreator(CommonUtil.getPersonId());
            scoreChange.setCreateDept(CommonUtil.getDefaultDept());
            scoreChange.setRequester(CommonUtil.getPersonId());
            scoreChange.setRequestDept(CommonUtil.getDefaultDept());
            scoreChange.setId(CommonUtil.getUUID());
            scoreChangeService.insertScoreChange(scoreChange);
            return new Message(1, "新增成功！", null);
        } else {
            scoreChange.setRequester(CommonUtil.getPersonId());
            scoreChange.setRequestDept(CommonUtil.getDefaultDept());
            scoreChange.setChanger(CommonUtil.getPersonId());
            scoreChange.setChangeDept(CommonUtil.getDefaultDept());
            scoreChangeService.updateScoreChangeById(scoreChange);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 判断当前登录人 是否是教务处教师
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreChange/getScoreChangeByPersonId")
    public Boolean getScoreChangeByPersonId() {
        List<EmpDeptRelation> list = scoreChangeService.getEmployeeDeptByDeptIdPersonId(CommonUtil.getPersonId());
        if (list.size() > 0) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 删除成绩更改申请
     * delete by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreChange/deleteScoreChangeById")
    public Message deleteScoreChangeById(String id) {
        scoreChangeService.deleteScoreChangeById(id);
        return new Message(1, "删除成功！", null);
    }

    /**
     * 部门自动提示框
     * dept by hanyue
     * modify by hanyue
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreChange/autoCompleteDept")
    public List<AutoComplete> autoCompleteDept() {
        return scoreChangeService.autoCompleteDept();
    }

    /**
     * 人员自动提示框
     * person by hanyue
     * modify by hanyue
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreChange/autoCompleteEmployee")
    public List<AutoComplete> autoCompleteEmployee() {
        return scoreChangeService.autoCompleteEmployee();
    }

    /**
     * 代办业务跳转
     * agency business by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/scoreChange/process")
    public ModelAndView scoreChangeProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreChange/scoreChangeProcess");
        return mv;
    }

    /**
     * 代办业务初始化
     * agency business initialize by hanyue
     * modify by hanyue
     *
     * @param scoreChange
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreChange/getProcessList")
    public Map<String, Object> getProcessList(ScoreChange scoreChange, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> scoreChanges = new HashMap();
        scoreChange.setCreator(CommonUtil.getPersonId());
        scoreChange.setCreateDept(CommonUtil.getDefaultDept());
        scoreChange.setChanger(CommonUtil.getPersonId());
        scoreChange.setChangeDept(CommonUtil.getDefaultDept());
        List<ScoreChange> list = scoreChangeService.getProcessList(scoreChange);
        PageInfo<List<ScoreChange>> info = new PageInfo(list);
        scoreChanges.put("draw", draw);
        scoreChanges.put("recordsTotal", info.getTotal());
        scoreChanges.put("recordsFiltered", info.getTotal());
        scoreChanges.put("data", list);
        return scoreChanges;
    }

    /**
     * 已办业务跳转
     * already done business by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/scoreChange/complete")
    public ModelAndView scoreChangeComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreChange/scoreChangeComplete");
        return mv;
    }

    /**
     * 已办页面初始化
     * already done business initialize by hanyue
     * modify by hanyue
     *
     * @param scoreChange
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreChange/getCompleteList")
    public Map<String, Object> getCompleteList(ScoreChange scoreChange, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> scoreChanges = new HashMap();
        scoreChange.setCreator(CommonUtil.getPersonId());
        scoreChange.setCreateDept(CommonUtil.getDefaultDept());
        scoreChange.setChanger(CommonUtil.getPersonId());
        scoreChange.setChangeDept(CommonUtil.getDefaultDept());
        List<ScoreChange> list = scoreChangeService.getCompleteList(scoreChange);
        PageInfo<List<ScoreChange>> info = new PageInfo(list);
        scoreChanges.put("draw", draw);
        scoreChanges.put("recordsTotal", info.getTotal());
        scoreChanges.put("recordsFiltered", info.getTotal());
        scoreChanges.put("data", list);
        return scoreChanges;
    }

    /**
     * 待办修改
     * agency update by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreChange/auditScoreChangeEdit")
    public ModelAndView auditScoreChangeEdit(String id) {
        ScoreChange scoreChange = scoreChangeService.getScoreChangeById(id);
        ScoreImport scoreImport = scoreChangeService.getScoreImportById2(scoreChange.getScoreId());
        scoreChange.setExamTypes(scoreImport.getExamTypes());
        scoreChange.setExamMethod(scoreImport.getExamMethod());
        if ("1".equals(scoreImport.getExamTypes())) {
            ModelAndView mv = new ModelAndView("/business/educational/score/scoreChange/editScoreChangeProcess");
            mv.addObject("head", "修改");
            mv.addObject("scoreChange", scoreChange);
            return mv;
        } else {
            ModelAndView mv = new ModelAndView("/business/educational/score/scoreChange/editScoreChangeProcess2");
            mv.addObject("head", "修改");
            mv.addObject("scoreChange", scoreChange);
            return mv;
        }
    }

    /**
     * 查看流程轨迹
     * process trajectory by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreChange/auditScoreChangeById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/score/scoreChange/addScoreChangeProcess");
        ScoreChange scoreChange = scoreChangeService.getScoreChangeBy(id);
        mv.addObject("head", "审批");
        mv.addObject("scoreChange", scoreChange);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreChange/printScoreChange")
    public ModelAndView printScoreChange(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/score/scoreChange/printScoreChange");
        ScoreChange scoreChange = scoreChangeService.getScoreChangeBy(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_JW_SCORE_CHANGE_WF01");
        String state = stampService.getStateById(id);
        List<Handle> list = stampService.getHandlebyId(id);
        int size = list.size();
        mv.addObject("handleList", list);
        mv.addObject("size", size);
        mv.addObject("state", state);
        String requestDate = scoreChange.getRequestDate().replace("T", " ");
        String time = scoreChange.getTime().replace("T", " ");
        mv.addObject("requestDate", requestDate);
        mv.addObject("time", time);
        mv.addObject("scoreChange", scoreChange);
        mv.addObject("workflowName", workflowName);
        return mv;
    }


    /**
     * 成绩更改申请导出
     *
     * @param id
     * @param response
     */
    @RequestMapping("/scoreChange/resultScoreChange")
    public void toEvaluationResult(@Param("id") String id, HttpServletResponse response) {

        HSSFWorkbook workbook = new HSSFWorkbook();
        CellStyle cellStyle0 = workbook.createCellStyle();
        Sheet sheet = workbook.createSheet("成绩更改申请表");

        cellStyle0.setAlignment(HorizontalAlignment.CENTER);
        cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle0.setWrapText(true);
        HSSFFont font = workbook.createFont();
        font.setFontHeightInPoints((short) 20);
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        font.setFontName("宋体");
        cellStyle0.setFont(font);

        CellStyle cellStyle1 = workbook.createCellStyle();
        cellStyle1.setAlignment(HorizontalAlignment.CENTER);
        cellStyle1.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle1.setWrapText(true);
        HSSFFont font1 = workbook.createFont();
        font1.setFontHeightInPoints((short) 24);
        font1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        font1.setFontName("宋体");
        cellStyle1.setFont(font1);

        CellStyle cellStyle2 = workbook.createCellStyle();
        cellStyle2.setAlignment(HorizontalAlignment.CENTER);
        cellStyle2.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle2.setWrapText(true);
        HSSFFont font2 = workbook.createFont();
        font2.setFontHeightInPoints((short) 14);
        font2.setFontName("楷体_GB2312");
        cellStyle2.setFont(font2);

        CellStyle cellStyle3 = workbook.createCellStyle();
        cellStyle3.setAlignment(HorizontalAlignment.LEFT);
        cellStyle3.setVerticalAlignment(VerticalAlignment.TOP);
        cellStyle3.setWrapText(true);
        HSSFFont font3 = workbook.createFont();
        font3.setFontHeightInPoints((short) 14);
        font3.setFontName("楷体_GB2312");
        cellStyle3.setFont(font3);

        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 5));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 5));
        sheet.addMergedRegion(new CellRangeAddress(3, 3, 1, 2));
        sheet.addMergedRegion(new CellRangeAddress(3, 3, 4, 5));
        sheet.addMergedRegion(new CellRangeAddress(5, 5, 1, 2));
        sheet.addMergedRegion(new CellRangeAddress(5, 5, 4, 5));
        sheet.addMergedRegion(new CellRangeAddress(6, 6, 0, 5));
        sheet.addMergedRegion(new CellRangeAddress(7, 7, 0, 5));
        sheet.addMergedRegion(new CellRangeAddress(8, 8, 0, 5));
        sheet.addMergedRegion(new CellRangeAddress(9, 9, 0, 5));

        sheet.setColumnWidth(0, 14 * 256);
        sheet.setColumnWidth(1, 19 * 256);
        sheet.setColumnWidth(2, 14 * 256);
        sheet.setColumnWidth(3, 19 * 256);
        sheet.setColumnWidth(4, 14 * 256);
        sheet.setColumnWidth(5, 19 * 256);

        Row row0 = sheet.createRow(0);
        Row row1 = sheet.createRow(1);
        Row row2 = sheet.createRow(2);
        Row row3 = sheet.createRow(3);
        Row row4 = sheet.createRow(4);
        Row row5 = sheet.createRow(5);
        Row row6 = sheet.createRow(6);
        Row row7 = sheet.createRow(7);
        Row row8 = sheet.createRow(8);
        Row row9 = sheet.createRow(9);

        row2.setHeightInPoints(35);
        row3.setHeightInPoints(35);
        row4.setHeightInPoints(35);
        row5.setHeightInPoints(35);
        row6.setHeightInPoints(150);
        row7.setHeightInPoints(120);


        ScoreChange scoreChange = scoreChangeService.getScoreChangeBy(id);
        List<Handle> list = scoreChangeService.getHandleById(id);
        String s = scoreChangeService.getTeacherIdByCourseId(scoreChange);
        Cell cell00 = row0.createCell(0);
        cell00.setCellValue("白城职业技术学院（白城师范学院分院）");
        cell00.setCellStyle(cellStyle0);

        Cell cell1 = row1.createCell(0);
        cell1.setCellValue("成 绩 更 改 申 请 单");
        cell1.setCellStyle(cellStyle1);

        Cell cell20 = row2.createCell(0);
        cell20.setCellValue("系部");
        cell20.setCellStyle(cellStyle2);

        Cell cell21 = row2.createCell(1);
        cell21.setCellValue(scoreChange.getDepartmentsId());
        cell21.setCellStyle(cellStyle2);

        Cell cell22 = row2.createCell(2);
        cell22.setCellValue("专业");
        cell22.setCellStyle(cellStyle2);

        Cell cell23 = row2.createCell(3);
        cell23.setCellValue(scoreChange.getMajorCode());
        cell23.setCellStyle(cellStyle2);

        Cell cell24 = row2.createCell(4);
        cell24.setCellValue("班级");
        cell24.setCellStyle(cellStyle2);

        Cell cell25 = row2.createCell(5);
        cell25.setCellValue(scoreChange.getClassId());
        cell25.setCellStyle(cellStyle2);

        Cell cell30 = row3.createCell(0);
        cell30.setCellValue("学号");
        cell30.setCellStyle(cellStyle2);

        Cell cell31 = row3.createCell(1);
        cell31.setCellValue(scoreChange.getStudentNumber());
        cell31.setCellStyle(cellStyle2);

        Cell cell32 = row3.createCell(3);
        cell32.setCellValue("学生姓名");
        cell32.setCellStyle(cellStyle2);

        Cell cell33 = row3.createCell(4);
        cell33.setCellValue(scoreChange.getStudentId());
        cell33.setCellStyle(cellStyle2);

        Cell cell40 = row4.createCell(0);
        cell40.setCellValue("学期");
        cell40.setCellStyle(cellStyle2);

        Cell cell41 = row4.createCell(1);
        cell41.setCellValue(scoreChange.getTerm());
        cell41.setCellStyle(cellStyle2);

        Cell cell42 = row4.createCell(2);
        cell42.setCellValue("科目");
        cell42.setCellStyle(cellStyle2);

        Cell cell43 = row4.createCell(3);
        cell43.setCellValue(scoreChange.getCourseId());
        cell43.setCellStyle(cellStyle2);

        Cell cell44 = row4.createCell(4);
        cell44.setCellValue("任课教师");
        cell44.setCellStyle(cellStyle2);

        Cell cell45 = row4.createCell(5);
        cell45.setCellValue(s);
        cell45.setCellStyle(cellStyle2);

        Cell cell50 = row5.createCell(0);
        cell50.setCellValue("原始成绩");
        cell50.setCellStyle(cellStyle2);

        Cell cell51 = row5.createCell(1);
        cell51.setCellValue(scoreChange.getOriginalScore());
        cell51.setCellStyle(cellStyle2);

        Cell cell53 = row5.createCell(3);
        cell53.setCellValue("更改成绩");
        cell53.setCellStyle(cellStyle2);

        Cell cell54 = row5.createCell(4);
        cell54.setCellValue(scoreChange.getScore());
        cell54.setCellStyle(cellStyle2);
        String s1 = scoreChange.getTime();
        s1 = s1.substring(0, 10);
        String[] times = s1.split("-");
        s1 = times[0] + "年" + times[1] + "月" + times[2] + "日";
        Cell cell60 = row6.createCell(0);
        cell60.setCellValue("变更原因：" + scoreChange.getReason() + "\n\n\n\n\n                                                      " + s1);
        cell60.setCellStyle(cellStyle3);
        boolean flags = false;
        Cell cell70 = row7.createCell(0);
        Cell cell80 = row8.createCell(0);
        Cell cell90 = row9.createCell(0);
        for (Handle handlelist : list) {
            String name = handlelist.getHandleRole();
            String handleTime = handlelist.getHandleTime();
            String[] handleTimeList = handleTime.split("-");
            handleTime = handleTimeList[0] + "年" + handleTimeList[1] + "月" + handleTimeList[2] + "日";

            switch (name) {
                case "系主任":
                    if ("".equals(handlelist.getRemark()) || null == handlelist.getRemark()) {
                        cell70.setCellValue("系部意见：" + "" + "\n\n\n\n                                                      " + handleTime);
                        cell70.setCellStyle(cellStyle3);
                        flags = true;
                        break;
                    } else {
                        cell70.setCellValue("系部意见：" + handlelist.getRemark() + "\n\n\n\n                                                      " + handleTime);
                        cell70.setCellStyle(cellStyle3);
                        flags = true;
                        break;
                    }
                case "教务处管教学的副处长":
                    if ("".equals(handlelist.getRemark()) || null == handlelist.getRemark()) {
                        cell80.setCellValue("教务处主管副处长意见：" + "" + "\n\n\n\n                                                      " + handleTime);
                        cell80.setCellStyle(cellStyle3);
                        flags = true;
                        break;
                    } else {
                        cell80.setCellValue("教务处主管副处长意见：" + handlelist.getRemark() + "\n\n\n\n                                                      " + handleTime);
                        cell80.setCellStyle(cellStyle3);
                        flags = true;
                        break;
                    }
                case "教务处处长":
                    if (flags) {
                        row8.setHeightInPoints(150);
                        row9.setHeightInPoints(120);
                        if ("".equals(handlelist.getRemark()) || null == handlelist.getRemark()) {
                            cell90.setCellValue("教务处处长意见：" + "" + "\n\n\n\n                                                      " + handleTime);
                            cell90.setCellStyle(cellStyle3);
                        } else {
                            cell90.setCellValue("教务处处长意见：" + handlelist.getRemark() + "\n\n\n\n                                                      " + handleTime);
                            cell90.setCellStyle(cellStyle3);
                        }
                    } else {
                        cell70 = row7.createCell(0);
                        if ("".equals(handlelist.getRemark()) || null == handlelist.getRemark()) {
                            cell70.setCellValue("教务处处长意见：" + "" + "\n\n\n\n                                                      " + handleTime);
                            cell70.setCellStyle(cellStyle3);
                        } else {
                            cell70.setCellValue("教务处处长意见：" + handlelist.getRemark() + "\n\n\n\n                                                      " + handleTime);
                            cell70.setCellStyle(cellStyle3);
                        }
                    }
                    break;
                default:
                    break;
            }
        }


        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("成绩更改申请表.xls", "utf-8"));
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
