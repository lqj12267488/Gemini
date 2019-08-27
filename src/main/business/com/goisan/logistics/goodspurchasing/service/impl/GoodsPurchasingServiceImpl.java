package com.goisan.logistics.goodspurchasing.service.impl;

import com.goisan.logistics.goodspurchasing.bean.GoodsPurchasing;
import com.goisan.logistics.goodspurchasing.service.GoodsPurchasingService;
import com.goisan.logistics.goodspurchasing.dao.GoodsPurchasingDao;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Tree;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/7/31.
 */
@Service
public class GoodsPurchasingServiceImpl implements GoodsPurchasingService {
    @Resource
    private GoodsPurchasingDao goodsPurchasingDao;

    public List<GoodsPurchasing> goodsPurchasingAction(GoodsPurchasing goodsPurchasing) {
        return goodsPurchasingDao.goodsPurchasingAction(goodsPurchasing);
    }

    public String getPersonNameById(String personId) {
        return goodsPurchasingDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return goodsPurchasingDao.getDeptNameById(deptId);
    }

    public GoodsPurchasing getGoodsPurchasingById(String id) {
        return goodsPurchasingDao.getGoodsPurchasingById(id);
    }

    public void insertGoodsPurchasing(GoodsPurchasing goodsPurchasing) {
        goodsPurchasingDao.insertGoodsPurchasing(goodsPurchasing);
    }

    public void updateGoodsPurchasing(GoodsPurchasing goodsPurchasing) {
        goodsPurchasingDao.updateGoodsPurchasing(goodsPurchasing);
    }

    public void deleteGoodsPurchasingById(String id) {
        goodsPurchasingDao.deleteGoodsPurchasingById(id);
    }

    public List<AutoComplete> selectDept() {
        return goodsPurchasingDao.selectDept();
    }

    public List<AutoComplete> selectPerson() {
        return goodsPurchasingDao.selectPerson();
    }

    /*public List<Tree> getMajorClassTree() {
        return goodsPurchasingDao.getMajorClassTree();
    }

    public List<Tree> getGoodsPurchasingTree(String roleId) {
        return goodsPurchasingDao.getGoodsPurchasingTree(roleId);
    }*/

    public List<GoodsPurchasing> getGoodsPurchasingListProcess(GoodsPurchasing goodsPurchasing) {
        return goodsPurchasingDao.getGoodsPurchasingListProcess(goodsPurchasing);
    }

    public List<GoodsPurchasing> getGoodsPurchasingListComplete(GoodsPurchasing goodsPurchasing) {
        return goodsPurchasingDao.getGoodsPurchasingListComplete(goodsPurchasing);
    }
}
