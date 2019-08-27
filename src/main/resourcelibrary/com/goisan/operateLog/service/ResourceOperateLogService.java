package com.goisan.operateLog.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ResourceOperateLogService {

    List<BaseBean> getResourceOperateLogList(BaseBean baseBean);

    void saveResourceOperateLog(BaseBean baseBean);

    BaseBean getResourceOperateLogById(String id);

    void updateResourceOperateLog(BaseBean baseBean);

    void delResourceOperateLog(String id);

}