package com.goisan.educational.otherAchievements.controller;

import com.goisan.educational.otherAchievements.bean.OtherAchievements;
import com.goisan.educational.otherAchievements.bean.OtherAchievementsDetails;
import com.goisan.educational.otherAchievements.service.OtherAchievementsDetailsService;
import com.goisan.system.tools.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/otherAchievementsDetails")
public class OtherAchievementsDetailsController {


    @Autowired
    private OtherAchievementsDetailsService otherAchievementsDetailsService;


    @ResponseBody
    @RequestMapping("/getOtherAchievementsDatilsList")
    public Map<String, List<OtherAchievements>> getOtherAchievementsDatilsList(String otherAchievementsId,  String studentName,  String studentNum){
        Map<String,List<OtherAchievements>> map=new HashMap<>();
        OtherAchievementsDetails otherAchievementsDetails = new OtherAchievementsDetails();
        otherAchievementsDetails.setOtherAchievementsId(otherAchievementsId);
        otherAchievementsDetails.setStudentName(studentName);
        otherAchievementsDetails.setStudentNum(studentNum);
        List<OtherAchievements> otherAchievementsList = otherAchievementsDetailsService.getOtherAchievementsDetailsList(otherAchievementsDetails);
        map.put("data",otherAchievementsList);
        return map;
    }


    /**
     * 前台页面批量保存接口
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/saveOtherAchievementsDatilsCon")
    public Message saveOtherAchievementsDatilsCon(HttpServletRequest request) {
        return otherAchievementsDetailsService.saveOtherAchievementsDeatilsCon(request);
    }


    /**
     * 批量提交确认状态
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateCommentStatesByIds")
    public Message updateCommentStatesByIds(String ids) {
        otherAchievementsDetailsService.updateCommentStatesByIds(ids);
        return new Message(1, "提交成功！", null);
    }

    /**
     * 批量提交确认状态
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateOpenFlagsByIds")
    public Message updateOpenFlagsByIds(String ids) {
        otherAchievementsDetailsService.updateCommentStatesByIds(ids);

        return new Message(1, "提交成功！", null);
    }












}
