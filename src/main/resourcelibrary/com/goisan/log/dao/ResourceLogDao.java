package com.goisan.log.dao;

import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ResourceLogDao {

    List<BaseBean> getResourceLogList(BaseBean baseBean);

    List<BaseBean> getPrivateResourceLogList(BaseBean baseBean);

    void saveResourceLog(BaseBean baseBean);

    BaseBean getResourceLogById(String id);

    void updateResourceLog(BaseBean baseBean);

    void delResourceLog(String id);

    void delStatistics();

    void insertStatistics();

}
