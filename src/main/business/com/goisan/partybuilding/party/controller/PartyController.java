package com.goisan.partybuilding.party.controller;

/**
 * Created by fn on 2017/7/26/026.
 */

import com.goisan.partybuilding.party.bean.Party;
import com.goisan.partybuilding.party.bean.PartyMemberLog;
import com.goisan.partybuilding.party.service.PartyService;
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
public class PartyController {
    @Resource
    private PartyService partyService;

    @RequestMapping("/partyList")
    public ModelAndView partyList() {
        ModelAndView mv = new ModelAndView("/business/partybuilding/party/partyList");
        return mv;
    }

    /**
     * 党支部管理首页 by fn 20170726
     */
    @ResponseBody
    @RequestMapping("/getPartyList")
    public Map<String, List<Party>> getPartyList(Party party) {
        Map<String, List<Party>> partyMap = new HashMap<String, List<Party>>();
        party.setRelationshipChangeType("3");
        party.setCreator(CommonUtil.getPersonId());
        party.setCreateDept(CommonUtil.getDefaultDept());
        party.setLevel(CommonUtil.getLoginUser().getLevel());
        partyMap.put("data", partyService.partyAction(party));
        return partyMap;
    }

    /*
     *  党员管理新增页
    */
    @ResponseBody
    @RequestMapping("/addParty")
    public ModelAndView addParty() {
        ModelAndView mv = new ModelAndView("/business/partybuilding/party/editParty");
        Party party = new Party();
        mv.addObject("party", party);
        mv.addObject("head", "新增党员信息");
        return mv;
    }

    /*
     *修改页面
     */
    @ResponseBody
    @RequestMapping("/editParty")
    public ModelAndView editParty(String id) {
        ModelAndView mv = new ModelAndView("/business/partybuilding/party/editParty");
        Party party = partyService.getPartyById(id);
        mv.addObject("head", "党员信息修改");
        mv.addObject("party", party);
        return mv;
    }

    /**
     * 党员新增保存方法
     */
    @ResponseBody
    @RequestMapping("/saveParty")
    public Message saveParty(Party party) {
        if (party.getId() == null || party.getId().equals("") || party.getId() == "") {
            party.setCreator(CommonUtil.getPersonId());
            party.setCreateDept(CommonUtil.getDefaultDept());
            partyService.insertParty(party);
            PartyMemberLog partyMemberLog = new PartyMemberLog();
            partyMemberLog.setPersonType(party.getPersonType());
            partyMemberLog.setBranchId(party.getBranchId());
            partyMemberLog.setDeptId(party.getDeptId());
            partyMemberLog.setLogType("1");
            partyMemberLog.setPersonId(party.getPersonId());
            String remark = "在" + CommonUtil.now("yyyy-MM-dd") + "新增该条数据。";
            partyMemberLog.setLogRemark(remark);
            partyMemberLog.setCreator(CommonUtil.getPersonId());
            partyMemberLog.setCreateDept(CommonUtil.getDefaultDept());
            partyService.insertPartyMemberLog(partyMemberLog);
            return new Message(1, "新增成功！", "success");
        } else {
            party.setChanger(CommonUtil.getPersonId());
            party.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            partyService.updateParty(party);
            PartyMemberLog partyMemberLog = new PartyMemberLog();
            partyMemberLog.setPersonType(party.getPersonType());
            partyMemberLog.setBranchId(party.getBranchId());
            partyMemberLog.setDeptId(party.getDeptId());
            partyMemberLog.setLogType("2");
            partyMemberLog.setPersonId(party.getPersonId());
            String remark = "在" + CommonUtil.now("yyyy-MM-dd") + "修改了该条数据";
            partyMemberLog.setLogRemark(remark);
            partyMemberLog.setCreator(CommonUtil.getPersonId());
            partyMemberLog.setCreateDept(CommonUtil.getDefaultDept());
            partyService.insertPartyMemberLog(partyMemberLog);
            return new Message(1, "修改成功！", "success");
        }
    }

    /**
     * 新增党员名称查重
     */
    @ResponseBody
    @RequestMapping("/party/checkName")
    public Message checkName(Party party) {
        List size = partyService.checkName(party);
        if (size.size() > 0) {
            return new Message(1, "该人员的信息已存在，请检查！", null);
        } else {
            return new Message(0, "", null);
        }
    }

