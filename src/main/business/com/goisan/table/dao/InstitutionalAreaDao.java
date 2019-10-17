package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface InstitutionalAreaDao {

    List<BaseBean> getInstitutionalAreaList(BaseBean baseBean);

    void saveInstitutionalArea(BaseBean baseBean);

    BaseBean getInstitutionalAreaById(String id);

    void updateInstitutionalArea(BaseBean baseBean);

    void delInstitutionalArea(String id);

}
