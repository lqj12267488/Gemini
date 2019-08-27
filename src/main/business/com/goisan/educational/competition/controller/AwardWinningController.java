package com.goisan.educational.competition.controller;


import com.goisan.educational.competition.bean.AwardWinning;
import com.goisan.educational.competition.service.AwardWinningService;
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

@Controller
public class AwardWinningController {

        @Resource
        private AwardWinningService awardWinningService;

        /**
         * 获奖情况首页跳转
         * @return
         */
        @RequestMapping("/awardWinning/awardWinningList")
        public ModelAndView awardWinningList() {
            ModelAndView mv = new ModelAndView();
            mv.setViewName("/business/educational/awardwinning/awardWinningList");
            return mv;
        }

        /**
         * 获奖情况首页数据查询
         * @param awardWinning
         * @return
         */
        @ResponseBody
        @RequestMapping("/awardWinning/getAwardWinningList")
        public Map<String, List<AwardWinning>> getAwardWinningList(AwardWinning awardWinning) {
            Map<String, List<AwardWinning>> softInstallMap = new HashMap<String, List<AwardWinning>>();
            awardWinning.setCreator(CommonUtil.getPersonId());
            awardWinning.setChangeDept(CommonUtil.getDefaultDept());
            softInstallMap.put("data", awardWinningService.awardWinningAction(awardWinning));
            return softInstallMap;
        }

        /**
         * 获奖情况新增
         * @return
         */
        @ResponseBody
        @RequestMapping("/awardWinning/addAwardWinning")
        public ModelAndView addAwardWinningInstall() {
            ModelAndView mv = new ModelAndView("/business/educational/awardwinning/editAwardWinning");
            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
            String date = formatDate.format(new Date());
            AwardWinning awardWinning=new AwardWinning();
            mv.addObject("head", "新增获奖情况");
            mv.addObject("awardWinning",awardWinning);
            return mv;
        }

        /**
         * 获奖情况修改
         * @param id
         * @return
         */
        @ResponseBody
        @RequestMapping("/awardWinning/getAwardWinningById")
        public ModelAndView getAwardWinningById(String id) {
            ModelAndView mv = new ModelAndView("/business/educational/awardwinning/editAwardWinning");
            AwardWinning awardWinning = awardWinningService.getAwardWinningById(id);
            mv.addObject("head", "获奖情况修改");
            mv.addObject("awardWinning", awardWinning);
            return mv;
        }

        /**
         * 新增和修改保存
         * @param awardWinning
         * @return
         */
        @ResponseBody
        @RequestMapping("/awardWinning/saveAwardWinning")
        public Message saveawardWinning(AwardWinning awardWinning){
            if(awardWinning.getId() == null || awardWinning.equals("") || awardWinning.getId() == ""){
                awardWinning.setCreator(CommonUtil.getPersonId());
                awardWinning.setCreateDept(CommonUtil.getDefaultDept());
                awardWinning.setId(CommonUtil.getUUID());
                awardWinningService.insertAwardWinning(awardWinning);
                return new Message(1, "新增成功！", null);
            }else{
                awardWinning.setChanger(CommonUtil.getPersonId());
                awardWinning.setChangeDept(CommonUtil.getDefaultDept());
                awardWinningService.updateAwardWinningById(awardWinning);
                return new Message(1, "修改成功！", null);
            }
        }

        /**
         * 删除
         * @param id
         * @return
         */
        @ResponseBody
        @RequestMapping("/awardWinning/deleteAwardWinningById")
        public Message deleteDeptById(String id) {
            awardWinningService.deleteAwardWinningById(id);
            return new Message(1, "删除成功！", null);
        }


}
