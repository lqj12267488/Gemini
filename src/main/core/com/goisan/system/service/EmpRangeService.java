package com.goisan.system.service;

import com.goisan.system.bean.EmpRange;

import java.util.List;

/**
 * Created by mcq on 2017/5/9.
 */
public interface EmpRangeService {
    List<EmpRange> getEmpRangeList(EmpRange empRange);

    void insertEmpRange(EmpRange empRange);

    EmpRange getEmpRangeById(String id);

    void updatEmpRangeById(EmpRange empRange);

    void deleteEmpRangeById(String id);

    List<EmpRange> getEmpRangeByEmpId(String personId);
}
