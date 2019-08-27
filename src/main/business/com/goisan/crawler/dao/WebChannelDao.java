package com.goisan.crawler.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface WebChannelDao {

    List<BaseBean> getWebChannelList(BaseBean baseBean);

    void saveWebChannel(BaseBean baseBean);

    BaseBean getWebChannelById(String id);

    void updateWebChannel(BaseBean baseBean);

    void delWebChannel(String id);

}
