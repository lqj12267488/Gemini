package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;
import java.util.Map;

public interface QualificationService {

    List<BaseBean> getQualificationList(BaseBean baseBean);

    void saveQualification(BaseBean baseBean);

    BaseBean getQualificationById(String id);

    void updateQualification(BaseBean baseBean);

    void delQualification(String id);

    List<Map> getQualificationBySelect();

}