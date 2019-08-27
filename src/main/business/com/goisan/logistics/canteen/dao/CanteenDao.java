package com.goisan.logistics.canteen.dao;

import com.goisan.logistics.canteen.bean.Canteen;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wq on 2017/9/20.
 */
@Repository
public interface CanteenDao {

    List<Canteen> getCanteenList(Canteen studentDorm);

    void insertCanteen(Canteen studentDorm);

    Canteen getCanteenById(Canteen studentDorm);

    void updateCanteenById(Canteen studentDorm);

    void deleteCanteenById(Canteen studentDorm);
    ///////////////////////////////////////////////////////////
    List<Canteen> getCanteenStaffList(Canteen studentDorm);

 void insertCanteenStaff(Canteen studentDorm);

 Canteen getCanteenStaffById(Canteen studentDorm);

 void updateCanteenStaffById(Canteen studentDorm);

 void deleteCanteenStaffById(Canteen studentDorm);

    List<Canteen>  checkCanteenStaffById(Canteen canteen);

}
