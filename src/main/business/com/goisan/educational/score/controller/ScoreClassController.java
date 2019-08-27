package com.goisan.educational.score.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.score.bean.ScoreClass;
import com.goisan.educational.score.bean.ScoreCourse;
import com.goisan.educational.score.service.ScoreClassService;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.TableDict;
import com.goisan.system.bean.Tree;
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

/**
 * Created by Administrator on 2017/10/12.
 */
@Controller
public class ScoreClassController {


    @Resource
    private ScoreClassService scoreClassService;
    /**
     * 录入班级申请跳转
     * request by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/scoreClass/list")
    public ModelAndView scoreClassList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/score/scoreClass");
        return mv;
    }

    /**
     * 录入班级URL
     *  url by hanyue
     *  modify by hanyue
     * @param scoreClass
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreClass/getScoreClassList")
    public Map<String,Object> getScoreClassList(ScoreClass scoreClass, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> scoreClasss = new HashMap();
        scoreClass.setCreator(CommonUtil.getPersonId());
        List<ScoreClass> scoreClassList = scoreClassService.getScoreClassList(scoreClass);
        PageInfo<List<ScoreClass>> info = new PageInfo(scoreClassList);
        scoreClasss.put("draw", draw);
        scoreClasss.put("recordsTotal", info.getTotal());
        scoreClasss.put("recordsFiltered", info.getTotal());
        scoreClasss.put("data", scoreClassList);
        return scoreClasss;
    }
    @ResponseBody
    @RequestMapping("/scoreClass/selectScoreClassById")
    public Boolean selectScoreClassById(String scoreClassId) {
        ScoreClass scoreClass = scoreClassService.getScoreClassById(scoreClassId);
        if(scoreClass.getPersonId()==null || scoreClass.getPersonId().equals("")){
            return true ;
        }else{
            return false ;
        }

    }
    /**
     * 录入教师修改
     * update by hanyue
     * modify by hanyue
     * @param scoreClassId
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreClass/getScoreClassById")
    public ModelAndView getScoreClassById(String scoreClassId) {
        ModelAndView mv = new ModelAndView("/business/educational/score/editScoreClass");
        ScoreClass scoreClass = scoreClassService.getScoreClassById(scoreClassId);
        mv.addObject("head", "录入教师修改");
        mv.addObject("scoreClass", scoreClass);
        return mv;
    }
    /**
     * 删除录入班级
     * delete by hanyue
     * modify by hanyue
     * @param scoreClassId
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreClass/deleteScoreClassById")
    public Message deleteScoreClassById(String scoreClassId) {
        scoreClassService.updatePersonIdByScore(scoreClassId);
        return new Message(1, "删除成功！", null);
    }
    /**
     * 查询考试科目
     * update by hanyue
     * modify by hanyue
     * @param subjectId
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreClass/selectScoreCourse")
    public ScoreCourse selectScoreCourse(String subjectId) {
        ScoreCourse scoreCourse = scoreClassService.selectScoreCourse(subjectId);
        return scoreCourse;
    }
    /*班级分配树跳转*/
    @RequestMapping("/scoreClass/scoreClassTree")
    public ModelAndView signClassTree(String scoreClassId){
        ModelAndView mv = new ModelAndView("/business/educational/score/scoreClassTree");
        mv.addObject("scoreClassId", scoreClassId);
        return mv;
    }
    /*获取树*/
    @ResponseBody
    @RequestMapping("/scoreClass/getClassTreeByScoreClass")
    public Map<String,List> getClassTreeByScoreClass(String scoreClassId){
        List<Tree> trees = null;
        trees = scoreClassService.getClassTreeByScoreClass();
        List<ScoreClass> scoreClasses =scoreClassService.getClassByScoreClassId(scoreClassId);
        Map<String,List> map = new HashMap<String, List>();
        map.put("tree",trees);
        map.put("selected",scoreClasses);
        return map;
    }

    @ResponseBody
    @RequestMapping("/scoreClass/saveClass")
    public Message saveClass(String scoreClassId, String ids) {
        System.out.println(scoreClassId);
        System.out.println(ids);
        String[] tmp =  ids.split(",");
        ScoreClass  scoreClass=scoreClassService.getScoreClassById(scoreClassId);
        scoreClassService.deleteScoreClassByClass(scoreClass);
        scoreClassService.saveClass(tmp , scoreClassId);
        scoreClassService.delScoreClass(scoreClassId);
        return new Message(1,"保存成功!",null);

    }
    @ResponseBody
    @RequestMapping("/scoreClass/setScoreClassTeacher")
    public Message setScoreClassTeacher(String scoreClassIds, String personId, String teacherDeptId, String teacherPersonId){
        String[] tmp = scoreClassIds.split(",");
        for (String id : tmp) {
            ScoreClass scoreClass=scoreClassService.getScoreClassById(id);
            scoreClass.setPersonId(personId);
            scoreClass.setCreator(CommonUtil.getPersonId());
            scoreClass.setCreateDept(CommonUtil.getDefaultDept());
            scoreClass.setTeacherDeptId(teacherDeptId);
            scoreClass.setTeacherPersonId(teacherPersonId);
            scoreClassService.updateScoreClassById(scoreClass);
        }
        return new Message(1, "设置录入教师成功！", null);
    }
    @ResponseBody
    @RequestMapping("/scoreClass/saveScoreClassTeacher")
    public Message saveScoreClassTeacher(ScoreClass scoreClass){
        if(scoreClass.getPersonId()==null || scoreClass.getPersonId().equals("")){
            scoreClass.setCreator(CommonUtil.getPersonId());
            scoreClass.setCreateDept(CommonUtil.getDefaultDept());
            scoreClass.setScoreClassId(CommonUtil.getUUID());
            scoreClassService.updateScoreClassById(scoreClass);
            return new Message(1, "设置录入教师成功！", null);
        }else{
            scoreClass.setChanger(CommonUtil.getPersonId());
            scoreClass.setChangeDept(CommonUtil.getDefaultDept());
            scoreClassService.updateScoreClassById(scoreClass);
            return new Message(1, "修改录入教师成功！", null);
        }
    }
    @RequestMapping("/scoreClass/toScoreClass")
    public String toScoreClass(String scoreClassIds, Model model) {
        List<ScoreClass> scoreClassList =scoreClassService.getScoreClassByIds(scoreClassIds.substring(0, scoreClassIds.length() - 2));
        String classId = "";
        for (ScoreClass clas : scoreClassList) {
            classId += clas.getClassId() + ",";
        }
        model.addAttribute("classId", classId.substring(0, classId.length() - 1));
        model.addAttribute("scoreClassIds", scoreClassIds.replaceAll("'", ""));
        return "/business/educational/score/setScoreClassTeacher";
    }

    /**
     * 教学计划字典去重
     * @param tableDict
     * @return
     */
    @ResponseBody
    @RequestMapping("/scoreClass/getTableDict")
    public List<Select2> getTableDict(TableDict tableDict) {
        List<Select2> selectList = scoreClassService.getScoreClassTableDict(tableDict);
        return selectList;
    }
}
