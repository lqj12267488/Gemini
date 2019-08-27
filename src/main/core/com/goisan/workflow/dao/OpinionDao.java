package com.goisan.workflow.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface OpinionDao {

    List<BaseBean> getOpinionList(BaseBean baseBean);

    void saveOpinion(BaseBean baseBean);

    BaseBean getOpinionById(String id);

    void updateOpinion(BaseBean baseBean);

    void delOpinion(String id);

}
