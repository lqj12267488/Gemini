package com.goisan.educational.orderwork.service;

import com.goisan.educational.orderwork.bean.OtherWorkload;

import java.util.List;

public interface OtherWorkloadService {
    List<OtherWorkload> otherWorkloadAction(OtherWorkload otherWorkload);
    void deleteOtherWorkloadById(String id);
    OtherWorkload getOtherWorkloadById(String id);
    void updateOtherWorkloadById(OtherWorkload otherWorkload);
    void insertOtherWorkload(OtherWorkload otherWorkload);
}
