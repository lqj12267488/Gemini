package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.PublicityDelivery;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by Administrator on 2017/7/13.
 */
public interface PublicityDeliveryService {
    List<PublicityDelivery> publicityDeliveryAction(PublicityDelivery publicityDelivery);//
    String getPersonNameById(String personId);//通过ID获取申请人
    String getDeptNameById(String deptId);//通过ID获取部门名称
    PublicityDelivery getPublicityDeliveryById(String id);//通过ID获取宣传稿件
    void insertPublicityDelivery(PublicityDelivery publicityDelivery);//添加
    void updatePublicityDelivery(PublicityDelivery publicityDelivery);//更新
    void deletePublicityDeliveryById(String id);//删除
    List<AutoComplete> selectDept();//自动完成框_部门
    List<AutoComplete> selectPerson();//自动完成框_人员
    List<PublicityDelivery> getPublicityDeliveryProcess(PublicityDelivery publicityDelivery);
    List<PublicityDelivery> getPublicityDeliveryComplete(PublicityDelivery publicityDelivery);
}
