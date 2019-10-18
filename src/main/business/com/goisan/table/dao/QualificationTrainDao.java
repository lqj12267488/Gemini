package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface QualificationTrainDao {

    List<BaseBean> getQualificationTrainList(BaseBean baseBean);

    void saveQualificationTrain(BaseBean baseBean);

    BaseBean getQualificationTrainById(String id);

    void updateQualificationTrain(BaseBean baseBean);

    void delQualificationTrain(String id);

}
