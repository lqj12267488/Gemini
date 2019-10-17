package com.goisan.table.controller;

import com.goisan.table.bean.FixedAssets;
import com.goisan.table.service.FixedAssetsService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.system.bean.BaseBean;

import javax.annotation.Resource;
import java.util.*;

@Controller
public class FixedAssetsController {

    @Resource
    private FixedAssetsService fixedAssetsService;

    @RequestMapping("/fixedassets/toFixedAssetsList")
    public String toFixedAssetsList() {
        return "/business/table/fixedassets/fixedAssetsList";
    }

    @ResponseBody
    @RequestMapping("/fixedassets/getFixedAssetsList")
    public Map<String,Object> getFixedAssetsList(FixedAssets fixedAssets,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  fixedAssetsService.getFixedAssetsList(fixedAssets);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/fixedassets/toFixedAssetsAdd")
    public String toAddFixedAssets(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/fixedassets/fixedAssetsEdit";
    }

    @ResponseBody
    @RequestMapping("/fixedassets/saveFixedAssets")
    public Message saveFixedAssets(FixedAssets fixedAssets) {
        if (null != fixedAssets.getId() && !"".equals(fixedAssets.getId())) {
           CommonUtil.update(fixedAssets);
            fixedAssetsService.updateFixedAssets(fixedAssets);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(fixedAssets);
            fixedAssetsService.saveFixedAssets(fixedAssets);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/fixedassets/toFixedAssetsEdit")
    public String toEditFixedAssets(String id, Model model) {
        model.addAttribute("data", fixedAssetsService.getFixedAssetsById(id));
        model.addAttribute("head", "修改");
        return "/business/table/fixedassets/fixedAssetsEdit";
    }

    @ResponseBody
    @RequestMapping("/fixedassets/delFixedAssets")
    public Message delFixedAssets(String id) {
        fixedAssetsService.delFixedAssets(id);
        return new Message(0, "删除成功！", null);
    }

}
