package com.goisan.educational.rewardspunish.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.rewardspunish.bean.Punish;
import com.goisan.educational.rewardspunish.bean.Rewards;
import com.goisan.educational.rewardspunish.bean.RewardsPunish;
import com.goisan.educational.rewardspunish.service.RewardsPunishService;
import com.goisan.synergy.workflow.bean.AssetsScrap;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/7/13 0013.
 */
@Controller
public class TeacherRewardsAndPunishController {
    @Resource
    RewardsPunishService rewardsPunishService;
    /*
教师奖励弹出页面
 */
    @RequestMapping("/rewards/request")
    public ModelAndView rewardsList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/rewardspunish/teacherRewards");
        return mv;
    }

    //教师奖励初始化页面、查询
    @ResponseBody
    @RequestMapping("/rewards/rewardsAction")
    public Map<String, Object> getRewardsList(Rewards rewards,int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> rewardsList = new HashMap<String, Object>();
        rewards.setCreator(CommonUtil.getPersonId());
        rewards.setChangeDept(CommonUtil.getDefaultDept());
        List<Rewards> list = rewardsPunishService.rewardsAction(rewards);
        PageInfo<List<Rewards>> info = new PageInfo(list);
        rewardsList.put("draw", draw);
        rewardsList.put("recordsTotal", info.getTotal());
        rewardsList.put("recordsFiltered", info.getTotal());
        rewardsList.put("data", list);
        return rewardsList;
    }

    //教师奖励添加弹出页面
    @ResponseBody
    @RequestMapping("/rewards/addrewards")
    public ModelAndView addRewards(String id , String flag) {
        ModelAndView mv = new ModelAndView("/business/educational/rewardspunish/addTeacherRewards");
        if(id==""||id==null){
            mv.addObject("head", "新增");
        }else{
            mv.addObject("head", "修改");
            Rewards rewards= rewardsPunishService.getRewardsById(id);
            mv.addObject("rewards",rewardsPunishService.getRewardsById(id));
            if(flag!=null) {
                if (flag.equals("1") || flag == "1") {
                    mv.addObject("head", "详情信息");
                    mv.addObject("flag", flag);
                    mv.addObject("rewards", rewardsPunishService.getRewardsById(id));
                }
            }
        }
        return mv;
    }

    //教师奖励修改新增保存
    @ResponseBody
    @RequestMapping("/rewards/updaterewardsById")
    public Message updateRewards(Rewards rewards) {
        if (rewards.getId() == null || rewards.equals("") || rewards.getId() == "") {
            rewards.setCreator(CommonUtil.getPersonId());
            rewards.setCreateDept(CommonUtil.getDefaultDept());
            rewards.setId(CommonUtil.getUUID());
            rewardsPunishService.insertRewards(rewards);
            return new Message(1, "新增成功！", null);
        } else {
            rewards.setChanger(CommonUtil.getPersonId());
            rewards.setChangeDept(CommonUtil.getDefaultDept());
            rewardsPunishService.updateRewardsById(rewards);
            return new Message(1, "修改成功！", null);
        }
    }
    //教师奖励删除
    @ResponseBody
    @RequestMapping("/rewards/deleterewardsById")
    public Message deleteDeptById(String id) {
        rewardsPunishService.deleteRewardsById(id);
        return new Message(1, "删除成功！", null);
    }

    //教师惩处弹出页面
    @RequestMapping("/punish/request")
    public ModelAndView punishList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/rewardspunish/teacherPunish");
        return mv;
    }
    //教师惩处初始化页面、查询
    @ResponseBody
    @RequestMapping("/punish/punishAction")
    public Map<String, Object> getPunishList(Punish punish,int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> punishList = new HashMap<String, Object>();
        punish.setCreator(CommonUtil.getPersonId());
        punish.setChangeDept(CommonUtil.getDefaultDept());
        List<Punish> list = rewardsPunishService.punishAction(punish);
        PageInfo<List<Punish>> info = new PageInfo(list);
        punishList.put("draw", draw);
        punishList.put("recordsTotal", info.getTotal());
        punishList.put("recordsFiltered", info.getTotal());
        punishList.put("data", list);
       // List<Punish> list =rewardsPunishService.punishAction(punish);
        //punishMap.put("data", rewardsPunishService.punishAction(punish));
        return punishList;
    }

    //教师奖励添加弹出页面
    @ResponseBody
    @RequestMapping("/punish/addpunish")
    public ModelAndView addPunish(String id , String flag) {
        ModelAndView mv = new ModelAndView("/business/educational/rewardspunish/addTeacherPunish");
        if(id==""||id==null){
            mv.addObject("head", "新增");
        }else{
            mv.addObject("head", "修改");
            Punish punish= rewardsPunishService.getPunishById(id);
            mv.addObject("punish",rewardsPunishService.getPunishById(id));
            if(flag!=null) {
                if (flag.equals("1") || flag == "1") {
                    mv.addObject("head", "详情信息");
                    mv.addObject("flag", flag);
                    mv.addObject("punish", rewardsPunishService.getPunishById(id));
                }
            }
        }
        return mv;
    }
    //教师惩处修改新增保存
    @ResponseBody
    @RequestMapping("/punishs/updatepunishById")
    public Message updatePunish(Punish punish) {
        if (punish.getId() == null || punish.equals("") || punish.getId() == "") {
            punish.setCreator(CommonUtil.getPersonId());
            punish.setCreateDept(CommonUtil.getDefaultDept());
            punish.setId(CommonUtil.getUUID());
            rewardsPunishService.insertPunish(punish);
            return new Message(1, "新增成功！", null);
        } else {
            punish.setChanger(CommonUtil.getPersonId());
            punish.setChangeDept(CommonUtil.getDefaultDept());
            rewardsPunishService.updatePunishById(punish);
            return new Message(1, "修改成功！", null);
        }
    }
    //教师惩处删除
    @ResponseBody
    @RequestMapping("/punish/deletepunishById")
    public Message deletePunishById(String id) {
        rewardsPunishService.deletePunishById(id);
        return new Message(1, "删除成功！", null);
    }

    @RequestMapping("/rewardspunish/request")
    public ModelAndView rewardsPunish() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/rewardspunish/rewardsPunish");
        return mv;
    }

    //教师奖惩统计
    @ResponseBody
    @RequestMapping("/rewardspunish/rewardsPunishAction")
    public Map<String, Object> rewardsPunishAction(RewardsPunish rewardsPunish,int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> rewardsPunishList = new HashMap<String, Object>();
        List<RewardsPunish> list = rewardsPunishService.rewardsPunishAction(rewardsPunish);
        PageInfo<List<RewardsPunish>> info = new PageInfo(list);
        rewardsPunishList.put("draw", draw);
        rewardsPunishList.put("recordsTotal", info.getTotal());
        rewardsPunishList.put("recordsFiltered", info.getTotal());
        rewardsPunishList.put("data", list);
        return rewardsPunishList;
    }

    //教师个人奖惩查看页面跳转wq
    @RequestMapping("/rewardspunish/personal")
    public ModelAndView personalRewardsPunish() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/rewardspunish/personalRewardsPunish");
        return mv;
    }
    //教师个人奖惩查看wq
    @ResponseBody
    @RequestMapping("/rewardspunish/personalRewardsPunishList")
    public Map<String, List<RewardsPunish>> personalRewardsPunishList(RewardsPunish rewardsPunish){
        Map<String, List<RewardsPunish>> rewardsPunishMap = new HashMap<String, List<RewardsPunish>>();
        rewardsPunish.setRname(CommonUtil.getPersonId());
        rewardsPunish.setRdept(CommonUtil.getDefaultDept());
        rewardsPunishMap.put("data", rewardsPunishService.personalRewardsPunishList(rewardsPunish));
        return rewardsPunishMap;
    }
}
