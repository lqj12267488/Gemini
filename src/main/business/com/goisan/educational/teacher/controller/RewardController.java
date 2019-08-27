package com.goisan.educational.teacher.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.teacher.bean.Competition;
import com.goisan.educational.teacher.bean.RewardAndPunishment;
import com.goisan.educational.teacher.service.TeacherInfoService;
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

@Controller
public class RewardController {
    @Resource
    private TeacherInfoService teacherInfoService;

    @ResponseBody
    @RequestMapping("/teacher/rewardandpunishment")
    public ModelAndView rewardandpunishment() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teacher/rewardList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/teacher/getRewardList")
    public Map<String, Object> getRewardList(RewardAndPunishment rewardAndPunishment,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> rewardAndPunishmentList = new HashMap<String, Object>();
        rewardAndPunishment.setCreateDept(CommonUtil.getDefaultDept());
        rewardAndPunishment.setLevel(CommonUtil.getLoginUser().getLevel());
        List<RewardAndPunishment> list = teacherInfoService.getRewardList(rewardAndPunishment);
        PageInfo<List<RewardAndPunishment>> info = new PageInfo(list);
        rewardAndPunishmentList.put("draw", draw);
        rewardAndPunishmentList.put("recordsTotal", info.getTotal());
        rewardAndPunishmentList.put("recordsFiltered", info.getTotal());
        rewardAndPunishmentList.put("data", list);
        return rewardAndPunishmentList;
       // map.put("data", teacherInfoService.getRewardList(rewardAndPunishment));
        //return map;
    }

    @ResponseBody
    @RequestMapping("/teacher/toAddReward")
    public ModelAndView editCompetition(String rewardId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teacher/editReward");
        if ("".equals(rewardId) || rewardId == null) {
            mv.addObject("head", "新增");
            RewardAndPunishment rewardAndPunishment = new RewardAndPunishment();
            mv.addObject("rewardAndPunishment", rewardAndPunishment);
        } else {
            RewardAndPunishment rewardAndPunishment = teacherInfoService.getRewardById(rewardId);
            mv.addObject("head", "修改");
            mv.addObject("rewardAndPunishment", rewardAndPunishment);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/teacher/deleteRewardById")
    public Message deleteRewardById(String rewardId) {
        teacherInfoService.deleteRewardById(rewardId);
        return new Message(1, "删除成功！", "success");
    }

    @ResponseBody
    @RequestMapping("/teacher/rewardSave")
    public Message competitionSave(RewardAndPunishment rewardAndPunishment) {
        if ("".equals(rewardAndPunishment.getRewardId())) {
            rewardAndPunishment.setCreator(CommonUtil.getPersonId());
            rewardAndPunishment.setCreateDept(CommonUtil.getDefaultDept());
            teacherInfoService.insertReward(rewardAndPunishment);
            return new Message(1, "新增成功！", "success");
        } else {
            rewardAndPunishment.setChanger(CommonUtil.getPersonId());
            rewardAndPunishment.setChangeDept(CommonUtil.getDefaultDept());
            teacherInfoService.updateReward(rewardAndPunishment);
            return new Message(1, "修改成功！", "success");
        }
    }
}
