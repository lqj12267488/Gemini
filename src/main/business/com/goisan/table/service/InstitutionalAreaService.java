package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.InstitutionalArea;
import java.util.List;

public interface InstitutionalAreaService {

    List<BaseBean> getInstitutionalAreaList(BaseBean baseBean);

    void saveInstitutionalArea(BaseBean baseBean);

    BaseBean getInstitutionalAreaById(String id);

    void updateInstitutionalArea(BaseBean baseBean);

    void delInstitutionalArea(String id);
    List<InstitutionalArea> checkYear(InstitutionalArea institutionalArea);
}