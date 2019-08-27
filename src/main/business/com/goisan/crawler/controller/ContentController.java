package com.goisan.crawler.controller;

import com.goisan.crawler.bean.Content;
import com.goisan.crawler.service.ContentService;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("/crawler/content")
public class ContentController {

    @Resource
    private ContentService contentService;

    @RequestMapping("/toContentList")
    public String toList() {
        return "/business/crawler/content/contentList";
    }

    @ResponseBody
    @RequestMapping("/getContentList")
    public Map getList(Content content) {
        return CommonUtil.tableMap(contentService.getContentList(content));
    }

}
