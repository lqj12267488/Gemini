package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface InformationPersonnelDao {

    List<BaseBean> getInformationPersonnelList(BaseBean baseBean);

    void saveInformationPersonnel(BaseBean baseBean);

    BaseBean getInformationPersonnelById(String id);

    void updateInformationPersonnel(BaseBean baseBean);

    void delInformationPersonnel(String id);

}
