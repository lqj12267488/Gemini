package com.goisan.educational.otherAchievements.dao;


import com.goisan.educational.otherAchievements.bean.OtherAchievements;
import com.goisan.educational.otherexamination.bean.OtherExamination;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OtherAchievementsDao {

    List getOtherAchievementsList(OtherAchievements otherAchievements);

    OtherAchievements getOtherAchievementsById(String id);

    void deleteOtherAchievements(String id);

    void updateOtherAchievements(OtherAchievements otherAchievements);

    void saveOtherAchievements(OtherAchievements otherAchievements);

}
