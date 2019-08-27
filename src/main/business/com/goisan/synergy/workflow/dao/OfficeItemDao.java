package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.OfficeItem;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * Created by Administrator on 2017/5/6 0006.
 */
@Repository
public interface OfficeItemDao {

    List<OfficeItem> getOfficeItemList (String id);

    List<OfficeItem> officeItemAction (OfficeItem officeItem);

    List<OfficeItem> officeItemProcess (OfficeItem officeItem);

    List<OfficeItem> officeItemComplete (OfficeItem officeItem);

    OfficeItem getOfficeItemById (String id);

    void deleteById (String id);

    void insertOfficeItem (OfficeItem officeItem);

    void updateOfficeItem (OfficeItem officeItem);

    List<AutoComplete> selectDept();

    List<AutoComplete> selectPerson();

    String getDeptNameById(String id);

    String getPersonNameById(String id);

}
