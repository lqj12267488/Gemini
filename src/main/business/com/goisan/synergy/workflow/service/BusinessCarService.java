package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.BusinessCar;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.RoleEmpDeptRelation;

import java.util.List;

/**
 * Created by hanyu on 2017/6/27.
 */
public interface BusinessCarService {
    List<BusinessCar> getBusinessCarList(String id);
    void insertBusinessCar(BusinessCar businessCar);
    List<BusinessCar> businessCarAction (BusinessCar businessCar);
    BusinessCar getBusinessCarById(String id);
    BusinessCar getBusinessCarBy(String id);
    void updateBusinessCarById(BusinessCar businessCar);
    void deleteBusinessCarById(String id);
    List<AutoComplete> selectDept();
    List<AutoComplete> selectPerson();
    List<BusinessCar> getProcessList(BusinessCar businessCar);
    List<BusinessCar> getCompleteList(BusinessCar businessCar);
    String getPersonNameById(String id);
    String getDeptNameById(String id);
    List<BusinessCar> getBusinessCarListAll(BusinessCar businessCar);
    void insertBusinessCarManager(BusinessCar businessCar);
    void updateBusinessCarByManager(BusinessCar businessCar);
    void deleteBusinessCarByManager(String id);
    BusinessCar getBusinessCarByManager(String id);
    void updateBusinessCarMessage(String id);
    List<BusinessCar> getBusinessCarListOne(BusinessCar businessCar);
    List<BusinessCar> getProcessByAppList(BusinessCar businessCar);
    List<RoleEmpDeptRelation> getPersonIdByBusinessCar(String personId);
}
