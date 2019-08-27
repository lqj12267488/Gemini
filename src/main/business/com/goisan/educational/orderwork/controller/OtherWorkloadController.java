package com.goisan.educational.orderwork.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.orderwork.bean.OtherWorkload;
import com.goisan.educational.orderwork.service.OtherWorkloadService;
import com.goisan.educational.textbook.bean.TextBookLog;
import com.goisan.system.bean.Files;
import com.goisan.system.service.FilesService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class OtherWorkloadController {
    @Resource
    OtherWorkloadService otherWorkloadService;

    /**
     * 其他工作量页面跳转
     *
     * @return
     */
    @RequestMapping("/otherWorkload")
    public ModelAndView otherWorkloadList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/otherWork/otherWorkload");
        return mv;
    }


    /**
     * 其他工作量首页数据查询
     *
     * @param otherWorkload
     * @return
     */
    @ResponseBody
    @RequestMapping("/otherWorkload/otherWorkloadAction")
    public Map<String, Object> getOtherWorkloadList(OtherWorkload otherWorkload,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> otherWorkloadList = new HashMap<String, Object>();
        List<OtherWorkload> list = otherWorkloadService.otherWorkloadAction(otherWorkload);
        PageInfo<List<OtherWorkload>> info = new PageInfo(list);
        otherWorkloadList.put("draw", draw);
        otherWorkloadList.put("recordsTotal", info.getTotal());
        otherWorkloadList.put("recordsFiltered", info.getTotal());
        otherWorkloadList.put("data", list);
        return otherWorkloadList;
    }

    @ResponseBody
    @RequestMapping("/otherWorkload/addOtherWorkload")
    public ModelAndView addOtherWorkload() {
        ModelAndView mv = new ModelAndView("/business/educational/otherWork/addOtherWorkload");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date + 'T' + time;
        OtherWorkload otherWorkload = new OtherWorkload();
        otherWorkload.setTime(datetime);
        mv.addObject("head", "新增");
        mv.addObject("otherWorkload", otherWorkload);
        mv.addObject("id", CommonUtil.getUUID());
        return mv;
    }

    @Resource
    private FilesService filesService;

    @ResponseBody
    @RequestMapping("/otherWorkload/editOtherWorkload")
    public ModelAndView editOtherWorkload(String id, String type) {
        ModelAndView mv = new ModelAndView("/business/educational/otherWork/editOtherWorkload");
        mv.addObject("head", "修改");
        OtherWorkload otherWorkload = otherWorkloadService.getOtherWorkloadById(id);
        mv.addObject("otherWorkload", otherWorkload);
        List<Files> files = filesService.getFilesByBusinessId(id);
        StringBuilder filesName =new StringBuilder();
        for (Files file : files) {
            filesName.append("<a href='/files/downloadFiles?id=").append(file.getFileId()).append("'>").append(file.getFileName()).append("<br/>");
        }
        if ("".equals(filesName)) {
            filesName.append("无");
        }
        mv.addObject("filesName", filesName);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/otherWorkload/saveOtherWorkloadById")
    public Message saveOtherWorkloadById(OtherWorkload otherWorkload) {
        otherWorkload.setCreator(CommonUtil.getPersonId());
        otherWorkload.setCreateDept(CommonUtil.getDefaultDept());
        otherWorkloadService.insertOtherWorkload(otherWorkload);
        return new Message(1, "新增成功！", null);
    }

    @ResponseBody
    @RequestMapping("/otherWorkload/updateOtherWorkloadById")
    public Message updateOtherWorkload(OtherWorkload otherWorkload) {
        otherWorkload.setChanger(CommonUtil.getPersonId());
        otherWorkload.setChangeDept(CommonUtil.getDefaultDept());
        otherWorkloadService.updateOtherWorkloadById(otherWorkload);
        return new Message(1, "修改成功！", null);
    }

    @ResponseBody
    @RequestMapping("/otherWorkload/deleteOtherWorkloadById")
    public Message deleteOtherWorkloadById(String id) {
        otherWorkloadService.deleteOtherWorkloadById(id);
        return new Message(1, "删除成功！", null);
    }
}
