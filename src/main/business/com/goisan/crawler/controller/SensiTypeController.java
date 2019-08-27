package com.goisan.crawler.controller;

import com.goisan.crawler.bean.SensiType;
import com.goisan.crawler.bean.SensiWord;
import com.goisan.crawler.service.SensiTypeService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/crawler/sensitype")
public class SensiTypeController {

    @Resource
    private SensiTypeService sensiTypeService;

    @RequestMapping("/toSensiTypeList")
    public String toList() {
        return "/business/crawler/sensitype/sensiTypeList";
    }

    @ResponseBody
    @RequestMapping("/getSensiTypeList")
    public Map getList(SensiType sensiType) {
        return CommonUtil.tableMap(sensiTypeService.getSensiTypeList(sensiType));
    }

    @RequestMapping("/toSensiTypeAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/business/crawler/sensitype/sensiTypeEdit";
    }

    @ResponseBody
    @RequestMapping("/saveSensiType")
    public Message save(SensiType sensiType) {
        if ("".equals(sensiType.getId())) {
            sensiType.setId(CommonUtil.getUUID());
            CommonUtil.save(sensiType);
            sensiTypeService.saveSensiType(sensiType);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(sensiType);
            sensiTypeService.updateSensiType(sensiType);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/toSensiTypeEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", sensiTypeService.getSensiTypeById(id));
        model.addAttribute("head", "修改");
        return "/business/crawler/sensitype/sensiTypeEdit";
    }

    @ResponseBody
    @RequestMapping("/delSensiType")
    public Message del(String id) {
        Message message = new Message(0, "删除成功！", null);
        List<SensiWord> sensiWords = sensiTypeService.getSensiWordBySensiTypeId(id);
        if (sensiWords.size() > 0) {
            message.setMsg("该条记录已经被使用，不能删除！");
        } else {
            sensiTypeService.delSensiType(id);
        }
        return message;
    }

}
