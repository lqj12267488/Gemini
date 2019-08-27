package com.goisan.educational.otherAchievements.service;


import com.goisan.educational.otherAchievements.bean.OtherAchievements;
import com.goisan.educational.otherAchievements.bean.OtherAchievementsDetails;
import com.goisan.system.tools.Message;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public interface OtherAchievementsDetailsService {





    List getOtherAchievementsDetailsList(OtherAchievementsDetails otherAchievementsDetails);

    OtherAchievementsDetails getOtherAchievementsDetailsById(String id);

    void deleteOtherAchievementsDetails(String id);

    void updateOtherAchievementsDetails(OtherAchievementsDetails otherAchievementsDetails);

    void saveOtherAchievementsDetails(OtherAchievementsDetails otherAchievementsDetails);

    Message saveOtherAchievementsDeatilsCon(HttpServletRequest request);


    void updateCommentStatesByIds(String ids);


    void updateOpenFlagsByIds(String ids);




}
