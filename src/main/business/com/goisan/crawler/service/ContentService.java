package com.goisan.crawler.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ContentService {

    List<BaseBean> getContentList(BaseBean baseBean);

}