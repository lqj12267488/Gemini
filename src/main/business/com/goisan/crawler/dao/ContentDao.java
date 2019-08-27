package com.goisan.crawler.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ContentDao {

    List<BaseBean> getContentList(BaseBean baseBean);

}
