package com.goisan.logistics.goodspurchasing.service.impl;

import com.goisan.logistics.goodspurchasing.bean.GoodsPurchasingBig;
import com.goisan.logistics.goodspurchasing.dao.GoodsPurchasingBigDao;
import com.goisan.logistics.goodspurchasing.service.GoodsPurchasingBigService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 123456 on 2018/3/30.
 */
@Service
public class GoodsPurchasingBigServiceImpl implements GoodsPurchasingBigService {
    @Resource
    private GoodsPurchasingBigDao goodsPurchasingBigDao;

    public List<GoodsPurchasingBig> goodsPurchasingBigAction(GoodsPurchasingBig goodsPurchasingBig){
        return goodsPurchasingBigDao.goodsPurchasingBigAction(goodsPurchasingBig);
    }
    //通过ID获取申请人
    public String getPersonNameById(String personId){
        return goodsPurchasingBigDao.getPersonNameById(personId);
    }
    //通过ID获取部门名称
    public String getDeptNameById(String deptId){
        return goodsPurchasingBigDao.getDeptNameById(deptId);
    }
    //通过ID获取采购物品
    public GoodsPurchasingBig getGoodsPurchasingBigById(String id){
        return goodsPurchasingBigDao.getGoodsPurchasingBigById(id);
    }

    public void insertGoodsPurchasingBig(GoodsPurchasingBig goodsPurchasingBig){
        goodsPurchasingBigDao.insertGoodsPurchasingBig(goodsPurchasingBig);
    }

    public void updateGoodsPurchasingBig(GoodsPurchasingBig goodsPurchasingBig){
        goodsPurchasingBigDao.updateGoodsPurchasingBig(goodsPurchasingBig);
    }

    public void deleteGoodsPurchasingBigById(String id){
        goodsPurchasingBigDao.deleteGoodsPurchasingBigById(id);
    }

    public List<AutoComplete> selectDept(){
        return goodsPurchasingBigDao.selectDept();
    }

    public List<AutoComplete> selectPerson(){
        return goodsPurchasingBigDao.selectPerson();
    }

    public List<GoodsPurchasingBig> getGoodsPurchasingBigListProcess(GoodsPurchasingBig goodsPurchasingBig){
        return goodsPurchasingBigDao.getGoodsPurchasingBigListProcess(goodsPurchasingBig);
    }

    public List<GoodsPurchasingBig> getGoodsPurchasingBigListComplete(GoodsPurchasingBig goodsPurchasingBig){
        return goodsPurchasingBigDao.getGoodsPurchasingBigListComplete(goodsPurchasingBig);
    }
}
