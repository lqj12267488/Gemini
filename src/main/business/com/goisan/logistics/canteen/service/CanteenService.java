package com.goisan.logistics.canteen.service;

import com.goisan.logistics.canteen.bean.Canteen;

import java.util.List;

/**
 * Created by wq on 2017/9/20.
 */
public interface CanteenService {
    //学生初始化页面
    List<Canteen> getCanteenList(Canteen studentDorm);
    //新增学生
    void insertCanteen(Canteen studentDorm);
    //修改回显
    Canteen getCanteenById(Canteen studentDorm);
    //修改
    void updateCanteenById(Canteen studentDorm);
    //删除人员
    void deleteCanteenById(Canteen studentDorm);
    //////////////////////////////////////////////////////////
    //学生初始化页面
    List<Canteen> getCanteenStaffList(Canteen studentDorm);
    //新增学生
    void insertCanteenStaff(Canteen studentDorm);
    //修改回显
    Canteen getCanteenStaffById(Canteen studentDorm);
    //修改
    void updateCanteenStaffById(Canteen studentDorm);
    //删除人员
    void deleteCanteenStaffById(Canteen studentDorm);

    List<Canteen>  checkCanteenStaffById(Canteen canteen);
}
