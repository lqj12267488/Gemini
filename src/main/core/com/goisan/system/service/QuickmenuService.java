package com.goisan.system.service;

import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Quickmenu;
import com.goisan.system.bean.Tree;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface QuickmenuService {

    List<BaseBean> getQuickmenuList(BaseBean baseBean);

    List<BaseBean> getQuickmenuListByUser(BaseBean baseBean);

    List<BaseBean> getQuickmenuByUserId(String userId);

    List<Tree> getMenuListByUserId(Quickmenu quickmenu);

    void saveQuickmenu(BaseBean baseBean);

    BaseBean getQuickmenuById(String id);

    void updateQuickmenu(BaseBean baseBean);

    void delQuickmenu(String id);

    void delQMenu(String userId,String deptId);

    @Transactional
    void saveQMenu(String userId , String mentuValue);

    @Transactional
    List<BaseBean> getMenuListIndex();

}