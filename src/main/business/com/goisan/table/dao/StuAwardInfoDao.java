package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface StuAwardInfoDao {

    List<BaseBean> getStuAwardInfoList(BaseBean baseBean);

    void saveStuAwardInfo(BaseBean baseBean);

    BaseBean getStuAwardInfoById(String id);

    void updateStuAwardInfo(BaseBean baseBean);

    void delStuAwardInfo(String id);

}
