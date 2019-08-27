package com.goisan.educational.otherAchievements.service.impl;

import com.goisan.educational.otherAchievements.bean.OtherAchievements;
import com.goisan.educational.otherAchievements.bean.OtherAchievementsDetails;
import com.goisan.educational.otherAchievements.dao.OtherAchievementsDao;
import com.goisan.educational.otherAchievements.service.OtherAchievementsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OtherAchievementsServiceImpl implements OtherAchievementsService {


    @Autowired
    private OtherAchievementsDao otherAchievementsDao;



    @Override
    public List getOtherAchievementsList(OtherAchievements otherAchievements) {
        return otherAchievementsDao.getOtherAchievementsList(otherAchievements);
    }

    @Override
    public OtherAchievements getOtherAchievementsById(String id) {
        return otherAchievementsDao.getOtherAchievementsById(id);
    }

    @Override
    public void deleteOtherAchievements(String id) {
        otherAchievementsDao.deleteOtherAchievements(id);
    }

    @Override
    public void updateOtherAchievements(OtherAchievements otherAchievements) {
        otherAchievementsDao.updateOtherAchievements(otherAchievements);
    }

    @Override
    public void saveOtherAchievements(OtherAchievements otherAchievements) {
        otherAchievementsDao.saveOtherAchievements(otherAchievements);
    }
}
