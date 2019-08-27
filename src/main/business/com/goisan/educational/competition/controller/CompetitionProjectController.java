package com.goisan.educational.competition.controller;

import com.goisan.educational.competition.bean.AwardWinning;
import com.goisan.educational.competition.bean.CompetitionProject;
import com.goisan.educational.competition.service.CompetitionProjectService;
import com.goisan.educational.place.building.bean.Building;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CompetitionProjectController {
    @Resource
    private CompetitionProjectService competitionProjectService;
    //申请页跳转
    @RequestMapping("/competitionProject/competitionProjectList")
    public ModelAndView competitionProjectList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/competitionproject/competitionProjectList");
        return mv;
    }
    //申请页列表初始化
    @ResponseBody
    @RequestMapping("/competitionProject/getCompetitionProjectList")
    public Map<String, List<CompetitionProject>> getCompetitionProjectList(CompetitionProject competitionProject) {
        Map<String, List<CompetitionProject>> softInstallMap = new HashMap<String, List<CompetitionProject>>();
        competitionProject.setCreator(CommonUtil.getPersonId());
        competitionProject.setChangeDept(CommonUtil.getDefaultDept());
        softInstallMap.put("data", competitionProjectService.competitionProjectAction(competitionProject));
        return softInstallMap;
    }

    @ResponseBody
    @RequestMapping("/competitionProject/addCompetitionProject")
    public ModelAndView addCompetitionProjectInstall() {
        ModelAndView mv = new ModelAndView("/business/educational/competitionproject/editCompetitionProject");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String date = formatDate.format(new Date());
        CompetitionProject competitionProject=new CompetitionProject();
        mv.addObject("head", "新增申请");
        mv.addObject("competitionProject",competitionProject);
        return mv;
    }
    //申请页修改界面跳转
    @ResponseBody
    @RequestMapping("/competitionProject/getCompetitionProjectById")
    public ModelAndView getCompetitionProjectById(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/competitionproject/editCompetitionProject");
        CompetitionProject competitionProject = competitionProjectService.getCompetitionProjectById(id);
        mv.addObject("head", "技能鉴定修改");
        mv.addObject("competitionProject", competitionProject);
        return mv;
    }
    //新增和修改保存
    @ResponseBody
    @RequestMapping("/competitionProject/saveCompetitionProject")
    public Message savecompetitionProject(CompetitionProject competitionProject){
        if(competitionProject.getId() == null || competitionProject.equals("") || competitionProject.getId() == ""){
            competitionProject.setCreator(CommonUtil.getPersonId());
            competitionProject.setCreateDept(CommonUtil.getDefaultDept());
            competitionProjectService.insertCompetitionProject(competitionProject);
            return new Message(1, "新增成功！", null);
        }else{
            competitionProject.setChanger(CommonUtil.getPersonId());
            competitionProject.setChangeDept(CommonUtil.getDefaultDept());
            competitionProjectService.updateCompetitionProjectById(competitionProject);
            return new Message(1, "修改成功！", null);
        }
    }
    //删除
    @ResponseBody
    @RequestMapping("/competitionProject/deleteCompetitionProjectById")
    public Message deleteDeptById(String id) {
        competitionProjectService.deleteCompetitionProjectById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/competitionProject/selectCompetitionProject")
    public boolean selectCompetitionProject(String id){
        List<AwardWinning> list1=competitionProjectService.selectCompetitionProject(id);
        if( list1.size()> 0 ){
            return true;
        }else{
            return false;
        }

    }
}
