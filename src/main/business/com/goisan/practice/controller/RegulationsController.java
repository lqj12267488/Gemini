package com.goisan.practice.controller;

import com.goisan.practice.bean.Regulations;
import com.goisan.practice.service.RegulationsService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class RegulationsController {
    @Resource
    private RegulationsService regulationsService;
    /**
     * 实习管理规定首页跳转
     * @return
     */
    @RequestMapping("/regulations/regulationsList")
    public ModelAndView regulationsList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/practice/regulationsList");
        return mv;
    }

    /**
     * 实习管理规定首页数据查询
     * @param regulations
     * @return
     */
    @ResponseBody
    @RequestMapping("/regulations/getRegulationsList")
    public Map<String, List<Regulations>> getRegulationsList(Regulations regulations) {
        Map<String, List<Regulations>> softInstallMap = new HashMap<String, List<Regulations>>();
        regulations.setCreator(CommonUtil.getPersonId());
        regulations.setChangeDept(CommonUtil.getDefaultDept());
        softInstallMap.put("data", regulationsService.regulationsAction(regulations));
        return softInstallMap;
    }

    /**
     * 实习管理规定新增
     * @return
     */
    @ResponseBody
    @RequestMapping("/regulations/addRegulations")
    public ModelAndView addRegulationsInstall() {
        ModelAndView mv = new ModelAndView("/business/practice/editRegulations");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        Regulations regulations=new Regulations();
        regulations.setUploadTime(datetime);
        regulations.setUploadPerson(CommonUtil.getPersonName());
        mv.addObject("head", "新增实习管理规定");
        mv.addObject("regulations",regulations);
        return mv;
    }

    /**
     * 实习管理规定修改
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/regulations/getRegulationsById")
    public ModelAndView getRegulationsById(String id) {
        ModelAndView mv = new ModelAndView("/business/practice/editRegulations");
        Regulations regulations = regulationsService.getRegulationsById(id);
        mv.addObject("head", "实习管理规定修改");
        mv.addObject("regulations", regulations);
        return mv;
    }

    /**
     * 新增和修改保存
     * @param regulations
     * @return
     */
    @ResponseBody
    @RequestMapping("/regulations/saveRegulations")
    public Message saveregulations(Regulations regulations){
        if(regulations.getId() == null || regulations.equals("") || regulations.getId() == ""){
            regulations.setCreator(CommonUtil.getPersonId());
            regulations.setCreateDept(CommonUtil.getDefaultDept());
            regulations.setId(CommonUtil.getUUID());
            regulationsService.insertRegulations(regulations);
            return new Message(1, "新增成功！", null);
        }else{
            regulations.setChanger(CommonUtil.getPersonId());
            regulations.setChangeDept(CommonUtil.getDefaultDept());
            regulationsService.updateRegulationsById(regulations);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/regulations/deleteRegulationsById")
    public Message deleteDeptById(String id) {
        regulationsService.deleteRegulationsById(id);
        return new Message(1, "删除成功！", null);
    }

}
