package com.goisan.system.controller;

import com.goisan.system.bean.CommonGroup;
import com.goisan.system.bean.CommonGroupMember;
import com.goisan.system.bean.EmpDeptTree;
import com.goisan.system.bean.Role;
import com.goisan.system.service.CommonGroupService;
import com.goisan.system.service.RoleService;
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
 * Created by admin on 2017/6/30.
 */
@Controller
public class CommonGroupController {
    @Resource
    private CommonGroupService commonGroupService;
    @Resource
    private RoleService roleService;

    @ResponseBody
    @RequestMapping("/commonGroup/getGrid")
    public ModelAndView getGrid() {
        ModelAndView mv = new ModelAndView("/core/CommonGroup/commonGroupGrid");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/commonGroup/getGroupList")
    public Map<String, List<CommonGroup>> getGroupList(CommonGroup commomGroup) {
        Map<String, List<CommonGroup>> group = new HashMap<String, List<CommonGroup>>();
        group.put("data", commonGroupService.getGroupList(commomGroup));
        return group;
    }

    @ResponseBody
    @RequestMapping("/commonGroup/addGroup")
    public ModelAndView addGroup() {
        ModelAndView mv = new ModelAndView("/core/CommonGroup/editCommonGroup");
        mv.addObject("head","新增分组");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/commonGroup/editGroup")
    public ModelAndView editGroup(String groupId) {
        ModelAndView mv = new ModelAndView("/core/CommonGroup/editCommonGroup");
        mv.addObject("commomGroup",commonGroupService.getGroupById(groupId));
        mv.addObject("head","修改分组");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/commonGroup/updateGroup")
    public Message updateEmp(CommonGroup commomGroup) {
        if(null == commomGroup.getGroupId() || "".equals(commomGroup.getGroupId())){
            commomGroup.setCreator(CommonUtil.getPersonId());
            commomGroup.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            commonGroupService.insertGroup(commomGroup);
            return new Message(1, "新增成功！", null);
        }else{
            commomGroup.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            commomGroup.setChanger(CommonUtil.getPersonId());
            commonGroupService.updateGroup(commomGroup);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/commonGroup/delGroup")
    public Message delGroup(String groupId) {
        commonGroupService.delCommonGroupMember(groupId);
        commonGroupService.delCommonGroup(groupId);
        commonGroupService.delGroupRole(groupId);
        return new Message(1, "删除成功！", null);
    }

    @RequestMapping("/commonGroup/editEmp")
    public ModelAndView toSelectEmps(String groupId) {
        ModelAndView mv = new ModelAndView("/core/CommonGroup/groupEmpTree");
        mv.addObject("groupId", groupId);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/commonGroup/getEmpTree")
    public  List<EmpDeptTree> getEmpTree(String groupId) {
        List<EmpDeptTree> trees = commonGroupService.getGroupEmpTree(groupId);
        return trees;
    }

    @ResponseBody
    @RequestMapping("/commonGroup/saveCommomGroupMember")
    public Message saveCommomGroupMember(String groupId, String checkList) {
        commonGroupService.delCommonGroupMember(groupId);
        if (checkList.length() > 0) {
            String[] check = checkList.split(";");
            for (int i = 0; i < check.length; i++) {
                CommonGroupMember r = new CommonGroupMember();
                r.setGroupId(groupId);
                String a = (String) check[i];
                String[] b = a.split(",");
                r.setDeptId(b[1].toString());
                r.setPersonId(b[0].toString());
                r.setName(b[2].toString());
                r.setCreator(CommonUtil.getPersonId());
                r.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
                r.setCreateTime(CommonUtil.getDate());
                commonGroupService.insertCommonGroupMember(r);
            }
        }
        return new Message(1, "保存成功！", null);
    }

    @RequestMapping("/commonGroup/editRole")
    public ModelAndView editRole(String groupId) {
        ModelAndView mv = new ModelAndView("/core/CommonGroup/editGroupRole");
        mv.addObject("roleList",CommonUtil.jsonUtil( roleService.getRoleList(new Role())));
        mv.addObject("groupRoleList",CommonUtil.jsonUtil( commonGroupService.getGroupRole(groupId)));
        mv.addObject("groupId", groupId);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/commonGroup/saveRole")
    public Message editRole(CommonGroup commomGroup) {
        if (!"".equals(commomGroup.getRoleId())) {
            commonGroupService.insertGroupRole(commomGroup);
        }
        return new Message(1, "保存成功！", null);
    }

    @RequestMapping("/commonGroup/viewMenu")
    public ModelAndView viewMenu(String groupId) {
        ModelAndView mv = new ModelAndView("/core/CommonGroup/viewMenu");
        mv.addObject("menuList",CommonUtil.jsonUtil(commonGroupService.getGroupMenu(groupId)));
        return mv;
    }



}
