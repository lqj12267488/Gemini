package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface TeachContactDao {

    List<BaseBean> getTeachContactList(BaseBean baseBean);

    void saveTeachContact(BaseBean baseBean);

    BaseBean getTeachContactById(String id);

    void updateTeachContact(BaseBean baseBean);

    void delTeachContact(String id);

}
