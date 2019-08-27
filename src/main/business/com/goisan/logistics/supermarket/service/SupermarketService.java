package com.goisan.logistics.supermarket.service;

import com.goisan.logistics.supermarket.bean.Supermarket;

import java.util.List;

/**
 * Created by wq on 2017/9/20.
 */
public interface SupermarketService {
    //学生初始化页面
    List<Supermarket> getSupermarketList(Supermarket studentDorm);
    //新增学生
    void insertSupermarket(Supermarket studentDorm);
    //修改回显
    Supermarket getSupermarketById(Supermarket studentDorm);
    //修改
    void updateSupermarketById(Supermarket studentDorm);
    //删除人员
    void deleteSupermarketById(Supermarket studentDorm);
    //////////////////////////////////////////////////////////
    //学生初始化页面
    List<Supermarket> getSupermarketStaffList(Supermarket studentDorm);
    //新增学生
    void insertSupermarketStaff(Supermarket studentDorm);
    //修改回显
    Supermarket getSupermarketStaffById(Supermarket studentDorm);
    //修改
    void updateSupermarketStaffById(Supermarket studentDorm);
    //删除人员
    void deleteSupermarketStaffById(Supermarket studentDorm);

    List<Supermarket> checkSupermarketStaffById(Supermarket studentDorm);
}
