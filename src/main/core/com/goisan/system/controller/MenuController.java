package com.goisan.system.controller;

import com.github.stuxuhai.jpinyin.PinyinException;
import com.github.stuxuhai.jpinyin.PinyinHelper;
import com.goisan.system.bean.Menu;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.MenuService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.sql.Date;
import java.util.List;

/**
 * Created by Admin on 2017/4/21.
 */
@Controller
public class MenuController {
    @Resource
    private MenuService menuService;

    @ResponseBody
    @RequestMapping("/getMenuList")
    public List<Menu> getMenuList(String id) {
        return menuService.getMenuListByParentId(id);
    }

    @RequestMapping("/MenuTree")
    public ModelAndView MenuTree() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/menu/menuTree");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/getMenuTree")
    public List<Tree> getMenuTree() {
        List<Tree> a = menuService.getMenuTree();
        Tree tree = new Tree();
        tree.setId("0");
        tree.setName("菜单树");
        tree.setpId("MenuRootNode");
        a.add(tree);
        return a;
    }

    @ResponseBody
    @RequestMapping("/getSystemMenuTree")
    public List<Tree> getSysMenuTree() {
        List<Tree> a = menuService.getSystemMenuTree();
        Tree tree = new Tree();
        tree.setId("0");
        tree.setName("菜单树");
        tree.setpId("MenuRootNode");
        a.add(tree);
        return a;
    }

    @RequestMapping("/getMenuById")
    public ModelAndView getMenuById(String id) {
        ModelAndView mv = new ModelAndView();
        Menu menu = menuService.getMenuById(id);
        mv.addObject("menu", menu);
        mv.addObject("head", "菜单修改");
        mv.setViewName("/menu/editMenu");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/addMenu")
    public ModelAndView addMenu(String pId) {
        ModelAndView mv = new ModelAndView();
        Menu menu = new Menu();
        int resourceType = 0;
        if (!"0".equals(pId)) {
            resourceType = 1;
        }
        menu.setResourcetype(resourceType);
        menu.setParentresourceid(pId);
        mv.addObject("menu", menu);
        mv.addObject("head", "菜单新增");
        mv.setViewName("/menu/editMenu");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/deleteMenuById")
    public Message deleteMenuById(String id) {
        menuService.deleteMenuById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/updateMenu")
    public Message updateMenu(Menu menu) {
        if ("0".equals(menu.getParentresourceid()) && menu.getResourcetype() == 0) {
            String menuName = null;
            try {
                menuName = PinyinHelper.getShortPinyin(menu.getResourcename()).toUpperCase();
            } catch (PinyinException e) {
                e.printStackTrace();
            }
            menu.setSystem(menuName);
        } else if ("0".equals(menu.getParentresourceid()) && menu.getResourcetype() != 0) {
            return new Message(1, "添加失败！当前菜单类型只能为系统！", null);
        } else {
            menu.setSystem(menuService.getMenuById(menu.getParentresourceid()).getSystem());
        }
        if (menu.getResourceid() == null || "".equals(menu.getResourceid())) {
            String Parentid = menu.getParentresourceid();
            List<Menu> menuList = menuService.getMenuListOrderByMenuId(Parentid);
            if (menuList == null || menuList.size() == 0) {
                menu.setResourceid(CommonUtil.getnextId("", Parentid));
            } else {
                Menu menuC = menuList.get(menuList.size() - 1);
                menu.setResourceid(CommonUtil.getnextId(menuC.getResourceid(), Parentid));
            }
            menu.setCreator(CommonUtil.getPersonId());
            menu.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            menu.setCreateTime(CommonUtil.getDate());
            menuService.insertMenu(menu);
            return new Message(1, "新增成功！", null);
        } else {
            menu.setChanger(CommonUtil.getPersonId());
            menu.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            menu.setChangeTime(CommonUtil.getDate());
            menuService.updateMenu(menu);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/insertMenu")
    public Message insertMenu(Menu menu) {
        Date date = new Date(new java.util.Date().getTime());
        String Parentid = menu.getParentresourceid();
        List<Menu> menuList = menuService.getMenuListByParentId(Parentid);
        if (menuList == null || menuList.size() == 0)
            CommonUtil.getnextId("", Parentid);
        else {
            Menu menuC = menuList.get(menuList.size() - 1);
            CommonUtil.getnextId(menuC.getResourceid(), Parentid);
        }
        menu.setCreator(CommonUtil.getPersonId());
        menu.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        menu.setCreateTime(CommonUtil.getDate());
        menuService.updateMenu(menu);
        return new Message(1, "新增成功！", null);
    }

}
