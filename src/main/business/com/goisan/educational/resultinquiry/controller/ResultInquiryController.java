package com.goisan.educational.resultinquiry.controller;

import com.goisan.educational.exam.bean.Exam;
import com.goisan.educational.exam.service.ExamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ResultInquiryController {

    @Autowired
    private ExamService examService;

    @RequestMapping("/resultInquiry/resultInquiryList")
    public ModelAndView resultInquiryList(String type){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/educational/resultInquiry/resultInquiryList");
        mv.addObject("type",type);
        return mv;
    }

    @RequestMapping("/resultInquiry/import")
    public ModelAndView getResultInquiryList(String scoreExamId){
        ModelAndView mv= new ModelAndView();
        Exam exam = examService.selectExamById(scoreExamId);
        if(exam!=null){
            mv.addObject("scoreExamId",exam.getExamId());
            mv.addObject("scoreExamName",exam.getExamName());
            mv.addObject("term",exam.getTerm());
//            添加type
            mv.addObject("type",exam.getExamTypes());
            if("1".equals(exam.getExamTypes())){
                mv.addObject("scoreName","期末考试成绩");
            }else if("2".equals(exam.getExamTypes())){
                mv.addObject("scoreName","期末补考成绩");
            }else if("3".equals(exam.getExamTypes())){
                mv.addObject("scoreName","毕业前补考成绩");
            }else{
                mv.addObject("scoreName","毕业后补考成绩");
            }
            mv.setViewName("/business/educational/resultInquiry/resultInquiryExamList");
            return mv;
        }
        return null;
    }
}
