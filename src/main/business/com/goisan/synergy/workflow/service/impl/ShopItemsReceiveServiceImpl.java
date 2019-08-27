package com.goisan.synergy.workflow.service.impl;


import com.goisan.synergy.workflow.bean.ShopItemsReceive;
import com.goisan.synergy.workflow.dao.ShopItemsReceiveDao;
import com.goisan.synergy.workflow.service.ShopItemsReceiveService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/6/19.
 */
@Service
public class ShopItemsReceiveServiceImpl implements ShopItemsReceiveService{

    @Resource
    private ShopItemsReceiveDao shopItemsReceiveDao;
    public List<AutoComplete> selectPerson() {
        return shopItemsReceiveDao.selectPerson();
    }

    public List<AutoComplete> selectDept() {
        return shopItemsReceiveDao.selectDept();

    }
    public List<ShopItemsReceive> getShopItemsReceiveList(String id){
        return  shopItemsReceiveDao.getShopItemsReceiveList(id);
    }
    public void insertShopItemsReceive(ShopItemsReceive shopItemsReceive){shopItemsReceiveDao.insertShopItemsReceive(shopItemsReceive);}
    public List<ShopItemsReceive> shopItemsReceiveAction (ShopItemsReceive shopItemsReceive){return shopItemsReceiveDao.shopItemsReceiveAction(shopItemsReceive);}
    public ShopItemsReceive getShopItemsReceiveById(String id){return shopItemsReceiveDao.getShopItemsReceiveById(id); }
    public void updateShopItemsReceiveById(ShopItemsReceive shopItemsReceive){shopItemsReceiveDao.updateShopItemsReceiveById(shopItemsReceive);}
    public  void deleteShopItemsReceiveById(String id){shopItemsReceiveDao.deleteShopItemsReceiveById(id);}
    public  List<ShopItemsReceive> getProcessList(ShopItemsReceive shopItemsReceive){return shopItemsReceiveDao.getProcessList(shopItemsReceive);}
    public List<ShopItemsReceive> getCompleteList(ShopItemsReceive shopItemsReceive){return shopItemsReceiveDao.getCompleteList(shopItemsReceive);}
    public String getPersonNameById(String id){return shopItemsReceiveDao.getPersonNameById(id);}
    public  String getDeptNameById(String id){return shopItemsReceiveDao.getDeptNameById(id);}
}
