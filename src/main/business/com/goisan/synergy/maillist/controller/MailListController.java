package com.goisan.synergy.maillist.controller;

import com.goisan.synergy.maillist.bean.MailList;
import com.goisan.synergy.maillist.service.MailListService;
import com.goisan.synergy.message.bean.Message;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wq on 2017/10/24.
 */
@Controller
public class MailListController {
    @Resource
    MailListService mailListService;
    @RequestMapping("/mailList/action")
    public ModelAndView MailListAction(){
        ModelAndView mv=new ModelAndView("/business/synergy/workflow/mailList");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/mailList/getMailList")
    public Map<String,List<MailList>> getMailList(MailList mailList){
        List<MailList> mailLists = mailListService.getMailList(mailList);
        Map<String, List<MailList>> map = new HashMap<String, List<MailList>>();
        map.put("data", mailLists);
        return map;
    }
    @ResponseBody
    @RequestMapping("/mailList/autoCompleteDept")
    public List<AutoComplete> autoCompleteDept(){
        return mailListService.getAutoCompleteDept();
    }
    @ResponseBody
    @RequestMapping("/mailList/autoCompleteEmployee")
    public List<AutoComplete> autoCompleteEmployee(){
        return mailListService.getAutoCompleteEmployee();
    }
}
