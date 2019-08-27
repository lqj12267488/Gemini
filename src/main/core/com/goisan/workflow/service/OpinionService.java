package com.goisan.workflow.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface OpinionService {

    List<BaseBean> getOpinionList(BaseBean baseBean);

    void saveOpinion(BaseBean baseBean);

    BaseBean getOpinionById(String id);

    void updateOpinion(BaseBean baseBean);

    void delOpinion(String id);

}