package com.goisan.personnel.salary.dao;

import com.goisan.personnel.salary.bean.Salary;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by admin on 2017/6/30.
 */
@Repository
public interface SalaryDao {

    List<Salary> getSalaryList(Salary salary);

    Salary getSalaryById(String id);

    Salary getSalaryByApp(String id);

    List<Salary> getListUnDoSalaryAppByType(String userId);

    void insertSalary(Salary salary);

    void updateSalary(Salary salary);

    void delectSalary(Salary salary);

    void delectSalaryById(Salary salary);

    List<Salary> checkSalary(Salary salary);

    String getNameByIdCard(String idCard);

    String getIdCardByName(String name);

    String getNameBySalaryAll(String s);
}
