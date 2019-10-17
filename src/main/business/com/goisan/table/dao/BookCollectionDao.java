package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface BookCollectionDao {

    List<BaseBean> getBookCollectionList(BaseBean baseBean);

    void saveBookCollection(BaseBean baseBean);

    BaseBean getBookCollectionById(String id);

    void updateBookCollection(BaseBean baseBean);

    void delBookCollection(String id);

}
