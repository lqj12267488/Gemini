package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.InstitutionalArea;
import com.goisan.table.bean.ManagementInformation;

import java.util.List;

public interface ManagementInformationDao {

    List<BaseBean> getManagementInformationList(BaseBean baseBean);

    void saveManagementInformation(BaseBean baseBean);

    BaseBean getManagementInformationById(String id);

    void updateManagementInformation(BaseBean baseBean);

    void delManagementInformation(String id);
    List<ManagementInformation> checkYear(ManagementInformation managementInformation);

}
