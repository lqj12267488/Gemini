package com.goisan.logistics.goodspurchasing.service;

import com.goisan.logistics.goodspurchasing.bean.GoodsPurchasing;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Tree;

import java.util.List;

/**
 * Created by Administrator on 2017/7/31.
 */
public interface GoodsPurchasingService {
    List<GoodsPurchasing> goodsPurchasingAction(GoodsPurchasing goodsPurchasing);//
    String getPersonNameById(String personId);//通过ID获取申请人
    String getDeptNameById(String deptId);//通过ID获取部门名称
    GoodsPurchasing getGoodsPurchasingById(String id);//通过ID获取采购物品
    void insertGoodsPurchasing(GoodsPurchasing goodsPurchasing);//添加
    void updateGoodsPurchasing(GoodsPurchasing goodsPurchasing);//更新
    void deleteGoodsPurchasingById(String id);//删除
    List<AutoComplete> selectDept();//自动完成框_部门
    List<AutoComplete> selectPerson();//自动完成框_人员
    /*List<Tree> getMajorClassTree();
    List<Tree> getGoodsPurchasingTree(String roleId);*/
    List<GoodsPurchasing> getGoodsPurchasingListProcess(GoodsPurchasing goodsPurchasing);
    List<GoodsPurchasing> getGoodsPurchasingListComplete(GoodsPurchasing goodsPurchasing);
}
