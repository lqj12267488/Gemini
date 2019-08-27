package com.goisan.suggestionbox.controller;

import com.goisan.suggestionbox.bean.ReplyForSuggestion;
import com.goisan.suggestionbox.bean.TeacherSuggestion;
import com.goisan.suggestionbox.service.TeacherSuggestionService;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @descroption 教师意见(处理意见)
 * @author 郭千恺
 * @version v1.0
 * @date 2018/9/26 15:45
 */
@Controller
@RequestMapping("/suggestionBox/teacher/manage")
public class TeacherSuggestionManageController {
    @Resource
    private TeacherSuggestionService teacherSuggestionService;

    /**
     * 教师意见列表页面
     * @return
     */
    @RequestMapping("/suggestionListPage")
    public ModelAndView suggestionListPage() {
        ModelAndView mv = new ModelAndView("/business/suggestionbox/teacher/manage/suggestionList");
        return mv;
    }

    /**
     * 获取意见列表
     * @return
     */
    @ResponseBody
    @RequestMapping("/getSuggestionList")
    public Map getSuggestionList(TeacherSuggestion teacherSuggestion) {
        return CommonUtil.tableMap(this.teacherSuggestionService.getTeacherSuggestion(teacherSuggestion));
    }

    /**
     * 意见详情页面
     * @return
     */
    @ResponseBody
    @RequestMapping("/suggestionDetail")
    public ModelAndView suggestionDetail(String id) {
        TeacherSuggestion teacherSuggestion = this.teacherSuggestionService.getById(id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/suggestionbox/teacher/manage/suggestionDetail");
        mv.addObject("head", "意见详情");
        mv.addObject("detail", teacherSuggestion);
        return mv;
    }

    /**
     * 回复列表页面
     * @param id
     * @return
     */
    @RequestMapping("/replyListPage")
    public ModelAndView replyListPage(String id) {
        TeacherSuggestion teacherSuggestion = this.teacherSuggestionService.getById(id);
        String title = teacherSuggestion.getTitle();

        ModelAndView mv=new ModelAndView("/business/suggestionbox/teacher/manage/replyList");
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
     * 获取意见详情页面
     * @return
     */
    @ResponseBody
    @RequestMapping("/replyDetail")
    public ModelAndView replyDetail(String id) {
        ReplyForSuggestion replyForSuggestion = this.teacherSuggestionService.getReplyById(id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/suggestionbox/teacher/manage/replyDetail");
        mv.addObject("head", "意见回复");
        mv.addObject("reply", replyForSuggestion);
        return mv;
    }

    @RequestMapping("/saveReply")
    public ModelAndView saveReply(String suggestionId, String replyId) {
        TeacherSuggestion teacherSuggestion = this.teacherSuggestionService.getById(suggestionId);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/suggestionbox/teacher/manage/saveReply");
        mv.addObject("head", "意见详情");
        mv.addObject("detail", teacherSuggestion);
        ReplyForSuggestion reply;
        if (replyId!=null && !"".equals(replyId)) {
            reply = this.teacherSuggestionService.getReplyById(replyId);
        } else {
            reply = new ReplyForSuggestion();
        }
        mv.addObject("reply", reply);
        return mv;
    }

    /**
     * 回复教师意见
     * @param replyForSuggestion
     * @return
     */
    @ResponseBody
    @RequestMapping("/reply")
    public boolean reply(ReplyForSuggestion replyForSuggestion) {
        String id = replyForSuggestion.getId();
        if (id==null || "".equals(id)) {
            replyForSuggestion.setCreator(CommonUtil.getPersonId());
            replyForSuggestion.setCreateDept(CommonUtil.getDefaultDept());
        } else {
            replyForSuggestion.setChanger(CommonUtil.getPersonId());
            replyForSuggestion.setChangeDept(CommonUtil.getDefaultDept());
        }
        boolean success = this.teacherSuggestionService.reply(replyForSuggestion);
        this.teacherSuggestionService.changeFlag(replyForSuggestion.getSuggestionId(), "2");
        return success;
    }

    /**
     * 忽略教师意见
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/notReply")
    public boolean notReply(String id) {
        TeacherSuggestion teacherSuggestion = this.teacherSuggestionService.getById(id);
        if ("1".equals(teacherSuggestion.getReplyFlag())) {
            return this.teacherSuggestionService.changeFlag(id, "3");
        } else {
            return false;
        }
    }

    /**
     * 删除回复
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/delReply")
    public boolean delReply(String id) {
        return this.teacherSuggestionService.delReply(id);
    }
}
