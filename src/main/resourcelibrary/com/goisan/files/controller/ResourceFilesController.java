package com.goisan.files.controller;

import com.goisan.files.bean.ResourceFiles;
import com.goisan.files.service.ResourceFilesService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

@Controller
public class ResourceFilesController {

    @Resource
    private ResourceFilesService resourceFilesService;

    @RequestMapping("/resourceLibrary/files/toResourceFilesList")
    public String toList() {
        return "/resourcelibrary/files/resourceFilesList";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/files/getResourceFilesList")
    public Map getList(ResourceFiles resourceFiles) {
        return CommonUtil.tableMap(resourceFilesService.getResourceFilesList(resourceFiles));
    }

    @RequestMapping("/resourceLibrary/files/toResourceFilesAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/resourcelibrary/files/resourceFilesEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/files/saveResourceFiles")
    public Message save(ResourceFiles resourceFiles) {
        if ("".equals(resourceFiles.getFileId())) {
            resourceFiles.setFileId(CommonUtil.getUUID());
            CommonUtil.save(resourceFiles);
            resourceFilesService.saveResourceFiles(resourceFiles);
            return new Message(0, "添加成功！", "success");
        } else {
            CommonUtil.update(resourceFiles);
            resourceFilesService.updateResourceFiles(resourceFiles);
            return new Message(0, "修改成功！", "success");
        }

    }

    @RequestMapping("/resourceLibrary/files/toResourceFilesEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", resourceFilesService.getResourceFilesById(id));
        model.addAttribute("head", "修改");
        return "/resourcelibrary/files/resourceFilesEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/files/delResourceFiles")
    public Message del(String id) {
        resourceFilesService.delResourceFiles(id);
        return new Message(0, "删除成功！", "success");
    }

}
