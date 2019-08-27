package com.goisan.educational.exam.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.exam.bean.TestPaperAnalysis;
import com.goisan.educational.exam.service.TestPaperAnalysisService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class TestPaperAnalysisController {

    @Resource
    private TestPaperAnalysisService testPaperAnalysisService;

    @RequestMapping("/testPaperAnalysis/toTestPaperAnalysisList")
    public String toList() {
        return "/business/educational/exam/testPaperAnalysis/testPaperAnalysisList";
    }

    @ResponseBody
    @RequestMapping("/testPaperAnalysis/getTestPaperAnalysisList")
    public Map<String, Object> getList(TestPaperAnalysis testPaperAnalysis, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> testPaperAnalysiss = new HashMap();
        List<BaseBean> empList = testPaperAnalysisService.getTestPaperAnalysisList(testPaperAnalysis);
        PageInfo<List<TestPaperAnalysis>> info = new PageInfo(empList);
        testPaperAnalysiss.put("draw", draw);
        testPaperAnalysiss.put("recordsTotal", info.getTotal());
        testPaperAnalysiss.put("recordsFiltered", info.getTotal());
        testPaperAnalysiss.put("data", empList);
        return testPaperAnalysiss;
    }

    @RequestMapping("/testPaperAnalysis/toTestPaperAnalysisAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/business/educational/exam/testPaperAnalysis/testPaperAnalysisEdit";
    }

    @ResponseBody
    @RequestMapping("/testPaperAnalysis/saveTestPaperAnalysis")
    public Message save(TestPaperAnalysis testPaperAnalysis) {
        if ("".equals(testPaperAnalysis.getId())) {
            testPaperAnalysis.setId(CommonUtil.getUUID());
            CommonUtil.save(testPaperAnalysis);
            testPaperAnalysisService.saveTestPaperAnalysis(testPaperAnalysis);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(testPaperAnalysis);
            testPaperAnalysisService.updateTestPaperAnalysis(testPaperAnalysis);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/testPaperAnalysis/toTestPaperAnalysisEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", testPaperAnalysisService.getTestPaperAnalysisById(id));
        model.addAttribute("head", "修改");
        return "/business/educational/exam/testPaperAnalysis/testPaperAnalysisEdit";
    }

    @ResponseBody
    @RequestMapping("/testPaperAnalysis/delTestPaperAnalysis")
    public Message del(String id) {
        testPaperAnalysisService.delTestPaperAnalysis(id);
        return new Message(0, "删除成功！", null);
    }

    @RequestMapping("/testPaperAnalysis/toTestPaperAnalysisSearch")
    public String toTestPaperAnalysisSearch(String id, Model model) {
        model.addAttribute("data", testPaperAnalysisService.getTestPaperAnalysisById(id));
        model.addAttribute("head", "预览");
        return "/business/educational/exam/testPaperAnalysis/testPaperAnalysisSearch";
    }
    /**
     * PC端打印
     */
    @ResponseBody
    @RequestMapping("/testPaperAnalysis/printTestPaperAnalysis")
    public ModelAndView printTestPaperAnalysis(String id) {
        TestPaperAnalysis testPaperAnalysis = testPaperAnalysisService.getTestPaperAnalysisById(id);
        ModelAndView mv = new ModelAndView("/business/educational/exam/testPaperAnalysis/printTestPaperAnalysis");
        mv.addObject("data", testPaperAnalysis);
        return mv;
    }
}
