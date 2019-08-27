package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.BusinessCar;
import com.goisan.synergy.workflow.dao.BusinessCarDao;
import com.goisan.synergy.workflow.service.BusinessCarService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.RoleEmpDeptRelation;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/6/27.
 */
@Service
public class BusinessCarServiceImpl implements BusinessCarService {
    @Resource
    private BusinessCarDao businessCarDao;
    public List<AutoComplete> selectPerson() {
        return businessCarDao.selectPerson();
    }

    public List<AutoComplete> selectDept() {
        return businessCarDao.selectDept();

    }
    public List<BusinessCar> getBusinessCarList(String id){
        return  businessCarDao.getBusinessCarList(id);
    }
    public void insertBusinessCar(BusinessCar businessCar){businessCarDao.insertBusinessCar(businessCar);}
    public List<BusinessCar> businessCarAction (BusinessCar businessCar){return businessCarDao.businessCarAction(businessCar);}
    public BusinessCar getBusinessCarById(String id){return businessCarDao.getBusinessCarById(id); }
    public BusinessCar getBusinessCarBy(String id){return businessCarDao.getBusinessCarBy(id); }
    public void updateBusinessCarById(BusinessCar businessCar){businessCarDao.updateBusinessCarById(businessCar);}
    public  void deleteBusinessCarById(String id){businessCarDao.deleteBusinessCarById(id);}
    public  List<BusinessCar> getProcessList(BusinessCar businessCar){return businessCarDao.getProcessList(businessCar);}
    public List<BusinessCar> getCompleteList(BusinessCar businessCar){return businessCarDao.getCompleteList(businessCar);}
    public String getPersonNameById(String id){return businessCarDao.getPersonNameById(id);}
    public  String getDeptNameById(String id){return businessCarDao.getDeptNameById(id);}
    public  List<BusinessCar> getBusinessCarListAll(BusinessCar businessCar){
        return  businessCarDao.getBusinessCarListAll(businessCar);
   }
   public void insertBusinessCarManager(BusinessCar businessCar){ businessCarDao.insertBusinessCarManager(businessCar);}
   public void updateBusinessCarByManager(BusinessCar businessCar){ businessCarDao.updateBusinessCarByManager(businessCar);}
   public void deleteBusinessCarByManager(String id){businessCarDao.deleteBusinessCarByManager(id);}
   public BusinessCar getBusinessCarByManager(String id){ return businessCarDao.getBusinessCarByManager(id);}
   public void updateBusinessCarMessage(String id){businessCarDao.updateBusinessCarMessage(id);}
   public List<BusinessCar> getBusinessCarListOne(BusinessCar businessCar){ return businessCarDao.getBusinessCarListOne(businessCar);}
   public List<BusinessCar> getProcessByAppList(BusinessCar businessCar){return businessCarDao.getProcessByAppList(businessCar);}
   public List<RoleEmpDeptRelation> getPersonIdByBusinessCar(String personId){ return businessCarDao.getPersonIdByBusinessCar(personId);}
}
