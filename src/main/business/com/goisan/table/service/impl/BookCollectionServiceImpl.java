package com.goisan.table.service.impl;

import com.goisan.table.dao.BookCollectionDao;
import com.goisan.table.service.BookCollectionService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class BookCollectionServiceImpl implements BookCollectionService {

    @Resource
    private BookCollectionDao bookCollectionDao;

    @Override
    public List<BaseBean> getBookCollectionList(BaseBean baseBean) {
        return bookCollectionDao.getBookCollectionList(baseBean);
    }

    @Override
    public void saveBookCollection(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        bookCollectionDao.saveBookCollection(baseBean);
    }

    @Override
    public BaseBean getBookCollectionById(String id) {
        return bookCollectionDao.getBookCollectionById(id);
    }

    @Override
    public void updateBookCollection(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        bookCollectionDao.updateBookCollection(baseBean);
    }

    @Override
    public void delBookCollection(String id) {
        bookCollectionDao.delBookCollection(id);
    }
}
