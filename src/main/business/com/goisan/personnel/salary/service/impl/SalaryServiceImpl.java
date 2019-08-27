package com.goisan.personnel.salary.service.impl;

import com.goisan.personnel.salary.bean.Salary;
import com.goisan.personnel.salary.dao.SalaryDao;
import com.goisan.personnel.salary.service.SalaryService;
import com.goisan.workflow.bean.Start;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by admin on 2017/6/30.
 */
@Service
public class SalaryServiceImpl implements SalaryService {
    @Resource
    private SalaryDao salaryDao;

   public List<Salary> getSalaryList(Salary salary){
       return salaryDao.getSalaryList(salary);
   }

    public Salary getSalaryById(String id){
        return salaryDao.getSalaryById(id);
    }

    public Salary getSalaryByApp(String id){return salaryDao.getSalaryByApp(id);}

    public List<Salary> getListUnDoSalaryAppByType(String userId){return salaryDao.getListUnDoSalaryAppByType(userId);}

    public void insertSalary(Salary salary){
        salaryDao.insertSalary(salary);
    }

    public void updateSalary(Salary salary){
        salaryDao.updateSalary(salary);
    }

    public void delectSalary(Salary salary){
        salaryDao.delectSalary(salary);
    }

    public  void delectSalaryById(Salary salary){
        salaryDao.delectSalaryById(salary);
    }

    public List<Salary> checkSalary(Salary salary){
        return salaryDao.checkSalary(salary);
    }

    public String getNameByIdCard(String idCard){
        return salaryDao.getNameByIdCard(idCard);
    }

    public String getIdCardByName(String name){
        return salaryDao.getIdCardByName(name);
    }

    public String getNameBySalaryAll(String s){
        if("223".equals(s)){
            return "岗位工资填写错误,请输入正确标准（数字）";
        }else if("224".equals(s)){
            return "薪级工资填写错误,请输入正确标准（数字）";
        }else if("225".equals(s)){
            return "百分之十填写错误,请输入正确标准（数字）";
        }else if("226".equals(s)){
            return "基础性绩效填写错误,请输入正确标准（数字）";
        }else if("227".equals(s)){
            return "国家奖励性绩效填写错误,请输入正确标准（数字）";
        }else if("228".equals(s)){
            return "独子补贴填写错误,请输入正确标准（数字）";
        }else if("229".equals(s)){
            return "教护龄填写错误,请输入正确标准（数字）";
        }else if("230".equals(s)){
            return "房租补贴填写错误,请输入正确标准（数字）";
        }else if("231".equals(s)){
            return "特殊岗位津贴填写错误,请输入正确标准（数字）";
        }else if("232".equals(s)){
            return "补发津贴填写错误,请输入正确标准（数字）";
        }else if("233".equals(s)){
            return "劳动合同岗位工资填写错误,请输入正确标准（数字）";
        }else if("234".equals(s)){
            return "劳动合同学历工资填写错误,请输入正确标准（数字）";
        }else if("235".equals(s)){
            return "劳动合同职称津贴填写错误,请输入正确标准（数字）";
        }else if("236".equals(s)){
            return "劳动合同校龄工资填写错误,请输入正确标准（数字）";
        }else if("237".equals(s)){
            return "劳动合同调整津贴填写错误,请输入正确标准（数字）";
        }else if("238".equals(s)){
            return "劳动合同绩效工资填写错误,请输入正确标准（数字）";
        }else if("239".equals(s)){
            return "劳动合同独子补贴填写错误,请输入正确标准（数字）";
        }else if("240".equals(s)){
            return "采暖费填写错误,请输入正确标准（数字）";
        }else if("241".equals(s)){
            return "讲课费1填写错误,请输入正确标准（数字）";
        }else if("242".equals(s)){
            return "讲课费2填写错误,请输入正确标准（数字）";
        }else if("243".equals(s)){
            return "中专班主任费填写错误,请输入正确标准（数字）";
        }else if("244".equals(s)){
            return "大专班主任费填写错误,请输入正确标准（数字）";
        }else if("245".equals(s)){
            return "绩效考核返还填写错误,请输入正确标准（数字）";
        }else if("246".equals(s)){
            return "责任绩效填写错误,请输入正确标准（数字）";
        }else if("247".equals(s)){
            return "管理、教辅效益绩效填写错误,请输入正确标准（数字）";
        }else if("248".equals(s)){
            return "内聘津贴填写错误,请输入正确标准（数字）";
        }else if("249".equals(s)){
            return "职大百分之十填写错误,请输入正确标准（数字）";
        }else if("250".equals(s)){
            return "职大商校职称差额填写错误,请输入正确标准（数字）";
        }else if("251".equals(s)){
            return "补发工资1填写错误,请输入正确标准（数字）";
        }else if("252".equals(s)){
            return "补发工资2填写错误,请输入正确标准（数字）";
        }else if("253".equals(s)){
            return "招生项目绩效填写错误,请输入正确标准（数字）";
        }else if("254".equals(s)){
            return "大赛项目绩效填写错误,请输入正确标准（数字）";
        }else if("255".equals(s)){
            return "科研项目绩效填写错误,请输入正确标准（数字）";
        }else if("256".equals(s)){
            return "其他填写错误,请输入正确标准（数字）";
        }else if("257".equals(s)){
            return "绩效考核奖填写错误,请输入正确标准（数字）";
        }else if("258".equals(s)){
            return "应发合计填写错误,请输入正确标准（数字）";
        }else if("259".equals(s)){
            return "个人所得税填写错误,请输入正确标准（数字）";
        }else if("260".equals(s)){
            return "养老保险填写错误,请输入正确标准（数字）";
        }else if("261".equals(s)){
            return "医疗保险填写错误,请输入正确标准（数字）";
        }else if("262".equals(s)){
            return "住房基金填写错误,请输入正确标准（数字）";
        }else if("263".equals(s)){
            return "职业年金填写错误,请输入正确标准（数字）";
        }else if("264".equals(s)){
            return "补扣养老保险填写错误,请输入正确标准（数字）";
        }else if("265".equals(s)){
            return "补扣医疗保险填写错误,请输入正确标准（数字）";
        }else if("266".equals(s)){
            return "补扣房基金填写错误,请输入正确标准（数字）";
        }else if("267".equals(s)){
            return "补扣职业年金填写错误,请输入正确标准（数字）";
        }else if("268".equals(s)){
            return "补扣税填写错误,请输入正确标准（数字）";
        }else if("269".equals(s)){
            return "扣款填写错误,请输入正确标准（数字）";
        }else if("270".equals(s)){
            return "会费填写错误,请输入正确标准（数字）";
        }else{
            return "实发合计填写错误,请输入正确标准（数字）";
        }
    }
}
