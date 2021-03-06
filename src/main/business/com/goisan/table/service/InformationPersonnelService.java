package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.InformationPersonnel;

import java.util.List;

public interface InformationPersonnelService {

    List<BaseBean> getInformationPersonnelList(BaseBean baseBean);

    void saveInformationPersonnel(BaseBean baseBean);

    BaseBean getInformationPersonnelById(String id);

    void updateInformationPersonnel(BaseBean baseBean);

    void delInformationPersonnel(String id);
    List<InformationPersonnel> checkYear(InformationPersonnel informationPersonnel);

}