package com.goisan.practice.controller;

import com.goisan.practice.bean.Material;
import com.goisan.practice.service.MaterialService;
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
public class MaterialController {
    @Resource
    private MaterialService materialService;
    /**
     * 实习材料首页跳转
     * @return
     */
    @RequestMapping("/material/materialList")
    public ModelAndView materialList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/practice/materialList");
        return mv;
    }

    /**
     * 实习材料首页数据查询
     * @param material
     * @return
     */
    @ResponseBody
    @RequestMapping("/material/getMaterialList")
    public Map<String, List<Material>> getMaterialList(Material material) {
        Map<String, List<Material>> softInstallMap = new HashMap<String, List<Material>>();
        material.setCreator(CommonUtil.getPersonId());
        material.setChangeDept(CommonUtil.getDefaultDept());
        softInstallMap.put("data", materialService.materialAction(material));
        return softInstallMap;
    }

    /**
     * 实习材料新增
     * @return
     */
    @ResponseBody
    @RequestMapping("/material/addMaterial")
    public ModelAndView addMaterialInstall() {
        ModelAndView mv = new ModelAndView("/business/practice/editMaterial");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        Material material=new Material();
        material.setUploadTime(datetime);
        material.setUploadPerson(CommonUtil.getPersonName());
        mv.addObject("head", "新增实习材料");
        mv.addObject("material",material);
        return mv;
    }

    /**
     * 实习材料修改
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/material/getMaterialById")
    public ModelAndView getMaterialById(String id) {
        ModelAndView mv = new ModelAndView("/business/practice/editMaterial");
        Material material = materialService.getMaterialById(id);
        mv.addObject("head", "实习材料修改");
        mv.addObject("material", material);
        return mv;
    }

    /**
     * 新增和修改保存
     * @param material
     * @return
     */
    @ResponseBody
    @RequestMapping("/material/saveMaterial")
    public Message savematerial(Material material){
        if(material.getId() == null || material.equals("") || material.getId() == ""){
            material.setCreator(CommonUtil.getPersonId());
            material.setCreateDept(CommonUtil.getDefaultDept());
            material.setId(CommonUtil.getUUID());
            materialService.insertMaterial(material);
            return new Message(1, "新增成功！", null);
        }else{
            material.setChanger(CommonUtil.getPersonId());
            material.setChangeDept(CommonUtil.getDefaultDept());
            materialService.updateMaterialById(material);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/material/deleteMaterialById")
    public Message deleteDeptById(String id) {
        materialService.deleteMaterialById(id);
        return new Message(1, "删除成功！", null);
    }
}
