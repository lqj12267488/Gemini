package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface SchAwardDao {

    List<BaseBean> getSchAwardList(BaseBean baseBean);

    void saveSchAward(BaseBean baseBean);

    BaseBean getSchAwardById(String id);

    void updateSchAward(BaseBean baseBean);

    void delSchAward(String id);

}
