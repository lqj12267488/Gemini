package com.goisan.practice.dao;

import com.goisan.practice.bean.Insurance;

import javax.annotation.Resource;
import java.util.List;

@Resource
public interface InsuranceDao {
    List<Insurance> insuranceAction(Insurance insurance);

    void deleteInsuranceById(String id);

    Insurance getInsuranceById(String id);

    void updateInsuranceById(Insurance insurance);

    void insertInsurance(Insurance insurance);

    Insurance getStudent(String idcard);
}
