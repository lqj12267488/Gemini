package com.goisan.archives.controller;

import com.goisan.archives.bean.ArchivesType;
import com.goisan.archives.service.ArchivesTypeService;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.DeptService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class ArchivesTypeController {
    @Resource
    private ArchivesTypeService archivesTypeService;
    @Resource
    private DeptService deptService;
    /**
     *电子档案类别维护根节点*/
    @ResponseBody
    @RequestMapping("/archivesType/getArchivesTypeTree")
    public List<Tree> getArchivesTypeTree() {
        List<Tree> trees = archivesTypeService.getArchivesTypeTree();
        Tree root = new Tree();
        root.setId("0");
        root.setName("电子档案类别");
        root.setpId("root");
        root.setOpen(true);
        trees.add(root);
        return trees;
    }
    /**
     * 电子档案类别页面*/
    @ResponseBody
    @RequestMapping("/archivesType/archivesTypeList")
    public ModelAndView archivesTypeList(){
        ModelAndView modelAndView=new ModelAndView("/business/archives/archivesTypeList");
        return modelAndView;
    }
    /**
     * 电子档案类别新增*/
    @ResponseBody
    @RequestMapping("/archivesType/addArchivesType")
    public ModelAndView addArchivesType(String pId, String typeName) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("id", archivesTypeService.getNewTypeId(pId));
        mv.addObject("pId", pId);
        mv.addObject("name", typeName);
        mv.setViewName("/business/archives/addArchivesType");
        return mv;
    }
    /**
     * 字典类别名称查重
     */
    @ResponseBody
    @RequestMapping("/archivesType/checkName")
    public Message archivesTypeCheckName(ArchivesType archivesType){
        List size = archivesTypeService.checkName(archivesType);
        if(size.size()>0){
            return new Message(1, "名称重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    /**
     * 字典二级编号查重
     */
    @ResponseBody
    @RequestMapping("/archivesType/checkId")
    public Message archivesTypeCheckId(ArchivesType archivesType){
        List size = archivesTypeService.checkId(archivesType);
        if(size.size()>0){
            return new Message(1, "编号重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    /**
     * 电子档案新增保存*/
    @ResponseBody
    @RequestMapping("/archivesType/saveArchivesType")
    public Message saveArchivesType(ArchivesType archivesType) {
        if(archivesType.getPublicType().equals("1")){
            List<ArchivesType> allPid=archivesTypeService.allPid(archivesType);
            for(int i=0;i<allPid.size();i++){
                String[] pid=allPid.get(i).getTypeId().split(",");
                String apid="";
                for(int j=0;j<pid.length;j++){
                    apid= pid[j];
                    archivesType.setCreator(CommonUtil.getPersonId());
                    archivesType.setCreateTime(CommonUtil.getDate());
                    archivesType.setCreateDept(CommonUtil.getDefaultDept());
                    archivesType.setParentTypeId(apid);
                    archivesType.setTypeId(apid+archivesType.getNewTypeId());
                    String dicorder = archivesTypeService.getMaxDeptOrder(archivesType.getParentTypeId());
                    if (dicorder != null && dicorder != "") {
                        int neworder = Integer.parseInt(dicorder);
                        dicorder = (neworder + 1) + "";
                        archivesType.setDeptOrder(dicorder);
                    } else {
                        archivesType.setDeptOrder("1");
                    }
                    archivesTypeService.saveArchivesType(archivesType);
                }
            }
        }else {
            archivesType.setCreator(CommonUtil.getPersonId());
            archivesType.setCreateTime(CommonUtil.getDate());
            archivesType.setCreateDept(CommonUtil.getDefaultDept());
            String dicorder = archivesTypeService.getMaxDeptOrder(archivesType.getParentTypeId());
            if (dicorder != null && dicorder != "") {
                int neworder = Integer.parseInt(dicorder);
                dicorder = (neworder + 1) + "";
                archivesType.setDeptOrder(dicorder);
            } else {
                archivesType.setDeptOrder("1");
            }
            archivesTypeService.saveArchivesType(archivesType);
        }
        return new Message(1, "添加成功！", null);
    }
    /**
     * 电子档案类别修改*/
    @ResponseBody
    @RequestMapping("/archivesType/editArchivesType")
    public ModelAndView editArchivesType(String id,String name,String type) {
        ModelAndView mv = new ModelAndView();
        ArchivesType archivesType=new ArchivesType();
        archivesType = archivesTypeService.getArchivesTypeById(id);
        if(id.length()>3){
            archivesType.setNewTypeId(archivesType.getTypeId().substring(3,6));
        }
        mv.addObject("archivesType", archivesType);
        mv.addObject("name", name);
        mv.addObject("id", id);
        mv.setViewName("/business/archives/editArchivesType");
        return mv;
    }
    /**
     * 电子档案类别修改保存*/
    @ResponseBody
    @RequestMapping("/archivesType/updateArchivesType")
    public Message updateArchivesType(ArchivesType archivesType) {
        archivesType.setChanger(CommonUtil.getPersonId());
        archivesType.setChangeTime(CommonUtil.getDate());
        archivesType.setChangeDept(CommonUtil.getDefaultDept());
        archivesTypeService.updateArchivesType(archivesType);
        return new Message(1, "修改成功！", null);
    }
    /**
     * 电子档案类别删除*/
    @ResponseBody
    @RequestMapping("/archivesType/deleteArchivesType")
    public Message deleteArchivesType(ArchivesType archivesType) {
        Message message = new Message(1, "删除成功！", "success");
        archivesTypeService.deleteArchivesType(archivesType.getTypeId());
        return message;
    }
}
