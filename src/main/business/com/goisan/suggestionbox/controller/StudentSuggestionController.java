package com.goisan.suggestionbox.controller;

import com.goisan.educational.major.bean.Major;
import com.goisan.educational.major.service.MajorService;
import com.goisan.suggestionbox.bean.ReplyForSuggestion;
import com.goisan.suggestionbox.bean.StudentSuggestion;
import com.goisan.suggestionbox.service.StudentSuggestionService;
import com.goisan.system.bean.ClassBean;
import com.goisan.system.bean.Student;
import com.goisan.system.service.ClassService;
import com.goisan.system.service.StudentService;
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
 * @descroption 学生意见
 * @author 郭千恺
 * @version v1.0
 * @date 2018/9/29 09:30
 */
@Controller
@RequestMapping("/suggestionBox/student")
public class StudentSuggestionController {
    @Resource
    private StudentSuggestionService studentSuggestionService;
    @Resource
    private StudentService studentService;
    @Resource
    private ClassService classService;
    @Resource
    private MajorService majorService;

    /**
     * 获取意见列表页面
     * @return
     */
    @RequestMapping("/suggestionListPage")
    public ModelAndView suggestionListPage() {
        ModelAndView mv = new ModelAndView("/business/suggestionbox/student/suggestionList");
        return mv;
    }

    /**
     * 获取意见列表
     * @return
     */
    @ResponseBody
    @RequestMapping("/getSuggestionList")
    public Map getSuggestionList(StudentSuggestion studentSuggestion) {
        studentSuggestion.setCreator(CommonUtil.getPersonId());
//        studentSuggestion.setCreator("136985233685479951");
        List list = studentSuggestionService.getStudentSuggestion(studentSuggestion);
        return CommonUtil.tableMap(this.studentSuggestionService.getStudentSuggestion(studentSuggestion));
    }

    /**
     * 获取意见详情
     * @return
     */
    @ResponseBody
    @RequestMapping("/suggestionDetail")
    public ModelAndView suggestionDetail(String id) {
        StudentSuggestion studentSuggestion = this.studentSuggestionService.getById(id);
        studentSuggestionService.updateViewFlag(id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/suggestionbox/student/suggestionDetail");
        mv.addObject("head", "意见详情");
        mv.addObject("detail", studentSuggestion);
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
        studentSuggestionService.delDetails(id);
        return new Message(1, "删除成功！", "success");
    }

    /**
     * 获取回复列表页面
     * @param id
     * @return
     */
    @RequestMapping("/getReplyListPage")
    public ModelAndView getReplyListPage(String id) {
        StudentSuggestion studentSuggestion = this.studentSuggestionService.getById(id);
        String title = studentSuggestion.getTitle();

        ModelAndView mv=new ModelAndView("/business/suggestionbox/student/replyList");
        mv.addObject("suggestion", studentSuggestion);
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
        List<ReplyForSuggestion> replyList = this.studentSuggestionService.getById(id).getReplyList();
        return CommonUtil.tableMap(replyList);
    }

    /**
     * 获取回复详情
     * @return
     */
    @ResponseBody
    @RequestMapping("/replyDetail")
    public ModelAndView replyDetail(String id) {
        ReplyForSuggestion replyForSuggestion = this.studentSuggestionService.getReplyById(id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/suggestionbox/student/replyDetail");
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
        return "/business/suggestionbox/student/addSuggestion";
    }

    /**
     * 新增意见
     * @param studentSuggestion
     * @return
     */
    @ResponseBody
    @RequestMapping("/save")
    public boolean save(StudentSuggestion studentSuggestion) {
        // 测试用假数据
//        String studentId = "136985233685479951";
//        String classId = "7cbfc235-a572-4a1c-8335-5d8fb3c3f263";
//        String majorCode = "0101010101";
//        String majorSchool = "1";

        // 实际数据开始
        String studentId = "";
        String classId = "";
        String majorCode = "";
        String majorSchool = "";

        try {
            studentId = CommonUtil.getPersonId();
            Student student = this.studentService.getStudentById(studentId);
            classId = student.getClassId();
            ClassBean classBean = this.classService.getClassByClassid(classId);
            majorCode = classBean.getMajorCode();
            Major major = new Major();
            major.setMajorCode(majorCode);
            major = this.majorService.checkMajorCode(major).get(0);
            majorSchool = major.getMajorSchool();
            majorCode = classBean.getMajorCode();

        } catch (Exception e) {
            e.printStackTrace();
        }
        // 实际数据结束
        /**
         * 注意,非学生身份登陆因无法查到对应专业班级等而无法保存,可以使用假数据生成部分测试
         */

        studentSuggestion.setCreator(studentId);
        studentSuggestion.setClassId(classId);
        studentSuggestion.setMajorCode(majorCode);
        studentSuggestion.setMajorSchool(majorSchool);

        return this.studentSuggestionService.save(studentSuggestion);
    }

    /**
     * 按id获取意见
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/getById")
    public StudentSuggestion getById(String id) {
        return this.studentSuggestionService.getById(id);
    }

//    /**
//     * 删除意见
//     * @param id
//     * @return
//     */
//    @ResponseBody
//    @RequestMapping("/del")
//    public boolean del(String id) {
//        return this.studentSuggestionService.del(id);
//    }
}
