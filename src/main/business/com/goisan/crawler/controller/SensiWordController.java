package com.goisan.crawler.controller;

import com.goisan.crawler.bean.SensiWord;
import com.goisan.crawler.service.SensiWordService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("/crawler/sensiword")
public class SensiWordController {

    @Resource
    private SensiWordService sensiWordService;

    @RequestMapping("/toSensiWordList")
    public String toList() {
        return "/business/crawler/sensiword/sensiWordList";
    }

    @ResponseBody
    @RequestMapping("/getSensiWordList")
    public Map getList(SensiWord sensiWord) {
        return CommonUtil.tableMap(sensiWordService.getSensiWordList(sensiWord));
    }

    @RequestMapping("/toSensiWordAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/business/crawler/sensiword/sensiWordEdit";
    }

    @ResponseBody
    @RequestMapping("/saveSensiWord")
    public Message save(SensiWord sensiWord) {
        if ("".equals(sensiWord.getId())) {
            sensiWord.setId(CommonUtil.getUUID());
            CommonUtil.save(sensiWord);
            sensiWordService.saveSensiWord(sensiWord);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(sensiWord);
            sensiWordService.updateSensiWord(sensiWord);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/toSensiWordEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", sensiWordService.getSensiWordById(id));
        model.addAttribute("head", "修改");
        return "/business/crawler/sensiword/sensiWordEdit";
    }

    @ResponseBody
    @RequestMapping("/delSensiWord")
    public Message del(String id) {
        sensiWordService.delSensiWord(id);
        return new Message(0, "删除成功！", null);
    }

}
