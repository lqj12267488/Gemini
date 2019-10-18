package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.ContactInformation;

import java.util.List;

public interface ContactInformationService {

    List<BaseBean> getContactInformationList(BaseBean baseBean);

    void saveContactInformation(BaseBean baseBean);

    BaseBean getContactInformationById(String id);

    void updateContactInformation(BaseBean baseBean);

    void delContactInformation(String id);

    ContactInformation getPersonByPersonId(String personId);
}