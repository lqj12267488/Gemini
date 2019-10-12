package com.goisan.personnel.teachManageinfo.dao;

import com.goisan.system.bean.BaseBean;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TeachMgeInfoDao {

    List<BaseBean> getTeachMgeInfoList(BaseBean baseBean);

    void saveTeachMgeInfo(BaseBean baseBean);

    BaseBean getTeachMgeInfoById(@Param("personId") String personId,@Param("deptId") String deptId);

    BaseBean getTeachMgeInfoByPersonId(@Param("personId") String personId);

    void updateTeachMgeInfo(BaseBean baseBean);
}
