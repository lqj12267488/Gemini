package com.goisan.logistics.canteen.service.impl;

import com.goisan.logistics.canteen.bean.Canteen;
import com.goisan.logistics.canteen.dao.CanteenDao;
import com.goisan.logistics.canteen.service.CanteenService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wq on 2017/9/20.
 */
@Service
public class CanteenServiceImpl implements CanteenService {
    @Resource
    private CanteenDao CanteenDao;

    // 学校奖学金信息维护 2017/09/20
    public List<Canteen> getCanteenList(Canteen Canteen) {
        return CanteenDao.getCanteenList(Canteen);
    }

    @Override
    public void insertCanteen(Canteen Canteen) {
        CanteenDao.insertCanteen(Canteen);
    }

    @Override
    public Canteen getCanteenById(Canteen Canteen) {
        return CanteenDao.getCanteenById(Canteen);
    }

    @Override
    public void updateCanteenById(Canteen Canteen) {
        CanteenDao.updateCanteenById(Canteen);
    }

    @Override
    public void deleteCanteenById(Canteen Canteen) {
        CanteenDao.deleteCanteenById(Canteen);
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @Override
    public List<Canteen> getCanteenStaffList(Canteen studentDorm) {
        return CanteenDao.getCanteenStaffList(studentDorm);
    }

    @Override
    public void insertCanteenStaff(Canteen studentDorm) {
       CanteenDao.insertCanteenStaff(studentDorm);
    }

    @Override
    public Canteen getCanteenStaffById(Canteen studentDorm) {
        return CanteenDao.getCanteenStaffById(studentDorm);
    }

    @Override
    public void updateCanteenStaffById(Canteen studentDorm) {
       CanteenDao.updateCanteenStaffById(studentDorm);
    }

    @Override
    public void deleteCanteenStaffById(Canteen studentDorm) {
       CanteenDao.deleteCanteenStaffById(studentDorm);
    }

    @Override
    public List<Canteen> checkCanteenStaffById(Canteen canteen) {
        return CanteenDao.checkCanteenStaffById(canteen);
    }
}
