package com.goisan.appmui.controller;

import com.goisan.system.bean.Emp;
import com.goisan.system.service.EmpService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
public class TXLController {
    @Resource
    private EmpService empService;

    @RequestMapping("/txl/result/listResult")
    public ModelAndView index() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/app/txl/list_txl");
        List list = (List) new ArrayList();// List<Record> txlNameFirstlist = TxlBuss.findgetTxlNameFirst();
        List<Emp> emp = empService.getEmpList(null);
        for (int i = 0; i < emp.size(); i++) {
            HashMap map = new HashMap();
            map.put("id", emp.get(i).getPersonId());
            map.put("name", emp.get(i).getName());
            map.put("tel", emp.get(i).getTel());
            map.put("dept", emp.get(i).getDeptId());
            list.add(map);
        }
        mv.addObject("list", list);

        return mv;
    }

    /*@RequestMapping("/txl/result/search")
    public ModelAndView search(String name) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/app/txl/list_txl_searc");
        List list = (List) new ArrayList();// List<Record> txlNameFirstlist = TxlBuss.findgetTxlNameFirst();
        List<Emp> emp = empService.getEmpListByName("%"+name+"%");
        for(int i=0;i<emp.size();i++){
            HashMap map = new HashMap();
            map.put("id",emp.get(i).getPersonId());
            map.put("name",emp.get(i).getName());
            map.put("tel",emp.get(i).getTel());
            list.add(map);
        }
        mv.addObject("list", list);
        return mv;
    }*/
    @RequestMapping("/txl/result/listDedail")
    public ModelAndView detail(String id, String dept) {
        ModelAndView mv = new ModelAndView();
        Emp a = empService.getEmpByDeptIdAndPersonId(id, dept);
        String xm = "";
        String bm = "";
        String tel = "";
        if (a != null) {
            if (a.getDeptName() != null) {
                bm = String.valueOf(a.getDeptName());
            }
            if (a.getName() != null) {
                xm = String.valueOf(a.getName());
            }
            if (a.getTel() != null) {
                tel = String.valueOf(a.getTel());
            }
        }
        mv.addObject("xm", xm);
        mv.addObject("bm", bm);
        mv.addObject("tel", tel);

        mv.setViewName("/app/txl/detail_txl");
        return mv;
    }
}
