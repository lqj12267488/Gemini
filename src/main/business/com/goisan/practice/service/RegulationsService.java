package com.goisan.practice.service;

import com.goisan.practice.bean.Regulations;

import java.util.List;

public interface RegulationsService {
    List<Regulations> regulationsAction(Regulations regulations);

    void deleteRegulationsById(String id);

    Regulations getRegulationsById(String id);

    void updateRegulationsById(Regulations regulations);

    void insertRegulations(Regulations regulations);
}
