package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface BookCollectionService {

    List<BaseBean> getBookCollectionList(BaseBean baseBean);

    void saveBookCollection(BaseBean baseBean);

    BaseBean getBookCollectionById(String id);

    void updateBookCollection(BaseBean baseBean);

    void delBookCollection(String id);

}