    @ResponseBody
    @RequestMapping("/deletePartyById")
    public Message deletePartyById(String id) {
        partyService.deletePartyById(id);
        //菜单,按钮权限删除
        return new Message(1, "删除成功！", "success");
    }

    /*
   *   党员角色变更
   */
    @ResponseBody
    @RequestMapping("/editRolesTimeById")
    public ModelAndView editRolesTimeById(String id) {
        ModelAndView mv = new ModelAndView("/business/partybuilding/party/editRolesTime");
        Party party = partyService.selectPartyRolesById(id);
        mv.addObject("head", "成员角色变更");
        mv.addObject("party", party);
        return mv;
    }

    /**
     * 单条数据角色变更
     */
    @ResponseBody
    @RequestMapping("/updatePartyRolesById")
    public Message updatePartyRolesById(Party party) {
        party.setChanger(CommonUtil.getPersonId());
        party.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        partyService.updatePartyRolesById(party);
        Party partyMsg = partyService.selectPartyById(party.getId());
        PartyMemberLog partyMemberLog = new PartyMemberLog();
        partyMemberLog.setPersonType(partyMsg.getPersonType());
        partyMemberLog.setBranchId(partyMsg.getBranchId());
        partyMemberLog.setDeptId(partyMsg.getDeptId());
        partyMemberLog.setLogType("3");
        partyMemberLog.setPersonId(partyMsg.getPersonId());
        String remark = "在" + CommonUtil.now("yyyy-MM-dd") + "将该人员变更为[" + partyMsg.getPeopleRoles()+"]";
        partyMemberLog.setLogRemark(remark);
        partyMemberLog.setCreator(CommonUtil.getPersonId());
        partyMemberLog.setCreateDept(CommonUtil.getDefaultDept());
        partyService.insertPartyMemberLog(partyMemberLog);
        return new Message(1, "角色变更成功！", "success");

    }

    /**
     * 批量变更成员对象页面
     */
    @RequestMapping("/toChangePartyRoles")
    public String toChangePartyRoles(String ids, Model model) {
        List<Party> partyList = partyService.getPartyByIds(ids.substring(0, ids.length() - 2));
        String memberRoles = "";
        String peopleRoles = "";
        String personRoles = "";
        for (Party party : partyList) {
            //取当前成员角色id
            memberRoles = party.getMemberRoles();
            //取下一阶段成员角色名称
            peopleRoles = party.getPeopleRoles();
            //取上一阶段成员角色名称
            personRoles = party.getPersonRoles();
        }
        model.addAttribute("ids", ids.replaceAll("'", ""));
        model.addAttribute("memberRoles", memberRoles);
        model.addAttribute("peopleRoles", peopleRoles);
        model.addAttribute("personRoles", personRoles);
        return "/business/partybuilding/party/changePartyRoles";
    }

    /**
     * 批量发展为下一阶段方法
     */
    @ResponseBody
    @RequestMapping("/changePartyRoles")
    public Message changePartyRoles(Party party) {
        String ids = party.getIds();
        String[] tmp = ids.split(",");
        party.setChanger(CommonUtil.getPersonId());
        party.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        if (ids.indexOf(",") == -1) {
            party.setId(ids);
            partyService.updatePartyRolesById(party);
            Party partyMsg = partyService.selectPartyById(ids);
            PartyMemberLog partyMemberLog = new PartyMemberLog();
            partyMemberLog.setPersonType(partyMsg.getPersonType());
            partyMemberLog.setBranchId(partyMsg.getBranchId());
            partyMemberLog.setDeptId(partyMsg.getDeptId());
            partyMemberLog.setLogType("3");
            partyMemberLog.setPersonId(partyMsg.getPersonId());
            String remark = "在" + CommonUtil.now("yyyy-MM-dd") + "将该人员变更为[" + partyMsg.getPeopleRoles()+"]";
            partyMemberLog.setLogRemark(remark);
            partyMemberLog.setCreator(CommonUtil.getPersonId());
            partyMemberLog.setCreateDept(CommonUtil.getDefaultDept());
            partyService.insertPartyMemberLog(partyMemberLog);
        } else {
            for (String id : tmp) {
                party.setId(id);
                partyService.updatePartyRolesById(party);
                Party partyMsg = partyService.selectPartyById(id);
                PartyMemberLog partyMemberLog = new PartyMemberLog();
                partyMemberLog.setPersonType(partyMsg.getPersonType());
                partyMemberLog.setBranchId(partyMsg.getBranchId());
                partyMemberLog.setDeptId(partyMsg.getDeptId());
                partyMemberLog.setLogType("3");
                partyMemberLog.setPersonId(partyMsg.getPersonId());
                String remark = "在" + CommonUtil.now("yyyy-MM-dd") + "将该人员变更为[" + partyMsg.getPeopleRoles()+"]";
                partyMemberLog.setLogRemark(remark);
                partyMemberLog.setCreator(CommonUtil.getPersonId());
                partyMemberLog.setCreateDept(CommonUtil.getDefaultDept());
                partyService.insertPartyMemberLog(partyMemberLog);
            }
        }
        return new Message(1, "角色变更成功！", null);
    }

