package com.goisan.system.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ParentMessageDao {

    List<BaseBean> getParentMessageList(BaseBean baseBean);

    void saveParentMessage(BaseBean baseBean);

    BaseBean getParentMessageById(String id);

    void updateParentMessage(BaseBean baseBean);

    void delParentMessage(String id);

    void delParentMessageChild(String id);

    void saveParentMessageLog(BaseBean baseBean);

    void  updateParentMessageLog(BaseBean baseBean);

    void delParentMessageLog(String id);

    List<BaseBean> getParentMessageChildById(BaseBean baseBean);

    List<BaseBean> getParentMessageListByTeacher(BaseBean baseBean);

}
