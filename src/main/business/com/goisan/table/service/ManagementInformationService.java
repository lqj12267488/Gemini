package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.ManagementInformation;

import java.util.List;

public interface ManagementInformationService {

    List<BaseBean> getManagementInformationList(BaseBean baseBean);

    void saveManagementInformation(BaseBean baseBean);

    BaseBean getManagementInformationById(String id);

    void updateManagementInformation(BaseBean baseBean);

    void delManagementInformation(String id);
    List<ManagementInformation> checkYear(ManagementInformation managementInformation);

}