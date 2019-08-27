package com.goisan.crawler.service.impl;

import com.goisan.crawler.dao.WebChannelDao;
import com.goisan.crawler.service.WebChannelService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class WebChannelServiceImpl implements WebChannelService {
@Resource
private WebChannelDao webChannelDao;

    public List<BaseBean> getWebChannelList(BaseBean baseBean) {
        return webChannelDao.getWebChannelList(baseBean);
    }

    public void saveWebChannel(BaseBean baseBean) {
        webChannelDao.saveWebChannel(baseBean);
    }

    public BaseBean getWebChannelById(String id) {
        return webChannelDao.getWebChannelById(id);
    }

    public void updateWebChannel(BaseBean baseBean) {
        webChannelDao.updateWebChannel(baseBean);
    }

    public void delWebChannel(String id) {
        webChannelDao.delWebChannel(id);
    }
}
