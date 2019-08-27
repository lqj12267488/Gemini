package com.goisan.operateLog.dao;

import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ResourceOperateLogDao {

    List<BaseBean> getResourceOperateLogList(BaseBean baseBean);

    void saveResourceOperateLog(BaseBean baseBean);

    BaseBean getResourceOperateLogById(String id);

    void updateResourceOperateLog(BaseBean baseBean);

    void delResourceOperateLog(String id);

}
