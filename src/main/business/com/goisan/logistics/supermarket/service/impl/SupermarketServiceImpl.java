package com.goisan.logistics.supermarket.service.impl;

import com.goisan.logistics.supermarket.bean.Supermarket;
import com.goisan.logistics.supermarket.dao.SupermarketDao;
import com.goisan.logistics.supermarket.service.SupermarketService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wq on 2017/9/20.
 */
@Service
public class SupermarketServiceImpl implements SupermarketService {
    @Resource
    private SupermarketDao supermarketDao;

    // 学校奖学金信息维护 2017/09/20
    public List<Supermarket> getSupermarketList(Supermarket supermarket) {
        return supermarketDao.getSupermarketList(supermarket);
    }

    @Override
    public void insertSupermarket(Supermarket supermarket) {
        supermarketDao.insertSupermarket(supermarket);
    }

    @Override
    public Supermarket getSupermarketById(Supermarket supermarket) {
        return supermarketDao.getSupermarketById(supermarket);
    }

    @Override
    public void updateSupermarketById(Supermarket supermarket) {
        supermarketDao.updateSupermarketById(supermarket);
    }

    @Override
    public void deleteSupermarketById(Supermarket supermarket) {
        supermarketDao.deleteSupermarketById(supermarket);
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @Override
    public List<Supermarket> getSupermarketStaffList(Supermarket studentDorm) {
        return supermarketDao.getSupermarketStaffList(studentDorm);
    }

    @Override
    public void insertSupermarketStaff(Supermarket studentDorm) {
       supermarketDao.insertSupermarketStaff(studentDorm);
    }

    @Override
    public Supermarket getSupermarketStaffById(Supermarket studentDorm) {
        return supermarketDao.getSupermarketStaffById(studentDorm);
    }

    @Override
    public void updateSupermarketStaffById(Supermarket studentDorm) {
       supermarketDao.updateSupermarketStaffById(studentDorm);
    }

    @Override
    public void deleteSupermarketStaffById(Supermarket studentDorm) {
       supermarketDao.deleteSupermarketStaffById(studentDorm);
    }

    @Override
    public List<Supermarket> checkSupermarketStaffById(Supermarket studentDorm) {
        return supermarketDao.checkSupermarketStaffById(studentDorm);
    }
}
