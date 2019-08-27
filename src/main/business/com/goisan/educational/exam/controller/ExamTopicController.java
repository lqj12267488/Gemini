package com.goisan.educational.exam.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.exam.bean.ExamTopic;
import com.goisan.educational.exam.service.ExamTopicService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ExamTopicController {
    @Resource
    private ExamTopicService examTopicService;

    /**
     * 考试题库首页跳转
     * @return
     */
    @RequestMapping("/examTopic/examTopicList")
    public ModelAndView examTopicList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/exam/examtopic/examTopicList");
        return mv;
    }

    /**
     * 考试题库首页查询数据
     * @param examTopic
     * @return
     */
    @ResponseBody
    @RequestMapping("/examTopic/getExamTopicList")
    public Map<String, Object> getExamTopicList(ExamTopic examTopic,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String,Object> examTopicList = new HashMap<String, Object>();
        examTopic.setCreator(CommonUtil.getPersonId());
        examTopic.setChangeDept(CommonUtil.getDefaultDept());
        List<ExamTopic> list = examTopicService.examTopicAction(examTopic);
        PageInfo<List<ExamTopic>> info = new PageInfo(list);
        examTopicList.put("draw", draw);
        examTopicList.put("recordsTotal", info.getTotal());
        examTopicList.put("recordsFiltered", info.getTotal());
        examTopicList.put("data", list);
        //softInstallMap.put("data", examTopicService.examTopicAction(examTopic));
        return examTopicList;
    }

    /**
     * 新增考试题库
     * @return
     */
    @ResponseBody
    @RequestMapping("/examTopic/addExamTopic")
    public ModelAndView addExamTopicInstall() {
        ModelAndView mv = new ModelAndView("/business/educational/exam/examtopic/editExamTopic");
        mv.addObject("head", "新增考试题库");
        return mv;
    }

    /**
     * 考试名称自动完成框*/
    @ResponseBody
    @RequestMapping("/examTopic/getExamName")
    public List<AutoComplete> getExamName() {
        return examTopicService.getExamName();
    }

    /**
     * 考试题库修改跳转
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/examTopic/getExamTopicById")
    public ModelAndView getExamTopicById(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/exam/examtopic/editExamTopic");
        ExamTopic examTopic = examTopicService.getExamTopicById(id);
        mv.addObject("head", "考试题库修改");
        mv.addObject("examTopic", examTopic);
        return mv;
    }

    /**
     * 新增和修改保存
     * @param examTopic
     * @return
     */
    @ResponseBody
    @RequestMapping("/examTopic/saveExamTopic")
    public Message saveexamTopic(ExamTopic examTopic){
        if(examTopic.getId() == null || examTopic.equals("") || examTopic.getId() == ""){
            examTopic.setCreator(CommonUtil.getPersonId());
            examTopic.setCreateDept(CommonUtil.getDefaultDept());
            examTopicService.insertExamTopic(examTopic);
            return new Message(1, "新增成功！", null);
        }else{
            examTopic.setChanger(CommonUtil.getPersonId());
            examTopic.setChangeDept(CommonUtil.getDefaultDept());
            examTopicService.updateExamTopicById(examTopic);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/examTopic/deleteExamTopicById")
    public Message deleteExamTopicById(String id) {
        examTopicService.deleteExamTopicById(id);
        return new Message(1, "删除成功！", null);
    }
}
