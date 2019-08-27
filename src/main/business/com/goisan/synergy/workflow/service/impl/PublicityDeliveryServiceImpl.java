package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.PublicityDelivery;
import com.goisan.synergy.workflow.dao.PublicityDeliveryDao;
import com.goisan.synergy.workflow.service.PublicityDeliveryService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/7/13.
 */
@Service
public class PublicityDeliveryServiceImpl implements PublicityDeliveryService {
    @Resource
    private PublicityDeliveryDao publicityDeliveryDao;
    public List<PublicityDelivery> publicityDeliveryAction(PublicityDelivery publicityDelivery) {
        return publicityDeliveryDao.publicityDeliveryAction(publicityDelivery);
    }

    public String getPersonNameById(String personId) {
        return publicityDeliveryDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return publicityDeliveryDao.getDeptNameById(deptId);
    }

    public PublicityDelivery getPublicityDeliveryById(String id) {
        return publicityDeliveryDao.getPublicityDeliveryById(id);
    }

    public void insertPublicityDelivery(PublicityDelivery publicityDelivery) {
        publicityDeliveryDao.insertPublicityDelivery(publicityDelivery);
    }

    public void updatePublicityDelivery(PublicityDelivery publicityDelivery) {
        publicityDeliveryDao.updatePublicityDelivery(publicityDelivery);
    }

    public void deletePublicityDeliveryById(String id) {
        publicityDeliveryDao.deletePublicityDeliveryById(id);
    }

    public List<AutoComplete> selectDept() {
        return publicityDeliveryDao.selectDept();
    }

    public List<AutoComplete> selectPerson() {
        return publicityDeliveryDao.selectPerson();
    }

    public List<PublicityDelivery> getPublicityDeliveryProcess(PublicityDelivery publicityDelivery) {
        return publicityDeliveryDao.getPublicityDeliveryProcess(publicityDelivery);
    }

    public List<PublicityDelivery> getPublicityDeliveryComplete(PublicityDelivery publicityDelivery) {
        return publicityDeliveryDao.getPublicityDeliveryComplete(publicityDelivery);
    }
}
