package com.goisan.crawler.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface WebTypeService {

    List<BaseBean> getWebTypeList(BaseBean baseBean);

    void saveWebType(BaseBean baseBean);

    BaseBean getWebTypeById(String id);

    void updateWebType(BaseBean baseBean);

    void delWebType(String id);

}