package com.goisan.logistics.goodspurchasing.dao;

import com.goisan.logistics.goodspurchasing.bean.GoodsPurchasingBig;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by 123456 on 2018/3/30.
 */
@Repository
public interface GoodsPurchasingBigDao {
    List<GoodsPurchasingBig> goodsPurchasingBigAction(GoodsPurchasingBig goodsPurchasingBig);//
    String getPersonNameById(String personId);//通过ID获取申请人
    String getDeptNameById(String deptId);//通过ID获取部门名称
    GoodsPurchasingBig getGoodsPurchasingBigById(String id);//通过ID获取采购物品
    void insertGoodsPurchasingBig(GoodsPurchasingBig goodsPurchasingBig);//添加
    void updateGoodsPurchasingBig(GoodsPurchasingBig goodsPurchasingBig);//更新
    void deleteGoodsPurchasingBigById(String id);//删除
    List<AutoComplete> selectDept();//自动完成框_部门
    List<AutoComplete> selectPerson();//自动完成框_人员
    List<GoodsPurchasingBig> getGoodsPurchasingBigListProcess(GoodsPurchasingBig goodsPurchasingBig);
    List<GoodsPurchasingBig> getGoodsPurchasingBigListComplete(GoodsPurchasingBig goodsPurchasingBig);
}
