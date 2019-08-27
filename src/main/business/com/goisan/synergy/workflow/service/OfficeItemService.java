package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.OfficeItem;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by Administrator on 2017/5/6 0006.
 */
public interface OfficeItemService {

    List<OfficeItem> getOfficeItemList (String id);

    List<OfficeItem> officeItemAction (OfficeItem officeItem);

    List<OfficeItem> officeItemProcess (OfficeItem officeItem);

    List<OfficeItem> officeItemComplete (OfficeItem officeItem);

    OfficeItem getOfficeItemById (String id);

    void deleteById (String id);

    void insertOfficeItem (OfficeItem officeItem);

    void updateOfficeItem (OfficeItem officeItem);

    List<AutoComplete> selectPerson();

    List<AutoComplete> selectDept();

    String getDeptNameById(String id);

    String getPersonNameById(String id);

}
