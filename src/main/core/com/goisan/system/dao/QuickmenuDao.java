package com.goisan.system.dao;

import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Quickmenu;
import com.goisan.system.bean.Tree;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface QuickmenuDao {

    List<BaseBean> getQuickmenuList(BaseBean baseBean);

    List<BaseBean> getQuickmenuListByUser(BaseBean baseBean);

    List<BaseBean> getQuickmenuByUserId(@Param("userId") String userId, @Param("deptId") String deptId);

    List<Tree> getMenuListByUserId(Quickmenu quickmenu);

    void saveQuickmenu(BaseBean baseBean);

    BaseBean getQuickmenuById(String id);

    void updateQuickmenu(BaseBean baseBean);

    void delQuickmenu(String id);

    void delQMenu(@Param("userId") String userId, @Param("deptId") String deptId);
}
