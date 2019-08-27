package com.goisan.practice.dao;


import com.goisan.practice.bean.Regulations;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RegulationsDao {
    List<Regulations> regulationsAction(Regulations regulations);

    void deleteRegulationsById(String id);

    Regulations getRegulationsById(String id);

    void updateRegulationsById(Regulations regulations);

    void insertRegulations(Regulations regulations);
}
