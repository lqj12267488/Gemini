package com.goisan.practice.service.impl;

import com.goisan.practice.bean.Insurance;
import com.goisan.practice.dao.InsuranceDao;
import com.goisan.practice.service.InsuranceService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class InsuranceServiceImpl implements InsuranceService{
    @Resource
    private InsuranceDao insuranceDao;

    public List<Insurance> insuranceAction(Insurance insurance){
        return insuranceDao.insuranceAction(insurance);
    }

    public void deleteInsuranceById(String id){
        insuranceDao.deleteInsuranceById(id);
    }

    public Insurance getInsuranceById(String id){
        return insuranceDao.getInsuranceById(id);
    }

    public void updateInsuranceById(Insurance insurance){
        insuranceDao.updateInsuranceById(insurance);
    }

    public void insertInsurance(Insurance insurance){
        insuranceDao.insertInsurance(insurance);
    }

    public Insurance getStudent(String idcard){ return insuranceDao.getStudent(idcard); }
}
