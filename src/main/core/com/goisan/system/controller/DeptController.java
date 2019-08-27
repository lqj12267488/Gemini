package com.goisan.system.controller;

import com.goisan.system.bean.Dept;
import com.goisan.system.bean.EmpDeptTree;
import com.goisan.system.bean.Select2;
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

/**
 * Created by Admin on 2017/4/19.
 */

@Controller
public class DeptController {
    @Resource
    private DeptService deptService;

    @ResponseBody
    @RequestMapping("/getDeptTree")
    public List<Tree> getDeptTree() {
        List<Tree> trees = deptService.getDeptTree();
        Tree root = new Tree();
        root.setId("0");
        root.setName("组织机构");
        root.setpId("root");
        root.setOpen(true);
        trees.add(root);
        return trees;
    }

    @ResponseBody
    @RequestMapping("/dept")
    public ModelAndView dept() {
        ModelAndView mv = new ModelAndView("/core/dept/dept");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/addDept")
    public ModelAndView addDept(String pId, String name) {
        ModelAndView mv = new ModelAndView();
        Dept pDept = deptService.getDeptById(pId);
        if (null != pDept)
            mv.addObject("pDeptType", pDept.getDeptType());
        else
            mv.addObject("pDeptType", "0");

        mv.addObject("id", deptService.getNewDeptId(pId));
        mv.addObject("pId", pId);
        mv.addObject("name", name);
        mv.setViewName("/core/dept/addDept");
        return mv;
    }


    @ResponseBody
    @RequestMapping("/saveDept")
    public Message saveDept(Dept dept) {
        dept.setCreator(CommonUtil.getPersonId());
        dept.setCreateTime(CommonUtil.getDate());
        deptService.saveDept(dept);
        return new Message(1, "添加成功！", null);
    }

    @ResponseBody
    @RequestMapping("/editDept")
    public ModelAndView editDept(String id) {
        ModelAndView mv = new ModelAndView();
        Dept dept = deptService.getDeptById(id);
        mv.addObject("dept", dept);

        if (!"0".equals(dept.getParentDeptId())) {
            Dept pDept = deptService.getDeptById(dept.getParentDeptId());
            if (null != pDept)
                mv.addObject("pDeptType", pDept.getDeptType());
            else
                mv.addObject("pDeptType", "0");
        } else {
            mv.addObject("pDeptType", "0");
        }

        mv.setViewName("/core/dept/editDept");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/deleteDeptById")
    public Message deleteDeptById(String id) {
        Message message = new Message(1, "删除成功！", "success");
        List<String> list = deptService.getEmpByDeptId(id);
        if (list.size() > 0) {
            message.setStatus(0);
            message.setMsg("当前部门下有人员信息，不能删除！");
        } else {
            deptService.deleteDeptById(id);
        }
        return message;
    }

    @ResponseBody
    @RequestMapping("/updateDept")
    public Message updateDept(Dept dept) {
        dept.setChanger(CommonUtil.getPersonId());
        dept.setCreateTime(CommonUtil.getDate());
        deptService.updateDept(dept);
        return new Message(1, "修改成功！", null);
    }

    @ResponseBody
    @RequestMapping("/getDeptAndPersonTree")
    public List<EmpDeptTree> getDeptAndPersonTree(String id) {
        List<EmpDeptTree> trees = deptService.getDeptAndPersonTree(id);
        EmpDeptTree root = new EmpDeptTree();
        root.setId("0");
        root.setName("组织机构");
        root.setpId("root");
        root.setOpen(true);
        root.setChecked("false");
        root.setIsper("false");
        trees.add(root);
        return trees;
    }

    //同级部门名称查重create by wq
    @ResponseBody
    @RequestMapping("/checkDeptName")
    public Message checkDeptName(Dept dept) {
        List<Select2> list = deptService.checkDeptName(dept);
        if (list.size() > 0) {
            return new Message(1, "", null);
        } else {
            return new Message(0, "", null);
        }
    }


    @ResponseBody
    @RequestMapping("/getDeptTeachTree")
    public List<Tree> getDeptTeachTree() {
        List<Tree> trees = deptService.getDeptTeachTree();
        Tree root = new Tree();
        root.setId("0");
        root.setName("组织机构");
        root.setpId("root");
        root.setOpen(true);
        trees.add(root);
        return trees;
    }

}
