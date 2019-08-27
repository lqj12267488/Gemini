package com.goisan.crawler.service.impl;

import com.goisan.crawler.dao.ContentDao;
import com.goisan.crawler.service.ContentService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ContentServiceImpl implements ContentService {
    @Resource
    private ContentDao contentDao;

    public List<BaseBean> getContentList(BaseBean baseBean) {
        return contentDao.getContentList(baseBean);
    }

}