    /**
     * 判断批量党员变更的角色是否统一
     */
    @ResponseBody
    @RequestMapping("/isOneMembersRoles")
    public Message isOneMembersRoles(String ids) {
        List<Party> partyList = partyService.getMembersRolesByIds(ids.substring(0, ids.length() - 2));
        if (partyList.size() == 1) {
            return new Message(1, "", null);
        } else {
            return new Message(0, "只能选择成员角色类型相同的记录", null);
        }
    }

    /**
     * 批量回调至上一发展阶段方法
     */
    @ResponseBody
    @RequestMapping("/backPartyRoles")
    public Message backPartyRoles(Party party) {
        String ids = party.getIds();
        String[] tmp = ids.split(",");
        if (ids.indexOf(",") == -1) {
            party.setId(ids);
            partyService.backPartyRolesById(party);
            Party partyMsg = partyService.selectPartyById(ids);
            PartyMemberLog partyMemberLog = new PartyMemberLog();
            partyMemberLog.setPersonType(partyMsg.getPersonType());
            partyMemberLog.setBranchId(partyMsg.getBranchId());
            partyMemberLog.setDeptId(partyMsg.getDeptId());
            partyMemberLog.setLogType("5");
            partyMemberLog.setPersonId(partyMsg.getPersonId());
            String remark = "在" + CommonUtil.now("yyyy-MM-dd") + "将该人员回调为[" + partyMsg.getPersonRoles()+"]";
            partyMemberLog.setLogRemark(remark);
            partyMemberLog.setCreator(CommonUtil.getPersonId());
            partyMemberLog.setCreateDept(CommonUtil.getDefaultDept());
            partyService.insertPartyMemberLog(partyMemberLog);
        } else {
            for (String id : tmp) {
                party.setId(id);
                partyService.backPartyRolesById(party);
                Party partyMsg = partyService.selectPartyById(id);
                PartyMemberLog partyMemberLog = new PartyMemberLog();
                partyMemberLog.setPersonType(partyMsg.getPersonType());
                partyMemberLog.setBranchId(partyMsg.getBranchId());
                partyMemberLog.setDeptId(partyMsg.getDeptId());
                partyMemberLog.setLogType("5");
                partyMemberLog.setPersonId(partyMsg.getPersonId());
                String remark = "在" + CommonUtil.now("yyyy-MM-dd") + "将该人员回调为[" + partyMsg.getPersonRoles()+"]";
                partyMemberLog.setLogRemark(remark);
                partyMemberLog.setCreator(CommonUtil.getPersonId());
                partyMemberLog.setCreateDept(CommonUtil.getDefaultDept());
                partyService.insertPartyMemberLog(partyMemberLog);
            }
        }
        return new Message(1, "角色变更成功！", null);
    }

    /*
    * 党组织关系变更首页
    * */
    @RequestMapping("/relationshipChangeList")
    public ModelAndView relationshipChangeList() {
        ModelAndView mv = new ModelAndView("/business/partybuilding/relationshipChange/relationshipChangeList");
        return mv;
    }

    /**
     * 党组织关系变更首页 by fn 20170810
     */
    @ResponseBody
    @RequestMapping("/getRelationshipChangeList")
    public Map<String, List<Party>> getRelationshipChangeList(Party party) {
        Map<String, List<Party>> partyMap = new HashMap<String, List<Party>>();
        party.setCreator(CommonUtil.getPersonId());
        party.setCreateDept(CommonUtil.getDefaultDept());
        party.setLevel(CommonUtil.getLoginUser().getLevel());
        partyMap.put("data", partyService.partyAction(party));
        return partyMap;
    }

