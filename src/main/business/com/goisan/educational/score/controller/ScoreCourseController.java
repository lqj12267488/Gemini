package com.goisan.educational.score.controller;

import com.goisan.educational.score.bean.ScoreClass;
import com.goisan.educational.score.bean.ScoreCourse;
import com.goisan.educational.score.service.ScoreCourseService;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.TableDict;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.CommonService;
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

/**
 * Created by wq on 2017/10/12.
 */
@Controller
public class ScoreCourseController {
    @Resource
    private ScoreCourseService scoreCourseService;

    @Resource
    private CommonService commonService;

    @RequestMapping("/scoreCourse/list")
    public ModelAndView scoreCourseList(String scoreExamId,String scoreExamName){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/educational/score/scoreCourseList");
        mv.addObject("scoreExamId", scoreExamId);
        mv.addObject("scoreExamName", scoreExamName);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/scoreCourse/getScoreCourseList")
    public Map<String,List<ScoreCourse>> getScoreCourseList(ScoreCourse scoreCourse){
        Map<String,List<ScoreCourse>> map=new HashMap<String, List<ScoreCourse>>();
        map.put("data", scoreCourseService.getScoreCourseList(scoreCourse));
        return map;
    }
    @ResponseBody
    @RequestMapping("/scoreCourse/editScoreCourse")
    public ModelAndView editScoreCourse(String subjectId){
        ModelAndView mv=new ModelAndView();
        mv.setViewName("/business/educational/score/scoreCourseEdit");
        if(subjectId==""||subjectId==null){
            mv.addObject("head","新增");
        }else{
            ScoreCourse scoreCourse = scoreCourseService.getScoreCourseById(subjectId);
            mv.addObject("head", "修改");
            mv.addObject("scoreCourse", scoreCourse);
        }
        return mv;
    }
    @ResponseBody
    @RequestMapping("/scoreCourse/saveScoreCourse")
    public Message saveScoreCourse(ScoreCourse scoreCourse){
        if(scoreCourse.getSubjectId()==""){
            scoreCourse.setCreator(CommonUtil.getPersonId());
            scoreCourse.setCreateDept(CommonUtil.getDefaultDept());
            scoreCourseService.insertScoreCourse(scoreCourse);
            return new Message(1,"新增成功！","success");
        }else{
            scoreCourse.setChanger(CommonUtil.getPersonId());
            scoreCourse.setChangeDept(CommonUtil.getDefaultDept());
            scoreCourseService.updateScoreCourseById(scoreCourse);
            return new Message(1,"修改成功！","success");
        }
    }
    @ResponseBody
    @RequestMapping("/scoreCourse/deleteScoreCourseById")
    public Message deleteScoreCourseById(String subjectId){
        scoreCourseService.deleteScoreCourseById(subjectId);
        scoreCourseService.deleteClassBySubjectId(subjectId);
        scoreCourseService.deleteScoreBySubjectId(subjectId);
        return new Message(1,"删除成功！","success");
    }
    //通过专业id获取课程
    @ResponseBody
    @RequestMapping("/scoreCourse/getCourseByMajorShow")
    public List<Select2> getCourseByMajorShow(String majorShow) {
        return scoreCourseService.getCourseByMajorShow(majorShow);
    }

    @ResponseBody
    @RequestMapping("/scoreCourse/getCourseByMajorShow2")
    public List<Select2> getCourseByMajorShow2(String majorShow,String termId) {
        TableDict tableDict = new TableDict();
        tableDict.setId("c.course_id");
        tableDict.setText(" FUNC_GET_TABLEVALUE(c.course_id, 'T_JW_COURSE', 'course_id', 'course_name')");
        tableDict.setTableName("T_JW_TEACHINGTASK t,T_JW_COURSE c ");
        StringBuilder sb = new StringBuilder();
        sb.append("where t.semester ='");
        sb.append(termId);
        sb.append("' and t.course_id = c.course_id and c.course_type='1'");
        tableDict.setWhere(sb.toString());
        List<Select2> list = scoreCourseService.getCourseByMajorShow(majorShow);
        list.addAll(commonService.getDistinctTableDict(tableDict));

        return list;
    }

    /**
     * 通过教学任务，班级id 查询课程
     */
    @ResponseBody
    @RequestMapping("/scoreCourse/getCourseByPlanAndClass")
    public List<Select2> getCourseByPlanAndClass(String classInfo,String term) {
        return scoreCourseService.getCourseByPlanAndClass(classInfo,term);
    }



    //通过课程类型获取课程
    @ResponseBody
    @RequestMapping("/scoreCourse/getCourseByType")
    public List<Select2> getCourseByType(String courseType) {
        return scoreCourseService.getCourseByType(courseType);
    }
    //通过教学计划导入课程、班级和录入教师信息
    @ResponseBody
    @RequestMapping("/scoreCourse/planImport")
    public ModelAndView signImport(String scoreExamId){
        ModelAndView mv=new ModelAndView();
        mv.setViewName("/business/educational/score/scoreCoursePlanImport");
        mv.addObject("scoreExamId","scoreExamId");
        mv.addObject("head","教学计划");
        return mv;
    }
    //教学计划导入
    @ResponseBody
    @RequestMapping("/scoreCourse/import")
    public Message importCourse(ScoreCourse scoreCourse) {
        scoreCourse.setCreator(CommonUtil.getPersonId());
        scoreCourse.setCreateDept(CommonUtil.getDefaultDept());
        scoreCourseService.importCourse(scoreCourse);
        scoreCourseService.importClassPerson(scoreCourse);
        return new Message(1,"新增成功！","success");
    }
    /*班级分配树跳转*/
    @RequestMapping("/scoreCourse/scoreClassTree")
    public ModelAndView signClassTree(ScoreClass scoreClass){
        ModelAndView mv = new ModelAndView("/business/educational/score/scoreClassTree");
        mv.addObject("scoreClass", scoreClass);
        return mv;
    }
    /*获取系部-专业-班级下拉树*/
    @ResponseBody
    @RequestMapping("/scoreCourse/getClassTreeByScoreClass")
    public Map<String,List> getClassTreeByScoreClass(String subjectId,String courseType){
        List<Tree> trees = null;
        if(courseType.equals("公共基础")) {
            trees = scoreCourseService.getClassTreeForPublishCourse();
        }else{
            trees = scoreCourseService.getClassTreeForScoreCourse();
        }
        List<ScoreClass> scoreClasses =scoreCourseService.getClassBySubjectId(subjectId);
        Map<String,List> map = new HashMap<String, List>();
        map.put("tree",trees);
        map.put("selected",scoreClasses);
        return map;
    }
    /*保存所选班级*/
    @ResponseBody
    @RequestMapping("/scoreCourse/saveClass")
    public Message saveClass(ScoreClass scoreClass, String classes) {
        System.out.println(scoreClass.getSubjectId());
        System.out.println(classes);
        String[] classIds = classes.split(",");
        scoreCourseService.saveClassAll(scoreClass,classIds);
        return new Message(1,"保存成功!","success");
    }
}
