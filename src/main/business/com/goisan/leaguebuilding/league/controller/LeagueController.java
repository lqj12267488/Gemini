package com.goisan.leaguebuilding.league.controller;

/**
 * Created by fn on 2017/9/22/026.
 */

import com.goisan.leaguebuilding.league.bean.League;
import com.goisan.leaguebuilding.league.bean.LeagueMemberLog;
import com.goisan.leaguebuilding.league.service.LeagueService;
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

@Controller
public class LeagueController {
    @Resource
    private LeagueService leagueService;

    @RequestMapping("/league/leagueList")
    public ModelAndView leagueList() {
        ModelAndView mv = new ModelAndView("/business/leaguebuilding/league/league");
        return mv;
    }
    /**
     * 团员管理首页 by fn 20170926
     */
    @ResponseBody
    @RequestMapping("/league/getLeagueList")
    public Map<String, List<League>> getLeagueList(League league) {
        Map<String, List<League>> leagueMap = new HashMap<String, List<League>>();
        league.setRelationshipChangeType("3");
        league.setCreator(CommonUtil.getPersonId());
        league.setCreateDept(CommonUtil.getDefaultDept());
        leagueMap.put("data", leagueService.leagueAction(league));
        return leagueMap;
    }

    /*
     *  团管理新增页
    */
    @ResponseBody
    @RequestMapping("/league/addLeague")
    public ModelAndView addLeague(String branchId) {
        ModelAndView mv = new ModelAndView("/business/leaguebuilding/league/editLeague");
        League league = new League();
        league.setBranchId(branchId);
        mv.addObject("league", league);
        mv.addObject("head", "新增团员信息");
        return mv;
    }

    /*
     *修改页面
     */
    @ResponseBody
    @RequestMapping("/league/editLeague")
    public ModelAndView editLeague(String id) {
        ModelAndView mv = new ModelAndView("/business/leaguebuilding/league/editLeague");
        League league = leagueService.getLeagueById(id);
        mv.addObject("head", "团员信息修改");
        mv.addObject("league", league);
        return mv;
    }

    /**
     * 党员新增保存方法
     */
    @ResponseBody
    @RequestMapping("/league/saveLeague")
    public Message saveLeague(League league) {
        if (league.getId() == null || league.getId().equals("") || league.getId() == "") {
            league.setCreator(CommonUtil.getPersonId());
            league.setCreateDept(CommonUtil.getDefaultDept());
            leagueService.insertLeague(league);
            LeagueMemberLog leagueMemberLog = new LeagueMemberLog();
            leagueMemberLog.setBranchId(league.getBranchId());
            leagueMemberLog.setStudentId(league.getStudentId());
            leagueMemberLog.setClassId(league.getClassId());
            leagueMemberLog.setLogType("1");
            String remark = "在" + CommonUtil.now("yyyy-MM-dd") + "新增该条数据。";
            leagueMemberLog.setLogRemark(remark);
            leagueMemberLog.setCreator(CommonUtil.getPersonId());
            leagueMemberLog.setCreateDept(CommonUtil.getDefaultDept());
            leagueService.insertLeagueMemberLog(leagueMemberLog);
            return new Message(1, "新增成功！", null);
        } else {
            league.setChanger(CommonUtil.getPersonId());
            league.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            leagueService.updateLeague(league);
            LeagueMemberLog leagueMemberLog = new LeagueMemberLog();
            leagueMemberLog.setBranchId(league.getBranchId());
            leagueMemberLog.setStudentId(league.getStudentId());
            leagueMemberLog.setClassId(league.getClassId());
            leagueMemberLog.setLogType("2");
            String remark = "在" + CommonUtil.now("yyyy-MM-dd") + "修改了该条数据";
            leagueMemberLog.setLogRemark(remark);
            leagueMemberLog.setCreator(CommonUtil.getPersonId());
            leagueMemberLog.setCreateDept(CommonUtil.getDefaultDept());
            leagueService.insertLeagueMemberLog(leagueMemberLog);
            return new Message(1, "修改成功！", null);
        }
    }
    /**
     * 新增团员名称查重
     */
    @ResponseBody
    @RequestMapping("/league/checkName")
    public Message checkName(League league) {
        List size = leagueService.checkName(league);
        if (size.size() > 0) {
            return new Message(1, "该人员的信息已存在，请检查！", null);
        } else {
            return new Message(0, "", null);
        }
    }

    @ResponseBody
    @RequestMapping("/league/deleteLeagueById")
    public Message deleteLeagueById(String id) {
        leagueService.deleteLeagueById(id);
        //菜单,按钮权限删除
        return new Message(1, "删除成功！", null);
    }


