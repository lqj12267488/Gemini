package com.goisan.logistics.supermarket.dao;

import com.goisan.logistics.supermarket.bean.Supermarket;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wq on 2017/9/20.
 */
@Repository
public interface SupermarketDao {

    List<Supermarket> getSupermarketList(Supermarket studentDorm);

    void insertSupermarket(Supermarket studentDorm);

    Supermarket getSupermarketById(Supermarket studentDorm);

    void updateSupermarketById(Supermarket studentDorm);

    void deleteSupermarketById(Supermarket studentDorm);
    ///////////////////////////////////////////////////////////
    List<Supermarket> getSupermarketStaffList(Supermarket studentDorm);

 void insertSupermarketStaff(Supermarket studentDorm);

 Supermarket getSupermarketStaffById(Supermarket studentDorm);

 void updateSupermarketStaffById(Supermarket studentDorm);

 void deleteSupermarketStaffById(Supermarket studentDorm);

    List<Supermarket> checkSupermarketStaffById(Supermarket studentDorm);

}
