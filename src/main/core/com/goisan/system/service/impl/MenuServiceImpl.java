package com.goisan.system.service.impl;

import com.goisan.system.bean.Menu;
import com.goisan.system.bean.Tree;
import com.goisan.system.dao.MenuDao;
import com.goisan.system.service.MenuService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Admin on 2017/4/21.
 */
@Service
public class MenuServiceImpl implements MenuService {
    @Resource
    private MenuDao menuDao;

    public List<Menu> getMenuListByParentId(String pId) {
        return menuDao.getMenuListByParentId(pId);
    }

    public List<Menu> getMenuListOrderByMenuId(String pId) {
        return menuDao.getMenuListOrderByMenuId(pId);
    }

    public List<Tree> getMenuTree() {
        return menuDao.getMenuTree();
    }

    public List<Tree> getSystemMenuTree() {
        return menuDao.getSystemMenuTree();
    }

    public Menu getMenuById(String id) {
        return menuDao.getMenuById(id);
    }

    public void deleteMenuById(String id) {
        menuDao.deleteMenuById(id);
    }

    public void updateMenu(Menu menu) {
        menuDao.updateMenu(menu);
    }

    public List<Menu> getMenuListByRoles(String roles, String system, String id) {
        return menuDao.getMenuListByRoles(roles, system, id);
    }

    public void insertMenu(Menu menu) {
        menuDao.insertMenu(menu);
    }

    @Override
    public List<Menu> getMenuListSystem(String s) {
        return menuDao.getMenuListSystem(s);
    }

    @Override
    public List<Menu> getMenusByRoles(String roleIds, String id) {
        List<Menu> menus = menuDao.getMenusByRoles(roleIds, id);
        getMenuChildren(roleIds, menus);
        return menus;
    }

    private void getMenuChildren(String roleIds, List<Menu> menus) {
        for (Menu menu : menus) {
            List<Menu> children = menuDao.getMenusByRoles(roleIds, menu.getResourceid());
            menu.setMenuList(children);
            getMenuChildren(roleIds, children);
        }
    }
}
