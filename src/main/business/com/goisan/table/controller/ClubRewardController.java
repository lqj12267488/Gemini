package com.goisan.table.controller;

import com.goisan.table.bean.ClubReward;
import com.goisan.table.service.ClubRewardService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.system.bean.BaseBean;

import javax.annotation.Resource;
import java.util.*;

@Controller
public class ClubRewardController {

    @Resource
    private ClubRewardService clubRewardService;

    @RequestMapping("/clubreward/toClubRewardList")
    public String toClubRewardList() {
        return "/business/table/clubreward/clubRewardList";
    }

    @ResponseBody
    @RequestMapping("/clubreward/getClubRewardList")
    public Map<String,Object> getClubRewardList(ClubReward clubReward,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  clubRewardService.getClubRewardList(clubReward);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/clubreward/toClubRewardAdd")
    public String toAddClubReward(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/clubreward/clubRewardEdit";
    }

    @ResponseBody
    @RequestMapping("/clubreward/saveClubReward")
    public Message saveClubReward(ClubReward clubReward) {
        if (null != clubReward.getId() && !"".equals(clubReward.getId())) {
            CommonUtil.update(clubReward);
            clubRewardService.updateClubReward(clubReward);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(clubReward);
            clubRewardService.saveClubReward(clubReward);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/clubreward/toClubRewardEdit")
    public String toEditClubReward(String id, Model model) {
        model.addAttribute("data", clubRewardService.getClubRewardById(id));
        model.addAttribute("head", "修改");
        return "/business/table/clubreward/clubRewardEdit";
    }

    @ResponseBody
    @RequestMapping("/clubreward/delClubReward")
    public Message delClubReward(String id) {
        clubRewardService.delClubReward(id);
        return new Message(0, "删除成功！", null);
    }

}
