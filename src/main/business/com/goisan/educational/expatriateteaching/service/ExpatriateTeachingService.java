package com.goisan.educational.expatriateteaching.service;

import com.goisan.educational.expatriateteaching.bean.ExpatriateTeaching;
import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ExpatriateTeachingService {

    List<ExpatriateTeaching> getExpatriateTeachingList(ExpatriateTeaching expatriateTeaching);

    void saveExpatriateTeaching(BaseBean baseBean);

    BaseBean getExpatriateTeachingById(String id);

    void updateExpatriateTeaching(BaseBean baseBean);

    void delExpatriateTeaching(String id);

}