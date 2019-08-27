package com.goisan.educational.otherAchievements.service;

import com.goisan.educational.otherAchievements.bean.OtherAchievements;
import com.goisan.educational.otherAchievements.bean.OtherAchievementsDetails;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface OtherAchievementsService {


    List getOtherAchievementsList(OtherAchievements otherAchievements);

    OtherAchievements getOtherAchievementsById(String id);

    void deleteOtherAchievements(String id);

    void updateOtherAchievements(OtherAchievements otherAchievements);

    void saveOtherAchievements(OtherAchievements otherAchievements);


}