    /*
    * 团组织关系变更首页
    * */
    @RequestMapping("/league/leagueRelationshipChange")
    public ModelAndView leagueRelationshipChange() {
        ModelAndView mv = new ModelAndView("/business/leaguebuilding/relationshipChange/leagueRelationshipChangeList");
        return mv;
    }

    /**
     * 团组织关系变更首页 by fn 20170810
     */
    @ResponseBody
    @RequestMapping("/league/getRelationshipChangeList")
    public Map<String, List<League>> getRelationshipChangeList(League league) {
        Map<String, List<League>> leagueMap = new HashMap<String, List<League>>();
        league.setCreator(CommonUtil.getPersonId());
        league.setCreateDept(CommonUtil.getDefaultDept());
        leagueMap.put("data", leagueService.leagueAction(league));
        return leagueMap;
    }

    /**
     * 批量变更团组织关系页面
     */
    @RequestMapping("/league/changeLeagueRelationship")
    public String toChangeRelationship(String ids, Model model) {
        model.addAttribute("ids", ids.replaceAll("'", ""));
        return "/business/leaguebuilding/relationshipChange/leagueRelationshipChange";
    }

    /**
     * 批量变更团组织关系
     */
    @ResponseBody
    @RequestMapping("/league/updateRelationshipByIds")
    public Message updateRelationshipByIds(League league) {
        String ids = league.getIds();
        String[] tmp = ids.split(",");
        league.setChanger(CommonUtil.getPersonId());
        league.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        if (ids.indexOf(",") == -1) {
            league.setId(ids);
            leagueService.updateRelationshipByIds(league);
            League leagueMsg = leagueService.selectLeagueById(ids);
            LeagueMemberLog leagueMemberLog = new LeagueMemberLog();
            leagueMemberLog.setBranchId(leagueMsg.getBranchId());
            leagueMemberLog.setStudentId(leagueMsg.getStudentId());
            leagueMemberLog.setClassId(leagueMsg.getClassId());
            leagueMemberLog.setLogType("3");
            String remark = "在" + CommonUtil.now("yyyy-MM-dd") + "将该人员团组织关系变更为[" + leagueMsg.getRelationshipChangeType()
                    + "],团组织变更为[" + leagueMsg.getRemark() + "]";
            leagueMemberLog.setLogRemark(remark);
            leagueMemberLog.setCreator(CommonUtil.getPersonId());
            leagueMemberLog.setCreateDept(CommonUtil.getDefaultDept());
            leagueService.insertLeagueMemberLog(leagueMemberLog);
        } else {
            for (String id : tmp) {
                league.setId(id);
                leagueService.updateRelationshipByIds(league);
                League leagueMsg = leagueService.selectLeagueById(id);
                LeagueMemberLog leagueMemberLog = new LeagueMemberLog();
                leagueMemberLog.setBranchId(leagueMsg.getBranchId());
                leagueMemberLog.setStudentId(leagueMsg.getStudentId());
                leagueMemberLog.setClassId(leagueMsg.getClassId());
                leagueMemberLog.setLogType("3");
                String remark = "在" + CommonUtil.now("yyyy-MM-dd") + "将该人员团组织关系变更为[" + leagueMsg.getRelationshipChangeType()
                        + "],团组织变更为[" + leagueMsg.getRemark() + "]";
                leagueMemberLog.setLogRemark(remark);
                leagueMemberLog.setCreator(CommonUtil.getPersonId());
                leagueMemberLog.setCreateDept(CommonUtil.getDefaultDept());
                leagueService.insertLeagueMemberLog(leagueMemberLog);
            }
        }
        return new Message(1, "团组织关系变更成功！", null);
    }

    /*
     * 团员信息综合查询首页
     */
    @RequestMapping("/league/leagueIntegratedQuerList")
    public ModelAndView leagueIntegratedQuerList() {
        ModelAndView mv = new ModelAndView("/business/leaguebuilding/leagueIntegratedQuer/leagueIntegratedQuerList");
        return mv;
    }

    /*
     *操作日志
     */
    @ResponseBody
    @RequestMapping("/league/showLeagueLog")
    public ModelAndView showLeagueLog(String id) {
        ModelAndView mv = new ModelAndView("/business/leaguebuilding/leagueIntegratedQuer/showLeagueLog");
        League league = leagueService.selectLeagueById(id);
        mv.addObject("head", "操作日志");
        mv.addObject("league", league);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/league/getLeagueLog")
    public Map getLeagueLog(String studentId) {
        return CommonUtil.tableMap(leagueService.getLeagueLogByPersonId(studentId));
    }
}
