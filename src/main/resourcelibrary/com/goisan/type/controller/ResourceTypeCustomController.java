package com.goisan.type.controller;

import com.goisan.system.bean.LoginUser;
import com.goisan.type.bean.ResourceTypeCustom;
import com.goisan.type.service.ResourceTypeCustomService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

@Controller
public class ResourceTypeCustomController {

    @Resource
    private ResourceTypeCustomService resourceTypeCustomService;

    @RequestMapping("/resourceLibrary/typeCustom/toResourceTypeCustomList")
    public String toList() {
        return "/resourcelibrary/type/resourceTypeCustomList";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/typeCustom/getResourceTypeCustomList")
    public Map getList(ResourceTypeCustom resourceTypeCustom) {
        String creator = CommonUtil.getPersonId();
        resourceTypeCustom.setCreator(creator);
        return CommonUtil.tableMap(resourceTypeCustomService.getResourceTypeCustomList(resourceTypeCustom));
    }

    @RequestMapping("/resourceLibrary/typeCustom/toResourceTypeCustomAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/resourcelibrary/type/resourceTypeCustomEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/typeCustom/saveResourceTypeCustom")
    public Message save(ResourceTypeCustom resourceTypeCustom) {
        LoginUser login = CommonUtil.getLoginUser();
        if ("".equals(resourceTypeCustom.getTypeId())) {
            resourceTypeCustom.setTypeId(CommonUtil.getUUID());
            CommonUtil.save(resourceTypeCustom);
            resourceTypeCustomService.saveResourceTypeCustom(resourceTypeCustom);
            return new Message(0, "添加成功！", "success");
        } else {
            CommonUtil.update(resourceTypeCustom);
            resourceTypeCustomService.updateResourceTypeCustom(resourceTypeCustom);
            return new Message(0, "修改成功！", "success");
        }

    }

    @RequestMapping("/resourceLibrary/typeCustom/toResourceTypeCustomEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", resourceTypeCustomService.getResourceTypeCustomById(id));
        model.addAttribute("head", "修改");
        return "/resourcelibrary/type/resourceTypeCustomEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/typeCustom/delResourceTypeCustom")
    public Message del(String id) {
        String count = resourceTypeCustomService.checkTypeCustom(id);
        if(null == count || count.equals("0")|| count.equals("")){
            resourceTypeCustomService.delResourceTypeCustom(id);
            return new Message(1, "删除成功！", "success");
        }else{
            return new Message(0, "此资源类型下有数据，目前不能删除", "error");
        }

    }

    //我的资源分类
    @RequestMapping("/resourceLibrary/typeCustom/myReasourceClassify")
    public String myReasourceClassify(String id, Model model) {
        return "/resourcelibrary/type/myTypeLibrary";
    }

}
