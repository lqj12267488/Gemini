package com.goisan.leaguebuilding.leaguebranch.controller;

/**
 * Created by fn on 2017/9/20/026.
 */

import com.goisan.leaguebuilding.leaguebranch.bean.LeagueBranch;
import com.goisan.leaguebuilding.leaguebranch.service.LeagueBranchService;
import com.goisan.system.bean.Tree;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import javax.annotation.Resource;
import java.util.List;


@Controller
public class LeagueBranchController {
    @Resource
    private LeagueBranchService leagueBranchService;

    /**
     *团组织维护首页树
     */
    @ResponseBody
    @RequestMapping("/league/getLeagueBranchTree")
    public List<Tree> getLeagueBranchTree() {
        List<Tree> trees = leagueBranchService.getLeagueBranchTree();
        Tree root = new Tree();
        root.setId("0");
        root.setName("团组织管理");
        root.setpId("root");
        root.setOpen(true);
        trees.add(root);
        return trees;
    }
    /**
     *树页面
     */
    @ResponseBody
    @RequestMapping("/league/leagueBranch")
    public ModelAndView leagueBranch() {
        ModelAndView mv = new ModelAndView("/business/leaguebuilding/leagueBranch/leagueBranchTree");
        return mv;
    }

    /**
     *团组织维护首页树新增节点
     */
    @ResponseBody
    @RequestMapping("/league/addLeagueBranch")
    public ModelAndView addLeagueBranch(String pId, String name) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("id", leagueBranchService.getNewLeagueBranchId(pId));
        mv.addObject("pId", pId);
        mv.addObject("name", name);
        mv.setViewName("/business/leaguebuilding/leagueBranch/addLeagueBranch");
        return mv;
    }

    /**
     *团组织维护首页树新增保存方法
     */
    @ResponseBody
    @RequestMapping("/league/saveLeagueBranch")
    public Message saveLeagueBranch(LeagueBranch leagueBranch) {
        leagueBranch.setCreator(CommonUtil.getPersonId());
        leagueBranch.setCreateTime(CommonUtil.getDate());
        leagueBranch.setCreateDept(CommonUtil.getDefaultDept());
        leagueBranchService.saveLeagueBranch(leagueBranch);
        return new Message(1, "添加成功！", null);
    }
    /**
     *团组织维护首页树删除方法
     */
    @ResponseBody
    @RequestMapping("/league/deleteLeagueBranchById")
    public Message deleteLeagueBranchById(String id) {
        List size = leagueBranchService.isExistInLeague(id);
        if (size.size() > 0) {
            return new Message(2, "该团组织数据已经被引用，不可以被删除！", "error");
        } else {
            leagueBranchService.deleteLeagueBranchById(id);
            //菜单,按钮权限删除
            return new Message(1, "删除成功！", "success");
        }
    }
    /**
     *团组织维护首页树修改页面
     */
    @ResponseBody
    @RequestMapping("/league/editLeagueBranch")
    public ModelAndView editLeagueBranch(String id) {
        ModelAndView mv = new ModelAndView();
        LeagueBranch leagueBranch = leagueBranchService.getLeagueBranchById(id);
        mv.addObject("leagueBranch", leagueBranch);
        mv.setViewName("/business/leaguebuilding/leagueBranch/editLeagueBranch");
        return mv;
    }
    /**
     *团组织维护首页树修改保存方法
     */
    @ResponseBody
    @RequestMapping("/league/updateLeagueBranch")
    public Message updateDept(LeagueBranch leagueBranch) {
        leagueBranch.setChanger(CommonUtil.getPersonId());
        leagueBranch.setChangeDept(CommonUtil.getDefaultDept());
        leagueBranch.setChangeTime(CommonUtil.getDate());
        leagueBranchService.updateLeagueBranch(leagueBranch);
        return new Message(1, "修改成功！", null);
    }
    /**
     *团组织维护首页树删除方法
     */
    @ResponseBody
    @RequestMapping("/league/checkLeagueBranchById")
    public Message checkLeagueBranchById(String id) {
        List<LeagueBranch> leagueBranches = leagueBranchService.checkLeagueBranchById(id);
        if (leagueBranches.size()>0){
            return new Message(2, "", null);
        }
        return new Message(1, "", null);
    }
}
