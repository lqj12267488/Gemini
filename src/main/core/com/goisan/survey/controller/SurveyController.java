package com.goisan.survey.controller;

import com.goisan.survey.bean.Survey;
import com.goisan.survey.bean.SurveyOption;
import com.goisan.survey.bean.SurveyQuestion;
import com.goisan.survey.service.*;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

@Controller
public class SurveyController {

    @Resource
    private SurveyService surveyService;
    @Resource
    private SurveyQuestionService surveyQuestionService;
    @Resource
    private SurveyOptionService surveyOptionService;
    @Resource
    private SurveyPersonService surveyPersonService;
    @Resource
    private SurveyAnswerService surveyAnswerService;

    @RequestMapping("/survey/toSurveyList")
    public ModelAndView toList() {
        ModelAndView mv = new ModelAndView("/core/survey/surveyList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/getSurveyList")
    public Map getList(Survey survey) {
        return CommonUtil.tableMap(surveyService.getSurveyList(survey));
    }

    @RequestMapping("/survey/toSurveyAdd")
    public ModelAndView toAdd() {
        ModelAndView mv = new ModelAndView("/core/survey/surveyEdit");
        mv.addObject("head", "新增");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/saveSurvey")
    public Message save(Survey survey) {
        if ("".equals(survey.getSurveyId())) {
            survey.setSurveyId(CommonUtil.getUUID());
            CommonUtil.save(survey);
            surveyService.saveSurvey(survey);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(survey);
            surveyService.updateSurvey(survey);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/survey/toSurveyEdit")
    public ModelAndView toEdit(String id) {
        ModelAndView mv = new ModelAndView("/core/survey/surveyEdit");
        mv.addObject("head", "修改");
        mv.addObject("data", surveyService.getSurveyById(id));
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/delSurvey")
    public Message del(String id) {
        surveyService.delSurvey(id);
        return new Message(0, "删除成功！", null);
    }


    @RequestMapping("/survey/toSurveyPreview")
    public ModelAndView toSurveyPreview(String id) {
        ModelAndView mv = new ModelAndView("/core/survey/surveyPreview");
        mv.addObject("data", surveyService.getSurveyById(id));

        SurveyQuestion surveyQuestion = new SurveyQuestion();
        surveyQuestion.setSurveyId(id);
        List<SurveyQuestion> questionList = surveyQuestionService.getSurveyQuestionList(surveyQuestion);
        mv.addObject("questionList", questionList);

        SurveyOption surveyOption = new SurveyOption();
        surveyOption.setSurveyId(id);
//        List optionList = surveyOptionService.getSurveyOptionList(surveyOption);
//        mv.addObject("optionList",optionList);
        mv.addObject("surveyId", id);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/checkSurvey")
    public Message checkSurvey(Survey survey) {
        String msg = "";
        String checkQuestion = surveyQuestionService.checkQuestionBySurveyid(survey.getSurveyId());
        if (null == checkQuestion || checkQuestion.equals("0")) {
            msg = msg + "没有设置问题，";
        }
        List<SurveyOption> checkOption = surveyOptionService.checkOptionBySurveyid(survey.getSurveyId());
        if (null != checkOption) {
            String chectO = "";
            for (SurveyOption checkItem : checkOption) {
                if (null == checkItem.getOptionValue() ||
                        checkItem.getOptionValue().equals("0") ||
                        checkItem.getOptionValue().equals("")) {
                    chectO = chectO + checkItem.getOptionCode() + ",";
                }
            }
            if (!chectO.equals(""))
                msg = msg + chectO + "没有设置选项，";
        }
        String checkPerson = surveyPersonService.checkPersonBySurveyid(survey.getSurveyId());
        if (null == checkPerson || checkPerson.equals("0")) {
            msg = msg + "没有设置答卷人，";
        }

        if (msg.equals("")) {
            survey.setCheckFlag("1");
            CommonUtil.update(survey);
            surveyService.updateSurveyFlag(survey);
            return new Message(1, "验证成功！", "success");
        } else {
            return new Message(0, msg + "请先设置！", "error");
        }
    }

    @ResponseBody
    @RequestMapping("/survey/changeStartFlaf")
    public Message changeStartFlaf(Survey survey) {
        CommonUtil.update(survey);
        surveyService.updateSurveyFlag(survey);
        return new Message(1, "启动成功！", "success");
    }

    // 家长查看
    @RequestMapping("/survey/toSurveyListPerson")
    public ModelAndView toSurveyListPerson() {
        ModelAndView mv = new ModelAndView("/core/survey/parent/surveyListByParent");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/getSurveyListByPerson")
    public Map getListByPerson(Survey survey) {
        CommonUtil.save(survey);
        return CommonUtil.tableMap(surveyService.getSurveyListByPerson(survey));
    }

    @RequestMapping("/survey/toSurveyFill")
    public ModelAndView toSurveyFill(String id) {
        ModelAndView mv = new ModelAndView("/core/survey/parent/surveyFill");
        mv.addObject("data", surveyService.getSurveyById(id));

        SurveyQuestion surveyQuestion = new SurveyQuestion();
        surveyQuestion.setSurveyId(id);
        List questionList = surveyQuestionService.getSurveyQuestionList(surveyQuestion);
        mv.addObject("questionList", questionList);

        mv.addObject("questionListMap", CommonUtil.jsonUtil(questionList));

        SurveyOption surveyOption = new SurveyOption();
        surveyOption.setSurveyId(id);
        List optionList = surveyOptionService.getSurveyOptionList(surveyOption);
        mv.addObject("optionList", optionList);
        mv.addObject("surveyId", id);
        return mv;
    }

    @RequestMapping("/survey/toViewResult")
    public ModelAndView toViewResult(String id) {
        ModelAndView mv = new ModelAndView("/core/survey/viewResult");
        mv.addObject("data", surveyService.getSurveyById(id));
        SurveyQuestion surveyQuestion = new SurveyQuestion();
        surveyQuestion.setSurveyId(id);
        List questionList = surveyQuestionService.getSurveyQuestionList(surveyQuestion);
        mv.addObject("questionList", questionList);
        mv.addObject("surveyId", id);
        List personList = surveyPersonService.getSurveyPersonBySurveyId(id);
        mv.addObject("personList", personList);
        mv.addObject("colspan", questionList.size() + 1);

        List answerList = surveyAnswerService.surveyAnswerServiceBySurveyId(id);
        mv.addObject("answerList", CommonUtil.jsonUtil(answerList));
        return mv;
    }

    @RequestMapping("/survey/toOrderResult")
    public ModelAndView toOrderResult(String id) {
        ModelAndView mv = new ModelAndView("/core/survey/orderResult");
        mv.addObject("data", surveyService.getSurveyById(id));
        SurveyQuestion surveyQuestion = new SurveyQuestion();
        surveyQuestion.setSurveyId(id);
        List questionList = surveyQuestionService.getSurveyQuestionBySurveyId(id);
        mv.addObject("questionList", questionList);
        mv.addObject("surveyId", id);
        List personList = surveyPersonService.getSurveyPersonBySurveyId(id);
        mv.addObject("personList", personList);

        List answerList = surveyAnswerService.surveyAnswerServiceBySurveyId(id);
        mv.addObject("answerList", CommonUtil.jsonUtil(answerList));
        return mv;
    }

    /**
     * 就业调查统计首页
     *
     * @return
     */
    @RequestMapping("/survey/toSurveyStatisticsList")
    public ModelAndView toListStatistics() {
        ModelAndView mv = new ModelAndView("/core/survey/statistics/surveyListStatistics");
        return mv;
    }

    /**
     * 就业调查统计获取数据
     *
     * @param survey
     * @return
     */
    @ResponseBody
    @RequestMapping("/survey/getSurveyStatisticsList")
    public Map getListStatistics(Survey survey) {
        return CommonUtil.tableMap(surveyService.getSurveyList(survey));
    }

    /**
     * 就业调查统计详情首页
     *
     * @return
     */
    @RequestMapping("/survey/toSurveyEditStatistics")
    public ModelAndView toSurveyEditStatistics(String surveyId) {
        ModelAndView mv = new ModelAndView("/core/survey/statistics/toSurveyEditStatistics");
        mv.addObject("surveyId", surveyId);
        return mv;
    }

    /**
     * 就业调查统计详情获取数据
     *
     * @param survey
     * @return
     */
    @ResponseBody
    @RequestMapping("/survey/getSurveyStatisticsEditList")
    public Map getListEditStatistics(Survey survey) {
        return CommonUtil.tableMap(surveyService.getSurveyEditList(survey));
    }


    /**
     * 导出就业调查
     *
     * @param request
     * @param response
     */
    @ResponseBody
    @RequestMapping("/survey/exportSurvey")
    public void exportSurvey(HttpServletRequest request, HttpServletResponse response) {
        String surveyId = request.getParameter("surveyId");
        Survey survey = new Survey();
        survey.setSurveyId(surveyId);
        List<Survey> courseList = surveyService.getSurveyEditList(survey);
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        for (int t = 0; t < courseList.size(); t++) {
            //创建HSSFSheet对象
            HSSFSheet sheet = wb.createSheet(courseList.get(t).getDept() + "就业调查信息表");
            int tmp = 0;
            HSSFRow row0 = sheet.createRow(tmp);
            row0.createCell(0).setCellValue("");
            row0.createCell(1).setCellValue("系部");
            row0.createCell(2).setCellValue("专业");
            row0.createCell(3).setCellValue("班级");
            row0.createCell(4).setCellValue("学生姓名");
            row0.createCell(5).setCellValue("学号");
            row0.createCell(6).setCellValue("身份证号");
            row0.createCell(7).setCellValue("完成情况");
            tmp++;
            int i = 1;
            survey.setDepartmentsId(courseList.get(t).getDepartmentsId());
            List<Survey> surveyExport = surveyService.getSurveyExport(survey);
            for (Survey courseObj : surveyExport) {
                HSSFRow row = sheet.createRow(tmp);
                row.createCell(0).setCellValue(i);
                row.createCell(1).setCellValue(courseObj.getDept());
                row.createCell(2).setCellValue(courseObj.getMajor());
                row.createCell(3).setCellValue(courseObj.getClasses());
                row.createCell(4).setCellValue(courseObj.getStudentName());
                row.createCell(5).setCellValue(courseObj.getStudentNumber());
                row.createCell(6).setCellValue(courseObj.getStudentIdcard());
                row.createCell(7).setCellValue(courseObj.getCompletion());
                tmp++;
                i++;
            }
        }

        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("就业调查导出表.xls", "utf-8"));
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
