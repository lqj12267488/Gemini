package com.goisan.personnel.teachManageinfo.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface TeachMgeInfoService {

    List<BaseBean> getTeachMgeInfoList(BaseBean baseBean);

    void saveTeachMgeInfo(BaseBean baseBean);

    BaseBean getTeachMgeInfoById(String personId,String deptId);


}