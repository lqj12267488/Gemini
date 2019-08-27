package com.goisan.educational.expatriateteaching.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.expatriateteaching.bean.ExpatriateTeaching;
import com.goisan.educational.expatriateteaching.service.ExpatriateTeachingService;
import com.goisan.system.bean.Files;
import com.goisan.system.service.FilesService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ExpatriateTeachingController {

    @Resource
    private ExpatriateTeachingService expatriateTeachingService;

    @RequestMapping("/educational/expatriateTeaching/toExpatriateTeachingList")
    public String toList() {
        return "/business/expatriateTeaching/expatriateTeachingList";
    }

    @ResponseBody
    @RequestMapping("/educational/expatriateTeaching/getExpatriateTeachingList")
    public Map<String, Object> getList(ExpatriateTeaching expatriateTeaching, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> expatriateTeachingList = new HashMap<String, Object>();
        List<ExpatriateTeaching> list = expatriateTeachingService.getExpatriateTeachingList(expatriateTeaching);
        PageInfo<List<ExpatriateTeaching>> info = new PageInfo(list);
        expatriateTeachingList.put("draw", draw);
        expatriateTeachingList.put("recordsTotal", info.getTotal());
        expatriateTeachingList.put("recordsFiltered", info.getTotal());
        expatriateTeachingList.put("data", list);
        return expatriateTeachingList;
    }

    @RequestMapping("/educational/expatriateTeaching/toExpatriateTeachingAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        model.addAttribute("id", CommonUtil.getUUID());
        return "/business/expatriateTeaching/expatriateTeachingAdd";
    }

    @ResponseBody
    @RequestMapping("/educational/expatriateTeaching/saveExpatriateTeaching")
    public Message save(ExpatriateTeaching expatriateTeaching) {
        CommonUtil.save(expatriateTeaching);
        expatriateTeachingService.saveExpatriateTeaching(expatriateTeaching);
        return new Message(0, "添加成功！", null);
    }

    @ResponseBody
    @RequestMapping("/educational/expatriateTeaching/updateExpatriateTeaching")
    public Message updateExpatriateTeaching(ExpatriateTeaching expatriateTeaching) {
        CommonUtil.update(expatriateTeaching);
        expatriateTeachingService.updateExpatriateTeaching(expatriateTeaching);
        return new Message(0, "修改成功！", null);
    }

    @Resource
    private FilesService filesService;

    @RequestMapping("/educational/expatriateTeaching/toExpatriateTeachingEdit")
    public String toEdit(String id, Model model) {
        List<Files> files = filesService.getFilesByBusinessId(id);
        StringBuilder filesName =new StringBuilder();
        for (Files file : files) {
            filesName.append("<a href='/files/downloadFiles?id=").append(file.getFileId()).append("'>").append(file.getFileName()).append("<br/>");
        }
        if ("".equals(filesName)) {
            filesName.append("无");
        }
        model.addAttribute("filesName", filesName);
        model.addAttribute("data", expatriateTeachingService.getExpatriateTeachingById(id));
        model.addAttribute("head", "修改");
        return "/business/expatriateTeaching/expatriateTeachingEdit";
    }

    @ResponseBody
    @RequestMapping("/educational/expatriateTeaching/delExpatriateTeaching")
    public Message del(String id) {
        expatriateTeachingService.delExpatriateTeaching(id);
        return new Message(0, "删除成功！", null);
    }

}
