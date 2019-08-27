package com.goisan.system.controller;

import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.Quickmenu;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.QuickmenuService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
// @RequestMapping("")
public class QuickmenuController {

    @Resource
    private QuickmenuService quickmenuService;

    @RequestMapping("/quickmenu/toQuickmenuList")
    public String toList() {
        return "/core/quickmenu/quickmenuList";
    }

    @ResponseBody
    @RequestMapping("/quickmenu/getQuickmenuList")
    public Map getList(Quickmenu quickmenu) {
        return CommonUtil.tableMap(quickmenuService.getQuickmenuList(quickmenu));
    }

    @ResponseBody
    @RequestMapping("/quickmenu/getQuickmenuListByUser")
    public Map getListByUser(Quickmenu quickmenu) {
        return CommonUtil.tableMap(quickmenuService.getQuickmenuListByUser(quickmenu));
    }

    @RequestMapping("/quickmenu/toQuickmenuAdd")
    public ModelAndView toAdd(String userId) {
        ModelAndView mv = new ModelAndView("/core/quickmenu/quickmenuEdit");
        mv.addObject("head", "快捷菜单编辑");
        mv.addObject("userId", userId);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/quickmenu/getQuickmenuTree")
    public Map getQuickmenuTree(String userId, HttpSession session) {
        Map<String, List> map = new HashMap<>();
        map.put("data", quickmenuService.getQuickmenuByUserId(userId));
        Quickmenu quickmenu = new Quickmenu();
        LoginUser loginUser = CommonUtil.getLoginUser();
        if (userId.equals(loginUser.getPersonId())) {
            quickmenu.setUserId(loginUser.getPersonId());
            quickmenu.setDeptId(loginUser.getDefaultDeptId());
            quickmenu.setUserType(loginUser.getUserType());
        }
        List<Tree> TreeList = quickmenuService.getMenuListByUserId(quickmenu);
        Tree tree = new Tree();
        tree.setId((String) session.getAttribute("systemId"));
        tree.setName("菜单树");
        tree.setpId("MenuRootNode");
        TreeList.add(tree);

        map.put("menuTree", TreeList);
        return map;
    }

    @ResponseBody
    @RequestMapping("/quickmenu/saveQuickmenu")
    public Message save(String userId, String mentuValue) {
        quickmenuService.saveQMenu(userId, mentuValue);
        return new Message(0, "添加成功！", null);
    }

    @RequestMapping("/quickmenu/toQuickmenuEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", quickmenuService.getQuickmenuById(id));
        model.addAttribute("head", "修改");
        return "/core/quickmenu/quickmenuEdit";
    }

    @ResponseBody
    @RequestMapping("/quickmenu/delQuickmenu")
    public Message del(String id) {
        quickmenuService.delQuickmenu(id);
        return new Message(0, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/quickmenu/getMenuListIndex")
    public Map getMenuListIndex() {
        return CommonUtil.tableMap(quickmenuService.getMenuListIndex());
    }

    @RequestMapping("/quickmenu/toEditByUser")
    public ModelAndView toEditByUser() {
        ModelAndView mv = new ModelAndView("/core/quickmenu/quickmenuEdit");
        String userId = CommonUtil.getPersonId();
        mv.addObject("head", "快捷菜单编辑");
        mv.addObject("userId", userId);
        return mv;


    }

}
