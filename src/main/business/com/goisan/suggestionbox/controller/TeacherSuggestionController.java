package com.goisan.suggestionbox.controller;

import com.goisan.suggestionbox.bean.ReplyForSuggestion;
import com.goisan.suggestionbox.bean.TeacherSuggestion;
import com.goisan.suggestionbox.service.TeacherSuggestionService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @descroption 教师意见
 * @author 郭千恺
 * @version v1.0
 * @date 2018/9/26 15:45
 */
@Controller
@RequestMapping("/suggestionBox/teacher")
public class TeacherSuggestionController {
    @Resource
    private TeacherSuggestionService teacherSuggestionService;

    /**
     * 获取意见列表页面
     * @return
     */
    @RequestMapping("/suggestionListPage")
    public ModelAndView suggestionListPage() {
        ModelAndView mv = new ModelAndView("/business/suggestionbox/teacher/suggestionList");
        return mv;
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/suggestionDel")
    public Message deleteById(String id) {
        teacherSuggestionService.del(id);
        return new Message(1, "删除成功！", "success");
    }

    /**
     * 获取意见列表
     * @return
     */
    @ResponseBody
    @RequestMapping("/getSuggestionList")
    public Map getSuggestionList(TeacherSuggestion teacherSuggestion) {
        teacherSuggestion.setCreator(CommonUtil.getPersonId());
        return CommonUtil.tableMap(this.teacherSuggestionService.getTeacherSuggestion(teacherSuggestion));
    }

    /**
     * 获取意见详情
     * @return
     */
    @ResponseBody
    @RequestMapping("/suggestionDetail")
    public ModelAndView suggestionDetail(String id) {
        TeacherSuggestion teacherSuggestion = this.teacherSuggestionService.getById(id);
        teacherSuggestionService.updateViewFlag(id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/suggestionbox/teacher/suggestionDetail");
        mv.addObject("head", "意见详情");
        mv.addObject("detail", teacherSuggestion);
        return mv;
    }

    /**
     * 获取回复列表页面
     * @param id
     * @return
     */
    @RequestMapping("/getReplyListPage")
    public ModelAndView getReplyListPage(String id) {
        TeacherSuggestion teacherSuggestion = this.teacherSuggestionService.getById(id);
        String title = teacherSuggestion.getTitle();

        ModelAndView mv=new ModelAndView("/business/suggestionbox/teacher/replyList");
        mv.addObject("suggestion", teacherSuggestion);
        return mv;
    }

    /**
     * 获取回复列表
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/getReplyList")
    public Map getReplyList(String id) {
        List<ReplyForSuggestion> replyList = this.teacherSuggestionService.getById(id).getReplyList();
        return CommonUtil.tableMap(replyList);
    }

    /**
     * 获取回复详情
     * @return
     */
    @ResponseBody
    @RequestMapping("/replyDetail")
    public ModelAndView replyDetail(String id) {
        ReplyForSuggestion replyForSuggestion = this.teacherSuggestionService.getReplyById(id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/suggestionbox/teacher/replyDetail");
        mv.addObject("head", "意见回复");
        mv.addObject("reply", replyForSuggestion);
        return mv;
    }

    /**
     * 新增意见页面
     * @return
     */
    @RequestMapping("/addSuggestion")
    public String addSuggestion() {
        return "/business/suggestionbox/teacher/addSuggestion";
    }

    /**
     * 新增意见
     * @param teacherSuggestion
     * @return
     */
    @ResponseBody
    @RequestMapping("/save")
    public boolean save(TeacherSuggestion teacherSuggestion) {
        teacherSuggestion.setReplyFlag("1");
        teacherSuggestion.setCreator(CommonUtil.getPersonId());
        teacherSuggestion.setCreateDept(CommonUtil.getDefaultDept());
        return this.teacherSuggestionService.save(teacherSuggestion);
    }

    /**
     * 按id获取意见
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/getById")
    public TeacherSuggestion getById(String id) {
        return this.teacherSuggestionService.getById(id);
    }

//    /**
//     * 删除意见
//     * @param id
//     * @return
//     */
//    @ResponseBody
//    @RequestMapping("/del")
//    public boolean del(String id) {
//        return this.teacherSuggestionService.del(id);
//    }
}
