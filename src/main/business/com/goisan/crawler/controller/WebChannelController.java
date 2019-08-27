package com.goisan.crawler.controller;

import com.goisan.crawler.bean.WebChannel;
import com.goisan.crawler.service.WebChannelService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("/crawler/webchannel")
public class WebChannelController {

    @Resource
    private WebChannelService webChannelService;

    @RequestMapping("/toWebChannelList")
    public String toList() {
        return "/business/crawler/webchannel/webChannelList";
    }

    @ResponseBody
    @RequestMapping("/getWebChannelList")
    public Map getList(WebChannel webChannel) {
        return CommonUtil.tableMap(webChannelService.getWebChannelList(webChannel));
    }

    @RequestMapping("/toWebChannelAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/business/crawler/webchannel/webChannelEdit";
    }

    @ResponseBody
    @RequestMapping("/saveWebChannel")
    public Message save(WebChannel webChannel) {
        if ("".equals(webChannel.getId())) {
            webChannel.setId(CommonUtil.getUUID());
            CommonUtil.save(webChannel);
            webChannelService.saveWebChannel(webChannel);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(webChannel);
            webChannelService.updateWebChannel(webChannel);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/toWebChannelEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", webChannelService.getWebChannelById(id));
        model.addAttribute("head", "修改");
        return "/business/crawler/webchannel/webChannelEdit";
    }

    @ResponseBody
    @RequestMapping("/delWebChannel")
    public Message del(String id) {
        webChannelService.delWebChannel(id);
        return new Message(0, "删除成功！", null);
    }

}
