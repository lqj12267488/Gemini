package com.goisan.system.service;

import com.goisan.system.bean.Menu;
import com.goisan.system.bean.Tree;

import java.util.List;

/**
 * Created by Admin on 2017/4/21.
 */
public interface MenuService {
    List<Menu> getMenuListByParentId(String pId);

    List<Menu> getMenuListOrderByMenuId(String pId);

    List<Tree> getMenuTree();

    List<Tree> getSystemMenuTree();

    Menu getMenuById(String id);

    void deleteMenuById(String id);

    void updateMenu(Menu menu);

    void insertMenu(Menu menu);

    List<Menu> getMenuListByRoles(String roles, String system, String id);

    List<Menu> getMenuListSystem(String s);

    List<Menu> getMenusByRoles(String roleIds, String id);
}
