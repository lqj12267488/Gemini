package com.goisan.educational.skill.controller;

import com.goisan.educational.skill.bean.Skill;
import com.goisan.educational.skill.service.SkillService;
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
public class SkillController {
    @Resource
    private SkillService skillService;

    /**
     * 鉴定项目首页跳转
     * @return
     */
    @RequestMapping("/skill/skillList")
    public ModelAndView skillList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/skill/skillList");
        return mv;
    }

    /**
     * 鉴定项目首页查询数据
     * @param skill
     * @return
     */
    @ResponseBody
    @RequestMapping("/skill/getSkillList")
    public Map<String, List<Skill>> getSkillList(Skill skill) {
        Map<String, List<Skill>> softInstallMap = new HashMap<String, List<Skill>>();
        skill.setCreator(CommonUtil.getPersonId());
        skill.setChangeDept(CommonUtil.getDefaultDept());
        softInstallMap.put("data", skillService.skillAction(skill));
        return softInstallMap;
    }

    /**
     * 新增鉴定项目
     * @return
     */
    @ResponseBody
    @RequestMapping("/skill/addSkill")
    public ModelAndView addSkillInstall() {
        ModelAndView mv = new ModelAndView("/business/educational/skill/editSkill");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String date = formatDate.format(new Date());
        Skill skill=new Skill();
        mv.addObject("head", "新增鉴定项目");
        mv.addObject("skill",skill);
        return mv;
    }

    /**
     * 鉴定项目修改跳转
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/skill/getSkillById")
    public ModelAndView getSkillById(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/skill/editSkill");
        Skill skill = skillService.getSkillById(id);
        mv.addObject("head", "鉴定项目修改");
        mv.addObject("skill", skill);
        return mv;
    }

    /**
     * 新增和修改保存
     * @param skill
     * @return
     */
    @ResponseBody
    @RequestMapping("/skill/saveSkill")
    public Message saveskill(Skill skill){
        if(null == skill.getId() || "".equals(skill.getId())){
            skill.setCreator(CommonUtil.getPersonId());
            skill.setCreateDept(CommonUtil.getDefaultDept());
            skillService.insertSkill(skill);
            return new Message(1, "新增成功！", null);
        }else{
            skill.setChanger(CommonUtil.getPersonId());
            skill.setChangeDept(CommonUtil.getDefaultDept());
            skillService.updateSkillById(skill);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/skill/deleteSkillById")
    public Message deleteSkillById(String id) {
        skillService.deleteSkillById(id);
        return new Message(1, "删除成功！", null);
    }
}
