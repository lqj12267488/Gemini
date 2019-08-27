package com.goisan.collection.controller;

import com.goisan.collection.bean.ResourceCollection;
import com.goisan.collection.service.ResourceCollectionService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

@Controller
public class ResourceCollectionController {

    @Resource
    private ResourceCollectionService resourceCollectionService;

    @RequestMapping("/resourceLibrary/collection/toResourceCollectionList")
    public String toList() {
        return "/resourcelibrary/collection/resourceCollectionList";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/collection/getResourceCollectionList")
    public Map getList(ResourceCollection resourceCollection) {
        resourceCollection.setPersonId(CommonUtil.getPersonId());
        return CommonUtil.tableMap(resourceCollectionService.getResourceCollectionList(resourceCollection));
    }

    @RequestMapping("/resourceLibrary/collection/toResourceCollectionAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/resourcelibrary/collection/resourceCollectionEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/collection/saveResourceCollection")
    public Message save(ResourceCollection resourceCollection) {
        if (resourceCollection.getValidFlag().equals("0")) {
            resourceCollection.setId(CommonUtil.getUUID());
            CommonUtil.save(resourceCollection);
            resourceCollectionService.saveResourceCollection(resourceCollection);
            return new Message(0, "收藏成功！", "success");
        } else {
            CommonUtil.update(resourceCollection);
            resourceCollectionService.updateResourceCollection(resourceCollection);
            return new Message(0, "取消收藏成功！", "success");
        }
    }

    @RequestMapping("/resourceLibrary/collection/toResourceCollectionEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", resourceCollectionService.getResourceCollectionById(id));
        model.addAttribute("head", "修改");
        return "/resourcelibrary/collection/resourceCollectionEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/collection/delResourceCollection")
    public Message del(String id) {
        resourceCollectionService.delResourceCollection(id);
        return new Message(0, "删除成功！", "success");
    }

    @RequestMapping("/resourceLibrary/collection/myResourceCollectionList")
    public String myResourceCollectionList() {
        return "/resourcelibrary/privateResource/myCollectionList";
    }

}
