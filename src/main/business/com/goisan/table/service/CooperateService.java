package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.Cooperate;

import java.util.List;

public interface CooperateService {

    List<BaseBean> getCooperateList(BaseBean baseBean);

    void saveCooperate(BaseBean baseBean);

    Cooperate getCooperateById(String id);

    void updateCooperate(BaseBean baseBean);

    void delCooperate(String id);

    List<String> selectMajorName();
}