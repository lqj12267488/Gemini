package com.goisan.educational.rewardspunish.controller;

import com.goisan.educational.rewardspunish.bean.Punish;
import com.goisan.educational.rewardspunish.bean.Rewards;
import com.goisan.educational.rewardspunish.bean.RewardsPunish;
import com.goisan.educational.rewardspunish.service.RewardsPunishSearchService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/7/13 0013.
 */
@Controller
public class TeacherRewardsAndPunishSearchController {
    @Resource
    RewardsPunishSearchService rewardsPunishSearchService;
    /*
教师奖励弹出页面
 */
    @RequestMapping("/search/rewards/request")
    public ModelAndView rewardsList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/rewardspunish/teacherRewards");
        return mv;
    }
//
//    //教师奖励初始化页面、查询
//    @ResponseBody
//    @RequestMapping("/rewards/rewardsAction")
//    public Map<String, List<Rewards>> getRewardsList(Rewards rewards){
//        Map<String, List<Rewards>> rewardsMap = new HashMap<String, List<Rewards>>();
//        rewards.setCreator(CommonUtil.getPersonId());
//        rewards.setChangeDept(CommonUtil.getDefaultDept());
//        rewardsMap.put("data", rewardsPunishService.rewardsAction(rewards));
//        return rewardsMap;
//    }
//
//    //教师惩处弹出页面
//    @RequestMapping("/punish/request")
//    public ModelAndView punishList() {
//        ModelAndView mv = new ModelAndView();
//        mv.setViewName("/business/educational/rewardspunish/teacherPunish");
//        return mv;
//    }
//    //教师惩处初始化页面、查询
//    @ResponseBody
//    @RequestMapping("/punish/punishAction")
//    public Map<String, List<Punish>> getPunishList(Punish punish){
//        Map<String, List<Punish>> punishMap = new HashMap<String, List<Punish>>();
//        punish.setCreator(CommonUtil.getPersonId());
//        punish.setChangeDept(CommonUtil.getDefaultDept());
//        List<Punish> list =rewardsPunishService.punishAction(punish);
//        punishMap.put("data", rewardsPunishService.punishAction(punish));
//        return punishMap;
//    }

//    //教师奖惩统计
//    @ResponseBody
//    @RequestMapping("/rewardspunish/rewardsPunishAction")
//    public Map<String, List<RewardsPunish>> rewardsPunishAction(RewardsPunish rewardsPunish){
//        Map<String, List<RewardsPunish>> rewardsPunishMap = new HashMap<String, List<RewardsPunish>>();
//        rewardsPunishMap.put("data", rewardsPunishService.rewardsPunishAction(rewardsPunish));
//        return rewardsPunishMap;
//    }
}
