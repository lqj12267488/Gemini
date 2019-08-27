package com.goisan.partybuilding.party.controller;

/**
 * Created by fn on 2017/7/26/026.
 */

import com.goisan.partybuilding.party.bean.PartyBranch;
import com.goisan.partybuilding.party.service.PartyBranchService;
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

@Controller
public class PartyBranchController {
    @Resource
    private PartyBranchService partyBranchService;

    @RequestMapping("/partyBranchList")
    public ModelAndView partyBranchList() {
        ModelAndView mv = new ModelAndView("/business/partybuilding/partyBranch/partyBranchList");
        return mv;
    }

    /**
     * 党支部管理首页 by fn 20170726
     */
    @ResponseBody
    @RequestMapping("/getPartyBranchList")
    public Map<String, List<PartyBranch>> getPartyBranchList(PartyBranch partyBranch) {
        Map<String, List<PartyBranch>> partyBranchMap = new HashMap<String, List<PartyBranch>>();
        partyBranch.setCreator(CommonUtil.getPersonId());
        partyBranch.setCreateDept(CommonUtil.getDefaultDept());
        partyBranch.setLevel(CommonUtil.getLoginUser().getLevel());
        partyBranchMap.put("data", partyBranchService.partyBranchAction(partyBranch));
        return partyBranchMap;
    }

    /**
     * 党支部管理新增页
     */
    @ResponseBody
    @RequestMapping("/addPartyBranch")
    public ModelAndView addPartyBranch() {
        ModelAndView mv = new ModelAndView("/business/partybuilding/partyBranch/addPartyBranch");
        PartyBranch partyBranch = new PartyBranch();
        mv.addObject("partyBranch", partyBranch);
        mv.addObject("head", "新增党支部");
        return mv;
    }

    /*
     *修改页面
     */
    @ResponseBody
    @RequestMapping("/editPartyBranch")
    public ModelAndView getPartyBranch(String id) {
        ModelAndView mv = new ModelAndView("/business/partybuilding/partyBranch/editPartyBranch");
        PartyBranch partyBranch = partyBranchService.getPartyBranchById(id);
        mv.addObject("head", "党支部修改");
        mv.addObject("partyBranch", partyBranch);
        return mv;
    }

    /**
     * 党支部新增保存方法
     */
    @ResponseBody
    @RequestMapping("/savePartyBranch")
    public Message savePartyBranch(PartyBranch partyBranch) {
        if (partyBranch.getId() == null || partyBranch.getId().equals("") || partyBranch.getId() == "") {
            partyBranch.setCreator(CommonUtil.getPersonId());
            partyBranch.setCreateDept(CommonUtil.getDefaultDept());
            partyBranchService.insertPartyBranch(partyBranch);
            return new Message(1, "新增成功！", "success");
        } else {
            partyBranch.setChanger(CommonUtil.getPersonId());
            partyBranch.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            partyBranchService.updatePartyBranch(partyBranch);
            return new Message(1, "修改成功！", "success");
        }
    }

    /**
     * 党支部名称查重
     */
    @ResponseBody
    @RequestMapping("/partyBranch/checkName")
    public Message checkName(PartyBranch partyBranch) {
        List size = partyBranchService.checkName(partyBranch);
        if (size.size() > 0) {
            return new Message(1, "名称重复，请重新填写！", null);
        } else {
            return new Message(0, "", null);
        }
    }

    @ResponseBody
    @RequestMapping("deletePartyBranchById")
    public Message deletePartyBranchById(String id) {
        List size = partyBranchService.isExistInParty(id);
        if (size.size() > 0) {
            return new Message(1, "该党支部数据已经被引用，不可以被删除！", "error");
        } else {
            partyBranchService.deletePartyBranchById(id);
            //菜单,按钮权限删除
            return new Message(1, "删除成功！", "success");
        }
    }

    @ResponseBody
    @RequestMapping("/searchPartyBranch")
    public Map<String, List<PartyBranch>> searchPartyBranch(PartyBranch partyBranch) {
        Map<String, List<PartyBranch>> partyBranchMap = new HashMap<String, List<PartyBranch>>();
        partyBranch.setCreator(CommonUtil.getPersonId());
        partyBranch.setCreateDept(CommonUtil.getDefaultDept());
        partyBranch.setLevel(CommonUtil.getLoginUser().getLevel());
        partyBranchMap.put("data", partyBranchService.searchPartyBranchList(partyBranch));
        return partyBranchMap;
    }

}
