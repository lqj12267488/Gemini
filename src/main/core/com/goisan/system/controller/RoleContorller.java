package com.goisan.system.controller;

import com.goisan.system.bean.Role;
import com.goisan.system.bean.RoleResRelation;
import com.goisan.system.service.RoleService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/4/26.
 */
@Controller
public class RoleContorller {

    @Resource
    private RoleService roleService;

    /**
     * 角色基本信息 功能
     * start
     */
    public List<Role> getRoleList(String id) {
        return roleService.getRoleList(id);
    }

    @RequestMapping("/RoleList")
    public ModelAndView RoleList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/role/roleGrid");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/getRoleList")
    public Map<String, List<Role>> getRoleList() {
        Map<String, List<Role>> role = new HashMap<String, List<Role>>();
        role.put("data", roleService.getRoleList(new Role()));
        return role;
    }

    @ResponseBody
    @RequestMapping("/getRoleById")
    public ModelAndView getRoleById(String id) {
        ModelAndView mv = new ModelAndView("/core/role/editRole");
        Role role = roleService.getRoleById(id);
        mv.addObject("head", "角色修改");
        mv.addObject("role", role);
        return mv;
    }

    @RequestMapping("/addRole")
    public ModelAndView addRole() {
        ModelAndView mv = new ModelAndView("/core/role/editRole");
        mv.addObject("head", "角色新增");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/deleteRoleById")
    public Message deleteRoleById(String id) {
        roleService.deleteRoleById(id);
        //删除 教职工 角色 授权
        roleService.delRoleEmpDeptRelationByRoleid(id);
        //删除 学生 角色 授权
        roleService.delAndSaveStuRelation(id,"");
        //删除 学生家长 角色 授权

        //菜单,按钮权限删除
        roleService.deleteRoleResourceByRoleid(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/updateRole")
    public Message updateRole(Role role) {
        Date date = new Date(new java.util.Date().getTime());
        role.setChanger(CommonUtil.getPersonId());
        role.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        role.setChangeTime(CommonUtil.getDate());
        roleService.updateRole(role);
        return new Message(1, "修改成功！", null);
    }

    @ResponseBody
    @RequestMapping("/insertRole")
    public Message insertRole(Role role) {
        Date date = new Date(new java.util.Date().getTime());
        role.setCreator(CommonUtil.getPersonId());
        role.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        role.setCreateTime(CommonUtil.getDate());
        role.setRoleid(CommonUtil.getUUID());
        roleService.insertRole(role);
        return new Message(1, "新增成功！", null);
    }

    @ResponseBody
    @RequestMapping("/saveRole")
    public Message saveRole(Role role) {
        Date date = new Date(new java.util.Date().getTime());
        role.setCreateTime(CommonUtil.getDate());
        if (role.getRoleid() == null || "".equals(role.getRoleid())) {
            role.setCreator(CommonUtil.getPersonId());
            role.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            role.setRoleid(CommonUtil.getUUID());
            roleService.insertRole(role);
            return new Message(1, "新增成功！", null);
        } else {
            role.setChanger(CommonUtil.getPersonId());
            role.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            roleService.updateRole(role);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/role/search")
    public Map<String, List<Role>> search(Role role) {
        Map<String, List<Role>> roleList = new HashMap<String, List<Role>>();
        List<Role> r = roleService.getRoleList(role);
        roleList.put("data", r);
        return roleList;
    }

    /**
     * 角色基本信息 功能
     * end
     */

    /**
     * 角色 -- 菜单 功能
     * start
     */
    @RequestMapping("/roleMenuRelationByRole")
    public ModelAndView roleMenuRelationByRole(String roleid) {
        List<RoleResRelation> list = roleService.getRoleMenuRelationByRole(roleid);
        String menulist = "";
        boolean b = true;
        for (int i = 0; i < list.size(); i++) {
            RoleResRelation r = list.get(i);
            if (b) {
                menulist += r.getResourceid();
                b = false;
            } else
                menulist += "," + r.getResourceid();
        }
        ModelAndView mv = new ModelAndView("/core/role/roleMenuRelation");
        mv.addObject("roleid", roleid);
        mv.addObject("head", "菜单授权");
        mv.addObject("roleResRelation", menulist);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/saveRelation")
    public Message saveRelation(String roleid, String relationids) {
        roleService.saveRelation(roleid, relationids);
        return new Message(1, "保存成功！", null);
    }

    /**
     * 角色 -- 菜单 功能
     * end
     */

    /**
     * 角色 -- 教职工 功能
     * start
     */
    @RequestMapping("/rolePerRelationByRole")
    public ModelAndView rolePerRelationByRole(String roleid) {
        ModelAndView mv = new ModelAndView("/core/role/rolePerRel");
        mv.addObject("roleid", roleid);
        ModelAndView modelAndView = mv.addObject("head", "用户授权");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/savePerRelation")
    public Message savePerRelation(String roleid, String checkList) {
        roleService.delRoleEmpDeptRelationByRoleidAndInsertRoleEmpDeptRelation(roleid, checkList);
        return new Message(1, "保存成功！", null);
    }
    /**
     * 角色 -- 教职工 功能
     * end
     */

    /**
     * 角色 -- 学生 功能
     * start
     */
    @RequestMapping("/role/roleStuRel")
    public ModelAndView roleStuRel(String roleid) {
        ModelAndView mv = new ModelAndView("/core/role/roleStuRel");
        mv.addObject("roleid", roleid);
        ModelAndView modelAndView = mv.addObject("head", "学生授权");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/role/saveStuRelation")
    public Message saveStuRelation(String roleid, String checkList) {
        roleService.delAndSaveStuRelation(roleid,checkList);
        return new Message(1, "保存成功！", null);
    }
    /**
     * 角色 -- 学生 功能
     * end
     */

    /**
     * 角色 -- 学生家长 功能
     * start
     */
    @RequestMapping("/role/roleParStuRel")
    public ModelAndView rolePerStuRel(String roleid) {
        ModelAndView mv = new ModelAndView("/core/role/roleParStuRel");
        mv.addObject("roleid", roleid);
        ModelAndView modelAndView = mv.addObject("head", "学生家长授权");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/role/savePerStuRelation")
    public Message savePerStuRelation(String roleid, String checkList) {
        roleService.delAndSaveParStuRelation(roleid,checkList);
        return new Message(1, "保存成功！", null);
    }
    /**
     * 角色 -- 学生家长 功能
     * end
     */


}
