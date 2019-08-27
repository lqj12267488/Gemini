package com.goisan.educational.otherAchievements.dao;


import com.goisan.educational.otherAchievements.bean.OtherAchievements;
import com.goisan.educational.otherAchievements.bean.OtherAchievementsDetails;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OtherAchievementsDetailsDao {

    List getOtherAchievementsDetailsList(OtherAchievementsDetails otherAchievementsDetails);

    OtherAchievementsDetails getOtherAchievementsDetailsById(String id);

    void deleteOtherAchievementsDetails(String id);

    void updateOtherAchievementsDetails(OtherAchievementsDetails otherAchievementsDetails);

    void saveOtherAchievementsDetails(OtherAchievementsDetails otherAchievementsDetails);

    void updateCommentStatesByIds(@Param("ids")String ids);

    void updateOpenFlagsByIds(@Param("ids")String ids);



}
