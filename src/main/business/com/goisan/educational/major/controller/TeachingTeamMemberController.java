package com.goisan.educational.major.controller;

import com.goisan.educational.major.bean.TeachingTeamMember;
import com.goisan.educational.major.service.MajorLeaderService;
import com.goisan.educational.major.service.MajorService;
import com.goisan.educational.major.service.TeachingTeamMemberService;
import com.goisan.system.bean.EmpDeptTree;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @author 郭千恺
 * @version v1.0
 * @descroption
 * @date 2018/10/11 9:45
 */
@Controller
@RequestMapping("/teachingTeam")
public class TeachingTeamMemberController {
    @Resource
    private TeachingTeamMemberService teachingTeamMemberService;
    @Resource
    private MajorLeaderService majorLeaderService;

    /**
     * 获取leader页面
     * @return
     */
    @RequestMapping("/getLeaderPage")
    public ModelAndView getLeaderPage(String teamId) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "负责人列表");
        mv.addObject("teamId", teamId);
        mv.setViewName("/core/major/teachingTeamMember/addLeader");
        return mv;
    }
    /**
     * 获取leader列表
     * @param teachingTeamMember
     * @return
     */
    @ResponseBody
    @RequestMapping("/getLeaderList")
    public Map getLeaderList(TeachingTeamMember teachingTeamMember) {
        teachingTeamMember.setMemberType("1");
        List<TeachingTeamMember> returnList = this.teachingTeamMemberService.getList(teachingTeamMember);
        return CommonUtil.tableMap(returnList);
    }

    /**
     * 新增leader页面
     * @return
     */
    @RequestMapping("/addLeaderPage")
    public ModelAndView addLeaderPage(String teamId) {
        ModelAndView mv = new ModelAndView();
        String teamName = this.majorLeaderService.getTeachingTeamById(teamId).getPlanName();
        mv.addObject("head", "新增负责人");
        mv.addObject("teamName", teamName);
        mv.addObject("teamId", teamId);
        mv.setViewName("/core/major/teachingTeamMember/addLeader");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/getDeptAndPersonTree")
    public List<EmpDeptTree> getDeptAndPersonTree(TeachingTeamMember tt) {
        List<EmpDeptTree> trees = majorLeaderService.getDeptAndPersonTree(tt);
        EmpDeptTree root = new EmpDeptTree();
        root.setId("0");
        root.setName("组织机构");
        root.setpId("root");
        root.setOpen(true);
        root.setChecked("false");
        root.setIsper("false");
        trees.add(root);
        return trees;
    }
    /**
     * 新增leader
     * @param teachingTeamMember
     * @return
     */
    @ResponseBody
    @RequestMapping("/addLeader")
    public boolean addLeader(TeachingTeamMember teachingTeamMember) {
        teachingTeamMember.setMemberType("1");
        return this.teachingTeamMemberService.insert(teachingTeamMember);
    }
    /**
     * 删除leader
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/delLeader")
    public boolean delLeader(String id) {
        return this.teachingTeamMemberService.delete(id);
    }

    /**
     * 获取member页面
     * @return
     */
    @RequestMapping("/getMemberPage")
    public ModelAndView getMemberPage(String teamId) {
        ModelAndView mv = new ModelAndView();
        String teamName = this.majorLeaderService.getTeachingTeamById(teamId).getPlanName();
        mv.addObject("head", "新增团队成员");
        mv.addObject("teamName", teamName);
        mv.addObject("teamId", teamId);
        mv.setViewName("/core/major/teachingTeamMember/addMembers");
        return mv;
    }
    /**
     * 获取member列表
     * @param teachingTeamMember
     * @return
     */
    @ResponseBody
    @RequestMapping("/getMemberList")
    public Map getMemberList(TeachingTeamMember teachingTeamMember) {
        teachingTeamMember.setMemberType("2");
        List<TeachingTeamMember> returnList = this.teachingTeamMemberService.getList(teachingTeamMember);
        return CommonUtil.tableMap(returnList);
    }

    /**
     * 新增member页面
     * @return
     */
    @RequestMapping("/addMemberPage")
    public ModelAndView addMemberPage() {
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "新增成员");
        mv.setViewName("[新增member窗口]");
        return mv;
    }

    /**
     * 新增member
     * @param teachingTeamMember
     * @return
     */
    @ResponseBody
    @RequestMapping("/addMember")
    public boolean addMember(TeachingTeamMember teachingTeamMember) {
        teachingTeamMember.setMemberType("2");
        return this.teachingTeamMemberService.insert(teachingTeamMember);
    }
    /**
     * 删除member
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/delMember")
    public boolean delMember(String id) {
        return this.teachingTeamMemberService.delete(id);
    }
}
