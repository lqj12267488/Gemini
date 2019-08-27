package com.goisan.synergy.workflow.dao;


import com.goisan.synergy.workflow.bean.ShopItemsReceive;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by hanyu on 2017/6/19.
 */
public interface ShopItemsReceiveDao {
    List<ShopItemsReceive> getShopItemsReceiveList(String id);
    void insertShopItemsReceive(ShopItemsReceive shopItemsReceive);
    List<ShopItemsReceive> shopItemsReceiveAction (ShopItemsReceive shopItemsReceive);
    ShopItemsReceive getShopItemsReceiveById(String id);
    void updateShopItemsReceiveById(ShopItemsReceive shopItemsReceive);
    void deleteShopItemsReceiveById(String id);
    List<AutoComplete> selectDept();
    List<AutoComplete> selectPerson();
    List<ShopItemsReceive> getProcessList(ShopItemsReceive shopItemsReceive);
    List<ShopItemsReceive> getCompleteList(ShopItemsReceive shopItemsReceive);
    String getPersonNameById(String id);
    String getDeptNameById(String id);

}
