package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.OfficeItem;
import com.goisan.synergy.workflow.dao.OfficeItemDao;
import com.goisan.synergy.workflow.service.OfficeItemService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/5/6 0006.
 */
@Service
public class OfficeItemServiceImpl implements OfficeItemService {

    @Resource
    private OfficeItemDao officeItemDao;

    public List<AutoComplete> selectPerson() {
        return officeItemDao.selectPerson();
    }

    public List<AutoComplete> selectDept() {
        return officeItemDao.selectDept();
    }

    public List<OfficeItem> getOfficeItemList(String id) {
        return officeItemDao.getOfficeItemList(id);
    }

    public OfficeItem getOfficeItemById(String id) {
        return officeItemDao.getOfficeItemById(id);
    }

    public void deleteById(String id) {
        officeItemDao.deleteById(id);
    }

    public List<OfficeItem> officeItemAction(OfficeItem officeItem) {
        return officeItemDao.officeItemAction(officeItem);
    }

    public List<OfficeItem> officeItemProcess(OfficeItem officeItem) {
        return officeItemDao.officeItemProcess(officeItem);
    }

    public List<OfficeItem> officeItemComplete(OfficeItem officeItem) {
        return officeItemDao.officeItemComplete(officeItem);
    }

    public void insertOfficeItem(OfficeItem officeItem) {
        officeItemDao.insertOfficeItem(officeItem);
    }

    public void updateOfficeItem(OfficeItem officeItem) {
        officeItemDao.updateOfficeItem(officeItem);
    }

    public String getDeptNameById(String id) { return officeItemDao.getDeptNameById(id);}

    public String getPersonNameById(String id){ return officeItemDao.getPersonNameById(id);}
}
