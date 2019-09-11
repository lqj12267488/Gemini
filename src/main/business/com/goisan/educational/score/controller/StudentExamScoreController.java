package com.goisan.educational.score.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.score.service.StudentExamScoreService;
import com.goisan.system.service.ParameterService;
import com.goisan.system.tools.CommonUtil;
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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wq on 2017/10/18.
 */
@Controller
public class StudentExamScoreController {
    @Resource
    StudentExamScoreService studentExamScoreService;
    @Resource
    ParameterService parameterService;
    @RequestMapping("/studentExamScore/studentExamList")
    public ModelAndView studentExamList(){
        ModelAndView mv= new ModelAndView();
        String flag="";
        List<ScoreImport> listrole = studentExamScoreService.getExamRole(CommonUtil.getPersonId());
        if(listrole.size()>0){
            flag="0";
        }else {
            flag="1";
        }
        mv.setViewName("/business/educational/score/studentExamList");
        mv.addObject("flag",flag);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/studentExamScore/getStudentExamList")
    public Map<String,Object> getStudentExamList(ScoreImport scoreImport, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> scoreImportss = new HashMap();

        Map<String,List<ScoreImport>> map=new HashMap<String, List<ScoreImport>>();
        scoreImport.setStudentId(CommonUtil.getPersonId());
        List<ScoreImport> list=studentExamScoreService.getStudentExamClassList(scoreImport);
        ScoreImport examClass=new ScoreImport();
        if(list.size()>0){
            examClass=list.get(0);
        }
        scoreImport.setTerm(parameterService.getParameterValue());
        List<ScoreImport> scoreImports=studentExamScoreService.getStudentExamList(scoreImport);
        for (int i=0;i<scoreImports.size();i++) {
            ScoreImport s=scoreImports.get(i);
            s.setDepartmentsId(examClass.getDepartmentsId());
            s.setMajorCode(examClass.getMajorCode());
            s.setTrainingLevel(examClass.getTrainingLevel());
            s.setClassId(examClass.getClassId());
            scoreImports.set(i,s);
        }
        PageInfo<List<ScoreImport>> info = new PageInfo(scoreImports);
        scoreImportss.put("draw", draw);
        scoreImportss.put("recordsTotal", info.getTotal());
        scoreImportss.put("recordsFiltered", info.getTotal());
        scoreImportss.put("data", scoreImports);
        return scoreImportss;
    }
    @RequestMapping("/studentExamScore/studentExamScoreList")
    public ModelAndView studentExamScoreList(String scoreExamId,String scoreExamName){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/educational/score/studentExamScoreList");
        mv.addObject("scoreExamId",scoreExamId);
        mv.addObject("scoreExamName",scoreExamName);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/studentExamScore/getStudentExamScoreList")
    public Map<String,List<ScoreImport>> getStudentExamScoreList(ScoreImport scoreImport){
        Map<String,List<ScoreImport>> map=new HashMap<String, List<ScoreImport>>();
        scoreImport.setStudentId(CommonUtil.getPersonId());
        map.put("data", studentExamScoreService.getStudentExamScoreList(scoreImport));
        return map;
    }
    //    导出成绩表
    @RequestMapping("/studentExamScore/exportList")
    public void exportStudent(HttpServletRequest request, HttpServletResponse response,String scoreExamId,String scoreExamName) {
        ScoreImport scoreImport = new ScoreImport();
        scoreImport.setScoreExamId(scoreExamId);
        scoreImport.setStudentId(CommonUtil.getPersonId());
        List<ScoreImport> list=studentExamScoreService.getStudentExamScoreList(scoreImport);
        ScoreImport s=new ScoreImport();
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("考试成绩单");
        //创建HSSFRow对象
        int rowNum = 0;
        HSSFRow row0 = sheet.createRow(rowNum);
        //创建HSSFCell对象
        row0.createCell(3).setCellValue(scoreExamName+"成绩单");
        rowNum++;
        if(list.size()>0) {
            s = list.get(0);
            HSSFRow row1 = sheet.createRow(rowNum);
            //创建HSSFCell对象
            row1.createCell(0).setCellValue("姓名："+s.getStudentName());
            row1.createCell(3).setCellValue("学号："+s.getStudentNum());
            rowNum++;

            HSSFRow row2 = sheet.createRow(rowNum);
            //创建HSSFCell对象
            row2.createCell(0).setCellValue("系部："+s.getDepartmentsId());
            row2.createCell(3).setCellValue("专业："+s.getMajorCode());
            row2.createCell(6).setCellValue("班级："+s.getClassName());
            rowNum++;

            HSSFRow row3 = sheet.createRow(rowNum);
            //创建HSSFCell对象
            row3.createCell(0).setCellValue("课程名称");
            row3.createCell(1).setCellValue("总分");
            row3.createCell(2).setCellValue("及格分");
            row3.createCell(3).setCellValue("考试状态");
            row3.createCell(4).setCellValue("成绩");
            row3.createCell(5).setCellValue("补考状态");
            row3.createCell(6).setCellValue("补考成绩");
            row3.createCell(7).setCellValue("毕业补考状态");
            row3.createCell(8).setCellValue("毕业补考成绩");
            rowNum++;
            for (ScoreImport score : list) {
                HSSFRow row = sheet.createRow(rowNum);
                //创建HSSFCell对象
                row.createCell(0).setCellValue(score.getCourseId());
                row.createCell(1).setCellValue(score.getTotalScore());
                row.createCell(2).setCellValue(score.getPassScore());
                row.createCell(3).setCellValue(score.getExaminationStatus());
                row.createCell(4).setCellValue(score.getScore());
                row.createCell(5).setCellValue(score.getMakeupStatus());
                row.createCell(6).setCellValue(score.getMakeupScore());
                row.createCell(7).setCellValue(score.getGraduateMakeupStatus());
                row.createCell(8).setCellValue(score.getGraduateMakeupScore());
                rowNum++;
            }
        }else{
            HSSFRow row1 = sheet.createRow(rowNum);
            //创建HSSFCell对象
            row1.createCell(0).setCellValue("您的本次考试成绩暂未录入！");
            rowNum++;
        }

        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String date = formatDate.format(new Date());
        HSSFRow rows = sheet.createRow(rowNum);
        //创建HSSFCell对象
        rows.createCell(7).setCellValue("打印日期："+date);
        rowNum++;

        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    (scoreExamName+"成绩单--"+ CommonUtil.getPersonName()+".xls", "utf-8"));
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
