package com.goisan.table.controller;

import com.goisan.table.bean.BookCollection;
import com.goisan.table.bean.FixedAssets;
import com.goisan.table.service.BookCollectionService;
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
public class BookCollectionController {

    @Resource
    private BookCollectionService bookCollectionService;

    @RequestMapping("/bookcollection/toBookCollectionList")
    public String toBookCollectionList() {
        return "/business/table/bookcollection/bookCollectionList";
    }

    @ResponseBody
    @RequestMapping("/bookcollection/getBookCollectionList")
    public Map<String,Object> getBookCollectionList(BookCollection bookCollection,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  bookCollectionService.getBookCollectionList(bookCollection);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/bookcollection/toBookCollectionAdd")
    public String toAddBookCollection(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/bookcollection/bookCollectionEdit";
    }

    @ResponseBody
    @RequestMapping("/bookcollection/saveBookCollection")
    public Message saveBookCollection(BookCollection bookCollection) {
        if (null != bookCollection.getId() && !"".equals(bookCollection.getId())) {
           CommonUtil.update(bookCollection);
            bookCollectionService.updateBookCollection(bookCollection);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(bookCollection);
            bookCollectionService.saveBookCollection(bookCollection);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/bookcollection/toBookCollectionEdit")
    public String toEditBookCollection(String id, Model model) {
        model.addAttribute("data", bookCollectionService.getBookCollectionById(id));
        model.addAttribute("head", "修改");

        return "/business/table/bookcollection/bookCollectionEdit";
    }

    @ResponseBody
    @RequestMapping("/bookcollection/delBookCollection")
    public Message delBookCollection(String id) {
        bookCollectionService.delBookCollection(id);
        return new Message(0, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/bookcollection/checkYear")
    public Message bookCollectionCheckYear(BookCollection bookCollection){
        List size = bookCollectionService.checkYear(bookCollection);
        if(size.size()>0){
            return new Message(1, "年份重复，请重新选择！", null);
        }else{
            return new Message(0, "", null);
        }
    }
}
