package com.goisan.studentwork.graduatearchivesaddress.service.impl;

import com.goisan.studentwork.graduatearchivesaddress.bean.Arcad;
import com.goisan.studentwork.graduatearchivesaddress.dao.ArcadDao;
import com.goisan.studentwork.graduatearchivesaddress.service.ArcadServcie;
import com.goisan.system.tools.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created  By hanjie ON 2019/8/29
 */
@Service
public class ArcadServcieImpl implements ArcadServcie {

    @Autowired
    private ArcadDao arcadDao;

    @Override
    public List<Arcad> getArcadList(Arcad arcad) {
        return arcadDao.getArcadList(arcad);
    }

    @Override
    public Arcad getArcadById(String arcadId) {
        return arcadDao.getArcadById(arcadId);
    }

    @Override
    public void insertArcad(Arcad arcad) {
        arcad.setCreator(CommonUtil.getPersonId());
        arcad.setChangeDept(CommonUtil.getDefaultDept());
        arcadDao.insertArcad(arcad);
    }

    @Override
    public void updateArcadById(Arcad arcad) {
        arcad.setChangeDept(CommonUtil.getDefaultDept());
        arcad.setChanger(CommonUtil.getPersonId());
        arcadDao.updateArcadById(arcad);
    }

    @Override
    public void delArcadById(Arcad arcad) {
        arcadDao.delArcadById(arcad);
    }

    @Override
    public List<String> findProvince() {
        return arcadDao.findProvince();
    }

    @Override
    public List<String> findCity(String str) {
        return arcadDao.findCity(str);
    }

    @Override
    public List<String> findCity1(String str) {
        return arcadDao.findCity1(str);
    }

    @Override
    public List<String> findCounty(String str) {
        return arcadDao.findCounty(str);
    }

    @Override
    public List<String> find(String str) {
        return arcadDao.find(str);
    }

    @Override
    public List<String> findCounty1(String str) {
        return arcadDao.findCounty1(str);
    }

    @Override
    public List<String> findAllCity() {
        return arcadDao.findAllCity();
    }

    @Override
    public List<String> findCityOrCounty() {
        return arcadDao.findCityOrCounty();
    }

    @Override
    public List<String> select(String str) {
        return arcadDao.select(str);
    }

    @Override
    public List<String> findBj() {
        return arcadDao.findBj();
    }

    @Override
    public List<String> findTj() {
        return arcadDao.findTj();
    }

    @Override
    public List<String> findSh() {
        return arcadDao.findSh();
    }

    @Override
    public List<String> findCq() {
        return arcadDao.findCq();
    }
}
