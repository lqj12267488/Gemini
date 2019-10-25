package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.BookCollection;

import java.util.List;

public interface BookCollectionDao {

    List<BaseBean> getBookCollectionList(BaseBean baseBean);

    void saveBookCollection(BaseBean baseBean);

    BaseBean getBookCollectionById(String id);

    void updateBookCollection(BaseBean baseBean);

    void delBookCollection(String id);
    List<BookCollection> checkYear(BookCollection bookCollection);
}
