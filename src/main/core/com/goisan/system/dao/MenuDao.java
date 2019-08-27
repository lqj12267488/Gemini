package com.goisan.system.dao;

import com.goisan.system.bean.Menu;
import com.goisan.system.bean.Tree;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Admin on 2017/4/21.
 */
@Repository
public interface MenuDao {
    List<Menu> getMenuListByParentId(String pId);

    List<Menu> getMenuListOrderByMenuId(String pId);

    List<Tree> getMenuTree();

    List<Tree> getSystemMenuTree();

    Menu getMenuById(String id);

    void deleteMenuById(String id);

    void updateMenu(Menu menu);

    void insertMenu(Menu menu);

    List<Menu> getMenuListByRoles(@Param("roles") String roles, @Param("system") String system, @Param("parentId") String parentId);

    List<Menu> getMenuListSystem(String system);

    List<Menu> getMenusByRoles(@Param("roleIds") String roleIds, @Param("id") String id);
}
