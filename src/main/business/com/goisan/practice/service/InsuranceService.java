package com.goisan.practice.service;

import com.goisan.practice.bean.Insurance;

import java.util.List;

public interface InsuranceService {
    List<Insurance> insuranceAction(Insurance insurance);

    void deleteInsuranceById(String id);

    Insurance getInsuranceById(String id);

    void updateInsuranceById(Insurance insurance);

    void insertInsurance(Insurance insurance);

    Insurance getStudent(String idcard);
}