    /**
     * 批量变更党组织关系页面
     */
    @RequestMapping("/toChangeRelationship")
    public String toChangeRelationship(String ids, Model model) {
        List<Party> partyList = partyService.getPartyByIds(ids.substring(0, ids.length() - 2));
        model.addAttribute("ids", ids.replaceAll("'", ""));
        return "/business/partybuilding/relationshipChange/relationshipChange";
    }

    /**
     * 批量变更党组织关系
     */
    @ResponseBody
    @RequestMapping("/updateRelationshipByIds")
    public Message updateRelationshipByIds(Party party) {
        String ids = party.getIds();
        String[] tmp = ids.split(",");
        party.setChanger(CommonUtil.getPersonId());
        party.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        if (ids.indexOf(",") == -1) {
            party.setId(ids);
            partyService.updateRelationshipByIds(party);
            Party partyMsg = partyService.selectPartyById(ids);
            PartyMemberLog partyMemberLog = new PartyMemberLog();
            partyMemberLog.setPersonType(partyMsg.getPersonType());
            partyMemberLog.setBranchId(partyMsg.getBranchId());
            partyMemberLog.setDeptId(partyMsg.getDeptId());
            partyMemberLog.setLogType("4");
            partyMemberLog.setPersonId(partyMsg.getPersonId());
            String remark = "在" + CommonUtil.now("yyyy-MM-dd") + "将该人员党组织关系变更为[" + partyMsg.getRelationshipChangeType()
                    + "],党支部变更为[" + partyMsg.getRemark()+"]";
            partyMemberLog.setLogRemark(remark);
            partyMemberLog.setCreator(CommonUtil.getPersonId());
            partyMemberLog.setCreateDept(CommonUtil.getDefaultDept());
            partyService.insertPartyMemberLog(partyMemberLog);
        } else {
            for (String id : tmp) {
                party.setId(id);
                partyService.updateRelationshipByIds(party);
                Party partyMsg = partyService.selectPartyById(id);
                PartyMemberLog partyMemberLog = new PartyMemberLog();
                partyMemberLog.setPersonType(partyMsg.getPersonType());
                partyMemberLog.setBranchId(partyMsg.getBranchId());
                partyMemberLog.setDeptId(partyMsg.getDeptId());
                partyMemberLog.setLogType("4");
                partyMemberLog.setPersonId(partyMsg.getPersonId());
                String remark = "在" + CommonUtil.now("yyyy-MM-dd") + "将该人员党组织关系变更为[" + partyMsg.getRelationshipChangeType()
                        + "],党支部变更为[" + partyMsg.getRemark()+"]";
                partyMemberLog.setLogRemark(remark);
                partyMemberLog.setCreator(CommonUtil.getPersonId());
                partyMemberLog.setCreateDept(CommonUtil.getDefaultDept());
                partyService.insertPartyMemberLog(partyMemberLog);
            }
        }
        return new Message(1, "党组织关系变更成功！", null);
    }

    /*
       * 党员信息综合查询首页
       * */
    @RequestMapping("/partyIntegratedQuerList")
    public ModelAndView partyIntegratedQuerList() {
        ModelAndView mv = new ModelAndView("/business/partybuilding/partyIntegratedQuer/partyIntegratedQuerList");
        return mv;
    }

    /*
       *详细信息
       */
    @ResponseBody
    @RequestMapping("/showDetailed")
    public ModelAndView showDetailed(String id) {
        ModelAndView mv = new ModelAndView("/business/partybuilding/partyIntegratedQuer/showDetailedParty");
        Party party = partyService.getPartyDetailedById(id);
        mv.addObject("head", "详细信息");
        mv.addObject("party", party);
        return mv;
    }

    /*
       *操作日志
       */
    @ResponseBody
    @RequestMapping("/showPartyLog")
    public ModelAndView showPartyLog(String id) {
        ModelAndView mv = new ModelAndView("/business/partybuilding/partyIntegratedQuer/showPartyLog");
        Party party = partyService.selectPartyById(id);
        mv.addObject("head", "操作日志");
        mv.addObject("party", party);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/getPartyLog")
    public Map getPartyLog(String personId) {
        return CommonUtil.tableMap(partyService.getPartyLogByPersonId(personId));
    }
}
