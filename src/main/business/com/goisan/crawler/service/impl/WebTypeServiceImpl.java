package com.goisan.crawler.service.impl;

import com.goisan.crawler.dao.WebTypeDao;
import com.goisan.crawler.service.WebTypeService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class WebTypeServiceImpl implements WebTypeService {
@Resource
private WebTypeDao webTypeDao;

    public List<BaseBean> getWebTypeList(BaseBean baseBean) {
        return webTypeDao.getWebTypeList(baseBean);
    }

    public void saveWebType(BaseBean baseBean) {
        webTypeDao.saveWebType(baseBean);
    }

    public BaseBean getWebTypeById(String id) {
        return webTypeDao.getWebTypeById(id);
    }

    public void updateWebType(BaseBean baseBean) {
        webTypeDao.updateWebType(baseBean);
    }

    public void delWebType(String id) {
        webTypeDao.delWebType(id);
    }
}
