package com.goisan.indexsearch.controller;

import com.goisan.approval.bean.ResourcePublic;
import com.goisan.approval.service.ResourcePublicService;
import com.goisan.common.ResourcelibraryCommonUtil;
import com.goisan.indexsearch.bean.ResourceView;
import com.goisan.indexsearch.service.IndexSearchService;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/9/28.
 */
@Controller
public class IndexSearchController {
    @Resource
    private IndexSearchService indexSearchService;

    /**
     * 资源库首页
     * @return
     */
    @RequestMapping("/resourceLibrary/toIndex")
    public ModelAndView toResourceLibraryIndex() {
        ModelAndView mv = new ModelAndView();
        LoginUser loginUser = CommonUtil.getLoginUser();
        mv.addObject("userName",loginUser.getName());
        ResourceView resourceView = new ResourceView();
        resourceView.setRemark("");
        ResourceView countResource = indexSearchService.getCountResource(resourceView);

        String ResourceFileSize = countResource.getFileSize();
        try {
            long fileSize = Long.parseLong(ResourceFileSize);
            String size = ResourcelibraryCommonUtil.fileSize(fileSize);
            countResource.setFileSize(size);
        } catch (Exception e) {
            e.printStackTrace();
        }

        mv.addObject("countResource",countResource);
        mv.setViewName("/resourcelibrary/resourcelibraryIndex");
        return mv;
    }

    /*
    * by liudelong
    * Start
    * */
    //热门推荐搜索跳转页
    @RequestMapping("/IndexSearch/skip")
    public String indexSearch(String flag,String keyword,Model model) {
        String flag1=flag;
        if("".equals(keyword)||keyword==null||"null".equals(keyword)){

        }else{
            try {
                keyword = URLDecoder.decode(keyword, "UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            model.addAttribute("keyword",keyword);
        }
        LoginUser loginUser = CommonUtil.getLoginUser();
        model.addAttribute("flag",flag);
        model.addAttribute("userName",loginUser.getName());
        return "/resourcelibrary/searchResources/searchResourceList";
    }

    @ResponseBody
    @RequestMapping("/IndexSearch/SearchResource")
    public Map searchresource(ResourceView resourceView) {
        if((null == resourceView.getStartCount() || resourceView.getStartCount().equals(""))
            && (null == resourceView.getEndCount() || resourceView.getEndCount().equals(""))){
            resourceView.setStartCount("1");
            resourceView.setEndCount("12");
        }
        String format_id = resourceView.getResourceFormat();
        String format[] = new String [2];
        if(format_id!=null && !"".equals(format_id) && !"null".equals(format_id)){
             format = format_id.split("_");
             resourceView.setResourceFormat(format[1]);
        }
        String subject = resourceView.getResourceSubjectId();
        String major = resourceView.getResourceMajorId();
        String course = resourceView.getResourceCourseId();
        if("all".equals(subject)){
            resourceView.setResourceSubjectId("");
        }
        if( "all".equals(major) ){
            resourceView.setResourceMajorId("");
        }
        if("all".equals(course)){
            resourceView.setResourceCourseId("");
        }
        String flag = resourceView.getFlag();
        if("1".equals(flag)){
            resourceView.setOrderBy("viewCount");
        }else if("2".equals(flag)){
            resourceView.setOrderBy("downCount");
        }else{
            resourceView.setOrderBy("publicTime");
        }
        List<ResourceView>list = indexSearchService.searchResourceList(resourceView);
        resourceView.setOrderBy("");
        String countNum= indexSearchService.countSearchResource(resourceView);
        Map resultData = new HashMap();
        resultData.put("listData",list);
        resultData.put("countNum",countNum);
        return resultData;
    }

    /*
    * by liudelong
    * end
    * */



    /*
    * by yangsuang
    * Start
    * */
    @Resource
    private ResourcePublicService resourcePublicService;

    @ResponseBody
    @RequestMapping("/resourceLibrary/loginList")
    public Map<String, List> loginInList() {
        ResourcePublic resourcePublic = new ResourcePublic();
        Map<String, List> map = new HashMap<String, List>();
        // wdzy 文档资源
        resourcePublic.setRownum("4");
        resourcePublic.setResourceFormat("1");
        List resourcelist_wdzy = resourcePublicService.getPublicList(resourcePublic);
        map.put("wdzy", resourcelist_wdzy);
        // spzy  视频资源
        resourcePublic.setRownum("8");
        resourcePublic.setResourceFormat("4");
        List resourcelist_spzy = resourcePublicService.getPublicList(resourcePublic);
        map.put("spzy", resourcelist_spzy);
        resourcePublic.setResourceFormat("");

        resourcePublic.setRownum("3");
        // kjzy   课件
        resourcePublic.setResourceType("1");
        List resourcelist_kjzy = resourcePublicService.getPublicList(resourcePublic);
        map.put("kjzy", resourcelist_kjzy);
        // jazy   教案
        resourcePublic.setResourceType("3");
        List resourcelist_jazy = resourcePublicService.getPublicList(resourcePublic);
        map.put("jazy", resourcelist_jazy);
        // sczy   素材
        resourcePublic.setResourceType("4");
        List resourcelist_sczy = resourcePublicService.getPublicList(resourcePublic);
        map.put("sczy", resourcelist_sczy);
        // xtzy   习题
        resourcePublic.setResourceType("5");
        List resourcelist_xtzy = resourcePublicService.getPublicList(resourcePublic);
        map.put("xtzy", resourcelist_xtzy);
        // yhgx 用户贡献
        ResourceView resourceView = new ResourceView();
        resourceView.setStartCount("1");
        resourceView.setEndCount("8");
        resourceView.setOrderBy("countNum");
        List<ResourceView> resourcelist_yhgx = indexSearchService.searchResourceContribution(resourceView);
        map.put("yhgx", resourcelist_yhgx);

        // js 专业贡献排行    Contribution
        List<ResourceView> resourcelist_zygx = indexSearchService.searchMajorContribution(resourceView);
        map.put("zygx", resourcelist_zygx);

        List<ResourceView> personGx1 ;
        List<ResourceView> personGx2 ;
        //  personGx1  用户贡献1
        if(resourcelist_yhgx.size()>=1){
            String personId = resourcelist_yhgx.get(0).getPublicPersonId();
            resourceView.setOrderBy(" publicTime ");
            resourceView.setPublicPersonId(personId);
            resourceView.setEndCount("8");
            personGx1 = new ArrayList();
            personGx1 = indexSearchService.searchResourceList(resourceView);
            map.put("personGx1", personGx1);
        }

        //  personGx2  用户贡献2
        if(resourcelist_yhgx.size()>=2){
            String personId = resourcelist_yhgx.get(1).getPublicPersonId();
            resourceView.setOrderBy("publicTime ");
            resourceView.setPublicPersonId(personId);
            resourceView.setEndCount("8");
            personGx2 = new ArrayList();
            personGx2 = indexSearchService.searchResourceList(resourceView);
            map.put("personGx2", personGx2);
        }

        return map;
    }


    /*
    * by yangsuang
    * end
    * */


}
