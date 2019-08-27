package com.goisan.crawler.controller;

import com.goisan.crawler.bean.WebType;
import com.goisan.crawler.service.WebTypeService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("/crawler/webtype")
public class WebTypeController {

    @Resource
    private WebTypeService webTypeService;

    @RequestMapping("/toWebTypeList")
    public String toList() {
        return "/business/crawler/webtype/webTypeList";
    }

    @ResponseBody
    @RequestMapping("/getWebTypeList")
    public Map getList(WebType webType) {
        return CommonUtil.tableMap(webTypeService.getWebTypeList(webType));
    }

    @RequestMapping("/toWebTypeAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/business/crawler/webtype/webTypeEdit";
    }

    @ResponseBody
    @RequestMapping("/saveWebType")
    public Message save(WebType webType) {
        if ("".equals(webType.getId())) {
            webType.setId(CommonUtil.getUUID());
            CommonUtil.save(webType);
            webTypeService.saveWebType(webType);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(webType);
            webTypeService.updateWebType(webType);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/toWebTypeEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", webTypeService.getWebTypeById(id));
        model.addAttribute("head", "修改");
        return "/business/crawler/webtype/webTypeEdit";
    }

    @ResponseBody
    @RequestMapping("/delWebType")
    public Message del(String id) {
        webTypeService.delWebType(id);
        return new Message(0, "删除成功！", null);
    }

}
