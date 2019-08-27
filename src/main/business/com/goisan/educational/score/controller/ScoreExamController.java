package com.goisan.educational.score.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.exam.bean.Exam;
import com.goisan.educational.exam.service.ExamService;
import com.goisan.educational.score.bean.ScoreExam;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.score.service.ScoreExamService;
import com.goisan.educational.score.service.ScoreMakeupService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
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
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wq on 2017/10/12.
 */
@Controller
public class ScoreExamController {
    @Resource
    private ScoreExamService scoreExamService;

    @Autowired
    private ExamService examService;

    @RequestMapping("/scoreExam/list")
    public ModelAndView scoreExamList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreExamList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreExam/getScoreExamList1")
    public Map<String, Object> getScoreExamList1(Exam exam, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> map = new HashMap<>();
        List<Exam> examList = examService.getExamList2(exam);
        PageInfo<List<Exam>> info = new PageInfo(examList);
        map.put("draw", draw);
        map.put("recordsTotal", info.getTotal());
        map.put("recordsFiltered", info.getTotal());
        map.put("data", examList);
        return map;
    }

    @ResponseBody
    @RequestMapping("/scoreExam/getScoreExamList")
    public Map<String, Object> getScoreExamList(ScoreExam scoreExam, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> scoreExams = new HashMap();
        scoreExam.setCreateDept(CommonUtil.getDefaultDept());
        scoreExam.setLevel(CommonUtil.getLoginUser().getLevel());
        List<ScoreExam> empList = scoreExamService.getScoreExamList(scoreExam);
        PageInfo<List<ScoreExam>> info = new PageInfo(empList);
        scoreExams.put("draw", draw);
        scoreExams.put("recordsTotal", info.getTotal());
        scoreExams.put("recordsFiltered", info.getTotal());
        scoreExams.put("data", empList);
        return scoreExams;
    }

    @ResponseBody
    @RequestMapping("/scoreExam/editScoreExam")
    public ModelAndView editScoreExam(String scoreExamId, String flag) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreExamEdit");
        if (scoreExamId == "" || scoreExamId == null) {
            mv.addObject("head", "新增");
        } else {
            ScoreExam scoreExam = scoreExamService.getScoreExamById(scoreExamId);
            mv.addObject("head", "修改");
            mv.addObject("scoreExam", scoreExam);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/scoreExam/saveScoreExam")
    public Message saveScoreExam(ScoreExam scoreExam) {
        if (scoreExam.getScoreExamId() == "") {
            scoreExam.setCreator(CommonUtil.getPersonId());
            scoreExam.setCreateDept(CommonUtil.getDefaultDept());
            scoreExamService.insertScoreExam(scoreExam);
            return new Message(1, "新增成功！", "success");
        } else {
            scoreExam.setChanger(CommonUtil.getPersonId());
            scoreExam.setChangeDept(CommonUtil.getDefaultDept());
            scoreExamService.updateScoreExamById(scoreExam);
            return new Message(1, "修改成功！", "success");
        }
    }

    @ResponseBody
    @RequestMapping("/scoreExam/deleteScoreExamById")
    public Message deleteScoreExamById(String scoreExamId) {
        scoreExamService.deleteScoreExamById(scoreExamId);
        return new Message(1, "删除成功！", "success");
    }

    //成绩表公开功能
    @ResponseBody
    @RequestMapping("/scoreExam/openScoreExam")
    public Message openScoreExam(String scoreExamId) {
        scoreExamService.openScoreExam(scoreExamId);
        return new Message(1, "公开成功!", "success");
    }

    //学生公开成绩表列表页面
    @RequestMapping("/scoreExam/openStuScoreExamList")
    public ModelAndView openScoreExamList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/openScoreExamList");
        return mv;
    }

    //学生公开成绩表列表查询
    @ResponseBody
    @RequestMapping("/scoreExam/getOpenScoreExamList")
    public Map<String, Object> getOpenScoreExamList(ScoreImport scoreImport, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> scoreImports = new HashMap();
        scoreImport.setPersonId(CommonUtil.getPersonId());
        List<ScoreImport> empList = scoreExamService.getStuOpenScoreExamList(scoreImport);
        PageInfo<List<ScoreImport>> info = new PageInfo(empList);
        scoreImports.put("draw", draw);
        scoreImports.put("recordsTotal", info.getTotal());
        scoreImports.put("recordsFiltered", info.getTotal());
        scoreImports.put("data", empList);
        Map<String, List<ScoreImport>> map = new HashMap<String, List<ScoreImport>>();
        return scoreImports;
    }

