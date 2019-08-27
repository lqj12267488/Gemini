package com.goisan.system.service.impl;

import com.goisan.system.bean.EmpRange;
import com.goisan.system.dao.EmpRangeDao;
import com.goisan.system.service.EmpRangeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by mcq on 2017/5/9.
 */
@Service
public class EmpRangeServiceImpl implements EmpRangeService {
    @Resource
    private EmpRangeDao empRangeDao;

    public List<EmpRange> getEmpRangeList(EmpRange empRange) {
        return empRangeDao.getEmpRangeList(empRange);
    }


    public void insertEmpRange(EmpRange empRange) {
        empRangeDao.insertEmpRange(empRange);
    }

    public EmpRange getEmpRangeById(String id) {
        return empRangeDao.getEmpRangeById(id);
    }

    public void updatEmpRangeById(EmpRange empRange) {
        empRangeDao.updatEmpRangeById(empRange);
    }

    public void deleteEmpRangeById(String id) {
        empRangeDao.deleteEmpRangeById(id);
    }

    @Override
    public List<EmpRange> getEmpRangeByEmpId(String personId) {
        return empRangeDao.getEmpRangeByEmpId(personId);
    }
}
