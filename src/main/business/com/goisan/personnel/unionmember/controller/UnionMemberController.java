package com.goisan.personnel.unionmember.controller;

import com.goisan.personnel.unionmember.bean.UnionMember;
import com.goisan.personnel.unionmember.service.UnionMemberService;
import com.goisan.system.bean.LoginUser;
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

/**
 * Created by hanyu on 2017/9/19.
 */
@Controller
public class UnionMemberController {
    @Resource
    private UnionMemberService unionMemberService;

    @RequestMapping("/unionMember/request")
    public ModelAndView getUnionMember(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/unionmember/unionMemberList");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/unionMember/getUnionMemberList")
    public Map<String, List<UnionMember>> getUnionMemberList(UnionMember unionMember) {
        Map<String, List<UnionMember>> group = new HashMap<String, List<UnionMember>>();
        String level = CommonUtil.getLoginUser().getLevel();
        String dept = CommonUtil.getDefaultDept();
        unionMember.setCreateDept(dept);
        unionMember.setLevel(level);
        group.put("data", unionMemberService.getUnionMemberList(unionMember));
        return group;
    }
    @RequestMapping("/unionMember/getAddUnionMember")
    public ModelAndView getAddUnionMember() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/unionmember/editUnionMember");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        UnionMember unionMember=new UnionMember();
        unionMember.setJoinTime(datetime);
        mv.addObject("head","新增工会会员");
        mv.addObject("unionMember",unionMember);
        return mv;
    }

    @RequestMapping("/unionMember/getUpdateUnionMember")
    public ModelAndView updateList(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/personnel/unionmember/addUnionMember");
        mv.addObject("head","修改工会会员");
        UnionMember unionMember = unionMemberService.getUnionMemberById(id);
        mv.addObject("unionMember",unionMember);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/unionMember/saveUnionMember")
    public Message saveUnionMember(UnionMember unionMember){
        LoginUser login = CommonUtil.getLoginUser();

        if(null ==unionMember.getId() || unionMember.getId().equals("")){
            List<UnionMember> unionMemberList1=unionMemberService.getPersonIdDeptId(unionMember);
            if(unionMemberList1.size()>0){
                return new Message(1, "新增失败，会员名称重复！", null);
            }else{
                List<UnionMember> unionMemberList2=unionMemberService.getUnionNumber(unionMember);
                if(unionMemberList2.size()>1){
                    return new Message(1, "新增失败，会员编号重复！", null);
                }else{
                    unionMember.setCreator(login.getPersonId());
                    unionMember.setCreateDept(login.getDefaultDeptId());
                    unionMemberService.insertUnionMember(unionMember);
                    return new Message(1, "新增成功！", null);
                }
            }

        }else{
            List<UnionMember> unionMemberList3=unionMemberService.getUnionNumber(unionMember);
            if(unionMemberList3.size()>1){
                return new Message(1, "修改失败，会员编号重复！", null);
            }else{
                unionMember.setChanger(login.getPersonId());
                unionMember.setChangeDept(login.getDefaultDeptId());
                unionMemberService.updateUnionMember(unionMember);
                return new Message(1, "修改成功！", null);
            }

        }
    }

    @ResponseBody
    @RequestMapping("/unionMember/deleteUnionMember")
    public Message deleteUnionMember(String id){
        LoginUser login = CommonUtil.getLoginUser();
        UnionMember unionMember = new UnionMember();
        unionMember.setId(id);
        unionMember.setChanger(login.getPersonId());
        unionMember.setChangeDept(login.getDefaultDeptId());
        unionMemberService.deleteUnionMember(unionMember);
        return new Message(1, "删除成功！", null);
    }

}