    //成绩列表展示页面
    @RequestMapping("/scoreExam/openScoreList")
    public ModelAndView openScoreList(String scoreExamId, String scoreExamName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/openScoreList");
        mv.addObject("scoreExamId", scoreExamId);
        mv.addObject("scoreExamName", scoreExamName);
        return mv;
    }

    //成绩列表查询
    @ResponseBody
    @RequestMapping("/scoreExam/getOpenScoreList")
    public Map<String, List<ScoreImport>> getOpenScoreList(ScoreImport scoreImport) {
        Map<String, List<ScoreImport>> map = new HashMap<String, List<ScoreImport>>();
        //map.put("data", scoreExamService.getOpenScoreList(scoreImport));
        scoreImport.setPersonId(CommonUtil.getPersonId());
        map.put("data", scoreExamService.getStuOpenScoreList(scoreImport));
        return map;
    }

    //成绩导出
    @ResponseBody
    @RequestMapping("/scoreExam/exportOpenScore")
    public void exportMakeupScore(HttpServletRequest request, HttpServletResponse response) {
        String type = request.getParameter("type");
        String term = request.getParameter("term");
        String scoreExamId = request.getParameter("scoreExamId");
        String scoreExamName = request.getParameter("scoreExamName");
        ScoreImport scoreImport = new ScoreImport();
        scoreImport.setScoreExamId(request.getParameter("scoreExamId"));
        scoreImport.setDepartmentsId(request.getParameter("departmentsId"));
        scoreImport.setMajorCode(request.getParameter("majorCode"));
        scoreImport.setCourseId("%" + request.getParameter("courseId") + "%");
        List<ScoreImport> list = new ArrayList<ScoreImport>();
        String fileName = "";
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet;
        //创建HSSFSheet对象
        sheet = wb.createSheet(scoreExamName);
        list = scoreExamService.getOpenScoreList(scoreImport);
        fileName = scoreExamName + ".xls";
        //创建HSSFRow对象
        int tmp = 0;
        HSSFRow row1 = sheet.createRow(tmp);
        row1.createCell(0).setCellValue(term);
        row1.createCell(3).setCellValue(scoreExamName);
        tmp++;

        HSSFRow row2 = sheet.createRow(tmp);
        row2.createCell(0).setCellValue("学生姓名");
        row2.createCell(1).setCellValue("课程");
        row2.createCell(2).setCellValue("成绩");
        row2.createCell(3).setCellValue("补考成绩");
        row2.createCell(4).setCellValue("毕业补考成绩");
        row2.createCell(5).setCellValue("毕业后补考成绩");
        row2.createCell(6).setCellValue("系部");
        row2.createCell(7).setCellValue("专业");
        row2.createCell(8).setCellValue("班级");
        tmp++;
        int i = 0;
        for (ScoreImport scoreImport1 : list) {
            HSSFRow row = sheet.createRow(tmp);
            row.createCell(0).setCellValue(scoreImport1.getStudentId());
            row.createCell(1).setCellValue(scoreImport1.getCourseId());
            row.createCell(2).setCellValue(scoreImport1.getScore());
            row.createCell(3).setCellValue(scoreImport1.getMakeupScore());
            row.createCell(4).setCellValue(scoreImport1.getGraduateMakeupScore());
            row.createCell(5).setCellValue(scoreImport1.getAfertGraduateMakeupScore());
            row.createCell(6).setCellValue(scoreImport1.getDepartmentsId());
            row.createCell(7).setCellValue(scoreImport1.getMajorCode());
            row.createCell(8).setCellValue(scoreImport1.getClassId());
            tmp++;
            i++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    (fileName, "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
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

    //教师公开成绩表列表页面
    @RequestMapping("/scoreExam/openTeaScoreExamList")
    public ModelAndView openTeaScoreExamList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/openTeaScoreExamList");
        return mv;
    }

    //教师公开成绩表列表查询
    @ResponseBody
    @RequestMapping("/scoreExam/getTeaOpenScoreExamList")
    public Map<String, Object> getTeaOpenScoreExamList(ScoreImport scoreImport, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> scoreImports = new HashMap();
        scoreImport.setCreateDept(CommonUtil.getDefaultDept());
        scoreImport.setLevel(CommonUtil.getLoginUser().getLevel());
        List<ScoreImport> list = scoreExamService.getTeaOpenScoreExamList(scoreImport);
        PageInfo<List<ScoreImport>> info = new PageInfo(list);
        scoreImports.put("draw", draw);
        scoreImports.put("recordsTotal", info.getTotal());
        scoreImports.put("recordsFiltered", info.getTotal());
        scoreImports.put("data", list);
        return scoreImports;
    }

    //教师成绩列表展示页面
    @RequestMapping("/scoreExam/openTeaScoreList")
    public ModelAndView openTeaScoreList(String scoreExamId, String scoreExamName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/openTeaScoreList");
        mv.addObject("scoreExamId", scoreExamId);
        mv.addObject("scoreExamName", scoreExamName);
        return mv;
    }

    //教师成绩列表查询
    @ResponseBody
    @RequestMapping("/scoreExam/getTeaOpenScoreList")
    public Map<String, List<ScoreImport>> getTeaOpenScoreList(ScoreImport scoreImport) {
        Map<String, List<ScoreImport>> map = new HashMap<String, List<ScoreImport>>();
        String loginId = CommonUtil.getPersonId();
        //查询角色
        //List<ScoreImport> list=scoreExamService.getScoreRoleByPersonId("",loginId);//任课教师
        List<ScoreImport> list = scoreExamService.getScoreRoleByPersonId("82e13e97-a05c-4284-adec-e3a308d869b2", loginId);//教务管理员
        List<ScoreImport> list2 = scoreExamService.getScoreRoleByPersonId("cca8fd90-8c32-4188-89bd-674b4dda2a6a", loginId);//系部主任
        List<ScoreImport> list3 = scoreExamService.getScoreRoleByPersonId("8ec3c7af-74be-4a09-a1d9-36dabf7b7a8c", loginId);//教务导员
        if (list.size() > 0) {
            scoreImport = scoreImport;
        } else if (list2.size() > 0) {
            scoreImport.setDepartmentsId(CommonUtil.getDefaultDept());
        } else if (list3.size() > 0) {
            scoreImport.setTeachingTeacherId(loginId);
        } else {
            scoreImport.setTeachingTeacherId(loginId);
        }
//        else if(list2.size()>0){
//            scoreImport.setPersonId(loginId);
//        }
        map.put("data", scoreExamService.getTeaOpenScoreList(scoreImport));
        return map;
    }

    //教师成绩列表展示三层页面
    @RequestMapping("/scoreExam/openTeaScoreList2")
    public ModelAndView openTeaScoreList2(ScoreImport scoreImport) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/openTeaScoreList2");
        mv.addObject("scoreExamId", scoreImport.getScoreExamId());
        mv.addObject("scoreExamName", scoreImport.getScoreExamName());
        mv.addObject("classId", scoreImport.getClassId());
        mv.addObject("courseId", scoreImport.getCourseId());
        return mv;
    }

    //教师成绩三层列表查询
    @ResponseBody
    @RequestMapping("/scoreExam/getTeaOpenScoreList2")
    public Map<String, List<ScoreImport>> getTeaOpenScoreList2(ScoreImport scoreImport) {
        Map<String, List<ScoreImport>> map = new HashMap<String, List<ScoreImport>>();
        List<ScoreImport> list = scoreExamService.getTeaOpenScoreList2(scoreImport);
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getPeacetimeScoreA() == null) {
                list.get(i).setPeacetimeScoreA("0");
            }
            if (list.get(i).getPeacetimeScoreB() == null) {
                list.get(i).setPeacetimeScoreB("0");
            }
            if (list.get(i).getPeacetimeScoreC() == null) {
                list.get(i).setPeacetimeScoreC("0");
            }
            if (list.get(i).getPeacetimeScoreD() == null) {
                list.get(i).setPeacetimeScoreD("0");
            }
            if (list.get(i).getScoreSum() == null) {
                list.get(i).setScoreSum("0");
            }
        }
        map.put("data", list);
        return map;
    }
}
