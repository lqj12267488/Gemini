package com.goisan.log.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ResourceLogService {

    List<BaseBean> getResourceLogList(BaseBean baseBean);

    List<BaseBean> getPrivateResourceLogList(BaseBean baseBean);

    void saveResourceLog(BaseBean baseBean);

    BaseBean getResourceLogById(String id);

    void updateResourceLog(BaseBean baseBean);

    void delResourceLog(String id);

    void delStatistics();

    void insertStatistics();

}