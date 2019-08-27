package com.goisan.educational.orderwork.dao;

import com.goisan.educational.orderwork.bean.OtherWorkload;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OtherWorkloadDao {
    List<OtherWorkload> otherWorkloadAction(OtherWorkload otherWorkload);
    void deleteOtherWorkloadById(String id);
    OtherWorkload getOtherWorkloadById(String id);
    void updateOtherWorkloadById(OtherWorkload otherWorkload);
    void insertOtherWorkload(OtherWorkload otherWorkload);
}
