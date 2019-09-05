package com.goisan.survey.controller;

import com.goisan.survey.bean.SurveyPerson;
import com.goisan.survey.service.SurveyPersonService;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.ParentService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Controller
public class SurveyPersonController {

    @Resource
    private SurveyPersonService surveyPersonService;
    @Resource
    private ParentService parentService;

    @RequestMapping("/survey/person/toSurveyPersonList")
    public ModelAndView toList() {
        ModelAndView mv = new ModelAndView("/core/survey/person/surveyPersonList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/person/getSurveyPersonList")
    public Map getList(SurveyPerson surveyPerson) {
        return CommonUtil.tableMap(surveyPersonService.getSurveyPersonList(surveyPerson));
    }

    @RequestMapping("/survey/person/toSurveyPersonAdd")
    public ModelAndView toAdd() {
        ModelAndView mv = new ModelAndView("/core/survey/person/surveyPersonEdit");
        mv.addObject("head", "新增");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/person/saveSurveyPerson")
    public Message save(SurveyPerson surveyPerson) {
        if ("".equals(surveyPerson.getId())) {
            surveyPerson.setId(CommonUtil.getUUID());
            CommonUtil.save(surveyPerson);
            surveyPersonService.saveSurveyPerson(surveyPerson);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(surveyPerson);
            surveyPersonService.updateSurveyPerson(surveyPerson);
            return new Message(0, "修改成功！", null);
        }
    }

    @RequestMapping("/survey/person/toSurveyPersonEdit")
    public ModelAndView toEdit(String id) {
        ModelAndView mv = new ModelAndView("/core/survey/person/surveyPersonEdit");
        mv.addObject("data", surveyPersonService.getSurveyPersonById(id));
        mv.addObject("head", "修改");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/person/delSurveyPerson")
    public Message del(String id) {
        surveyPersonService.delSurveyPerson(id);
        return new Message(0, "删除成功！", null);
    }
    @RequestMapping("/survey/person/toSurveyStudent")
    public ModelAndView toListStudent(String id,String checkFlag) {
        ModelAndView mv = new ModelAndView("/core/survey/person/surveyStudentTree");
        mv.addObject("surveyId",id);
        mv.addObject("checkFlag",checkFlag);
        return mv;
    }

    @RequestMapping("/survey/person/toSurveyTeacher")
    public ModelAndView toListTeacher(String id,String checkFlag) {
        ModelAndView mv = new ModelAndView("/core/survey/person/surveyTeacherTree");
        mv.addObject("surveyId",id);
        mv.addObject("checkFlag",checkFlag);
        return mv;
    }

    @RequestMapping("/survey/person/toSurveyPerson")
    public ModelAndView toListPerson(String id,String checkFlag) {
        ModelAndView mv = new ModelAndView("/core/survey/person/surveyPersonTree");
        mv.addObject("surveyId",id);
        mv.addObject("checkFlag",checkFlag);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/survey/person/getSurveyParentTree")
    public List<Tree> getDeptAndPersonTree(String surveyId) {
        List<Tree> trees = parentService.getSurveyParsonTree(surveyId);
        return trees;
    }

    /**
     * 学生教师答卷人
     * @param surveyId
     * @return
     */
    @ResponseBody
    @RequestMapping("/survey/person/getSurveyTeacherTree")
    public List<Tree> getSurveyTeacherTree(String surveyId) {
        List<Tree> trees = parentService.getSurveyTeacherTree(surveyId);
        return trees;
    }

    /**
     * 学生答卷人
     * @param surveyId
     * @return
     */
    @ResponseBody
    @RequestMapping("/survey/person/getSurveyStudentTree")
    public List<Tree> getSurveyStudentTree(String surveyId) {
        List<Tree> trees = parentService.getSurveyStudentTree(surveyId);
        return trees;
    }

    @ResponseBody
    @RequestMapping("/survey/person/saveSurveyParent")
    public Message saveSurveyParent(String surveyId, String checkList, String personType) {
        surveyPersonService.delAndSaveSurveyParent(surveyId,checkList,personType);
        return new Message(1, "保存成功！", null);
    }

}
